


CREATE VIEW [man].[transformPublicHolidays]

AS
--------------------------------------------------------------------------------------------------------------------------------------
-- Author			:	Trevor Howe (c_TrevorHo)
-- Date Created		:	18-06-2016
-- Reason			:	Transform View for dbo.PublicHolidays
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By		:
-- Modified On		:
-- Reason			:
--------------------------------------------------------------------------------------------------------------------------------------


SELECT 
	 DATEFROMPARTS(
		SUBSTRING(Date,7,4), 
		SUBSTRING(Date,4,2), 
		SUBSTRING(Date,1,2))	AS Date
	,[Country]					AS Country
	,[Holiday]					AS PublicHolidayName
FROM [man].[PublicHolidays]


