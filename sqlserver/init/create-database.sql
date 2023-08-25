USE master
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'SampleDb')
BEGIN
  CREATE DATABASE SampleDb;
END;
GO