
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 06/18/2020 16:59:53
-- Generated from EDMX file: E:\学习不止\ORM_EF\EF\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [TYDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_ModelFIrstModelFirstTwo]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ModelFirstTwoes] DROP CONSTRAINT [FK_ModelFIrstModelFirstTwo];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[DS_TCategory]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DS_TCategory];
GO
IF OBJECT_ID(N'[dbo].[ModelFIrsts]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ModelFIrsts];
GO
IF OBJECT_ID(N'[dbo].[ModelFirstTwoes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ModelFirstTwoes];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'DS_TCategory'
CREATE TABLE [dbo].[DS_TCategory] (
    [CategoryID] int IDENTITY(1,1) NOT NULL,
    [CategoryName] varchar(20)  NOT NULL,
    [QCount] int  NULL,
    [Show1] int  NULL,
    [Description] varchar(500)  NULL
);
GO

-- Creating table 'ModelFIrsts'
CREATE TABLE [dbo].[ModelFIrsts] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(32)  NULL,
    [Time1] time  NOT NULL
);
GO

-- Creating table 'ModelFirstTwoes'
CREATE TABLE [dbo].[ModelFirstTwoes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [ModelFIrstId] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [CategoryID] in table 'DS_TCategory'
ALTER TABLE [dbo].[DS_TCategory]
ADD CONSTRAINT [PK_DS_TCategory]
    PRIMARY KEY CLUSTERED ([CategoryID] ASC);
GO

-- Creating primary key on [Id] in table 'ModelFIrsts'
ALTER TABLE [dbo].[ModelFIrsts]
ADD CONSTRAINT [PK_ModelFIrsts]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ModelFirstTwoes'
ALTER TABLE [dbo].[ModelFirstTwoes]
ADD CONSTRAINT [PK_ModelFirstTwoes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [ModelFIrstId] in table 'ModelFirstTwoes'
ALTER TABLE [dbo].[ModelFirstTwoes]
ADD CONSTRAINT [FK_ModelFIrstModelFirstTwo]
    FOREIGN KEY ([ModelFIrstId])
    REFERENCES [dbo].[ModelFIrsts]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ModelFIrstModelFirstTwo'
CREATE INDEX [IX_FK_ModelFIrstModelFirstTwo]
ON [dbo].[ModelFirstTwoes]
    ([ModelFIrstId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------