﻿
CREATE FUNCTION [Chronological].[DateAsInteger] (
	@date DATE	
)
RETURNS INT
AS
BEGIN
	RETURN CAST(CONVERT(VARCHAR(8), @date, 112) AS INT)
END