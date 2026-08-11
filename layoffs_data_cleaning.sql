-- Data Cleaning
select *from layoffs;
-- 1.Removing Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank values
-- 4 . Remove Any Columns



-- Creating the Staging Table
Create Table layoffs_staging 
Like layoffs;
insert layoffs_staging
select *from layoffs;
select *from layoffs_staging;


-- 1.Removing Duplicates
select *
, Row_Number() over (partition by stage,company , location, funds_raised_millions,  industry , total_laid_off , country, percentage_laid_off , `date`) as "row_num"
from layoffs_staging;
with duplicate_cte as 
(
select *
, Row_Number() over (partition by stage ,company ,  industry , total_laid_off , country, percentage_laid_off , `date`) as "row_num"
from layoffs_staging
)
select * from duplicate_cte 
where row_num >= 2 ;


