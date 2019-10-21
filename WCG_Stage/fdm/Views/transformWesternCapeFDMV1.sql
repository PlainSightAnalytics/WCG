



CREATE VIEW [fdm].[transformWesternCapeFDMV1] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17-03-2019
-- Reason				:	Transform view for WesternCapeFDMV1
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 CAST([FDM_COM_Co] AS VARCHAR(10))																AS [Commodity Code]
    ,CAST([label1]	AS VARCHAR(10))																	AS [Origin Location Code]
    ,CAST([label2]	AS VARCHAR(10))																	AS [Destination Location Code]
    ,CAST([md_or]	AS VARCHAR(50))																	AS [Origin Location]
    ,CAST([md_des]	AS VARCHAR(50))																	AS [Destination Location]
    --,[Supply point]
    --,[Demand point]
    ,CAST(
		NULLIF(
			NULLIF(
				NULLIF([National road allocated],'0')
				,'Core')
		,'')
	AS VARCHAR(10))																					AS [National Road Allocated]
    --,[COMTYPE]
    --,[COMMODITY_]
    --,[PACKAGING_]
    --,[SECTOR]
    --,[CARGO_TYPE]
    --,[INDUSTRY_G]
    ,CAST(
		CASE [impexpdom]						
			WHEN 'd' THEN 'Domestic'
			WHEN 'i' THEN 'Import'
			WHEN 'e' THEN 'Export'
		END AS VARCHAR(10))																			AS [Trade]
    ,CAST(NULLIF([DISTANCE],'') AS NUMERIC(19,2))													AS [AVERAGEDISTANCE]
    ,CAST([Distance Z] AS INT)																		AS [Rounded Distance]
    --,[corridor]		
    ,CAST(NULLIF([ORIGINNEWG],'') AS VARCHAR(50))													AS [Origin Location Area]
    ,CAST(NULLIF([DESTINATIO],'') AS VARCHAR(50))													AS [Destination Location Area]
    ,CAST(NULLIF([ORIGINDEST],'') AS VARCHAR(100))													AS [Freight Flow]
    --,[Economic_C]									AS [Economic Corridor Classification 1]
    --,[Economic_0]									AS [Economic Corridor Classification 2]
    ,CAST(
		NULLIF(
			NULLIF([Rail_Frien],'blank')
			,'') AS VARCHAR(50))																	AS [Rail Friendly]
    --,[newor]
    --,[newdes]
    ,CAST(NULLIF([or_density],'') AS VARCHAR(10))													AS [Origin Density]
    ,CAST(NULLIF([des_densit],'') AS VARCHAR(10))													AS [Destination Density]
    ,CAST(
		CASE [DBP]
			WHEN 'BD' THEN 'Border to Domestic'
			WHEN 'BP' THEN 'Border to Port'
			WHEN 'DB' THEN 'Domestic to Border'
			WHEN 'DD' THEN 'Domestic to Domestic'
			WHEN 'DP' THEN 'Domestic to Port'
			WHEN 'PB' THEN 'Port to Border'
			WHEN 'PD' THEN 'Port to Domestic'
			WHEN 'PP' THEN 'Port to Port'	
			ELSE NULL
		END	AS VARCHAR(50))																			AS [Freight Flow Type]
    ,CAST(
		CASE [Distance_C]
			WHEN '<50' THEN '0 to 49km'
			WHEN '150-500' THEN '150 to 500km'
			WHEN '50-149' THEN '50 to 149km'
			WHEN '500+' THEN 'Over 500km'
		END AS VARCHAR(30))																			AS [Distance Band]
    ,CAST(
		CASE [Distance_C]
			WHEN '<50' THEN 1
			WHEN '150-500' THEN 3
			WHEN '50-149' THEN 2
			WHEN '500+' THEN 4
		END AS VARCHAR(30))																			AS [Distance Band Order]
    ,CAST(UPPER([T_Class]) AS VARCHAR(3))															AS [Market Segmentation Code]
    ,CAST(REPLACE([Tclass],'"','') AS VARCHAR(100))													AS [Market Segmentation]
    ,CASE [GFB]
		WHEN 'GFB' THEN 'General Freight Business'
		WHEN 'Expl' THEN 'Export Lines'
	END																								AS [Corridor Classification]
    ,CAST([OProvince] AS VARCHAR(30))																AS [Origin Province]
    ,CAST([DProvince] AS VARCHAR(30))																AS [Destination Province]
    ,CAST([MainEcCor] AS VARCHAR(10))																AS [Economic Corridor Classification Code]
	,LTRIM( CAST( CONCAT(
		CASE PARSENAME(REPLACE(MainECCor,'_','.'),2)
			WHEN 'BB' THEN 'Beit Bridge'
			WHEN 'CPT' THEN 'Cape Town'
			WHEN 'DBN' THEN 'Durban'
			WHEN 'EL' THEN 'East London'
			WHEN 'ERM' THEN 'Ermelo'
			WHEN 'GT' THEN 'Gauteng'
			WHEN 'M' THEN 'Metro'
			WHEN 'MB' THEN 'Mossel Bay'
			WHEN 'NAM' THEN 'Namibia'
			WHEN 'NEL' THEN 'Nelspruit'
			WHEN 'PE' THEN 'Port Elizabeth'
			WHEN 'PLK' THEN 'Polekwane'
			WHEN 'R' THEN 'Rural'
			WHEN 'RB' THEN 'Richards Bay'
			WHEN 'SW' THEN 'Swaziland'
			WHEN 'UP' THEN 'Upington'
			WHEN 'WTB' THEN 'Witbank'
		END	
		,' - '
		,CASE PARSENAME(REPLACE(MainECCor,'_','.'),1)
			WHEN 'CPT' THEN 'Cape Town'
			WHEN 'DBN' THEN 'Durban'
			WHEN 'EC' THEN 'Eastern Cape'
			WHEN 'FS' THEN 'Free State'
			WHEN 'GT' THEN 'Gauteng'
			WHEN 'KZN' THEN 'Kwazulu Natal'
			WHEN 'LP' THEN 'Limpopo'
			WHEN 'MB' THEN 'Mossel Bay'
			WHEN 'MP' THEN 'Mapumalanga'
			WHEN 'NAM' THEN 'Namibia'
			WHEN 'NC' THEN 'Northern Cape'
			WHEN 'NW' THEN 'Northwest Province'
			WHEN 'PE' THEN 'Port Elizabeth'
			WHEN 'RB' THEN 'Richards Bay'
			WHEN 'UP' THEN 'Upington'
			WHEN 'WC' THEN 'Western Cape'
			WHEN 'WTB' THEN 'Witbank'
		END
		,CASE PARSENAME(REPLACE(MainECCor,'_','.'),3)
			WHEN 'CR' THEN ' Corridor'
			ELSE ''
		END	) AS VARCHAR(50)))																		AS [Economic Corridor Classification]	
	,NULLIF([Vehicleused],'0')																		AS [Vehicle Classification Code]
	,CAST(NULLIF(REPLACE(REPLACE([2017_Rail_tons],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [RAILTONS]
	,CAST(NULLIF(REPLACE(REPLACE([2017_Rail_tonkms],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [RAILTONKMS]
	,CAST(NULLIF(REPLACE(REPLACE([2017_Rail_cost],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [RAILCOST]
	,CAST(NULLIF(REPLACE(REPLACE([2017_Road_tons],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [ROADTONS]
	,CAST(NULLIF(REPLACE(REPLACE([2017_Road_tonkms],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [ROADTONKMS]
	,CAST(NULLIF(REPLACE(REPLACE([2017_Pipe_tons],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [PIPETONS]
	,CAST(NULLIF(REPLACE(REPLACE([2017_Pipe_tonkms],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [PIPETONKMS]
	,CAST(NULLIF(REPLACE(REPLACE([2017_Pipe_cost],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [PIPECOST]
	,CAST(NULLIF(REPLACE(REPLACE([2017_Total_tons],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [TOTALTONS]
	,CAST(NULLIF(REPLACE(REPLACE([2017_Total_tonkms],' ',''),'-',''),'')		AS NUMERIC(19,2))	AS [TOTALTONKMS]
	,CAST(NULLIF(REPLACE(REPLACE([2023_Total_tons],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [TOTALTONS6Y]
	,CAST(NULLIF(REPLACE(REPLACE([2023_Total_tonkms],' ',''),'-',''),'')		AS NUMERIC(19,2))	AS [TOTALTONKMS6Y]
	,CAST(NULLIF(REPLACE(REPLACE([2048_Total_tons],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [TOTALTONS30Y]
	,CAST(NULLIF(REPLACE(REPLACE([2048_Total_tonkms],' ',''),'-',''),'')		AS NUMERIC(19,2))	AS [TOTALTONKMS30Y]
	,CAST(NULLIF(REPLACE(REPLACE([Numberoftrips],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [NUMBEROFTRIPS]
	,CAST(CEILING(NULLIF(REPLACE(REPLACE([Numberoftrips],' ',''),'-',''),''))	AS NUMERIC(19,2))	AS [NUMBEROFVEHICLES]
	,CAST(NULLIF(REPLACE(REPLACE([Tripcost],' ',''),'-',''),'')					AS NUMERIC(19,2))	AS [TRIPCOST]
	,CAST(NULLIF(REPLACE(REPLACE([Costperton],' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [COSTPERTON]
	,CAST(NULLIF(REPLACE(REPLACE([Depreciation],' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [DEPRECIATION]
	,CAST(NULLIF(REPLACE(REPLACE([CostofCap],' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [COSTOFCAP]
	,CAST(NULLIF(REPLACE(REPLACE([Licence],' ',''),'-',''),'')					AS NUMERIC(19,2))	AS [LICENCE]
	,CAST(NULLIF(REPLACE(REPLACE([TollFees]	,' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [TOLLFEES]
	,CAST(NULLIF(REPLACE(REPLACE([Insurance],' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [INSURANCE]
	,CAST(NULLIF(REPLACE(REPLACE([Driver],' ',''),'-',''),'')					AS NUMERIC(19,2))	AS [DRIVER]
	,CAST(NULLIF(REPLACE(REPLACE([Fuel],' ',''),'-',''),'')						AS NUMERIC(19,2))	AS [FUEL]
	,CAST(NULLIF(REPLACE(REPLACE([M&R],' ',''),'-',''),'')						AS NUMERIC(19,2))	AS [M&R]
	,CAST(NULLIF(REPLACE(REPLACE([Tyres],' ',''),'-',''),'')					AS NUMERIC(19,2))	AS [TYRES]
	,CAST(NULLIF(REPLACE(REPLACE([TotalRoadcost],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [TOTALROADCOST]
	,CAST(NULLIF(REPLACE(REPLACE([TotalTransportcosts],' ',''),'-',''),'')		AS NUMERIC(19,2))	AS [TOTALTRANSPORTCOSTS]
	,CAST(NULLIF(REPLACE(REPLACE([RoadAccidents],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [ROADACCIDENTS]
	,CAST(NULLIF(REPLACE(REPLACE([RoadCongestion],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [ROADCONGESTION]
	,CAST(NULLIF(REPLACE(REPLACE([RoadEmissions],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [ROADEMISSIONS]
	,CAST(NULLIF(REPLACE(REPLACE([RoadLandway],' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [ROADLANDWAY]
	,CAST(NULLIF(REPLACE(REPLACE([RoadNoise],' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [ROADNOISE]
	,CAST(NULLIF(REPLACE(REPLACE([RoadPolicing],' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [ROADPOLICING]
	,CAST(NULLIF(REPLACE(REPLACE([RailAccidents],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [RAILACCIDENTS]
	,CAST(NULLIF(REPLACE(REPLACE([RailEmissions],' ',''),'-',''),'')			AS NUMERIC(19,2))	AS [RAILEMISSIONS]
	,CAST(NULLIF(REPLACE(REPLACE([RailLandway],' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [RAILLANDWAY]
	,CAST(NULLIF(REPLACE(REPLACE([RailNoise],' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [RAILNOISE]
	,CAST(NULLIF(REPLACE(REPLACE([Accidents],' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [ACCIDENTS]
	,CAST(NULLIF(REPLACE(REPLACE([Congestion],' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [CONGESTION]
	,CAST(NULLIF(REPLACE(REPLACE([Emissions],' ',''),'-',''),'')				AS NUMERIC(19,2))	AS [EMISSIONS]
	,CAST(NULLIF(REPLACE(REPLACE([Landway],' ',''),'-',''),'')					AS NUMERIC(19,2))	AS [LANDWAY]
	,CAST(NULLIF(REPLACE(REPLACE([Noise],' ',''),'-',''),'')					AS NUMERIC(19,2))	AS [NOISE]
	,CAST(NULLIF(REPLACE(REPLACE([Policing],' ',''),'-',''),'')					AS NUMERIC(19,2))	AS [POLICING]
	,CAST(NULLIF(REPLACE(REPLACE([Totalexternalitycosts],' ',''),'-',''),'')	AS NUMERIC(19,2))	AS [TOTALEXTERNALITYCOSTS]
  FROM [WCG_Stage].[fdm].[WesternCapeFDMV1]
  WHERE FDM_COM_Co <> ''
