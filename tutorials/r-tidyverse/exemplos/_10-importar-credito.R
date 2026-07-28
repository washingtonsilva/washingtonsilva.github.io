# define o caminho relativo do arquivo de crédito trimestral
credito_csv <- here("data/raw/credito_trimestral.csv")

# importa os dados no formato amplo
credito_amplo <- read_csv(credito_csv)

# verifica a estrutura antes da reorganização
glimpse(credito_amplo)
