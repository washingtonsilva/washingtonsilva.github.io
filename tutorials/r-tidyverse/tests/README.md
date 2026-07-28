# Validação do tutorial

Execute, a partir da raiz do repositório do site:

```bash
Rscript tutorials/r-tidyverse/tests/validar-tutorial.R
```

O teste cria um projeto R temporário, copia os CSVs para `data/raw/`, executa
os mesmos arquivos de código exibidos no tutorial e verifica resultados,
chaves e indicadores. Em seguida, renderiza uma cópia temporária do documento
com `quarto render --execute`. Nenhum arquivo publicado do site é alterado.
