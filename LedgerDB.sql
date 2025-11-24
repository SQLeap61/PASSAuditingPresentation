Create database LedgerDemo
  with ledger = on;


  select *
  into Customer
  from EncryptionTest.dbo.customer

 --   Find your ledger tables

SELECT 
		ts.[name] + '.' + t.[name] AS [ledger_table_name]
		, hs.[name] + '.' + h.[name] AS [history_table_name]
		, vs.[name] + '.' + v.[name] AS [ledger_view_name]
FROM sys.tables AS t
JOIN sys.tables AS h ON (h.[object_id] = t.[history_table_id])
JOIN sys.views v ON (v.[object_id] = t.[ledger_view_id])
JOIN sys.schemas ts ON (ts.[schema_id] = t.[schema_id])
JOIN sys.schemas hs ON (hs.[schema_id] = h.[schema_id])
JOIN sys.schemas vs ON (vs.[schema_id] = v.[schema_id])
WHERE t.[name] = 'Customer';

---- Your LedgerHistory file may be different than the one below.   

select * from dbo.MSSQL_LedgerHistoryFor_901578250

Select * 
	from customer 
	where customerID = 139475

select top 100 *
From Customer

update customer  
	set firstname = 'BOB'
	where customerID = 139475 

select top 100 *
From Customer