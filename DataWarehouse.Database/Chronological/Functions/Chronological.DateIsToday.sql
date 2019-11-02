
CREATE FUNCTION [Chronological].[DateIsToday] (
	@date DATE
)
RETURNS BIT AS
BEGIN
	-- This function checks the date parameter and confirms
	-- if it is today, note the CAST on GETDATE(), if we
	-- don't CAST as DATE the function will not work!
	RETURN CASE
		WHEN @date = CAST(GETDATE() AS DATE) THEN 1 
		ELSE 0 
	END
END