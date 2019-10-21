


CREATE PROCEDURE [man].[prcExtractCameraLookup]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	3-08-2016
-- Reason				:	Loads Camera Lookup from CSV file
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName
-- Ouputs				:	None
-- Test					:	exec dbo.prcExtractCameraLookup 'F:\WCG\data\CameraLookup.csv'
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@FileName AS VARCHAR(MAX)

AS

DECLARE @SQL AS VARCHAR(MAX)

/* Truncate Public Holidays */
TRUNCATE TABLE WCG_Stage.man.CameraLookup

/* Load from Public Holidays Text File */
SET @SQL = 'BULK INSERT WCG_Stage.man.CameraLookup '
SET @SQL = @SQL + 'FROM ''' + @FileName + ''''
SET @SQL = @SQL + '   WITH   '
SET @SQL = @SQL + '      (  '
SET @SQL = @SQL + '         FIELDTERMINATOR ='','',  '
SET @SQL = @SQL + '         ROWTERMINATOR =''\n'','
SET @SQL = @SQL + '		 FIRSTROW = 2 '
SET @SQL = @SQL + '      ); '

EXEC(@SQL)

;
;

;

;