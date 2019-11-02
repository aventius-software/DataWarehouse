
CREATE FUNCTION [String].[NumberWithSuffix] (
	@number BIGINT
)
RETURNS VARCHAR(21) AS
BEGIN
	DECLARE @numberString VARCHAR(19) = CAST(@number AS VARCHAR(19))
	
	RETURN @numberString + CASE RIGHT(@numberString, 1)
		WHEN '1' THEN 'st'
		WHEN '2' THEN 'nd'
		WHEN '3' THEN 'rd'
		ELSE 'th'
	END 
END