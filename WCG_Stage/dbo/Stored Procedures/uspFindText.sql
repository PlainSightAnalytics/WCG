
CREATE PROCEDURE [dbo].[uspFindText]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe (OM26233)
-- Date Created			:	23-02-2018
-- Reason				:	Common search procedure to return instances of text from all BI databases (sps, views, functions)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	None
-- Ouputs				:	None
-- Parameters			:	None
-- Test					:	uspFindText 'text'
--------------------------------------------------------------------------------------------------------------------------------------

@TextToFind VARCHAR(MAX)

AS

/* Declare Variables */
DECLARE @Command VARCHAR(MAX)
DECLARE @TextToFindString VARCHAR(MAX)
DECLARE @DBName VARCHAR(MAX)

/* Convert Text to wildcard format */
SELECT @TextToFindString = '%' + @TextToFind + '%';

/* Create Temp Table for results */
CREATE TABLE #temp (ObjectName VARCHAR(100))

/* Use Cursor to loop through each database and save found objects into temp table */
DECLARE DBcursor CURSOR  FOR 
    SELECT name FROM master.dbo.sysdatabases 
    WHERE  name IN ('WCG_DW', 'WCG_STAGE') 
	ORDER BY name;

    OPEN DBcursor; 
	
	FETCH  DBcursor INTO @DBName; 

    WHILE (@@FETCH_STATUS = 0) 
      BEGIN 
        DECLARE @dbContext nvarchar(256)=@dbName+'.dbo.'+'sp_executeSQL'
        SET @Command = 'USE ' + @DBName + '; insert into #temp (Objectname) 
		select distinct db_name() + ''.'' + s.name + ''.'' + o.name 
		from sys.objects o
		left join sys.schemas s on o.schema_id = s.schema_id
		left join sys.syscomments c on o.object_id = c.id
		where c.text like ''' + @TextToFindString  + ''''

		exec(@Command)

        FETCH  DBcursor INTO @dbName; 

     END; 

   CLOSE DBcursor; 
   DEALLOCATE DBcursor; 

/* Return Results */
SELECT * FROM #temp ORDER BY ObjectName

/* Drop Temp Table */
DROP TABLE #temp

