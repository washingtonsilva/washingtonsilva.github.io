# calcula o ROA e resume número de empresas, ativo e ROA médio simples por setor
resumo_setor <- indicadores |>
  mutate(roa = resultado_liquido / ativo_total) |>
  group_by(setor) |>
  summarise(
    empresas = n(),
    ativo_total = sum(ativo_total),
    roa_medio_simples = mean(roa)
  ) |>
  arrange(desc(roa_medio_simples))

# exibe o resumo por setor
resumo_setor
