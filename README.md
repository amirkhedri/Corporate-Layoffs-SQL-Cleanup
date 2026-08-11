<div align="center">
  
  # 🧹 Global Tech Layoffs: SQL Data Cleaning 
  
  *Transforming messy, real-world datasets into analytics-ready gold.*
  
  ![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
  ![Data Cleaning](https://img.shields.io/badge/Data_Cleaning-FF9E0F?style=for-the-badge&logo=data-databricks&logoColor=white)
  ![Portfolio Project](https://img.shields.io/badge/Portfolio_Project-2F80ED?style=for-the-badge)

  <br>

  <!-- REPLACE THIS LINK WITH A GIF OF YOU SCROLLING THROUGH THE CLEANED DATA -->
  <img src="https://via.placeholder.com/800x400/005C84/FFFFFF?text=Drop+a+GIF+of+your+SQL+queries+running+here!" alt="SQL Demo GIF" width="800"/>

</div>

<br>

## 📋 Project Overview
This repository contains the SQL scripts and methodology used to clean and standardize a messy dataset of global corporate layoffs. The objective of this phase is to transform raw, inconsistent data into a high-quality, reliable dataset perfectly optimized for Exploratory Data Analysis (EDA).

---

## ⚙️ The Data Cleaning Pipeline

### Phase 1: Environment Setup & Data Protection
Before manipulating any data, the raw dataset must be secured.
* Created a structural replica called `layoffs_staging`.
* Inserted all raw data into the staging environment. This guarantees the original dataset remains entirely untouched and serves as a backup in case of critical pipeline errors.

### Phase 2: Duplicate Detection & Removal
Because the raw dataset lacked a unique primary key identifier, advanced duplicate detection was required.

<!-- REPLACE THIS LINK WITH A SCREENSHOT OF YOUR DUPLICATE CTE QUERY -->
> <img src="https://via.placeholder.com/600x250/2980B9/FFFFFF?text=Add+Screenshot+of+Duplicate+CTE+Code" alt="CTE Code Snapshot" width="600"/>

* Utilized the `ROW_NUMBER()` window function, paired with `OVER(PARTITION BY ...)`, to generate unique row counts for exact matches across all column attributes.
* Wrapped the logic inside a **Common Table Expression (CTE)** to isolate identical records (`row_num >= 2`).
* **Engineering Workaround:** To bypass MySQL's strict limitations regarding updating/deleting directly from a CTE, a secondary staging table (`layoffs_staging2`) was instantiated to safely drop duplicates using `DELETE`.

### Phase 3: Data Standardization
Inconsistent text entries and incorrect data types were systematically corrected to ensure accurate aggregations.

* **White Space Removal:** Applied the `TRIM()` function to the `company` column to strip invisible trailing or leading spaces that break `GROUP BY` statements.
* **Industry Consolidation:** Identified distinct spelling variations within the Cryptocurrency sector (e.g., "Crypto Currency", "Crypto") and standardized them to a uniform `"Crypto"` label.
* **Geographical Corrections:** Removed trailing punctuation errors in the `country` column (e.g., converting `"United States."` to `"United States"`).
* **Time-Series Formatting:** Utilized the `STR_TO_DATE()` function to parse raw text strings (`'%m/%d/%Y'`), followed by an `ALTER TABLE` command to permanently cast the column to a standard MySQL `DATE` data type.

### Phase 4: Handling Missing & Null Values
Missing data was evaluated and either recovered or strategically removed.

<!-- REPLACE THIS LINK WITH A BEFORE AND AFTER SCREENSHOT OF THE DATA -->
<div align="center">
  <img src="https://via.placeholder.com/700x300/4CAF50/FFFFFF?text=Add+a+Before/After+Screenshot+of+Cleaned+Data" alt="Cleaned Data Result" width="700"/>
</div>

* **Blank Standardization:** Converted all empty string (`''`) anomalies in the `industry` column into true `NULL` values for standardized querying.
* **Data Imputation via Self-Join:** Engineered a `JOIN` on the table to itself. If a company's industry was `NULL` in one row, the query searched for populated rows sharing the same `company` name and dynamically updated the missing fields.
* **Strategic Deletions:** Safely dropped records where both quantitative metrics (`total_laid_off` and `percentage_laid_off`) were `NULL`. 

### Phase 5: Final Cleanup
* Dropped the temporary `row_num` structural column used during the duplicate removal phase to restore the table to its original, production-ready schema.

---

## 💡 Key SQL Competencies Demonstrated
* **Window Functions:** `ROW_NUMBER()`, `PARTITION BY`
* **Advanced Joins:** `JOIN` (Self-Joins for programmatic data imputation)
* **String Manipulation:** `TRIM()`, `LIKE`
* **Type Casting & Date Formatting:** `STR_TO_DATE()`, `ALTER TABLE ... MODIFY COLUMN`
* **Data Governance:** Staging environments, safe update toggling, logical data deletions.

---
<div align="center">
  <b>👨‍💻 Built by Amirmohammad Khedri</b>
</div>
