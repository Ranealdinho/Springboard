select *
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4

--select *
--from PortfolioProject..CovidVaccinations 
--order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1, 2

-- looking at total cases vs total deaths
-- shows likelihood of death after contracting covid in your country
select location, date, total_cases, total_deaths,(total_deaths / total_cases )*100 as death_percentage
from PortfolioProject..CovidDeaths
where location like '%states%'
order by 1, 2

-- looking at total cases vs total population
-- shows what percentage of population got covid
select location, date, population, total_cases, (total_cases/ population )*100 as covid_percentage
from PortfolioProject..CovidDeaths
where location like '%states%'
order by 1, 2

--looking at countries with highest infection rate compared to population
select location, population, max(total_cases) as highest_infection_count, max((total_cases/ population ))*100 as covid_percentage
from PortfolioProject..CovidDeaths
--where location like '%states%'
group by location, population
order by covid_percentage desc

--looking at countries with highest death count per population
select location,  max(cast(total_deaths as int)) as total_death_count
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
group by location
order by total_death_count desc


-- continent with highest death counts per continent
select continent,  max(cast(total_deaths as int)) as total_death_count
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
group by continent
order by total_death_count desc



-- Global numbers
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as global_death_percentage
From PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
--group by date
order by 1, 2 

-- looking at total populations vs vaccinations
-- use CTE

with PopvsVac (continent, location, date, population, new_vaccinations, rolling_people_vaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as bigint)) OVER (partition by dea.location order by dea.location, dea.date) as rolling_people_vaccinated
--, (rolling_people_vaccinated/ population)*100
FROM PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select *, (rolling_people_vaccinated/ population)*100 as vaccination_rate
from PopvsVac


--using Temporary Table
drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rolling_people_vaccinated numeric
)

insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as bigint)) OVER (partition by dea.location order by dea.location, dea.date) as rolling_people_vaccinated
--, (rolling_people_vaccinated/ population)*100
FROM PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select *, (rolling_people_vaccinated/ population)*100 as vaccination_rate
from #PercentPopulationVaccinated


--creating view to store data for visualization later

Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as bigint)) OVER (partition by dea.location order by dea.location, dea.date) as rolling_people_vaccinated
--, (rolling_people_vaccinated/ population)*100
FROM PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3