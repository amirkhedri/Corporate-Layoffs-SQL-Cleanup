-- Exploratory Data Analysis (EDA)

select max(total_laid_off) , max(percentage_laid_off) from layoffs_staging2;
select * from layoffs_staging2
where percentage_laid_off=1;


