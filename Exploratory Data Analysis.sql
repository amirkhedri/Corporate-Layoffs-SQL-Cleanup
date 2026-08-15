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

select year(`date`) , sum(total_laid_off) 
from layoffs_staging2
group by YEAR(`date`)
order by 1;

select stage , sum(total_laid_off) from layoffs_staging2 
group by stage
order by 2 desc;

select substring(`date` , 1 , 7) As "MONTH" , sum(total_laid_off) from layoffs_staging2
group by month 
order by 2;

with rolling_total AS
(
select substring(`date` , 1 , 7) As "MONTH" , sum(total_laid_off) as total_off from layoffs_staging2 
group by month
order by 1 asc
)
select month ,total_off , sum(total_off) over(order by month) AS rolling_total 
from rolling_total;
