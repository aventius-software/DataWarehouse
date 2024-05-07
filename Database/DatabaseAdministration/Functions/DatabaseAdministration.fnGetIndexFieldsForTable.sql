CREATE FUNCTION DatabaseAdministration.[fnGetIndexFieldsForTable] (	
	@schemaName VARCHAR(128)
	,@tableName VARCHAR(128)
	,@indexName VARCHAR(128)
	,@returnIncludedColumns BIT
)
RETURNS @table TABLE (
	[ColumnName] VARCHAR(128) NOT NULL
	,[OrdinalPosition] INT NOT NULL
	,[IsIncludedColumn] BIT NOT NULL
)
AS
BEGIN
	-- Get list and save
	INSERT INTO
    @table (
		[ColumnName]
		,[OrdinalPosition]
		,[IsIncludedColumn]
    )
    
	SELECT 
	[ColumnName] = COL_NAME([ic].[object_id], [ic].[column_id])
	,[OrdinalPosition] = [ic].[key_ordinal]
	,[IsIncludedColumn] = [ic].[is_included_column]

	FROM 
	sys.indexes [i]

	INNER JOIN 
	sys.index_columns [ic]
	ON 
	[i].[object_id] = [ic].[object_id]
	AND [i].[index_id] = [ic].[index_id]

	WHERE 
	[i].[object_id] = OBJECT_ID(@schemaName + '.' + @tableName)
	AND [i].[name] = @indexName
	AND [ic].[is_included_column] = @returnIncludedColumns

	-- Done
	RETURN
END