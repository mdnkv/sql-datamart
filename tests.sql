-- Copyright 2025 Iurii Mednikov <iurii.mednikov@iu-study.org>

-- Use of this source code is governed by an MIT-style
-- license that can be found in the LICENSE file or at
-- https://opensource.org/licenses/MIT

-- This file descirbes queries that are used to test database and retrieve data

-- Countries
-- Select countries
SELECT id, country_name FROM countries ORDER BY country_name DESC;

-- Cities
-- Select cities and the country for the city
SELECT 
cities.id, 
cities.city_name, 
countries.country_name as country
FROM cities
INNER JOIN countries ON cities.country_id = countries.id
ORDER BY cities.city_name;

-- Feature categories
-- Select categories 
SELECT id, category_name FROM feature_categories ORDER BY category_name DESC;

-- Features
-- Select features with categories
SELECT
features.id,
features.feature_name,
feature_categories.category_name AS category
FROM features
INNER JOIN feature_categories ON features.category_id = feature_categories.id
ORDER BY features.feature_name;

-- Languages
-- Select all langauges
SELECT id, language_name FROM languages ORDER BY language_name;

-- Users
-- Select all users
SELECT 
	id,
  first_name,
  last_name,
  email,
  is_verified
 FROM useraccounts
 ORDER BY first_name DESC, last_name ASC;

-- User languages
-- Select users that speak English
SELECT 
useraccounts.id AS user_id,
useraccounts.first_name,
useraccounts.last_name
FROM useraccounts
LEFT JOIN userlanguages ON useraccounts.id = userlanguages.user_id
WHERE userlanguages.language_id = 1;

-- Landmark categories
-- Select all landmark categories
SELECT id, category_name FROM landmark_categories;

-- Landmarks
-- Select all landmarks in Bogota
SELECT id AS landmark_id, landmark_name
FROM landmarks
WHERE city_id = 16
ORDER BY landmark_name DESC;

-- landmarkcategories_landmarks
-- Select museums in Berlin
SELECT
landmarks.id AS landmark_id,
landmarks.landmark_name
FROM landmarkcategories_landmarks
INNER JOIN landmarks ON landmarkcategories_landmarks.landmark_id = landmarks.id
INNER JOIN landmark_categories ON landmarkcategories_landmarks.category_id = landmark_categories.id
WHERE landmark_categories.category_name = 'Museum' AND landmarks.city_id = 1;

-- Media
-- Select all media
SELECT id, media_type, media_path, property_id FROM media;

-- Payment methods
SELECT id, method_name FROM payment_methods WHERE method_name LIKE '%card';

-- Payments
-- Completed payments done with cards
SELECT payments.id AS payment_id,
payment_methods.method_name AS payment_method,
payments.payment_date AS payment_date
FROM payments
INNER JOIN payment_methods ON payments.payment_method_id = payment_methods.id
WHERE payments.payment_status = 'COMPLETED' AND payments.method_name LIKE '%card'
ORDER BY payments.payment_date DESC;

-- Properties
-- Select active properties
SELECT 
properties.id AS property_id,
cities.city_name AS city,
properties.rate_currency,
properties.rate_amount,
properties.title,
properties.property_description,
properties.property_type
FROM properties
INNER JOIN cities ON properties.city_id = cities.id
WHERE properties.is_active = true ORDER BY properties.rate_amount ASC;

-- Reviews
-- Select reviews with comments
SELECT 
id,
reservation_id,
rating,
comment
FROM reviews
WHERE comment IS NOT NULL;

-- Propertylandmarks
-- Select properties by distance from the landmark and order by distance and price
SELECT 
properties.id,
properties.rate_currency,
properties.rate_amount,
properties.title,
propertylandmarks.distance 
FROM propertylandmarks
INNER JOIN properties
ON propertylandmarks.property_id = properties.id
WHERE propertylandmarks.landmark_id = 1 AND propertylandmarks.distance < 10
ORDER BY propertylandmarks.distance ASC, properties.rate_amount ASC;

-- Reservations
-- Select completed reservations and calculate their price
SELECT
reservations.id AS reservation_id,
useraccounts.first_name AS guest_first_name,
useraccounts.last_name AS guest_last_name,
properties.rate_currency AS currency,
(properties.rate_amount * (reservations.to_date - reservations.from_date)) AS total_price
FROM reservations
INNER JOIN useraccounts ON reservations.guest_id = useraccounts.id
INNER JOIN properties ON properties.id = reservations.property_id
WHERE reservations.reservation_status = 'COMPLETED';

-- Hosts
-- Get user data for each host
SELECT 
DISTINCT useraccounts.id AS user_id,
useraccounts.first_name AS host_first_name,
useraccounts.last_name AS host_last_name
FROM hosts
INNER JOIN useraccounts ON useraccounts.id = hosts.user_id
ORDER BY host_first_name DESC, host_last_name DESC;

-- Property features
-- Select properties that have kitchen
SELECT 
properties.title,
properties.property_type,
properties.rate_currency,
properties.rate_amount
FROM propertyfeatures
INNER JOIN properties ON propertyfeatures.property_id = properties.id
WHERE propertyfeatures.feature_id = 3
ORDER BY properties.rate_amount ASC;