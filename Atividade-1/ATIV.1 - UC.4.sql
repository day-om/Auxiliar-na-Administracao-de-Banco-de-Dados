
/*Crie um usuário chamado user_relatorio. Crie role para ele, com acesso ao comando SELECT de todas tabelas da base de dados uc4atividades.
Não pode ser definido para este usuário nenhum outro comando DDL ou DML além do SELECT.*/

CREATE USER "user_relatorio"@"localhost" IDENTIFIED BY "123456";
CREATE ROLE "relatorio";
GRANT SELECT ON uc4atividades.* TO "relatorio";
GRANT "relatorio" TO "user_relatorio"@"localhost";

/*Crie usuário chamado user_funcionario. Crie role para esse usuário.Ele poderá manipular as tabelas de venda, cliente e produto da base de dados uc4atividades, 
ou seja, poderá fazer apenas os comandos de SELECT, INSERT, UPDATE e DELETE.*/

CREATE USER "user_funcionario"@"localhost" IDENTIFIED BY "654321";
CREATE ROLE "funcionario";
GRANT INSERT, UPDATE, DELETE ON uc4atividades.* TO "funcionario";

