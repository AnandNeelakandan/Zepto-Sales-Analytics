# Zepto Sales Analytics

This project analyzes sales and inventory data for Zepto dark stores.  
The goal is to answer business questions such as **daily run rate (DRR_7, DRR_14)**,  
**days of inventory**, and **month-to-date (MTD) sales** using SQL.  

---

## 📂 Repository Structure

- **Dataset for zepto/** → Raw datasets provided (`zepto_sales`, `zepto_sales_meta_data`, `zepto_stock_on_hand`).
- **ZEPTO SQL QUERIES_FOR_PROJECT/** → Contains all SQL queries written for analysis.
- **Zepto_Sales_Project_Data_Dictionary/** → Metadata and description of dataset fields.
- **Zepto_dark_store_output/** → Excel output of SQL queries (raw result sets exported from MySQL Workbench).

---

## 🔑 Key SQL Analysis Performed
- Calculated **Daily Run Rate (DRR_7 and DRR_14)** for each SKU, city, and dark store.  
- Computed **Days of Inventory** using stock on hand vs. DRR_14.  
- Derived **Month-to-Date Sales** at SKU, city, and dark store level.  
- Merged datasets (`zepto_sales`, `zepto_sales_meta_data`, `zepto_stock_on_hand`) to build insights.  

---

## 🛠️ Tools Used
- **MySQL Workbench** → Writing and executing SQL queries.  
- **Excel** → Exporting query results for better readability.  
- **GitHub** → Project documentation and version control.  

---

## 🚀 How to Use
1. Download the datasets from `Dataset for zepto/`.  
2. Run the SQL queries from `ZEPTO SQL QUERIES_FOR_PROJECT/` in MySQL Workbench.  
3. Compare results with the Excel output (`Zepto_dark_store_output`).  

---

## 📌 Author
**Anand Neelakandan**  
- 💼 Aspiring Data Analyst  
- 📊 Skills: SQL, Excel 
