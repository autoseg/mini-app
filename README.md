## Challenge AutoSeg

## Resolução

### Tarefa 1

Foram realizadas duas ações no controller do profile para a resolução do bug:\
1 - Adicionar o código do strong params para o profile.\
2 - Colocar o callback 'find_profile' antes do 'public?', que chamava a var de instancia @profile, definida no 'find_profile'

### Tarefa 2
Foi criado um controller (reports_controller) que possuí duas ações para rotas diferentes.

A primeira rota vai para uma view com a listagem das tarefas. Os specs podem ser rodados com:\
`rspec spec/features/user_can_view_report_spec.rb`

A segunda renderiza a listagem em pdf. Para isso foi usado a gem wicked_pdf. Os specs podem ser rodados com:\
`rspec spec/features/user_can_generate_pdf_report_spec.rb`\

### Tarefa 3
Foi criado o crud das tarefas, os specs podem ser rodados com:\
`rspec spec/features/user_can_create_task_spec.rb`\
`rspec spec/features/user_can_update_task_spec.rb`\
`rspec spec/features/user_can_delete_task_spec.rb`\
`rspec spec/features/user_can_change_task_status_spec.rb`
`rspec spec/models/task_spec.rb`

Além disso, foi desenvolido/implementado as funcionalidades que estava sendo previstas pelos testes, mas não haviam sido desenvolvidas/implementadas ainda, como:
- Comentários (criar e deletar)
- Pesquisa de tarefas
- Curtir e descurtir comentarios
- Mudar e tratar a privacidade das tarefas
- Ordenação das tarefas e comentarios (para o qual foi criado um modulo com metódo de classe chamado Orderable, em `lib/orderable.rb`)
- Outros relacionados a visibilidade de tarefas

Assim, ao rodar `spec`, todos os testes devem passar.

## Instruções de uso

Clone o projeto com:

`$ git clone git@github.com:rgdotta/mini-app.git`

Instale as dependências:
```
$ yarn install --check-files
$ bundle install
```

Cria o banco de dados:
```
$ bundle exec rails db:drop db:create db:migrate
```

Rode o servidor com `rails s`
