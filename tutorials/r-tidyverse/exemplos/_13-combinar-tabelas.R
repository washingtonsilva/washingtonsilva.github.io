# acrescenta o cadastro das agências usando a chave id_agencia
# acrescenta a inadimplência usando a chave composta agência-trimestre
# e cria indicadores de crédito por cooperado e de risco
dados_completos <- credito_longo |>
  left_join(agencias, by = "id_agencia") |>
  left_join(inadimplencia, by = c("id_agencia", "trimestre")) |>
  mutate(
    credito_por_cooperado = volume_credito / cooperados,
    risco = case_when(
      taxa_inadimplencia < 0.03 ~ "Baixo",
      taxa_inadimplencia < 0.045 ~ "Moderado",
      TRUE ~ "Alto"
    )
  )

# verifica a estrutura final após os joins e as novas variáveis
glimpse(dados_completos)
