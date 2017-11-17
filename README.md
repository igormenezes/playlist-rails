1 - Crie o banco playlist
2 - As tabelas da aplicação se encontra no arquivo, apenas importar para o mysql: playlist.sql

IMPORTANTE: 

No arquivo .env se encontra os dados de conexão com o banco, não esqueça de alterar conforme sua necessidade.

O usuário para acesso ao admin é: 

e-mail/login: admin@yahoo.com.br  
senha: 123

Caso não queira importar as tabelas do arquivo playlist.sql, você pode gerar elas pelo migrate:

1 - Acesse pelo terminal o diretório do projeto.
2 - execute o seguinte comando: php artisan migrate

IMPORTANTE: 

Caso não importe a tabela do banco playlist, o primeiro usuário criado será o adminsitrador, automaticamente ao realizar login será redirecioando para a área de adminsitrador(cadastro de músicas, verificar as mais favoritadas). 

Os demais usuarios cadastrados serão usuários sem privilégios, automaticamente ao realizar login será redirecionado a área do usuário(adicionar aos favoritos, busca, etc).


Para rodar a aplicação, faça o seguinte:

1 - Acesse pelo terminal o diretório do projeto.
2 - execute php artisan serve
3 - acesse a url: http://localhost:8000/

Depois só utilizar a aplicação =)
