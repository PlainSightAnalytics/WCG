CREATE VIEW [dbo].[LoadFactTrafficCotraventions] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17-06-2019
-- Reason				:	Load view for FactTrafficContraventions
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.[DriverKey],-1)				AS DriverKey
	,ISNULL(d2.[MagistratesCourtKey],-1)	AS MagistratesCourtKey
	,ISNULL(d3.[DateKey],-1)				AS OffenceDateKey
	,ISNULL(d4.[TrafficCentreKey],-1)		AS TrafficCentreKey
	,ISNULL(d5.[VehicleKey],-1)				AS VehicleKey
	,ISNULL(d6.[ViolationChargeKey],-1)		AS ViolationChargeKey
	,tfm.CaseResultDate
	,tfm.CourtDate
	,tfm.CurrentAmount
	,tfm.IssueDate
	,tfm.LastAction
	,tfm.LastActionDate
	,tfm.NoticeNumber
	,tfm.NoticeStage
	,tfm.NoticeStatus
	,tfm.NoticeType
	,tfm.OriginalAmount
	,tfm.PaidAmount
	,tfm.PaymentDueDate
	,tfm.PaymentReceiptDate
	,tfm.ReceiptNumber
	,tfm.ReducedAmount
	,tfm.UnequalPaidAmount
	,tfm.WarrantDate
	,tfm.WithdrawnAmount
FROM [WCG_Stage].[man].[transformFactTrafficContraventions] tfm WITH (NOLOCK)
LEFT JOIN [WCG_DW].[dbo].[DimDriver]				d1 WITH (NOLOCK) ON tfm.IDDocumentNumber = d1.IDDocumentNo
LEFT JOIN [WCG_DW].[dbo].[DimMagistratesCourt]		d2 WITH (NOLOCK) ON tfm.MagistratesCourtGUID = d2.MagistratesCourtID
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d3 WITH (NOLOCK) ON tfm.OffenceDate = d3.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]			d4 WITH (NOLOCK) ON tfm.TrafficCentreGUID = d4.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimVehicle]				d5 WITH (NOLOCK) ON tfm.RegistrationNo = d5.RegistrationNo
LEFT JOIN [WCG_DW].[dbo].[DimViolationCharge]		d6 WITH (NOLOCK) ON tfm.ChargeCode = d6.ChargeCode













