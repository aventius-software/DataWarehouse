﻿
CREATE FUNCTION [Chronological].[CalendarQuarterStartDate] (
	@date DATE
)
RETURNS DATE AS
BEGIN
	RETURN DATEADD(QUARTER, DATEPART(QUARTER, @date) - 1, DATEFROMPARTS(YEAR(@date), 1, 1))
END