/*
Tabelas utilizadas:
tabela de clientes
*/

-- FUNÇÕES DE TEXTO

/* LOWER
Retorna uma expressão de caracteres depois de converter para minúsculas os dados de caracteres maiúsculos 
*/

SELECT 
	nome, 
	nome_minusculo = LOWER(nome) 
FROM tabela_de_clientes

/* UPPER
Retorna uma expressão de caracteres com dados de caractere em minúscula convertidos em maiúscula	
*/

SELECT 
	nome, 
	nome_maiusculo = UPPER(nome) 
FROM tabela_de_clientes

/* CONCAT
Essa função retorna uma cadeia de caracteres resultante de concatenação ou junção de dois ou mais valores de cadeia de caracteres ponta a ponta,
também pode ser utilizado por meio do '+'
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
Repete um valor da cadeia de caracteres um número específico de vezes.
*/

SELECT 
	genero, 
	genero_repeticao = REPLICATE(genero,3)
FROM tabela_de_clientes

/* SUBSTRING
Retorna a parte de uma expressão de caractere, binária, de texto ou de imagem no SQL Server.
*/

SELECT 
	cpf, 
	particao_nome = SUBSTRING(cpf,3,11) -- inicia a partir do terceiro digito indo até o 11 dígito
FROM tabela_de_clientes

/* LTRIM
Remove o caractere de espaço char(32) ou outros caracteres especificados do INÍCIO de uma cadeia de caracteres.
*/

SELECT 
	LTRIM('          RETIRANDO ESPAÇOS A ESQUERDA <<'),
	LTRIM('//////////RETIRANDO SIMBOLOS A ESQUERDA <<', '/')

/* RTRIM
Remove o caractere de espaço char(32) ou outros caracteres especificados do FINAL de uma cadeia de caracteres.
*/

SELECT 
	RTRIM('>> RETIRANDO ESPAÇOS A DIREITA          '),
	RTRIM('>> RETIRANDO SIMBOLOS A DIREITA//////////', '/')

/* TRIM
Remove o caractere de espaço char(32) ou outros caracteres especificados do INÍCIO E FINAL de uma cadeia de caracteres.
*/

SELECT 
	TRIM('          <<RETIRANDO ESPAÇOS EM AMBOS OS LADOS>>          '),
	TRIM('/' FROM '//////////<<RETIRANDO SIMBOLOS EM AMBOS OS LADOS>>//////////')

/* REPLACE
Substitui todas as ocorrências de um valor da cadeia de caracteres especificados por outro valor de cadeia de caracteres.
*/

SELECT 
	nome,
	nome_substituicao = REPLACE(nome, ' ', '-')
FROM tabela_de_clientes

/* REPLACE
Retorna o número de caracteres da expressão de cadeia de caracteres especificada, excluindo espaços a direita
*/

SELECT 
	nome,
	tamanho_nome = LEN(nome)
FROM tabela_de_clientes

-- FUNÇÕES DE DATA

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
Essa função adiciona um número (um inteiro com sinal) a um datepart de uma data de entrada e retorna um valor de data/hora modificado.

   GETDATE
Essa função pega a data e hora atual do computador.
*/

SELECT 
	hoje = GETDATE(),
	daqui_30_dias = DATEADD(DAY, 30, GETDATE()),
	daqui_1_ano = DATEADD(YEAR, 1, GETDATE())

/* DATEDIFF
Essa função retorna a contagem (como um valor inteiro com sinal) ou diferença dos limites de datepart especificados cruzados 
entre os parâmetros especificados 'startdate' e 'enddate'.
*/

SELECT 
	idade = DATEDIFF(YEAR, '1999-06-27', GETDATE())

/* DATEPART
Essa função retorna um inteiro que representa o datepart especificado do argumento date especificado.
*/

SELECT 
	data_de_hoje = GETDATE(),
	dia_atual = DATEPART(DAY, GETDATE()),
	mes_atual = DATEPART(MONTH, GETDATE()),
	ano_atual = DATEPART(YEAR, GETDATE())

/* DAY, MONTH e YEAR
Essas funções retornam seus respectivos dateparts em uma data especificada.
*/

SELECT 
	data_de_hoje = GETDATE(),
	dia_atual = DAY(GETDATE()),
	mes_atual = MONTH(GETDATE()),
	ano_atual = YEAR(GETDATE())

/* ISDATE
Retornará 1 se a expressão for datetime e 0 caso contrário.
*/

SELECT 
	[é data] = ISDATE(GETDATE()),
	[não é data] = ISDATE('Samuel')

-- FUNÇÕES NUMÉRICAS

/* ROUND
Retorna um valor numérico, arredondado, para o comprimento ou precisão especificados (valor real).
*/

SELECT 
	valor = PI(),
	valor_arredondado = ROUND(PI(),2)

/* CEILING
Retorna o menor inteiro maior que ou igual ao número real especificado (arredonda pra cima).
*/

SELECT 
	valor = PI(),
	valor_arredondado = CEILING(PI())

/* FLOOR
Retorna o menor inteiro menor que ou igual ao número real especificado (arredonda pra baixo).
*/

SELECT 
	valor = PI(),
	valor_arredondado = FLOOR(PI())

/* POWER
Retorna a potência do valor especificado.
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
Retorna o valor absoluto (distância da origem) para o número real especificado.
*/

SELECT
	positivo = ABS(38),
	negativo = ABS(-38)

/* %
Retorna o resto da divisão inteira.
*/

SELECT 
	9%2

/* LOG, LOG10
Retorna o logaritmo natural ou logaritmo base10 para o valor especificado.
*/

SELECT
	[log] = LOG(38),
	[log10] = LOG10(38)
	
-- FUNÇÕES DE CONVERSÃO

/* Diferença entre as funções:

CAST é uma função ANSI SQL padrão, o que significa que é mais portátil e compatível com outros sistemas de gerenciamento de banco de dados.
CONVERT, embora amplamente suportada no SQL Server, não é uma função padrão ANSI SQL e pode não ser suportada por todos os sistemas de banco de dados.

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
