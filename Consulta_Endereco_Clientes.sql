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