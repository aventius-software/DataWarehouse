CREATE FUNCTION [DatabaseAdministration].[fnGetPrimaryKeysForTable] (	
	@schemaName VARCHAR(128)
	,@tableName VARCHAR(128)
)
RETURNS @table TABLE (
	[ColumnName] VARCHAR(128) NOT NULL
	,[OrdinalPosition] INT NOT NULL
)
AS
BEGIN
	-- Get list of tables and save
	INSERT INTO
    @table (
		[ColumnName]
		,[OrdinalPosition]
    )
    
	SELECT 
	[c].[name]
	,[ic].[key_ordinal]

	FROM 
	sys.indexes [i]
    
	INNER JOIN 
	sys.index_columns [ic]
	ON 
	[i].[object_id] = [ic].[object_id] 
	AND [i].index_id = [ic].index_id
    
	INNER JOIN 
	sys.columns [c]
	ON 
	[ic].[object_id] = [c].[object_id] 
	AND [c].[column_id] = [ic].[column_id]

	WHERE
	[i].[is_primary_key] = 1
    AND [i].[object_id] = OBJECT_ID(@schemaName + '.' + @tableName)

	-- Done
	RETURN
END