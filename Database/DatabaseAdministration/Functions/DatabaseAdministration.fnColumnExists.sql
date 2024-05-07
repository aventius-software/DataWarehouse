CREATE FUNCTION [DatabaseAdministration].[fnColumnExists] (
    @schemaName VARCHAR(128)
	,@tableOrViewName VARCHAR(128)
	,@columnName VARCHAR(128)
)
RETURNS BIT
AS
BEGIN
    RETURN CASE 
		WHEN EXISTS (
			SELECT 
			1

			FROM
			sys.columns
						
			WHERE
			[object_id] = OBJECT_ID(@schemaName + '.' + @tableOrViewName)
			AND [name] = @columnName
		)
		THEN 1
		ELSE 0
	END
END