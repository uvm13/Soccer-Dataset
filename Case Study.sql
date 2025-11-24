USE [CarSalesDb1]
GO

SELECT [year]
      ,[make]
      ,[model]
      ,[trim]
      ,[body]
      ,[transmission]
      ,[vin]
      ,[state]
      ,[condition]
      ,[odometer]
      ,[color]
      ,[interior]
      ,[seller]
      ,[mmr]
      ,[sellingprice]
      ,[saledate]
  FROM [dbo].[car_sales]

GO

--- Check table
SELECT * FROM [CarSalesDb1].[dbo].[car_sales];


-- 1. Rename columns
EXEC sp_rename '[CarSalesDb1].[dbo].[car_sales].seller', 'dealership', 'COLUMN';
EXEC sp_rename '[CarSalesDb1].[dbo].[car_sales].odometer', 'mileage', 'COLUMN';
EXEC sp_rename '[CarSalesDb1].[dbo].[car_sales].sellingprice', 'revenue', 'COLUMN';

EXEC sp_rename '[CarSalesDb1].[dbo].[car_sales].year', 'car_model_year', 'COLUMN';
EXEC sp_rename '[CarSalesDb1].[dbo].[car_sales].state', 'region', 'COLUMN';



-- 2. Display saledate in yyyy-mm-dd format
SELECT
    car_model_year,
    make,
    model,
    body,
    transmission,
    region,
    mileage,
    color,
    interior,
    dealership,
    revenue,
    CONVERT(VARCHAR(10), saledate, 23) AS saledate -- 23 = yyyy-mm-dd
FROM [CarSalesDb1].[dbo].[car_sales];


--- Add new columns for saledate year and month 

SELECT
  car_model_year,
    make,
    model,
    body,
    transmission,
    region,
    mileage,
    color,
    interior,
    dealership,
    revenue,
    CONVERT(VARCHAR(10), saledate, 23) AS saledate,  -- yyyy-mm-dd
    YEAR(saledate) AS sale_date_year,
    DATENAME(MONTH, saledate) AS sale_date_month_name
FROM [CarSalesDb1].[dbo].[car_sales];

