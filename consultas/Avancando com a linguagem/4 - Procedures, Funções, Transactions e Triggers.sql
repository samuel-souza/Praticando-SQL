-- Estrutura de uma função

CREATE FUNCTION DOBRO (@NUMERO FLOAT)
RETURNS FLOAT
AS
BEGIN
	RETURN @numero * 2
END;

-- Executando a função

SELECT dbo.DOBRO(5);
PRINT dbo.DOBRO(5);


-- Exemplo de função

	SELECT * FROM clientes;
	SELECT * FROM itens_vendidos;
	SELECT * FROM produtos;
	SELECT * FROM vendedores;
	SELECT * FROM vendas;


-- Localizador de informações de cliente na base

CREATE FUNCTION Localiza 
(
    @CPF VARCHAR(11)
)
RETURNS TABLE
AS 
RETURN
( -- Em retorno de consultas maiores, não é necessário o uso de BEGIN e END, mas sim o uso dos parênteses
    SELECT 
        a.cpf,
        endereco = CONCAT(a.endereco, ', ', a.bairro, ', ', a.cidade, ', ', a.estado, ', ', a.cep),
        a.data_nascimento,
        a.idade,
        a.genero,
        a.limite_de_credito,
        b.qtd_compras,
        b.qtd_itens
    FROM clientes a
    INNER JOIN (
        SELECT
            a.cpf,
            qtd_compras = COUNT(a.numero),
            qtd_itens = SUM(b.quantidade)
        FROM vendas a
        INNER JOIN itens_vendidos b 
            ON a.numero = b.numero
        GROUP BY 
            a.cpf
    ) b
    ON a.cpf = b.cpf
    WHERE a.cpf = @CPF
);


-- Executando a função

SELECT * FROM [dbo].[Localiza]('7771579779')


-- Alterando função para adição do campo "nome" do cliente

ALTER FUNCTION Localiza 
(
    @CPF VARCHAR(11)
)
RETURNS TABLE
AS 
RETURN
( -- Em retorno de consultas maiores, não é necessário o uso de BEGIN e END, mas sim o uso dos parênteses
    SELECT 
        a.cpf,
		a.nome,
        endereco = CONCAT(a.endereco, ', ', a.bairro, ', ', a.cidade, ', ', a.estado, ', ', a.cep),
        a.data_nascimento,
        a.idade,
        a.genero,
        a.limite_de_credito,
        b.qtd_compras,
        b.qtd_itens
    FROM clientes a
    INNER JOIN (
        SELECT
            a.cpf,
            qtd_compras = COUNT(a.numero),
            qtd_itens = SUM(b.quantidade)
        FROM vendas a
        INNER JOIN itens_vendidos b 
            ON a.numero = b.numero
        GROUP BY 
            a.cpf
    ) b
    ON a.cpf = b.cpf
    WHERE a.cpf = @CPF
);

SELECT * FROM dbo.Localiza('7771579779')


-- Excluir a função

DROP FUNCTION dbo.Localiza


-- PROCEDURES

CREATE PROCEDURE CONCATENATE 
@STRING1 VARCHAR(255),
@STRING2 VARCHAR(255)
AS
BEGIN
	PRINT @STRING1 + @STRING2
END


-- Executando procedure

EXEC CONCATENATE @STRING1 = 'Samuel', @STRING2 = 'Souza'

CREATE FUNCTION CONCATENATE (
@STRING1 VARCHAR(255),
 	@STRING2 VARCHAR(255)
)
RETURNS VARCHAR(255)
AS
BEGIN
RETURN @STRING1 + @STRING2
END

SELECT dbo.CONCATENATE('Samuel','Souza')

PRINT dbo.CONCATENATE('Samuel', 'Souza')


-- Procedure para atualizar informações em uma tabela

-- Tab de exemplo:

CREATE TABLE ClientesExemplo (
    ID INT PRIMARY KEY,
    Nome NVARCHAR(100),
    Saldo DECIMAL(10, 2)
);

INSERT INTO ClientesExemplo (ID, Nome, Saldo)
VALUES
    (1, 'Cliente A', 1000.00),
    (2, 'Cliente B', 1500.00),
    (3, 'Cliente C', 800.50);


-- Procedure

CREATE PROCEDURE AtualizarSaldoCliente
    @ClienteID INT,
    @NovoSaldo DECIMAL(10, 2)
AS
BEGIN
    UPDATE ClientesExemplo
    SET Saldo = @NovoSaldo
    WHERE ID = @ClienteID;
END;


-- atualizando o saldo do Cliente com ID 2 para 2000.00

EXEC AtualizarSaldoCliente @ClienteID = 2, @NovoSaldo = 2000.00;


-- Verificando o resultado

SELECT * FROM ClientesExemplo;


-- Excluindo procedure

DROP PROCEDURE CONCATENATE


-- TRANSACTIONS


-- CASO 1:
-- Iniciar uma transação
BEGIN TRANSACTION;


-- Executar algumas operações SQL
UPDATE ClientesExemplo SET Saldo = 900.0 WHERE ID = 1;


-- Verificando
SELECT * FROM ClientesExemplo;


-- Para confirmar a transação
COMMIT;


-- CASO 2:
-- Iniciar uma transação
BEGIN TRANSACTION;


-- Executar algumas operações SQL
UPDATE ClientesExemplo SET Saldo = 90000.0 WHERE ID = 1;


-- Verificando
SELECT * FROM ClientesExemplo;


-- Se ocorrer um erro ou você deseja desfazer as alterações, use ROLLBACK pra cancelar a transação.
 ROLLBACK;


 -- Verificando
SELECT * FROM ClientesExemplo;


-- TRIGGERs (Gatilho)


-- Criando tabela de Logs

CREATE TABLE ClientesExemploLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT,
    DataHoraRegistro DATETIME
);

SELECT * FROM ClientesExemploLog;

-- Criando TRIGGER

CREATE TRIGGER Trigger_LogClientes
ON ClientesExemplo 
AFTER INSERT
AS
BEGIN
    INSERT INTO ClientesExemploLog (ClienteID, DataHoraRegistro)
    SELECT ID, GETDATE()
    FROM INSERTED;
END;

-- Verificando resultado

INSERT INTO ClientesExemplo(ID, nome, Saldo)
VALUES
(4, 'Samuel', 500.0)

SELECT * FROM ClientesExemplo;
SELECT * FROM ClientesExemploLog;


