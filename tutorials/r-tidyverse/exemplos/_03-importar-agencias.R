# define o caminho relativo para o arquivo csv
# usando a função here() do pacote here
agencias_csv <- here("data/raw/agencias.csv")

# importa o arquivo csv com a função readr do pacote readr
# e armazena os dados no objeto agencias
agencias <- read_csv(agencias_csv)

# exibe visão geral dos dados importados
glimpse(agencias)

# visualiza as primeiras linhas da tabela
head(agencias)
