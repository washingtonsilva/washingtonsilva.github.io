# Valida os exemplos do tutorial em um projeto R temporário e isolado.

argumento <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(argumento) != 1) {
  stop("Execute este arquivo com Rscript tests/validar-tutorial.R.", call. = FALSE)
}

verificar <- function(condicao, mensagem) {
  if (!isTRUE(condicao)) {
    stop(mensagem, call. = FALSE)
  }
}

arquivo_teste <- normalizePath(sub("^--file=", "", argumento))
diretorio_tutorial <- normalizePath(file.path(dirname(arquivo_teste), ".."))
diretorio_temporario <- tempfile("validacao-r-tidyverse-")
projeto_teste <- file.path(diretorio_temporario, "projeto")

dir.create(file.path(projeto_teste, "data", "raw"), recursive = TRUE)
on.exit(unlink(diretorio_temporario, recursive = TRUE), add = TRUE)

arquivos_dados <- c("agencias.csv", "credito_trimestral.csv", "inadimplencia.csv")
for (arquivo in arquivos_dados) {
  copiado <- file.copy(
    file.path(diretorio_tutorial, "dados", arquivo),
    file.path(projeto_teste, "data", "raw", arquivo)
  )
  verificar(copiado, paste("Não foi possível preparar o arquivo de dados:", arquivo))
}

invisible(file.create(file.path(projeto_teste, "tutorial-r-tidyverse-teste.Rproj")))
diretorio_anterior <- getwd()
setwd(projeto_teste)
on.exit(setwd(diretorio_anterior), add = TRUE)

exemplos <- c(
  "_00-pacotes.R", "_02-caminho-agencias.R", "_03-importar-agencias.R",
  "_04-criar-indicadores.R", "_05-empresas-rentaveis.R",
  "_06-pipeline-sem-atribuicao.R", "_07-resumo-setor.R", "_08-roa-agregado.R",
  "_09-classificar-indicadores.R", "_10-importar-credito.R",
  "_11-organizar-credito.R", "_12-importar-inadimplencia.R",
  "_13-combinar-tabelas.R", "_14-verificar-chaves.R"
)

for (exemplo in exemplos) {
  source(file.path(diretorio_tutorial, "exemplos", exemplo), echo = FALSE)
}

verificar(
  identical(normalizePath(here::here()), normalizePath(projeto_teste)),
  "here() não localizou a raiz do projeto temporário."
)
verificar(nrow(agencias) == 3L, "A importação de agencias.csv deve produzir três agências.")
verificar(nrow(empresas_rentaveis) == 3L, "O filtro de empresas rentáveis deve produzir três linhas.")
verificar(nrow(resumo_setor) == 4L, "O resumo por setor deve produzir quatro setores.")
verificar(
  identical(dplyr::group_vars(resumo_setor), character()),
  "O resumo por setor não deve manter agrupamento residual."
)
verificar(
  dplyr::filter(resumo_setor, setor == "Varejo")$empresas == 2L,
  "O setor Varejo deve ter duas empresas."
)
verificar(
  dplyr::filter(resumo_setor, setor == "Varejo")$ativo_total == 850000,
  "O ativo total do setor Varejo deve ser 850000."
)
verificar(
  abs(dplyr::filter(resumo_setor, setor == "Varejo")$roa_medio_simples - 0.025) < 1e-12,
  "O ROA médio simples do setor Varejo deve ser 2,5%."
)
verificar(
  abs(dplyr::filter(resumo_setor_agregado, setor == "Varejo")$roa_agregado - 21600 / 850000) < 1e-12,
  "O ROA agregado do setor Varejo não está consistente com os totais."
)
verificar(nrow(credito_longo) == 12L, "Os dados longos de crédito devem ter 12 linhas.")
verificar(
  identical(names(credito_longo), c("id_agencia", "trimestre", "volume_credito")),
  "Os dados longos de crédito devem conter as três colunas esperadas."
)
verificar(nrow(dados_completos) == 12L, "Os joins devem manter 12 linhas.")
verificar(!anyNA(dados_completos$taxa_inadimplencia), "Os joins não devem criar inadimplência ausente.")
verificar(
  !anyDuplicated(dados_completos[c("id_agencia", "trimestre")]),
  "A chave agência-trimestre não pode ter duplicidades após os joins."
)
verificar(
  identical(sort(unique(dados_completos$risco)), c("Baixo", "Moderado")),
  "A classificação de risco deve produzir apenas Baixo e Moderado nestes dados."
)

material_teste <- file.path(diretorio_temporario, "material")
dir.create(material_teste, recursive = TRUE)
copiado <- file.copy(diretorio_tutorial, material_teste, recursive = TRUE)
verificar(copiado, "Não foi possível copiar o tutorial para a validação de renderização.")

diretorio_renderizacao <- file.path(material_teste, basename(diretorio_tutorial))
setwd(diretorio_renderizacao)
on.exit(setwd(diretorio_anterior), add = TRUE)

status_renderizacao <- system2(
  "quarto",
  c(
    "render", "index.qmd", "--execute",
    "--execute-dir", projeto_teste,
    "--output-dir", "_output"
  ),
  stdout = TRUE,
  stderr = TRUE
)
if (!is.null(attr(status_renderizacao, "status"))) {
  cat(paste(status_renderizacao, collapse = "\n"), "\n")
}
verificar(
  identical(attr(status_renderizacao, "status"), NULL),
  "A renderização executada do tutorial falhou."
)
verificar(
  file.exists(file.path(material_teste, basename(diretorio_tutorial), "_output", "index.html")),
  "A renderização executada não produziu o arquivo HTML esperado."
)

cat("Validação concluída: exemplos, dados, resultados e renderização executada estão consistentes.\n")
