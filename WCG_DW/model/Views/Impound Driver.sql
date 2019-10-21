


CREATE VIEW [model].[Impound Driver] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   11-06-2019
-- Reason               :   Driver filtered for Impound Only
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
	SELECT DriverKey FROM (
		SELECT DriverKey FROM model.[_Impound Events]
		UNION
		SELECT DriverKey FROM model.[_Impound Release Costs]
		UNION
		SELECT DriverKey FROM model.[_Impound Violation Charges]
		UNION
		SELECT DriverKey FROM model.[_Impound Requests]
	) t
	WHERE d.DriverKey = t.DriverKey
)



