
CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForGoodFriday](
	@year INT
) 
RETURNS DATE AS 
BEGIN 
	-- Much easier than Easter Sunday, as its always just the Friday (2 days) before! ;-)
	RETURN DATEADD(DAY, -2, [Chronological].[fnGetBankHolidayDateForEasterSunday](@year))
END