﻿
CREATE FUNCTION [Chronological].[DateIsInTheCurrentMonth] (
	@date DATE
)
RETURNS BIT AS
BEGIN	
	RETURN CASE
		WHEN MONTH(@date) = MONTH(GETDATE()) AND YEAR(@date) = YEAR(GETDATE()) THEN 1
		ELSE 0 
	END
END