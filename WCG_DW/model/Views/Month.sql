


CREATE VIEW [model].[Month] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   22-10-2019
-- Reason               :   DimDate at Month Grain
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

SELECT 
	  0-CalendarYearMonthKey				AS [CalendarYearMonthKey]
	 ,[Calendar Year]
	 ,[Month Display]
	 ,[Month Year Name]
	 ,[Financial Month Display]
	 ,[Financial Month Number]
	 ,[Financial Year Display]
	 ,Year
FROM WCG_DW.model.Date WITH (NOLOCK)
WHERE [Is Last Day Of Month] = 'Yes'