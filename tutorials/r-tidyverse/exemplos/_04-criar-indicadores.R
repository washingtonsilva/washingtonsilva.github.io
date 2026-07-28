# cria uma tibble simulada de indicadores anuais
indicadores <- tribble(
  ~empresa,        ~setor,        ~ano, ~ativo_total, ~resultado_liquido,
  "Alfa Energia",  "Energia",    2025,      820000,              49200,
  "Beta Varejo",   "Varejo",     2025,      460000,              13800,
  "Gama Saúde",    "Saúde",      2025,      610000,              42700,
  "Delta Varejo",  "Varejo",     2025,      390000,               7800,
  "Épsilon Banco", "Financeiro", 2025,     1250000,              87500
)

# verifica a estrutura da tibble criada
glimpse(indicadores)
