
/*Consulta dados de correspondencia*/
CREATE VIEW Dados_Correpondencia
AS
SELECT C.Nome_Cliente AS Nome, E.CEP AS CEP, E.Logradouro AS Endereco, C.End_Num AS Numero, C.Complemento AS Complemento, B.Bairro AS Bairro, Ci.Cidade As Cidade, Es.Estado AS Estado
FROM Clientes AS C
LEFT JOIN Endereco AS E
ON C.Endereco_idEndereco = E.idEndereco
LEFT JOIN Bairro AS B
ON E.Bairro_idBairro = B.idBairro
LEFT JOIN Cidade_has_Bairro AS CB
ON CB.Bairro_idBairro = B.idBairro
LEFT JOIN Cidade AS Ci
ON CB.Cidade_idCidade = Ci.idCidade
LEFT JOIN Cidade_has_Estado AS CE
ON CE.Cidade_idCidade = Ci.idCidade
LEFT JOIN Estado AS Es
ON CE.Estado_idEstado = Es.idEstado

SELECT * FROM Dados_Correpondencia ORDER BY Nome


/*2consulta clientes PF*/
CREATE VIEW Clientes_PF
AS
SELECT C.Nome_Cliente AS Nome, PF.CPF AS CPF, C.Email AS Email, T.Numero AS Telefone
FROM Clientes AS C
RIGHT JOIN PF
ON C.idClientes = PF.Clientes_idClientes
INNER JOIN Telefone AS T
ON C.idClientes = T.idTelefone

SELECT * FROM Clientes_PF ORDER BY Nome

/*3consulta clientes PJ*/
CREATE VIEW Clientes_PJ
AS
SELECT C.Nome_Cliente AS Nome, PJ.CNPJ AS CNPJ, C.Email AS Email, T.Numero AS Telefone
FROM Clientes AS C
RIGHT JOIN PJ
ON C.idClientes = PJ.Clientes_idClientes
INNER JOIN Telefone AS T
ON C.idClientes = T.idTelefone

SELECT * FROM Clientes_PJ ORDER BY Nome

/*4consulta de propostas e apolices*/
CREATE VIEW Propostas_Apolices_Clientes
AS
SELECT C.Nome_Cliente AS Cliente, P.Prop_Num AS Proposta, A.Apol_Num AS Apolice, P.Inicio_Vig AS Inicio, P.Vencimento AS Vencimento, S.Seguradora AS Seguradora, R.Ramo AS Ramo, P.Premio_Total AS Premio
FROM Clientes AS C
INNER JOIN Propostas AS P
ON C.idClientes = P.Clientes_idClientes
INNER JOIN Seguradoras AS S
ON P.Seguradoras_idSeguradoras = S.idSeguradoras
INNER JOIN Ramos AS R
ON P.Ramos_idRamos = R.idRamos
INNER JOIN Apolice AS A
ON P.idPropostas = A.Propostas_idPropostas


SELECT * FROM Propostas_Apolices_Clientes ORDER BY Cliente

/*5aniversariantes dos proximos 15 dias*/
CREATE VIEW Aniversariantes
AS
SELECT C.Nome_Cliente AS Nome, C.Email AS Email, T.Numero AS Telefone, PF.Nascimento AS Data,FLOOR(DATEDIFF(DAY,PF.Nascimento,GETDATE()) / 365.25) AS Idade_Atual
FROM Clientes AS C
INNER JOIN Clientes_has_Telefone AS CT
ON CT.Clientes_idClientes = C.idClientes
INNER JOIN Telefone AS T
ON CT.Telefone_idTelefone = T.idTelefone
INNER JOIN PF
ON C.idClientes = PF.Clientes_idClientes
WHERE 1 = (FLOOR(DATEDIFF(DAY,PF.Nascimento,GETDATE()+15) / 365.25)) - (FLOOR(DATEDIFF(DAY,PF.Nascimento,GETDATE()) / 365.25))


SELECT * FROM Aniversariantes ORDER BY MONTH(Data), DAY(Data)

/*6consulta de apolice por cidade e estado*/
CREATE VIEW Apolice_Cidade_Estado
AS
SELECT A.Apol_Num AS Apolice, C.Cidade AS Cidade, E.Estado AS Estado
FROM Apolice AS A
LEFT JOIN Propostas AS P
ON P.idPropostas = A.Propostas_idPropostas
LEFT JOIN Clientes AS Cl
ON Cl.idClientes = P.Clientes_idClientes
LEFT JOIN Endereco AS En
ON En.idEndereco = Cl.Endereco_idEndereco
LEFT JOIN Bairro AS B
ON B.idBairro = En.Bairro_idBairro
LEFT JOIN Cidade_has_Bairro AS CB
ON CB.Bairro_idBairro = B.idBairro
LEFT JOIN Cidade AS C
ON C.idCidade = CB.Cidade_idCidade
LEFT JOIN Cidade_has_Estado AS CE
ON CE.Cidade_idCidade = C.idCidade
LEFT JOIN Estado AS E
ON E.idEstado = CE.Estado_idEstado

