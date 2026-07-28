# define o caminho relativo do arquivo de inadimplência trimestral
inadimplencia_csv <- here("data/raw/inadimplencia.csv")

# importa os dados de inadimplência
inadimplencia <- read_csv(inadimplencia_csv)

# verifica a estrutura dos dados importados
glimpse(inadimplencia)
