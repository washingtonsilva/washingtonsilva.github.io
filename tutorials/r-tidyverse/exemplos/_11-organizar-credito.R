# transforma as colunas trimestrais em duas variáveis: trimestre e volume de crédito
credito_longo <- credito_amplo |>
  pivot_longer(
    cols = -id_agencia,
    names_to = "trimestre",
    values_to = "volume_credito"
  )

# exibe os dados reorganizados no formato longo
credito_longo
