--CREATE FUNCTION [Chronological].[fnGetQuarterBeginningDate] (
--	@date DATE
--)
--RETURNS DATE AS
--BEGIN
--	-- Calculates the beginning date for the quarter that the specified date is in
--	RETURN DATEADD(QUARTER, DATEPART(QUARTER, @date) - 1, DATEFROMPARTS(YEAR(@date), 1, 1))
--END


--CREATE FUNCTION [Chronological].[fnGetDayOfTheQuarter] (
--	@date DATE
--)
--RETURNS INT AS
--BEGIN
--	-- Calculates the day of the current quarter for the specified date
--	RETURN DATEDIFF(DAY, [Chronological].[fnGetQuarterBeginningDate](@date), @date) + 1
--END

CREATE FUNCTION [Chronological].[fnGetDayOfTheWeek] (
	@date DATE
	,@dateFirst TINYINT -- Standard DATEFIRST range, so Monday = 1, Sunday = 7 etc...
)
RETURNS SMALLINT AS
BEGIN
	-- Since we cannot use 'SET DATEFIRST' in a function we need to account for the
	-- 'shift' in whatever the current DATEFIRST value might be on the server that is
	-- running this code. If we don't, this function could return different values 
	-- depending on the server. So, to normalise this behaviour and make it predictable
	-- we need to do some work here. First, we'll cheat and use a date that is in the 
	-- past relative to the supplied date. Also to keep the return values in the same 
	-- range as DATEFIRST (i.e. 1-7 instead of 0-6) we'll need to add the @dateFirst parameter 
	-- value to the date offset calculation! 
	DECLARE @dateOffset DATE = DATEADD(DAY, -1 * (@dateFirst + @@DATEFIRST), @date)

	-- Now we can just use the offset'd date from above and combine with the normalisation
	-- of the DATEFIRST value itself
	DECLARE @dateFirstOffset TINYINT = (DATEPART(WEEKDAY, @dateOffset) + @@DATEFIRST) % 7
	
	-- Now we just add our offset to the DATEFIRST value and we'll get the value we want
	-- in the range of 1-7 with the value depending on which @dateFirst value was supplied!
	RETURN CASE 
		WHEN @dateFirstOffset = 0 THEN @dateFirstOffset + @@DATEFIRST
		ELSE @dateFirstOffset
	END
END