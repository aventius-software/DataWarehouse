
CREATE FUNCTION [Chronological].[DateIsAWeekday] (
	@date DATE
)
RETURNS BIT AS
BEGIN	
	RETURN CASE 
		WHEN [Chronological].[DayOfTheWeek](@date, 1) < 6 THEN 1
		ELSE 0
	END
END