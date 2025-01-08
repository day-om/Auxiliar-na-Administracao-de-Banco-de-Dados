/*1. Crie um stored procedure que receba id de cliente, data inicial e data final, e que mostre a lista de compras realizadas pelo referido cliente entre as datas informadas 
(incluindo essas datas), mostrando nome do cliente, id da compra, total, nome e quantidade de cada produto comprado. No script, inclua o código de criação
e o comando de chamada da procedure.*/

DELIMITER //
CREATE PROCEDURE atv2_1 (IN id_cliente INT, data_inicial DATE, data_final DATE)
BEGIN    
	   
    SELECT c.nome AS nome_cliente, v.id AS id_venda, v.valor_total, p.nome AS produto, iv.quantidade FROM
    cliente c JOIN venda v ON c.id = v.cliente_id JOIN
    produto p JOIN item_venda iv ON iv.produto_id = p.id
    WHERE id_cliente = v.cliente_id AND v.data BETWEEN data_inicial AND data_final;
	    
END //
DELIMITER ;

CALL atv2_1 (50,'2019-01-05','2020-05-11');

/*2.Crie uma stored function que receba id de cliente e retorne se o cliente é “PREMIUM” ou “REGULAR”. Um cliente é “PREMIUM” se já realizou mais de R$ 10 mil em compras na loja.
  Se não, é um cliente “REGULAR”. No script, inclua o código de criação e o comando de chamada da function.*/
  
  DELIMITER //
  CREATE FUNCTION atv2_2 (id_cliente INT)
  RETURNS VARCHAR(10) DETERMINISTIC 
  BEGIN
	DECLARE total_cliente DECIMAL(5,2);
    DECLARE tipo_cliente VARCHAR (10);
    SET total_cliente = (SELECT COUNT(valor_total) FROM venda WHERE id_cliente = cliente_id);
    IF total_cliente > 10.000 THEN
		SET tipo_cliente = 'PREMIUM';
	ELSE
		SET tipo_cliente = 'REGULAR';
	END IF;
        
	RETURN tipo_cliente;
  END //
  DELIMITER ;
  
SELECT atv2_2(2);


/*3.Crie um trigger que atue sobre a tabela “usuário” de modo que, ao incluir um novo usuário,
 aplique automaticamente MD5() à coluna “senha”; utilize nesta atividade variáveis com NEW.*/
 
 DELIMITER //
 
 CREATE trigger atv2_3 BEFORE INSERT ON usuario
 FOR EACH ROW
 BEGIN
 SET NEW.senha = MD5(senha);
 
 END //
 DELIMITER ;