SELECT * FROM Apolice_Cidade_Estado ORDER BY Cidade, Estado

/*7 consulta de quantidade de proposta e premio total por estado por ano*/
CREATE VIEW Qtd_Total_Estado
AS
SELECT Es.Estado AS Estado, (SELECT COUNT(P.Prop_Num) FROM Propostas AS P	
														RIGHT JOIN Clientes AS Cl
														ON Cl.idClientes = P.Clientes_idClientes
														RIGHT JOIN Endereco AS En
														ON En.idEndereco = Cl.Endereco_idEndereco
														RIGHT JOIN Bairro AS B
														ON B.idBairro = En.Bairro_idBairro
														RIGHT JOIN Cidade_has_Bairro AS CB
														ON CB.Bairro_idBairro = B.idBairro
														RIGHT JOIN Cidade AS C
														ON C.idCidade = CB.Cidade_idCidade
														RIGHT JOIN Cidade_has_Estado AS CE
														ON CE.Cidade_idCidade = C.idCidade
														RIGHT JOIN Estado AS E
														ON E.idEstado = CE.Estado_idEstado
														WHERE Estado = Es.Estado AND YEAR(P.Data_Transmissao) = 2015) AS Quantidade_2015,
		(SELECT SUM(P.Premio_Total) FROM Propostas AS P	
														RIGHT JOIN Clientes AS Cl
														ON Cl.idClientes = P.Clientes_idClientes
														RIGHT JOIN Endereco AS En
														ON En.idEndereco = Cl.Endereco_idEndereco
														RIGHT JOIN Bairro AS B
														ON B.idBairro = En.Bairro_idBairro
														RIGHT JOIN Cidade_has_Bairro AS CB
														ON CB.Bairro_idBairro = B.idBairro
														RIGHT JOIN Cidade AS C
														ON C.idCidade = CB.Cidade_idCidade
														RIGHT JOIN Cidade_has_Estado AS CE
														ON CE.Cidade_idCidade = C.idCidade
														RIGHT JOIN Estado AS E
														ON E.idEstado = CE.Estado_idEstado
														WHERE Estado = Es.Estado AND YEAR(P.Data_Transmissao) = 2015) AS Total_Premio_2015,
		(SELECT AVG(P.Premio_Total) FROM Propostas AS P	
														RIGHT JOIN Clientes AS Cl
														ON Cl.idClientes = P.Clientes_idClientes
														RIGHT JOIN Endereco AS En
														ON En.idEndereco = Cl.Endereco_idEndereco
														RIGHT JOIN Bairro AS B
														ON B.idBairro = En.Bairro_idBairro
														RIGHT JOIN Cidade_has_Bairro AS CB
														ON CB.Bairro_idBairro = B.idBairro
														RIGHT JOIN Cidade AS C
														ON C.idCidade = CB.Cidade_idCidade
														RIGHT JOIN Cidade_has_Estado AS CE
														ON CE.Cidade_idCidade = C.idCidade
														RIGHT JOIN Estado AS E
														ON E.idEstado = CE.Estado_idEstado
														WHERE Estado = Es.Estado AND YEAR(P.Data_Transmissao) = 2015) AS Media_2015,

		(SELECT COUNT(P.Prop_Num) FROM Propostas AS P	
														RIGHT JOIN Clientes AS Cl
														ON Cl.idClientes = P.Clientes_idClientes
														RIGHT JOIN Endereco AS En
														ON En.idEndereco = Cl.Endereco_idEndereco
														RIGHT JOIN Bairro AS B
														ON B.idBairro = En.Bairro_idBairro
														RIGHT JOIN Cidade_has_Bairro AS CB
														ON CB.Bairro_idBairro = B.idBairro
														RIGHT JOIN Cidade AS C
														ON C.idCidade = CB.Cidade_idCidade
														RIGHT JOIN Cidade_has_Estado AS CE
														ON CE.Cidade_idCidade = C.idCidade
														RIGHT JOIN Estado AS E
														ON E.idEstado = CE.Estado_idEstado
														WHERE Estado = Es.Estado AND YEAR(P.Data_Transmissao) = 2016) AS Quantidade_2016,
		(SELECT SUM(P.Premio_Total) FROM Propostas AS P	
														RIGHT JOIN Clientes AS Cl
														ON Cl.idClientes = P.Clientes_idClientes
														RIGHT JOIN Endereco AS En
														ON En.idEndereco = Cl.Endereco_idEndereco
														RIGHT JOIN Bairro AS B
														ON B.idBairro = En.Bairro_idBairro
														RIGHT JOIN Cidade_has_Bairro AS CB
														ON CB.Bairro_idBairro = B.idBairro
														RIGHT JOIN Cidade AS C
														ON C.idCidade = CB.Cidade_idCidade
														RIGHT JOIN Cidade_has_Estado AS CE
														ON CE.Cidade_idCidade = C.idCidade
														RIGHT JOIN Estado AS E
														ON E.idEstado = CE.Estado_idEstado
														WHERE Estado = Es.Estado AND YEAR(P.Data_Transmissao) = 2016) AS Total_Premio_2016,
		(SELECT AVG(P.Premio_Total) FROM Propostas AS P	
														RIGHT JOIN Clientes AS Cl
														ON Cl.idClientes = P.Clientes_idClientes
														RIGHT JOIN Endereco AS En
														ON En.idEndereco = Cl.Endereco_idEndereco
														RIGHT JOIN Bairro AS B
														ON B.idBairro = En.Bairro_idBairro
														RIGHT JOIN Cidade_has_Bairro AS CB
														ON CB.Bairro_idBairro = B.idBairro
														RIGHT JOIN Cidade AS C
														ON C.idCidade = CB.Cidade_idCidade
														RIGHT JOIN Cidade_has_Estado AS CE
														ON CE.Cidade_idCidade = C.idCidade
														RIGHT JOIN Estado AS E
														ON E.idEstado = CE.Estado_idEstado
														WHERE Estado = Es.Estado AND YEAR(P.Data_Transmissao) = 2016) AS Media_2016
		
		FROM Estado AS Es		

