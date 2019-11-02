
CREATE FUNCTION [Chronological].[DateIsInLastWeek] (
	@date DATE
)
RETURNS BIT AS
BEGIN
	-- This function checks the date parameter and confirms if its a date in the previous week
	RETURN CASE
		WHEN DATEPART(WEEK, @date) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) THEN 1 
		ELSE 0 
	END
END