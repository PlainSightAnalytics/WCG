

CREATE VIEW [model].[Transport Operation Driver] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   04-10-2019
-- Reason               :   Drivers related to Transport Operation Events
------------------------------------------------------------------------------------------
-- Modified By          :	
-- Modified On          :	
-- Reason               :	
------------------------------------------------------------------------------------------

SELECT 
	 [DriverKey]
	,[Country]
	,[Date Of Birth]
	,[Gender]
	,[ID Document No]
	,[ID Document Type]
	,[Initials]
	,[License Expiry Date]
	,[License First Date]
	,[License Number]
	,[License Type]
	,[Surname]
FROM model.[Driver] d WITH (NOLOCK)
WHERE 
	EXISTS (
		SELECT DriverKey
		FROM model.[_Transport Operation Events] e WITH (NOLOCK)
		WHERE d.DriverKey = e.DriverKey
	) 
	OR 
	EXISTS (
		SELECT DriverKey
		FROM model.[_Road Safety Education Events] e WITH (NOLOCK)
		WHERE d.DriverKey = e.DriverKey
	)