SELECT * FROM Qtd_Total_Estado ORDER BY Quantidade_2015 DESC, Quantidade_2016 DESC


/*8consulta propostas por ramo e valor*/
CREATE VIEW Proposta_Ramo_Valor
AS
SELECT P.Prop_Num AS Proposta, R.Ramo AS Ramo, P.Premio_Total AS Premio
FROM Propostas AS P
LEFT JOIN Ramos AS R
ON P.Ramos_idRamos = R.idRamos

SELECT * FROM Proposta_Ramo_Valor ORDER BY Ramo

/*9consulta das propostas que vencem nos proximos 30 dias*/
CREATE VIEW Propostas_Vencimento
AS
SELECT C.Nome_Cliente AS Cliente, C.Email AS Email, T.Numero AS Telefone, P.Prop_Num AS Proposta, P.Vencimento AS Vencimento
FROM Propostas AS P
LEFT JOIN Clientes AS C
ON P.Clientes_idClientes = C.idClientes
LEFT JOIN Clientes_has_Telefone AS CT
ON CT.Clientes_idClientes = C.idClientes
LEFT JOIN Telefone AS T
ON CT.Telefone_idTelefone = T.idTelefone
WHERE (P.Vencimento > GETDATE()) AND (P.Vencimento < (GETDATE()+30))

SELECT * FROM Propostas_Vencimento ORDER BY MONTH(Vencimento), DAY(Vencimento)

/*10consulta produção de 2016*/
CREATE VIEW Producao2016
AS
SELECT COUNT(P.Prop_Num) AS Propostas, SUM(P.Premio_Total) AS Total, AVG(P.Premio_Total) AS Media, MIN(P.Premio_Total) AS Menor, MAX(P.Premio_Total) AS Maximo
FROM Propostas AS P
WHERE YEAR(P.Data_Transmissao) = 2016

SELECT * FROM Producao2016

/*11 consulta de quantidade e valores por ramos em 2016*/
CREATE VIEW Detalhes_Producao_2016
AS
SELECT (SELECT COUNT(Propostas.Prop_Num) FROM Propostas WHERE Propostas.Ramos_idRamos = 1 AND YEAR(Propostas.Data_Transmissao) = 2016) AS Automovel,
		(SELECT SUM(Propostas.Premio_Total) FROM Propostas WHERE Propostas.Ramos_idRamos = 1 AND YEAR(Propostas.Data_Transmissao) = 2016) AS Total_Automovel,
		(SELECT COUNT(Propostas.Prop_Num) FROM Propostas WHERE Propostas.Ramos_idRamos = 2 AND YEAR(Propostas.Data_Transmissao) = 2016) AS Residencial,
		(SELECT SUM(Propostas.Premio_Total) FROM Propostas WHERE Propostas.Ramos_idRamos = 2 AND YEAR(Propostas.Data_Transmissao) = 2016) AS Total_Residencial,
		(SELECT COUNT(Propostas.Prop_Num) FROM Propostas WHERE Propostas.Ramos_idRamos = 3 AND YEAR(Propostas.Data_Transmissao) = 2016) AS Vida,
		(SELECT SUM(Propostas.Premio_Total) FROM Propostas WHERE Propostas.Ramos_idRamos = 3 AND YEAR(Propostas.Data_Transmissao) = 2016) AS Total_Vida

SELECT * FROM Detalhes_Producao_2016


SELECT * FROM Estado




