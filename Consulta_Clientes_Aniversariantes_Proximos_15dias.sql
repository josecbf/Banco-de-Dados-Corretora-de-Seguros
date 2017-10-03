/*Aniversariantes dos proximos 15 dias*/
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