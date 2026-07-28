# calcula o ROA agregado a partir dos totais de cada setor
resumo_setor_agregado <- indicadores |>
  group_by(setor) |>
  summarise(
    resultado_liquido = sum(resultado_liquido),
    ativo_total = sum(ativo_total),
    roa_agregado = resultado_liquido / ativo_total
  ) |>
  arrange(desc(roa_agregado))

# exibe o resumo com o ROA agregado por setor
resumo_setor_agregado
