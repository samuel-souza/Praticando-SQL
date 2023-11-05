/*
Tabelas utilizadas:
tabela de clientes
*/

-- FUN��ES DE TEXTO

/* LOWER
Retorna uma express�o de caracteres depois de converter para min�sculas os dados de caracteres mai�sculos 
*/

SELECT 
	nome, 
	nome_minusculo = LOWER(nome) 
FROM tabela_de_clientes

/* UPPER
Retorna uma express�o de caracteres com dados de caractere em min�scula convertidos em mai�scula	
*/

SELECT 
	nome, 
	nome_maiusculo = UPPER(nome) 
FROM tabela_de_clientes

/* CONCAT
Essa fun��o retorna uma cadeia de caracteres resultante de concatena��o ou jun��o de dois ou mais valores de cadeia de caracteres ponta a ponta,
tamb�m pode ser utilizado por meio do '+'
*/

SELECT 
	cpf,
	nome, 
	[cpf + nome] = CONCAT(cpf, nome) 
FROM tabela_de_clientes;

SELECT 
	cpf,
	nome, 
	[cpf + nome] = cpf + nome 
FROM tabela_de_clientes

/* RIGHT
Retorna a parte DIREITA de uma cadeia de caracteres de acordo com o numero de caracteres especificado.
*/

SELECT 
	cpf, 
	tres_ultimos_digitos = RIGHT(cpf,3)
FROM tabela_de_clientes

/* LEFT
Retorna a parte ESQUERDA de uma cadeia de caracteres de acordo com o numero de caracteres especificado.
*/

SELECT 
	cpf, 
	tres_primeiros_digitos = LEFT(cpf,3)
FROM tabela_de_clientes

/* REPLICATE 
Repete um valor da cadeia de caracteres um n�mero espec�fico de vezes.
*/

SELECT 
	genero, 
	genero_repeticao = REPLICATE(genero,3)
FROM tabela_de_clientes

/* SUBSTRING
Retorna a parte de uma express�o de caractere, bin�ria, de texto ou de imagem no SQL Server.
*/

SELECT 
	cpf, 
	particao_nome = SUBSTRING(cpf,3,11) -- inicia a partir do terceiro digito indo at� o 11 d�gito
FROM tabela_de_clientes

/* LTRIM
Remove o caractere de espa�o char(32) ou outros caracteres especificados do IN�CIO de uma cadeia de caracteres.
*/

SELECT 
	LTRIM('          RETIRANDO ESPA�OS A ESQUERDA <<'),
	LTRIM('//////////RETIRANDO SIMBOLOS A ESQUERDA <<', '/')

/* RTRIM
Remove o caractere de espa�o char(32) ou outros caracteres especificados do FINAL de uma cadeia de caracteres.
*/

SELECT 
	RTRIM('>> RETIRANDO ESPA�OS A DIREITA          '),
	RTRIM('>> RETIRANDO SIMBOLOS A DIREITA//////////', '/')

/* TRIM
Remove o caractere de espa�o char(32) ou outros caracteres especificados do IN�CIO E FINAL de uma cadeia de caracteres.
*/

SELECT 
	TRIM('          <<RETIRANDO ESPA�OS EM AMBOS OS LADOS>>          '),
	TRIM('/' FROM '//////////<<RETIRANDO SIMBOLOS EM AMBOS OS LADOS>>//////////')

/* REPLACE
Substitui todas as ocorr�ncias de um valor da cadeia de caracteres especificados por outro valor de cadeia de caracteres.
*/

SELECT 
	nome,
	nome_substituicao = REPLACE(nome, ' ', '-')
FROM tabela_de_clientes

/* REPLACE
Retorna o n�mero de caracteres da express�o de cadeia de caracteres especificada, excluindo espa�os a direita
*/

SELECT 
	nome,
	tamanho_nome = LEN(nome)
FROM tabela_de_clientes

-- FUN��ES DE DATA

/*
DATEPART / ABREVIACAO
year / y, yy, yyyy
quarter / qq, q
month / mm, m
dayofyear / dy
day / dd, d
week / wk, ww
hour / hh
minute / mi, n
second / ss, s
millisecond / ms
microsecond / mcs
nanosecond / ns
*/


