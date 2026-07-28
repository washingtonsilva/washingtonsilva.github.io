# calcula o ROA e classifica cada empresa conforme os limites definidos
indicadores_classificados <- indicadores |>
  mutate(
    roa = resultado_liquido / ativo_total,
    faixa_roa = case_when(
      roa >= 0.08 ~ "Alta",
      roa >= 0.04 ~ "Intermediária",
      TRUE        ~ "Baixa"
    )
  )

# conta empresas em cada faixa de rentabilidade
indicadores_classificados |>
  count(faixa_roa)
