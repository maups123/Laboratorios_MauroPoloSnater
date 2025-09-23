select title from film;

SELECT DISTINCT name AS language
FROM language;

SELECT COUNT(*) as total_stores
FROM store;

SELECT COUNT(*) AS total_staff
FROM staff;

SELECT first_name, last_name
FROM staff;

SELECT *
FROM actor
WHERE first_name = 'SCARLETT';

SELECT *
FROM actor
WHERE last_name = 'JOHANSSON';

SELECT COUNT(*) AS available_films
FROM inventory;

SELECT COUNT(*) AS rented_films
FROM rental;

SELECT MIN(rental_duration) AS shortest_rental,
       MAX(rental_duration) AS longest_rental
FROM film;

SELECT MIN(length) AS min_duration,
       MAX(length) AS max_duration
FROM film;

SELECT AVG(length) AS avg_duration
FROM film;

SELECT FLOOR(AVG(length) / 60) AS hours,
       ROUND(AVG(length) % 60) AS minutes
FROM film;

SELECT COUNT(*) AS films_over_3h
FROM film
WHERE length > 180;

SELECT CONCAT(first_name, ' ', last_name, ' - ', email) AS formatted_contact
FROM customer;

SELECT MAX(LENGTH(title)) AS longest_title_length
FROM film;

