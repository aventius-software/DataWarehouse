CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForSummer] (
	@year INT 
)
RETURNS DATE AS
BEGIN	
	-- Summer bank holiday is the last Monday in August. Other countries apart from the UK
	-- may have different calculations https://www.gov.uk/bank-holidays?mod=article_inline

	-- First get the last date in August for the specified year
	DECLARE @summerBankHoliday DATE = DATEADD(DAY, -1, DATEFROMPARTS(@year, 9, 1))

	-- Adjust if not Monday...
	IF DATENAME(WEEKDAY, @summerBankHoliday) <> 'Monday' SET @summerBankHoliday = CASE
		-- Adjust the day
		WHEN DATENAME(WEEKDAY, @summerBankHoliday) = 'Tuesday' THEN DATEADD(DAY, -1, @summerBankHoliday)
		WHEN DATENAME(WEEKDAY, @summerBankHoliday) = 'Wednesday' THEN DATEADD(DAY, -2, @summerBankHoliday)
		WHEN DATENAME(WEEKDAY, @summerBankHoliday) = 'Thursday' THEN DATEADD(DAY, -3, @summerBankHoliday)
		WHEN DATENAME(WEEKDAY, @summerBankHoliday) = 'Friday' THEN DATEADD(DAY, -4, @summerBankHoliday)
		WHEN DATENAME(WEEKDAY, @summerBankHoliday) = 'Saturday' THEN DATEADD(DAY, -5, @summerBankHoliday)

		-- Its Sunday
		ELSE DATEADD(WEEKDAY, -6, @summerBankHoliday)
	END
    
	RETURN @summerBankHoliday
END