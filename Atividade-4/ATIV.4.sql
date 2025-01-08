
/* 1. Por que a tabela “Cliente” não está na 1FN? Proponha uma solução para fazer sua normalização na 1FN.
A tabela “cliente” não está na 1FN pois apresenta colunas que podem ser desmembradas em outras tabelas,
como, por exemplo, a coluna “telefone”, que, neste contexto, poderia ser uma outra tabela e apresentar mais de um telefone
(fixo, celular), assim como a coluna “endereço” poderia ser desmembrada em outras colunas ao invés de uma coluna só com todas as informações dos endereços.  

2.Por que a tabela “Item_venda” não está na 2FN? Proponha uma solução para fazer sua normalização na 2FN.
A tabela “item_venda” apresenta atributos que não são dependentes das duas chaves que compõem a chave primária da tabela por isso não estão na 2FN.
Para sua normalização na 2FN uma solução seria eliminar os atributos “nome_produto” e “valor_unitario” que estão dependentes em parte da chave e criar
uma nova tabela para eles associado apenas a chave em que são diretamente associados: "produto_id".

3.Por que a tabela “venda” não está na 3FN? Proponha uma solução para fazer sua normalização na 3FN.
A tabela “venda” não está na 3FN pois possui atributo com valores que depende de outro atributo, o atributo “valor_total” que depende de um atributo de outra tabela,
o “subtotal” de cada produto vendido. Para solucionar, pode-se retirar a coluna “valor_total” e criar uma view contendo o resultado da operação algébrica. 

4.Crie o script SQL correspondente à alteração proposta com os comandos de criação e/ou alteração das tabelas normalizadas.*/

/*RESOLUÇÃO - QUESTÃO O1*/
ALTER TABLE cliente DROP telefone;
ALTER TABLE cliente DROP endereco;

ALTER TABLE cliente 
ADD logradouro VARCHAR(50), 
ADD numero VARCHAR(10), 
ADD bairro VARCHAR(50),
ADD cidade VARCHAR(50),
ADD estado VARCHAR(50);

CREATE TABLE telefones (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
fixo VARCHAR(20),
celular VARCHAR(20)
);

ALTER TABLE cliente ADD telefone_id INT;
ALTER TABLE cliente ADD FOREIGN KEY (telefone_id) REFERENCES telefones (id);

/*RESOLUÇÃO - QUESTÃO O2*/
ALTER TABLE item_venda DROP valor_unitario;
ALTER TABLE item_venda DROP nome_produto;

CREATE TABLE valor_produto (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome_produto VARCHAR(20),
valor_unitario DECIMAL(9,2),
produto_id INT NOT NULL,
FOREIGN KEY (produto_id) REFERENCES produto(id)
);

/*RESOLUÇÃO - QUESTÃO O3*/

ALTER TABLE venda DROP valor_total;

CREATE VIEW valor_total AS SELECT (iv.quantidade * vp.valor_unitario) AS valor_total FROM
item_venda iv JOIN valor_produto vp ON iv.produto_id = vp.produto_id;




