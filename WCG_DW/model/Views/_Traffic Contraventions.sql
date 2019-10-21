
CREATE VIEW [model].[_Traffic Contraventions] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   17 Jun 2019 12:59:18 PM
-- Reason               :   Semantic View for dbo.FactTrafficContraventions
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [DriverKey] AS [DriverKey]
	,[MagistratesCourtKey] AS [MagistratesCourtKey]
	,[OffenceDateKey] AS [OffenceDateKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[VehicleKey] AS [VehicleKey]
	,[ViolationChargeKey] AS [ViolationChargeKey]
	,[CaseResultDate] AS [Case Result Date]
	,[CourtDate] AS [Court Date]
	,[IssueDate] AS [Issue Date]
	,[LastAction] AS [Last Action]
	,[LastActionDate] AS [Last Action Date]
	,[NoticeNumber] AS [Notice Number]
	,[NoticeStage] AS [Notice Stage]
	,[NoticeStatus] AS [Notice Status]
	,[NoticeType] AS [Notice Type]
	,[PaymentDueDate] AS [Payment Due Date]
	,[PaymentReceiptDate] AS [Payment Receipt Date]
	,[ReceiptNumber] AS [Receipt Number]
	,[WarrantDate] AS [Warrant Date]
	,[CurrentAmount] AS [_CurrentAmount]
	,[OriginalAmount] AS [_OriginalAmount]
	,[PaidAmount] AS [_PaidAmount]
	,[ReducedAmount] AS [_ReducedAmount]
	,[UnequalPaidAmount] AS [_UnequalPaidAmount]
	,[WithdrawnAmount] AS [_WithdrawnAmount]
FROM WCG_DW.dbo.FactTrafficContraventions WITH (NOLOCK)
