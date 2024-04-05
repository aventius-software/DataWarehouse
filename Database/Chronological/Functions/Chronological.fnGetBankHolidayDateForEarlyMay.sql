
CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForEarlyMay] (
	@year INT 
)
RETURNS DATE AS
BEGIN	
	-- Early May bank holiday is first Monday in May, so lets start on May the 1st
	-- find the Monday that comes on or after this date. See this link below for UK 
	-- Government details on bank holidays
    -- https://www.gov.uk/bank-holidays?mod=article_inline

	-- Start with the first date in May for the specified year
	DECLARE @earlyMayDay DATE = DATEFROMPARTS(@year, 5, 1)

	-- Adjust if not Monday...
	RETURN CASE
		-- It is a Monday, so all done, no adjustment needed...
		WHEN DATENAME(WEEKDAY, @earlyMayDay) = 'Monday' THEN @earlyMayDay

		-- Its not a Monday, so we adjust the date and move to the following Monday
		WHEN DATENAME(WEEKDAY, @earlyMayDay) = 'Tuesday' THEN DATEADD(DAY, 6, @earlyMayDay)
		WHEN DATENAME(WEEKDAY, @earlyMayDay) = 'Wednesday' THEN DATEADD(DAY, 5, @earlyMayDay)
		WHEN DATENAME(WEEKDAY, @earlyMayDay) = 'Thursday' THEN DATEADD(DAY, 4, @earlyMayDay)
		WHEN DATENAME(WEEKDAY, @earlyMayDay) = 'Friday' THEN DATEADD(DAY, 3, @earlyMayDay)
		WHEN DATENAME(WEEKDAY, @earlyMayDay) = 'Saturday' THEN DATEADD(DAY, 2, @earlyMayDay)

		-- Otherwise its Sunday, so just add 1 day to get first Monday in the month ;-)
		ELSE DATEADD(WEEKDAY, 1, @earlyMayDay)
	END
END