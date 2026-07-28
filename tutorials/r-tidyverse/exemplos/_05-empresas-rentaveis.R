# calcula o ROA, seleciona empresas com rentabilidade acima de 5%
# e organiza o resultado do maior para o menor ROA
empresas_rentaveis <- indicadores |>
  mutate(roa = resultado_liquido / ativo_total) |>
  filter(roa > 0.05) |>
  select(empresa, setor, ativo_total, resultado_liquido, roa) |>
  arrange(desc(roa))

# exibe o objeto que responde à pergunta analítica
empresas_rentaveis
