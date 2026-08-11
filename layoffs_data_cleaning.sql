-- Data Cleaning
select *from layoffs;
-- 1.Removing Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank values
-- 4 . Remove Any Columns

Create Table layoffs_staging 
Like layoffs;
insert layoffs_staging
select *from layoffs;
select *from layoffs_staging