USE [PROD]
GO
/****** Object:  StoredProcedure [dbo].[sp_EmadeCustomer]    Script Date: 2/18/2025 11:48:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: QUDDUS BELLO
-- Create date: 2/2/2025
-- Description: Incremental load for Emade Customer using merge
-- =============================================
ALTER PROCEDURE [dbo].[sp_EmadeCustomer]

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

   
--PERFORMING MERGE OPERATIONS

INSERT INTO TGT_EMADEPRODUCTLIST (PRODUCTID, PRODUCTNAME, PRICE, STARTDATE, ENDDATE, IS_ACTIVE)
SELECT PRODUCTID, PRODUCTNAME, PRICE, STARTDATE, ENDDATE, IS_ACTIVE
FROM (
    MERGE INTO TGT_EMADEPRODUCTLIST AS TARGET
    USING STG_EMADEPRODUCTUPDATEDLIST AS SOURCE
    ON TARGET.PRODUCTID = SOURCE.PRODUCTID AND TARGET.IS_ACTIVE = 'Y'
    WHEN MATCHED THEN
        UPDATE SET
            TARGET.IS_ACTIVE = 'N',
            TARGET.ENDDATE = GETDATE()
    WHEN NOT MATCHED THEN
        INSERT (PRODUCTID, PRODUCTNAME, PRICE, STARTDATE, ENDDATE, IS_ACTIVE)
        VALUES (SOURCE.PRODUCTID, SOURCE.PRODUCTNAME, SOURCE.PRICE, GETDATE(), NULL, 'Y')
    OUTPUT $ACTION,
        SOURCE.PRODUCTID,
        SOURCE.PRODUCTNAME,
        SOURCE.PRICE,
        GETDATE(),
        NULL,
        'Y'
) AS [CHANGES] (ACTION, PRODUCTID, PRODUCTNAME, PRICE, STARTDATE, ENDDATE, IS_ACTIVE)
WHERE ACTION = 'UPDATE';
END
