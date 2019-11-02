
CREATE FUNCTION [Chronological].[DateIsInTheCurrentWeek] (
	@date DATE
)
RETURNS BIT AS
BEGIN
	-- This function checks the date parameter and confirms if its a date in the current week
	RETURN CASE
		WHEN DATEPART(WEEK, @date) = DATEPART(WEEK, GETDATE()) THEN 1 
		ELSE 0 
	END
END