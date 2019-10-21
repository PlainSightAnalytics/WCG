

CREATE PROCEDURE [man].[prcExtractPublicHolidays]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	23-07-2016
-- Reason				:	Loads Public Holidays from Text file
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName
-- Ouputs				:	None
-- Test					:	exec dbo.prcExtractPublicHolidays 'F:\WCG\data\PublicHolidays.txt'
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@FileName AS VARCHAR(MAX)

AS

DECLARE @SQL AS VARCHAR(MAX)

/* Truncate Public Holidays */
TRUNCATE TABLE WCG_Stage.man.PublicHolidays

/* Load from Public Holidays Text File */
SET @SQL = 'BULK INSERT WCG_Stage.man.PublicHolidays '
SET @SQL = @SQL + 'FROM ''' + @FileName + ''''
SET @SQL = @SQL + '   WITH   '
SET @SQL = @SQL + '      (  '
SET @SQL = @SQL + '         FIELDTERMINATOR =''\t'',  '
SET @SQL = @SQL + '         ROWTERMINATOR =''\n'','
SET @SQL = @SQL + '		 FIRSTROW = 2 '
SET @SQL = @SQL + '      ); '

EXEC(@SQL)

;
;

;