CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForEasterSunday](
	@year INT
) 
RETURNS DATE AS 
BEGIN 
	-- See https://stackoverflow.com/questions/2192533/function-to-return-date-of-easter-for-the-given-year
	-- for the original, cleaned up some code. Also see this page here https://en.wikipedia.org/wiki/Easter#Date
	-- under the 'computation' section. Note that this function is only valid for years 1900 - 2199!
    DECLARE 
		@epactCalculation INT
        ,@paschalDaysCalculation INT
        ,@numberOfDaysToSunday INT 
        ,@easterMonth INT 
        ,@easterDay INT 

    SET @epactCalculation = (24 + 19 * (@year % 19)) % 30 
    SET @paschalDaysCalculation = @epactCalculation - (@epactCalculation / 28) 
    SET @numberOfDaysToSunday = @paschalDaysCalculation - ( 
        (@year + @year / 4 + @paschalDaysCalculation - 13) % 7 
    ) 

    SET @easterMonth = 3 + (@numberOfDaysToSunday + 40) / 44 

    SET @easterDay = @numberOfDaysToSunday + 28 - ( 
        31 * (@easterMonth / 4) 
    ) 

	RETURN DATEFROMPARTS(@year, @easterMonth, @easterDay)
END