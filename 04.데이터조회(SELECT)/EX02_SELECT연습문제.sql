-- EX02_SELECT연습문제
USE world;

-- 문제 1: ORDER BY와 LIMIT 사용
-- 1. country 테이블에서 인구(Population)가 많은 상위 10개의 나라를 조회하세요.
SELECT Name, Population 
FROM country 
ORDER BY Population DESC LIMIT 10;

-- 문제 2: ORDER BY와 LIMIT, OFFSET 사용
-- 2. city 테이블에서 인구(Population)가 많은 상위 10번째에서 20번째까지의 도시를 조회하세요.
SELECT Name, Population 
FROM city 
ORDER BY Population DESC LIMIT 10 OFFSET 10;

-- 문제 3: ORDER BY와 LIMIT, OFFSET 사용
-- 3. country 테이블에서 대륙(Continent)이 'Asia'인 나라들을 면적(SurfaceArea) 기준으로 내림차순 정렬하여 상위 5개의 나라를 조회하세요.
SELECT Name, SurfaceArea
FROM country
WHERE Continent = 'Asia'
ORDER BY SurfaceArea DESC LIMIT 5;

-- 문제 4: ORDER BY와 LIMIT 사용
-- 4. city 테이블에서 이름(Name)을 오름차순 정렬하여 첫 5개의 도시를 조회하세요.
SELECT Name
FROM city
ORDER BY Name LIMIT 5;

-- 문제 5: DISTINCT 사용
-- 5. country 테이블에서 고유한 대륙(Continent) 목록을 조회하세요.
SELECT DISTINCT Continent
FROM country;

-- 문제 6: ORDER BY와 DISTINCT 사용
-- 6. city 테이블에서 고유한 국가 코드(CountryCode)를 조회하고, 이를 오름차순으로 정렬하세요.
SELECT DISTINCT CountryCode
FROM city
ORDER BY CountryCode ASC;




-- (2)


-- 1. country 테이블에서 대륙(Continent)이 'Asia'인 나라들 중 인구(Population)가 많은 상위 5개 나라를 조회하세요.
-- 결과는 나라 이름(Name)과 인구(Population)를 내림차순으로 정렬하여 조회하세요.
SELECT Name, Population
FROM country
WHERE Continent = 'Asia'
ORDER BY Population DESC LIMIT 5;

-- 2. countrylanguage 테이블에서 고유한 나라 코드(CountryCode) 목록을 조회하세요.
-- 결과는 나라 코드(CountryCode)를 오름차순으로 정렬하여 조회하세요.
SELECT DISTINCT CountryCode
FROM countrylanguage
ORDER BY CountryCode;

-- 3. city 테이블에서 이름(Name)이 'S'로 시작하는 도시들 중 인구(Population)가 많은 상위 5개 도시를 조회하세요.
-- 결과는 도시 이름(Name)과 인구(Population)를 내림차순으로 정렬하여 조회하세요.
SELECT Name, Population
FROM city
WHERE Name LIKE 'S%'
ORDER BY Population DESC LIMIT 5;

-- 4. country 테이블에서 인구(Population)가 1000만에서 5000만 사이인 나라들을 조회하세요.
-- 결과는 나라 이름(Name)과 인구(Population)를 인구가 많은 순서로 정렬하여 조회하세요.
SELECT Name, Population
FROM country
WHERE Population BETWEEN 10000000 AND 50000000
ORDER BY Population DESC;


-- 5. country 테이블에서 대륙(Continent)이 'Europe', 'Asia', 'North America'인 나라들 중 GNP가 높은 상위 10개 나라를 조회하세요.
-- 결과는 나라 이름(Name)과 GNP를 내림차순으로 정렬하여 조회하세요.
SELECT Name, GNP
FROM country
WHERE Continent IN ('Europe', 'Asia', 'North America')
ORDER BY GNP DESC LIMIT 10;




