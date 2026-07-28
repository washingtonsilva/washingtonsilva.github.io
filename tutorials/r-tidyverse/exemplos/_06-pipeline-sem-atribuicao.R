# este pipeline apenas exibe uma nova tabela; não altera indicadores
indicadores |>
  mutate(roa = resultado_liquido / ativo_total)
