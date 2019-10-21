

CREATE VIEW [model].[Public Transport Driver] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   20-04-2019
-- Reason               :   Driver filtered for Public Transport Only
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

SELECT
	 d.[DriverKey]
	,d.[Country]
	,d.[Date Of Birth]
	,d.[Gender]
	,d.[ID Document No]
	,d.[ID Document Type]
	,d.[Initials]
	,d.[License Expiry Date]
	,d.[License First Date]
	,d.[License Number]
	,d.[License Type]
	,d.[Surname]
FROM model.Driver d
WHERE EXISTS (
SELECT DriverKey FROM model.[_Public Transport Traffic Control Events] t
WHERE d.DriverKey = t.DriverKey)
