	use Zepto_Sales;
	show tables;
	create table Zepto_sales_Raws (
	Sales_Date varchar(100),
	SKU_Name varchar(100),
	SKU_ID varchar(50),
	EAN varchar(50),
	Vendor_ID varchar(20),
	Vendor_Name varchar(50),
	City varchar(30),
	Brand_Name varchar(50),
	Manufacturer_ID varchar(50),
	Manufacturer_Name varchar(100),
	Store_Name varchar(100),
	SKU_Category varchar(100),
	Quantity int,
	primary key (Sales_Date, SKU_ID, Store_Name));
	describe Zepto_sales_Raws;
	select * from Zepto_sales_Raws;
	alter table Zepto_sales_Raws
	add column Sales_Date_New date after Sales_date;
	update Zepto_sales_Raws
	set Sales_Date_New = str_to_date(sales_date, '%d-%m-%Y');
	alter table Zepto_sales_Raws
	drop primary key;
	alter table Zepto_sales_Raws
	drop column Sales_Date;
	alter table Zepto_sales_Raws
	rename column Sales_Date_New to Sales_Date;
	alter table Zepto_sales_Raws
	add primary key (Sales_Date, SKU_ID, Store_Name);
	describe Zepto_sales_Raws;
	select * from Zepto_sales_Raws;

	create table zepto_sales_meta_data (
	Sales_Date varchar(100),
	SKU_Name varchar(100), 
	SKU_ID varchar(100), 
	City varchar(50), 
	Brand_Name varchar(50), 
	Manufacturer_ID varchar(100), 
	Manufacturer_Name varchar(50), 
	SKU_Category varchar(50), 
	Quantity varchar(50), 
	GMV varchar(50),
	primary key (Sales_Date, SKU_ID, City));
	describe zepto_sales_meta_data;
	select * from zepto_sales_meta_data;
	alter table zepto_sales_meta_data 
	add column Sales_Date_New date after Sales_Date;
	set sql_safe_updates=0;
	update zepto_sales_meta_data 
	set Sales_Date_New = str_to_date(Sales_Date, '%d-%m-%Y');
	alter table zepto_sales_meta_data 
	drop primary key;
	alter table zepto_sales_meta_data 
	drop column Sales_Date;
	alter table zepto_sales_meta_data 
	rename column Sales_Date_New to Sales_Date;
	alter table zepto_sales_meta_data 
	add primary key (Sales_Date, SKU_ID, City);
	describe zepto_sales_meta_data;
	select * from zepto_sales_meta_data;
	update zepto_sales_meta_data
	set Quantity = null
	where Quantity ='';
	update zepto_sales_meta_data
	set GMV = null
	where GMV ='';
	alter table zepto_sales_meta_data
	modify column Quantity int;
	alter table zepto_sales_meta_data
	modify column GMV int;
	describe zepto_sales_meta_data;
	select sum(GMV) from zepto_sales_meta_data;

	create table zepto_stock_on_hand (
	City varchar(50),
	Brand_Name varchar(50),
	Vendor_ID varchar(50),
	Vendor_Name varchar(150),
	Manufacturer_ID varchar(100),
	Manufacturer_Name varchar(100),
	Store_Name varchar(150),
	Store_Type varchar(50),
	SKU_Category varchar(150),
	SKU_Name varchar(100),
	SKU_ID varchar(50),
	EAN varchar(50),
	Total_Quantity int,
	primary key (SKU_ID,Store_Name));
	describe zepto_stock_on_hand;
	select * from zepto_stock_on_hand;
	update zepto_stock_on_hand
	set Vendor_ID =null
	where Vendor_ID ='';
	update zepto_stock_on_hand
	set Vendor_Name =null
	where Vendor_Name ='';
	select count(vendor_id) from zepto_stock_on_hand;

CREATE TABLE zepto_dark_store_insights AS
SELECT
    A.Sales_Date AS date,
    A.SKU_ID AS sku_id,
    A.SKU_Name AS sku,
    A.SKU_Category AS category,
    A.City AS platform_city,
    A.Store_Name AS dark_store,
    A.Quantity AS qty_sold,

    B.GMV / NULLIF(B.Quantity, 0) AS sales_mrp,

    AVG(A.Quantity) OVER (
        PARTITION BY A.SKU_ID, A.City, A.Store_Name
        ORDER BY A.Sales_Date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS drr_7,

    AVG(A.Quantity) OVER (
        PARTITION BY A.SKU_ID, A.City, A.Store_Name
        ORDER BY A.Sales_Date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
    ) AS drr_14,

    C.Total_Quantity AS dark_store_inv_qty,

    C.Total_Quantity / NULLIF(
        AVG(A.Quantity) OVER (
            PARTITION BY A.SKU_ID, A.City, A.Store_Name
            ORDER BY A.Sales_Date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
        ), 0
    ) AS days_of_inventory_drr_14,

    SUM(B.GMV / NULLIF(B.Quantity, 0)) OVER (
        PARTITION BY A.SKU_ID, A.City, A.Store_Name, MONTH(A.Sales_Date)
    ) AS month_to_date_sales

FROM Zepto_sales_Raws A
JOIN zepto_sales_meta_data B
    ON A.Sales_Date = B.Sales_Date AND A.SKU_ID = B.SKU_ID AND A.City = B.City
JOIN zepto_stock_on_hand C
    ON A.SKU_ID = C.SKU_ID AND A.Store_Name = C.Store_Name AND A.City = C.City
WHERE C.Store_Type = 'RETAIL_STORE';

SELECT * FROM zepto_dark_store_insights;








