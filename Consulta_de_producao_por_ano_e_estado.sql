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
