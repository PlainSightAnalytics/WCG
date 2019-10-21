ALTER ROLE [db_owner] ADD MEMBER [pbi_user];


GO
ALTER ROLE [db_datareader] ADD MEMBER [pbi_user];


GO
ALTER ROLE [db_datareader] ADD MEMBER [NT SERVICE\MSSQLServerOLAPService];

