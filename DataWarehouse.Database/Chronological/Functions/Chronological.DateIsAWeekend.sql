
CREATE FUNCTION [Chronological].[DateIsAWeekend] (
	@date DATE
)
RETURNS BIT AS
BEGIN	
	RETURN CASE 
		WHEN [Chronological].[DayOfTheWeek](@date, 1) > 5 THEN 1
		ELSE 0
	END
END