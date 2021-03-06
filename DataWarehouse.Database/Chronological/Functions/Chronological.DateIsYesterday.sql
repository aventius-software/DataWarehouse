﻿
CREATE FUNCTION [Chronological].[DateIsYesterday] (
	@date DATE
)
RETURNS BIT AS
BEGIN
	-- This function checks the date parameter and confirms
	-- if it is yesterday, note the CAST on GETDATE(), if we
	-- don't CAST as DATE the function will not work!
	RETURN CASE
		WHEN @date = CAST(GETDATE() - 1 AS DATE) THEN 1 
		ELSE 0 
	END
END