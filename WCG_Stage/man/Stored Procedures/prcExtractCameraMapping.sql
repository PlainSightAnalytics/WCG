




CREATE PROCEDURE [man].[prcExtractCameraMapping]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	25-02-2017
-- Reason				:	Loads Camera Mapping from CSV file
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName
-- Ouputs				:	None
-- Test					:	exec man.prcExtractCameraMapping 'C:\WCG\data\CameraMapping.csv'
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@FileName AS VARCHAR(MAX)

AS

DECLARE @SQL AS VARCHAR(MAX)

/* Truncate Public Holidays */
TRUNCATE TABLE WCG_Stage.man.CameraMapping

/* Load from Public Holidays Text File */
SET @SQL = 'BULK INSERT WCG_Stage.man.CameraMapping '
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




