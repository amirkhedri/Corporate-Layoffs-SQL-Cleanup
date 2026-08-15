-- Exploratory Data Analysis (EDA)

-- Finding fully laid off companies 
select max(total_laid_off) , max(percentage_laid_off) from layoffs_staging2;
select * from layoffs_staging2
where percentage_laid_off=1
order by total_laid_off desc;	

-- Finding total laid offs for each parameter

select company , sum(total_laid_off) from layoffs_staging2 
group by company
order by 2 desc;

select industry , sum(total_laid_off) from layoffs_staging2 
group by industry
order by 2 desc;


select country , sum(total_laid_off) from layoffs_staging2 
group by country
order by 2 desc;