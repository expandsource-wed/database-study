-- EX04_JOIN 연습문제.sql
USE sakila;

-- MySQL 샘플 DB sakila : 영화 대여점 비즈니스 모델 기반으로 설계된 DB

-- JOIN 연습문제
-- sakila 데이터베이스에서 조회하세요.
-- 문제 1: 고객(customer)의 이름과 그들이 대여(rental)한 영화(film)의 제목을 조회하세요.
-- 선택할 컬럼 : 이름(first_name, last_name) 영화 제목(title)
-- 사용 테이블: customer(customer_id, first_name, last_name), rental(rental_id, customer_id, inventory_id), film(film_id, title), inventory(inventory_id, film_id)
SELECT c.first_name, c.last_name, f.title
 FROM customer c
 JOIN rental r USING (customer_id)
 JOIN inventory i USING (inventory_id)
 JOIN film f USING (film_id);

-- 문제 2: 각 영화(film)의 제목과 해당 영화가 속한 카테고리(category)의 이름을 조회하세요.
-- 선택할 컬럼: 영화제목(film.title), 카테고리이름(category.name)
-- 사용 테이블: film(film_id, title), film_category(film_id, category_id), category(category_id, name)
DESC film;
DESC film_category;
DESC category;

SELECT f.title, c.name
 FROM film f
 JOIN film_category fc ON f.film_id = fc.film_id
 JOIN category c ON fc.film_id = c.category_id;

-- 문제 3: 각 영화(film)에 대해 몇 명의 배우(actor)가 출연했는지, 영화 제목과 함께 조회하세요.
-- 선택할 컬럼 : 영화제목(film.title), 영화배우 수(count(film_actor.actor_id))
-- 사용 테이블: film(film_id, title), film_actor(film_id, actor_id), actor(actor_id, first_name, last_name)
SELECT f.film_id, f.title as 영화제목, count(fa.actor_id) as 영화별배우수
 FROM film f
 JOIN film_actor fa ON f.film_id = fa.film_id
 GROUP BY f.film_id;


-- 문제 4: 모든 대여(rental) 정보에 대해, 해당 대여가 이루어진 스토어(store)의 ID와 직원(staff)의 이름을 조회하세요.
-- 선택할 컬럼 : 대여ID(rental_id), 스토어ID(stord_id), 스탭이름(first_name, last_name)
-- 사용 테이블: rental(rental_id, staff_id), store(store_id), staff(staff_id, first_name, last_name, store_id)
SELECT 
    r.rental_id, s.store_id, 
    st.first_name as '직원이름', st.last_name as '직원성'
FROM
    rental r
        JOIN
    staff st USING (staff_id)
        JOIN
    store s USING (store_id);

-- 문제 5: 가장 많이 대여된 영화 5개의 제목과 대여 횟수를 조회하세요.
-- 선택할 컬럼 : 영화제목(film.title), 대여횟수(count(rental_id))
-- 사용 테이블: film(film_id, title), inventory(inventory_id, film_id), rental(rental_id, inventory_id)
SELECT 
    f.film_id, f.title, COUNT(r.rental_id) AS '영화별대여횟수'
FROM
    film f
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY 영화별대여횟수 DESC
LIMIT 5;

-- 문제 6: 각 고객(customer)별로 그들이 지불한 총 금액(payment)을 조회하세요.
-- 선택할 컬럼 : 고객ID(customer_id), 총 금액(sum(payment.amount))
-- 사용 테이블: customer(customer_id, first_name, last_name), payment(payment_id, customer_id, amount)
SELECT c.customer_id, c.first_name, c.last_name, sum(p.amount)
 FROM customer c
 JOIN payment p USING (customer_id)
GROUP BY c.customer_id;


-- 문제 7: 각 카테고리(category)별로 대여된 영화의 총 수를 조회하세요.
-- 선택할 컬럼 : 카테고리ID, 이름(category_id, name), 총 대여 수(count(rental_id)
-- 사용 테이블: category(category_id, name), film_category(film_id, category_id), inventory(inventory_id, film_id), rental(rental_id, inventory_id)
SELECT c.category_id, c.name, count(rental_id)
 FROM category c
 JOIN film_category f USING (category_id)
 JOIN inventory i USING (film_id)
 JOIN rental r USING (inventory_id)
GROUP BY c.category_id;


-- 문제 8: 2005년 7월에 대여된 모든 영화의 제목과 대여 날짜를 조회하세요.
-- 선택할 컬럼 : 영화제목(film.title), 대여날짜(rental.rental_date)
-- 사용 테이블: rental(rental_id, rental_date, inventory_id), inventory(inventory_id, film_id), film(film_id, title)

SELECT r.rental_date, f.title as film_title 
 FROM rental r
 JOIN inventory i ON r.inventory_id = i.inventory_id
 JOIN film f ON i.film_id = f.film_id
 WHERE r.rental_date BETWEEN '2005-07-01' AND '2005-07-31';


-- 문제 9: 'Comedy' 카테고리에 속하는 영화들의 평균 대여 기간(rental_duration)을 조회하세요.
-- 선택할 컬럼 : 카테고리명(category_name) 대여기간(film.rental_duration)
-- 사용 테이블: category(category_id, name), film_category(film_id, category_id), film(film_id, title, rental_duration)
SELECT c.name as '카테고리명', avg(f.rental_duration) as '평균대여기간'
 FROM category c
 JOIN film_category fc ON c.category_id = fc.category_id
 JOIN film f ON fc.film_id = f.film_id
 WHERE c.name = 'Comedy';


-- 문제 10: 모든 배우(actor)의 이름과 그들이 출연한 영화(film)의 수를 조회하세요. (LEFT JOIN 사용)
-- 선택할 컬럼 : 배우 이름(actor.first_name, actor.last_name), 영화수(count(film_id))
-- 사용 테이블: actor(actor_id, first_name, last_name), film_actor(actor_id, film_id), film(film_id)

SELECT a.actor_id, a.first_name, a.last_name,
	count(f.film_id) as `배우별 영화출연수`
 FROM actor a
 LEFT JOIN film_actor f ON a.actor_id = f.actor_id
 GROUP BY actor_id;
