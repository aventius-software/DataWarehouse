CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForBoxingDay] (
	@date [DATE]
) 
RETURNS DATE AS
BEGIN
    -- This code is valid for use in the UK, other countries may need adjustments! In
    -- the UK if Boxing day falls on a weekend you get the following Monday or Tuesday 
    -- as a 'substitute' bank holiday. Which day depends on if Christmas day also falls on
    -- on a weekend. So you need to take that into account when calculating the day for a
    -- particular year. See this link below for UK Government details on bank holidays:-
    -- https://www.gov.uk/bank-holidays?mod=article_inline

    -- First get the real Christmas day for this year
    DECLARE @christmasDay DATE = DATEFROMPARTS(YEAR(@date), 12, 25)
	
    -- Now lets work out the Boxing day bank holiday date!
    DECLARE @boxingDayBankHoliday DATE = CASE
        -- If Christmas day is on a Friday, Boxing day is of course Saturday so
        -- the following Monday is taken as a bank holiday for Boxing day. So we
		-- just need to add 3 days to Christmas day to get Monday's date
        WHEN DATENAME(WEEKDAY, @christmasDay) = 'Friday' THEN DATEADD(DAY, 3, @christmasDay)

        -- If Christmas day is on a Saturday then the following Monday is
        -- taken as a bank holiday for Christmas, so Tuesday becomes a bank holiday
        -- for Boxing day. So if we add 3 days we'll get Tuesday's date ;-)
        WHEN DATENAME(WEEKDAY, @christmasDay) = 'Saturday' THEN DATEADD(DAY, 3, @christmasDay)

		-- If Christmas day is on a Sunday, then the following Monday is
        -- taken as a bank holiday for Christmas, so Tuesday becomes a bank holiday
        -- for Boxing day. If we add 2 days to the Christmas day (Sunday), we'll get the
		-- Tuesday date for our bank holiday
        WHEN DATENAME(WEEKDAY, @christmasDay) = 'Sunday' THEN DATEADD(DAY, 2, @christmasDay)

        -- Otherwise Christmas and Boxing day are just normal week days, so our Boxing day
		-- bank holiday date is just the day after the Christmas day date - simple!
        ELSE DATEADD(DAY, 1, @christmasDay)
    END
           
    -- Done...
    RETURN @boxingDayBankHoliday		
END