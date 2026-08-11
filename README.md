<div align="center">
  
  # 🧹 Global Tech Layoffs: SQL Data Cleaning 
  
  *Transforming messy, real-world datasets into analytics-ready gold.*
  
  ![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
  ![Data Engineering](https://img.shields.io/badge/Data_Engineering-FF9E0F?style=for-the-badge&logo=databricks&logoColor=white)
  ![Data Analytics](https://img.shields.io/badge/Data_Analytics-2F80ED?style=for-the-badge&logo=googleanalytics&logoColor=white)

</div>

<br>

## 📋 Project Overview
> **Objective:** To programmatically transform a raw, inconsistent dataset of global corporate layoffs into a high-quality, reliable dataset perfectly optimized for Exploratory Data Analysis (EDA).

This repository contains the SQL scripts and methodology used to clean and standardize the data. It demonstrates a rigorous approach to database management, focusing on data integrity, anomaly resolution, and scalable query writing.

---

## ⚙️ The Data Cleaning Pipeline

### Phase 1: Environment Setup & Data Protection
Before manipulating any data, the raw dataset was secured to ensure the original records remained completely untouched.
* **Staging Implementation:** Created a structural replica called `layoffs_staging` and inserted all raw data into this environment. 
* **Failsafe:** This guarantees a reliable backup exists in case of critical pipeline errors during the cleaning process.

### Phase 2: Duplicate Detection & Removal
Because the raw dataset lacked a unique primary key identifier, advanced duplicate detection was required.
* **Window Functions:** Utilized `ROW_NUMBER()` paired with `OVER(PARTITION BY ...)` to generate unique row counts for exact matches across all column attributes.
* **Common Table Expressions (CTEs):** Wrapped the logic inside a CTE to isolate identical records (`row_num >= 2`).
* **Engineering Workaround:** To bypass MySQL's strict limitations regarding updating/deleting directly from a CTE, a secondary staging table (`layoffs_staging2`) was instantiated to safely execute the `DELETE` commands.

### Phase 3: Data Standardization
Inconsistent text entries and incorrect data types were systematically corrected to ensure accurate future aggregations.
* **White Space Removal:** Applied the `TRIM()` function to the `company` column to strip invisible trailing or leading spaces that corrupt `GROUP BY` operations.
* **Industry Consolidation:** Identified distinct spelling variations within sectors (e.g., "Crypto Currency", "Crypto") and standardized them to a uniform label using the `LIKE` operator.
* **Geographical Corrections:** Removed trailing punctuation errors in the `country` column (e.g., converting `"United States."` to `"United States"`).
* **Time-Series Formatting:** Utilized the `STR_TO_DATE()` function to parse raw text strings (`'%m/%d/%Y'`), followed by an `ALTER TABLE` command to permanently cast the column to a standard MySQL `DATE` data type.

### Phase 4: Handling Missing & Null Values
Missing data was evaluated and either recovered or strategically removed.
* **Blank Standardization:** Converted all empty string (`''`) anomalies in the `industry` column into true `NULL` values for standardized querying.
* **Data Imputation via Self-Join:** Engineered a `JOIN` on the table to itself. If a company's industry was `NULL` in one row, the query dynamically searched for populated rows sharing the same `company` name and updated the missing fields.
* **Strategic Deletions:** Safely dropped records where both quantitative metrics (`total_laid_off` and `percentage_laid_off`) were `NULL`, as rows missing both critical data points hold zero analytical value.

### Phase 5: Final Cleanup
* **Schema Restoration:** Dropped the temporary `row_num` structural column used during the duplicate removal phase to restore the table to its original, production-ready schema.

---

## 💡 Key SQL Competencies Demonstrated

* 🔍 **Window Functions:** `ROW_NUMBER()`, `PARTITION BY`
* 🔗 **Advanced Joins:** `JOIN` (Self-Joins for programmatic data imputation)
* 📝 **String Manipulation:** `TRIM()`, `LIKE`
* ⏳ **Type Casting & Date Formatting:** `STR_TO_DATE()`, `ALTER TABLE ... MODIFY COLUMN`
* 🛡️ **Data Governance:** Staging environments, safe update toggling, logical data deletions.

---

<div align="center">
  <b>👨‍💻 Engineered by Amirmohammad Khedri</b> <br>
  <i>Built for the 30-Week Data Analytics Master Schedule</i>
</div>
