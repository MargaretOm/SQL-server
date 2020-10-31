USE [AdventureWorks2012];
GO

CREATE VIEW Sales.View_ExtendedCreditCard (
	CreditCardID,
	CardType,
	CardNumber,
	ExpMonth,
	ExpYear,
	BusinessEntityID,
	ModifiedDate,
	PersonModifiedDate
) WITH ENCRYPTION, SCHEMABINDING AS SELECT 
	CC.CreditCardID,
	CC.CardType,
	CC.CardNumber,
	CC.ExpMonth,
	CC.ExpYear,
	PCC.BusinessEntityID,
	CC.ModifiedDate,
	PCC.ModifiedDate
FROM Sales.CreditCard AS CC INNER JOIN Sales.PersonCreditCard AS PCC
ON CC.CreditCardID = PCC.CreditCardID
GO

CREATE UNIQUE CLUSTERED INDEX AK_View_ExtendedCreditCard_CreditCardID ON Sales.View_ExtendedCreditCard (CreditCardId);
GO



CREATE TRIGGER Sales.Trigger_View_ExtendedCreditCard_Instead_Insert ON Sales.View_ExtendedCreditCard
INSTEAD OF INSERT AS
BEGIN
	INSERT INTO Sales.CreditCard (CardType, CardNumber, ExpMonth, ExpYear, ModifiedDate)
	SELECT  CardType, CardNumber, ExpMonth, ExpYear, COALESCE(ModifiedDate, GETDATE())
	FROM inserted;
	INSERT INTO Sales.PersonCreditCard (BusinessEntityID, CreditCardID, ModifiedDate)
	SELECT I.BusinessEntityID, CC.CreditCardID, GETDATE() 
	FROM inserted AS I JOIN Sales.CreditCard AS CC ON I.CardNumber = CC.CardNumber
END;
GO

CREATE TRIGGER Sales.Trigger_View_ExtendedCreditCard_Instead_Update ON Sales.View_ExtendedCreditCard
INSTEAD OF UPDATE AS
BEGIN
	UPDATE Sales.CreditCard SET 
		CardType = I.CardType, 
		CardNumber = I.CardNumber, 
		ExpMonth = I.ExpMonth, 
		ExpYear = I.ExpYear, 
		ModifiedDate = COALESCE(I.ModifiedDate, Sales.CreditCard.ModifiedDate)
	FROM inserted AS I
	WHERE I.CreditCardID = Sales.CreditCard.CreditCardID
END;
GO

CREATE TRIGGER Sales.Trigger_View_ExtendedCreditCard_Instead_Delete ON Sales.View_ExtendedCreditCard
INSTEAD OF DELETE AS
BEGIN
	DELETE FROM Sales.PersonCreditCard WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
	DELETE FROM Sales.CreditCard WHERE CreditCardID IN (SELECT CreditCardID FROM deleted) 
										AND CreditCardID NOT IN (SELECT CreditCardID FROM Sales.PersonCreditCard);
END;
GO


SELECT * FROM Sales.View_ExtendedCreditCard
ORDER BY CreditCardID DESC;
GO

INSERT INTO Sales.View_ExtendedCreditCard(
	CardType,
	CardNumber,
	ExpMonth,
	ExpYear,
	BusinessEntityID
) VALUES ('TestCardType', '11111111111111111', 10, 2020, 4955);
GO

SELECT * FROM Sales.View_ExtendedCreditCard
ORDER BY CreditCardID DESC;
GO

UPDATE Sales.View_ExtendedCreditCard SET
	CardType = 'Updated',
	CardNumber = '22222222222222222',
	ExpMonth = 11,
	ExpYear = 2020
WHERE CreditCardID = 19245
GO

DELETE FROM Sales.View_ExtendedCreditCard WHERE CardNumber = '22222222222222222';

SELECT * FROM Sales.CreditCardHst