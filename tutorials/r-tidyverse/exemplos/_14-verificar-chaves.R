# verifica se há mais de uma linha por combinação agência-trimestre
credito_longo |> count(id_agencia, trimestre) |> filter(n > 1)

# aplica a mesma verificação à tabela de inadimplência
inadimplencia |> count(id_agencia, trimestre) |> filter(n > 1)
