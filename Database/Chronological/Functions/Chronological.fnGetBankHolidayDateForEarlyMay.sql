CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForEarlyMay] (
	@year INT 
)
RETURNS DATE AS
BEGIN	
	-- Early May bank holiday is first monday in May, so lets start on May first
	-- then we just need to find the Monday that comes after this date. See this 
	-- link below for UK Government details on bank holidays
    -- https://www.gov.uk/bank-holidays?mod=article_inline

	-- Start with the first date in May for the specified year
	DECLARE @earlyMayDay DATE = DATEFROMPARTS(@year, 5, 1)

	-- Adjust if not Monday...
	IF DATENAME(WEEKDAY, @earlyMayDay) <> 'Monday' SET @earlyMayDay = CASE
		-- Adjust the day
		WHEN DATENAME(WEEKDAY, @earlyMayDay) = 'Tuesday' THEN DATEADD(DAY, 6, @earlyMayDay)
		WHEN DATENAME(WEEKDAY, @earlyMayDay) = 'Wednesday' THEN DATEADD(DAY, 5, @earlyMayDay)
		WHEN DATENAME(WEEKDAY, @earlyMayDay) = 'Thursday' THEN DATEADD(DAY, 4, @earlyMayDay)
		WHEN DATENAME(WEEKDAY, @earlyMayDay) = 'Friday' THEN DATEADD(DAY, 3, @earlyMayDay)
		WHEN DATENAME(WEEKDAY, @earlyMayDay) = 'Saturday' THEN DATEADD(DAY, 2, @earlyMayDay)

		-- Its Sunday, so just add 1 day to get first Monday in the month ;-)
		ELSE DATEADD(WEEKDAY, 1, @earlyMayDay)
	END
    
	RETURN @earlyMayDay
END