/****************************************************

	Name: Uf_All_Personal_Connections
	Date: 06/13/2018

****************************************************/

USE [LDSPhilanthropiesDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[Uf_All_Personal_Connections]()
RETURNS TABLE
AS
RETURN

SELECT CONVERT(NVARCHAR(100),ContactId) AS Donor_Key
	, STUFF(( SELECT  ' | ' + All_Personal_Connections 
					FROM 
						(SELECT DISTINCT ContactId
							, Relationship + ': (' + COALESCE(RTRIM(CONVERT(NVARCHAR(50),Relationship_LdspId)),' ') + ') ' + Relationship_Name AS All_Personal_Connections
							FROM _Connection_Dim 
						) A
					WHERE B.ContactId = A.ContactId FOR XML PATH('')),1 ,3, ''
			)  All_Personal_Connections
	FROM 
		(SELECT DISTINCT ContactId
			FROM _Connection_Dim)  B
	WHERE 1 = 1
		AND ContactId IS NOT NULL
	GROUP BY ContactId