/* DATEADD
Essa fun��o adiciona um n�mero (um inteiro com sinal) a um datepart de uma data de entrada e retorna um valor de data/hora modificado.

   GETDATE
Essa fun��o pega a data e hora atual do computador.
*/

SELECT 
	hoje = GETDATE(),
	daqui_30_dias = DATEADD(DAY, 30, GETDATE()),
	daqui_1_ano = DATEADD(YEAR, 1, GETDATE())

/* DATEDIFF
Essa fun��o retorna a contagem (como um valor inteiro com sinal) ou diferen�a dos limites de datepart especificados cruzados 
entre os par�metros especificados 'startdate' e 'enddate'.
*/

SELECT 
	idade = DATEDIFF(YEAR, '1999-06-27', GETDATE())

/* DATEPART
Essa fun��o retorna um inteiro que representa o datepart especificado do argumento date especificado.
*/

SELECT 
	data_de_hoje = GETDATE(),
	dia_atual = DATEPART(DAY, GETDATE()),
	mes_atual = DATEPART(MONTH, GETDATE()),
	ano_atual = DATEPART(YEAR, GETDATE())

/* DAY, MONTH e YEAR
Essas fun��es retornam seus respectivos dateparts em uma data especificada.
*/

SELECT 
	data_de_hoje = GETDATE(),
	dia_atual = DAY(GETDATE()),
	mes_atual = MONTH(GETDATE()),
	ano_atual = YEAR(GETDATE())

/* ISDATE
Retornar� 1 se a express�o for datetime e 0 caso contr�rio.
*/

SELECT 
	[� data] = ISDATE(GETDATE()),
	[n�o � data] = ISDATE('Samuel')

-- FUN��ES NUM�RICAS

/* ROUND
Retorna um valor num�rico, arredondado, para o comprimento ou precis�o especificados (valor real).
*/

SELECT 
	valor = PI(),
	valor_arredondado = ROUND(PI(),2)

/* CEILING
Retorna o menor inteiro maior que ou igual ao n�mero real especificado (arredonda pra cima).
*/

SELECT 
	valor = PI(),
	valor_arredondado = CEILING(PI())

/* FLOOR
Retorna o menor inteiro menor que ou igual ao n�mero real especificado (arredonda pra baixo).
*/

SELECT 
	valor = PI(),
	valor_arredondado = FLOOR(PI())

/* POWER
Retorna a pot�ncia do valor especificado.
*/

SELECT 
	valor = PI(),
	valor_arredondado = POWER(PI(),2)

/* EXP
Retorna o valor exponencial do valor real (ou numero de euler na base 1).
*/

SELECT 
	euler = EXP(1)

/* SQRT
Retorna a raiz quadrada do valor.
*/

SELECT
	valor = 9,
	raiz = SQRT(9)

/* SIGN
Retorna 1 se o valor for positivo, -1 se negativo e 0 se nulo.
*/

SELECT
	positivo = SIGN(38),
	negativo = SIGN(-38),
	nulo = SIGN(0)

/* ABS
Retorna o valor absoluto (dist�ncia da origem) para o n�mero real especificado.
*/

SELECT
	positivo = ABS(38),
	negativo = ABS(-38)

/* %
Retorna o resto da divis�o inteira.
*/

SELECT 
	9%2

/* LOG, LOG10
Retorna o logaritmo natural ou logaritmo base10 para o valor especificado.
*/

SELECT
	[log] = LOG(38),
	[log10] = LOG10(38)
	
-- FUN��ES DE CONVERS�O

/* Diferen�a entre as fun��es:

CAST � uma fun��o ANSI SQL padr�o, o que significa que � mais port�til e compat�vel com outros sistemas de gerenciamento de banco de dados.
CONVERT, embora amplamente suportada no SQL Server, n�o � uma fun��o padr�o ANSI SQL e pode n�o ser suportada por todos os sistemas de banco de dados.

*/


/* CAST
Converte um tipo de dado para outro especificado.
*/

SELECT
	data_original = data_de_nascimento,
	data_convertida = CAST(data_de_nascimento AS DATETIME)
FROM tabela_de_clientes

/* CONVERT
Converte um tipo de dado para outro especificado.
*/

SELECT
	data_original = data_de_nascimento,
	data_convertida = CONVERT(DATETIME, data_de_nascimento, 13)
FROM tabela_de_clientes
