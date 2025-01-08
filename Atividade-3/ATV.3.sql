/*QUESTÃO 01 - Execute o comando EXPLAIN mostrando detalhes da execução da consulta e tire um print.
/***
consulta para um relatório de todas as vendas pagas em dinheiro. 
Necessários para o relatório data da venda, valor total; produtos vendidos, quantidade e valor unitário; nome do cliente, cpf e telefone.
Ordena-se pela data de venda, as mais recentes primeiro.
**/
EXPLAIN SELECT * FROM venda v, item_venda iv, produto p, cliente c, funcionario f
WHERE v.id = iv.venda_id AND c.id = v.cliente_id AND p.id = iv.produto_id AND f.id = v.funcionario_id and tipo_pagamento = 'D';

/***
consulta para encontrar todas as vendas de produtos de um dado fabricante
Mostrar dados do produto, quantidade vendida, data da venda.
Ordena-se pelo nome do produto.
***/
EXPLAIN SELECT * FROM produto p, item_venda iv, venda v
WHERE p.id = iv.produto_id AND v.id = iv.venda_id AND p.fabricante like '%lar%';
 
/***
Relatório de vendas de produto por cliente.
Mostrar dados do cliente, dados do produto e valor e quantidade totais de venda ao cliente de cada produto.
*/
EXPLAIN SELECT SUM(iv.subtotal), SUM(iv.quantidade)
FROM produto p, item_venda iv, venda v, cliente c
WHERE p.id = iv.produto_id AND v.id = iv.venda_id AND c.id = v.cliente_id /*f.id = v.funcionario_id*/
GROUP BY c.nome, p.nome;

/*QUESTÃO 02 - Realize ajustes de otimização nas consultas utilizando JOINs entre as tabelas, assim como removendo os asteriscos (*)
 e definindo quais colunas devem ser retornadas de cada consulta, a fim de otimizá-la.
/***
consulta para um relatório de todas as vendas pagas em dinheiro. 
Necessários para o relatório data da venda, valor total; produtos vendidos, quantidade e valor unitário; nome do cliente, cpf e telefone.
Ordena-se pela data de venda, as mais recentes primeiro.
**/
SELECT v.data, v.valor_total, p.nome AS produto, iv.quantidade, iv.valor_unitario, c.nome AS cliente, c.cpf,c.telefone
FROM venda v JOIN item_venda iv ON v.id = iv.venda_id
JOIN cliente c ON c.id = v.cliente_id
JOIN produto p ON p.id = iv.produto_id
JOIN funcionario f ON f.id = v.funcionario_id
WHERE tipo_pagamento = 'D'
ORDER BY data DESC;

/***
consulta para encontrar todas as vendas de produtos de um dado fabricante
Mostrar dados do produto, quantidade vendida, data da venda.
Ordena-se pelo nome do produto.
***/
SELECT p.nome, p.descricao, p.estoque, p.fabricante, iv.quantidade, v.data
FROM produto p JOIN item_venda iv ON p.id = iv.produto_id
JOIN venda v ON v.id = iv.venda_id
WHERE p.fabricante like '%lar%'
ORDER BY p.nome;
 
/***
Relatório de vendas de produto por cliente.
Mostrar dados do cliente, dados do produto e valor e quantidade totais de venda ao cliente de cada produto.
*/
SELECT c.nome AS cliente, p.nome AS produto, SUM(iv.subtotal), SUM(iv.quantidade)
FROM produto p JOIN item_venda iv ON p.id = iv.produto_id 
JOIN venda v ON  v.id = iv.venda_id
JOIN cliente c ON c.id = v.cliente_id
GROUP BY c.nome, p.nome;


/*QUESTÃO 03 - Crie índices que possam se beneficiar do recurso para melhorar o desempenho das consultas,
considerando principalmente colunas utilizadas nas cláusulas WHERE.*/

CREATE INDEX idx_tipo_pagamento ON venda(tipo_pagamento);

CREATE INDEX idx_fabricante ON produto(fabricante);

/*QUESTÃO 04 - Execute novamente o comando EXPLAIN, mostrando agora os detalhes da execução da consulta depois das otimizações realizadas e tire um print.*/

EXPLAIN SELECT v.data, v.valor_total, p.nome AS produto, iv.quantidade, iv.valor_unitario, c.nome AS cliente, c.cpf,c.telefone
FROM venda v JOIN item_venda iv ON v.id = iv.venda_id
JOIN cliente c ON c.id = v.cliente_id
JOIN produto p ON p.id = iv.produto_id
JOIN funcionario f ON f.id = v.funcionario_id
WHERE tipo_pagamento = 'D'
ORDER BY data DESC;

EXPLAIN SELECT p.nome, p.descricao, p.estoque, p.fabricante, iv.quantidade, v.data
FROM produto p JOIN item_venda iv ON p.id = iv.produto_id
JOIN venda v ON v.id = iv.venda_id
WHERE p.fabricante like '%lar%'
ORDER BY p.nome;

EXPLAIN SELECT c.nome AS cliente, p.nome AS produto, SUM(iv.subtotal), SUM(iv.quantidade)
FROM produto p JOIN item_venda iv ON p.id = iv.produto_id 
JOIN venda v ON  v.id = iv.venda_id
JOIN cliente c ON c.id = v.cliente_id
GROUP BY c.nome, p.nome;

/*QUESTÃO 05 - Crie uma view para cada uma das consultas ajustadas com JOINS.*/

CREATE VIEW consulta01 AS SELECT v.data, v.valor_total, p.nome AS produto, iv.quantidade, iv.valor_unitario, c.nome AS cliente, c.cpf,c.telefone
FROM venda v JOIN item_venda iv ON v.id = iv.venda_id
JOIN cliente c ON c.id = v.cliente_id
JOIN produto p ON p.id = iv.produto_id
JOIN funcionario f ON f.id = v.funcionario_id
WHERE tipo_pagamento = 'D'
ORDER BY data DESC;

CREATE VIEW consulta02 AS SELECT p.nome, p.descricao, p.estoque, p.fabricante, iv.quantidade, v.data
FROM produto p JOIN item_venda iv ON p.id = iv.produto_id
JOIN venda v ON v.id = iv.venda_id
WHERE p.fabricante like '%lar%'
ORDER BY p.nome;

CREATE VIEW consulta03 AS SELECT c.nome AS cliente, p.nome AS produto, SUM(iv.subtotal), SUM(iv.quantidade)
FROM produto p JOIN item_venda iv ON p.id = iv.produto_id 
JOIN venda v ON  v.id = iv.venda_id
JOIN cliente c ON c.id = v.cliente_id
GROUP BY c.nome, p.nome;


