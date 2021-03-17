## Challenge AutoSeg

## Resolução

### Tarefa 1

Foram realizadas duas ações no controller do profile para a resolução do bug:
1 - Adicionar o código do strong params para p profile.
2 - Colocar o callback 'find_profile' antes do 'public?', que chamava a var de instancia @profile, definida no 'find_profile'

### Tarefa 2
Foi criado um controller (reports_controller) que possuí duas ações para rotas diferentes.

A primeira rota vai para uma view com a listagem das tarefas completas. Os specs podem ser rodados com:
`rspec spec/features/user_can_view_report_spec.rb`

A segunda renderiza a lsitagem em pdf. Para isso foi usado a gem wicked_pdf. Os specs podem ser rodados com:
`rspec spec/features/user_can_generate_pdf_report_spec.rb`
(Obs: O wicked_pdf usa a gem 'wkhtmltopdf-binary'. Por conta do tamanho do arquivo dessa dependencia, geralmente ele é instalado e executado de forma local na maquina, mas como o proposito desse repositório é apenas o teste, optei em colocar como gem mesmo)

### Tarefa 3
Foi criado o crud básico das tasks, os specs podem ser rodados com:
`rspec spec/features/user_can_create_task_spec.rb`
`rspec spec/features/user_can_update_task_spec.rb`
`rspec spec/features/user_can_delete_task_spec.rb`
`rspec spec/features/user_can_change_task_status_spec.rb`

Além disso, foi utilizado práticas de TDD para desenvolver as funcionalidades que estava sendo previstas pelos testes, mas não haviam sido implementadas, como:
- Comentários (criar e deletar)
- Curtir e descurtir comentãrios
- Mudar e tratar a privacidade das tarefas
- Ordenação das tarefas e comentarios (para o qual foi criado um modulo de utilidade chamado Orderable, em `lib/orderable.rb`)
- Outros relacionados a visibilidade de tarefas

Assim, ao rodar `spec`, todos os testes devem passar (tanto os novos, quanto os que já existiam)

### TaskManager App
Considere o app deste projeto já estruturado, onde nele conseguimos cadastrar tarefas do dia-a-dia a serem realizadas, junto com uma descrição, colocar comentários e algumas outras features :)
  Então... considere a atual estrutura de model já existente:

  ```
                ____________
               | User       |
        _____* | - email    |
       /       | - password |
      /        |____________|
     /
    *
 _______________              __________
| Tasks         |            | Comments |
| - title       |1 -------- *| - body   |
| - description |            | - status |
| - status      |            | - score  |
| - priority    |            | - like   |
| - share       |            |__________|
|_______________|
```
### Instruções para o challenge
0 - Versão do Ruby
`ruby 2.7.1`
1 - Clone o projeto
```console
$ git clone git@github.com:autoseg/mini-app.git
```
2 - Build o projeto e roda os seeds
```console
$ bundle install
$ bundle exec rails db:create db:migrate db:seeds
$ yarn install --check-files
$ rails s
```
3 - Ao acessar a aplicação, crie uma conta.
### Tarefa 1
1 - Logo na sequência que criou a conta no passo anterior, será necessário criar um perfil.
Porém há um bug nesta feature, a atividade da tarefa 1 é tentar identificá-lo e corrigir.
### Tarefa 2
2 - Para esta tarefa é necessário a execução do seeds antes, certifique-se que você populou o banco de dados.
2.1 - Esta atividade é para ser criado um relatório de todas as Tarefas, onde listaremos algo semelhante ao exemplo abaixo:
___________________________________
| Tasks (ID) | Comments | Status   |
|------------|----------|----------|
| 1          | Aaaaaa   | complete |
| 2          | Bbbbbb   | complete |


2.2. - Para isto, crie:
 - Uma controller;
 - Uma rota;
 - Uma view;

  2.3. - Exiba um relatório das Tasks completas do User, e liste todos os comentários em ordem alfabética conforme o exemplo acima.

  2.4. - Crie um spec de integração para o relatório.

### Tarefa 3

3 - Crie um CRUD de tarefas em tasks/new;

  3.1 - Temos o arquivo deste spec vazio, escreva o(s) spec(s) de integração;

  3.2 - Crie um spec unitário.

### Boa sorte

Caso tenha dúvidas, por gentileza entre em contato com a Equipe AutoSeg :)
### Observações
- Não é necessário realizar o deploy do projeto no Heroku.
- Crie um projeto em seu Github e suba o projeto lá após a finalização.
- Não dê um fork / suba um PR em nosso repositório.
