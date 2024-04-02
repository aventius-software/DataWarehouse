CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForEasterMonday](
	@year INT
) 
RETURNS DATE AS 
BEGIN 
	-- Much easier than Easter Sunday, as its always just the next day! ;-)
	RETURN DATEADD(DAY, 1, [Chronological].[fnGetBankHolidayDateForEasterSunday](@year))
END