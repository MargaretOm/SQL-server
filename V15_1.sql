USE AdventureWorks2012;
GO

CREATE TABLE Sales.CreditCardHst (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Action CHAR(6) NOT NULL CHECK (Action IN('INSERT', 'UPDATE', 'DELETE')),
    ModifiedDate DATETIME NOT NULL,
    SourceID INT NOT NULL,
    UserName VARCHAR(50) NOT NULL
);
GO


CREATE TRIGGER Sales.Trigger_CreditCard_After_DML
ON Sales.CreditCard
AFTER INSERT, UPDATE, DELETE AS 
    INSERT INTO Sales.CreditCardHst(Action, ModifiedDate, SourceID, UserName) 
    SELECT
      CASE WHEN inserted.CreditCardID IS NULL THEN 'DELETE'
           WHEN  deleted.CreditCardID IS NULL THEN 'INSERT'
                                              ELSE 'UPDATE'
      END                                                   AS Action,
      GetDate()                                             AS ModifiedDate,
	  COALESCE(inserted.CreditCardID, deleted.CreditCardID) AS SourceID,
      User_Name()                                           AS UserName
    FROM inserted FULL OUTER JOIN deleted
    ON inserted.CreditCardID = deleted.CreditCardID
GO



CREATE VIEW Sales.View_CreditCard AS SELECT * FROM Sales.CreditCard
GO


INSERT INTO Sales.View_CreditCard(CardNumber, CardType, ExpMonth, ExpYear, ModifiedDate)
VALUES (11111111111111, '123', 31, 2020, GetDate());
GO

UPDATE Sales.View_CreditCard SET CardType = '321' WHERE CardNumber = 11111111111111;
GO

DELETE FROM Sales.View_CreditCard WHERE CardNumber = 11111111111111;
GO

SELECT * FROM Sales.CreditCardHst;
GO

