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