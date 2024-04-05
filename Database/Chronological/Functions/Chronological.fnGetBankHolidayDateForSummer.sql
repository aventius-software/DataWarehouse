
CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForSummer] (
	@year INT 
)
RETURNS DATE AS
BEGIN	
	-- Summer bank holiday is the last Monday in August. Other countries apart from the UK
	-- may have different calculations https://www.gov.uk/bank-holidays?mod=article_inline

	-- First get the last date in August for the specified year
	DECLARE @summerBankHoliday DATE = DATEADD(DAY, -1, DATEFROMPARTS(@year, 9, 1))

	-- Now check if its Monday or not
	RETURN CASE
		-- Its a Monday, so no adjustment required
		WHEN DATENAME(WEEKDAY, @summerBankHoliday) = 'Monday' THEN @summerBankHoliday

		-- Go back to earlier to a Monday
		WHEN DATENAME(WEEKDAY, @summerBankHoliday) = 'Tuesday' THEN DATEADD(DAY, -1, @summerBankHoliday)
		WHEN DATENAME(WEEKDAY, @summerBankHoliday) = 'Wednesday' THEN DATEADD(DAY, -2, @summerBankHoliday)
		WHEN DATENAME(WEEKDAY, @summerBankHoliday) = 'Thursday' THEN DATEADD(DAY, -3, @summerBankHoliday)
		WHEN DATENAME(WEEKDAY, @summerBankHoliday) = 'Friday' THEN DATEADD(DAY, -4, @summerBankHoliday)
		WHEN DATENAME(WEEKDAY, @summerBankHoliday) = 'Saturday' THEN DATEADD(DAY, -5, @summerBankHoliday)

		-- Its a Sunday, so go back almost a week to the previous Monday
		ELSE DATEADD(WEEKDAY, -6, @summerBankHoliday)
	END
END