USE master;
GO

ALTER DATABASE AdventureWorks2017 SET QUERY_STORE = ON;
GO

ALTER DATABASE AdventureWorks2017 SET QUERY_STORE (OPERATION_MODE = READ_WRITE);
GO

ALTER DATABASE AdventureWorks2017 SET COMPATIBILITY_LEVEL = 100;
GO

USE master;
GO

ALTER DATABASE AdventureWorks2017 SET COMPATIBILITY_LEVEL = 150;
GO

// Run a workload 

USE AdventureWorks2017

GO

SELECT SalesOrderId, OrderDate

FROM Sales.SalesOrderHeader 

WHERE SalesPersonID=288;


USE [AdventureWorks2017]

GO

SELECT SalesOrderId, OrderDate

FROM Sales.SalesOrderHeader

WHERE SalesPersonID=277;


USE AdventureWorks2017  
GO 

CREATE OR ALTER PROCEDURE getSalesOrder  
@PersonID INT 
AS 
SELECT SalesOrderId, OrderDate 
FROM Sales.SalesOrderHeader 
WHERE SalesPersonID = @PersonID 
GO

// Execute the parameter 

EXEC getSalesOrder 277 
GO  

// Execute the Sales order 

EXEC getSalesOrder 288 
GO  

// Execute the order 

USE AdventureWorks2017  
GO 
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;  
GO

EXEC getSalesOrder 288 
GO  

USE AdventureWorks2017  
GO 

CREATE OR ALTER PROCEDURE getSalesOrder  
@PersonID INT 
AS 
SELECT SalesOrderId, OrderDate  
FROM Sales.SalesOrderHeader   
WHERE SalesPersonID = @PersonID  
OPTION (OPTIMIZE FOR (@PersonID = 288));  
GO    

EXEC getSalesOrder 288; 
GO  

EXEC getSalesOrder 277; 
GO 

EXEC getSalesOrder 200;
GO 


