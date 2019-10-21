
CREATE VIEW [model].[Hour] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimHour
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [HourKey] AS [HourKey]
	,[AMPMIndicator] AS [A M P M Indicator]
	,[Hour24] AS [Hour 24]
	,[HourBand] AS [Hour Band]
	,[HourShiftSort] AS [Hour Shift Sort]
	,[Is6amTo8pm] AS [Is 6am To 8pm]
	,[PeriodOfDay] AS [Period Of Day]
	,[Shift] AS [Shift]
FROM WCG_DW.dbo.DimHour WITH (NOLOCK)
