/****************************************************

	Name: Ldsp_First_Donation_Date_Byuh
	Date: 01/20/2018
	
	This Table-valued Function returns a table with the date of the first donation given to BYUH by a donor.

****************************************************/



USE [LDSPhilanthropiesDW]
GO
/****** Object:  UserDefinedFunction [dbo].[Ldsp_First_Donation_Date_Byuh]    Script Date: 1/20/2018 1:47:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[Ldsp_First_Donation_Date_Byuh]()
			RETURNS TABLE
			AS 
			RETURN
				SELECT A.Donor_Key
					, MIN(B.New_ReceiptDate) AS Min_Receipt_Date
					FROM _Donation_Fact A
						INNER JOIN _Donation_Dim B ON A.Donation_Key = B.Donation_Key
						INNER JOIN _Hier_Dim C ON A.Hier_Key = C.Hier_Key
					WHERE 1 = 1
						AND A.Plus_SharedCreditType != 'Matching' -- Not Matching
						AND A.Plus_Type IN ('Hard','Shared') -- Not Influence 100000001
						AND C.New_Inst = 'BYUH'
					GROUP BY A.Donor_Key