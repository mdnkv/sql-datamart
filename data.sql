-- Copyright 2025 Iurii Mednikov <iurii.mednikov@iu-study.org>

-- Use of this source code is governed by an MIT-style
-- license that can be found in the LICENSE file or at
-- https://opensource.org/licenses/MIT

-- This file containts test data 

-- DISCLAIMER: user data was generated using fake data generators and does not represent any real person

-- Add 20 countries
INSERT INTO countries (id, country_name) VALUES 
(1, 'Germany'),
(2, 'Serbia'),
(3, 'Mexico'),
(4, 'Colombia'),
(5, 'Brazil'),
(6, 'Peru'),
(7, 'Ecuador'),
(8, 'Bolivia'),
(9, 'Chile'),
(10, 'Paraguay'),
(11, 'Dominican Republic'),
(12, 'Panama'),
(13, 'Uruguay'),
(14, 'Bosnia and Herzegovina'),
(15, 'Montenegro'),
(16, 'India'),
(17, 'Sri Lanka'),
(18, 'Tunisia'),
(19, 'Morocco'),
(20, 'Egypt');

-- Add 20 cities
INSERT INTO cities (id, country_id, city_name) VALUES
(1, 1, 'Berlin'),
(2, 1, 'Dresden'),
(3, 1, 'Erfurt'),
(4, 1, 'Munich'),
(5, 2, 'Belgrade'),
(6, 2, 'Novi Sad'),
(7, 2, 'Nis'),
(8, 2, 'Kraguevac'),
(9, 2, 'Sremski Karlovci'),
(10, 2, 'Sremska Mitrovica'),
(11, 3, 'Mexico City'),
(12, 3, 'Guadalajara'),
(13, 3, 'Puebla'),
(14, 3, 'Tijuana'),
(15, 3, 'Cancun'),
(16, 4, 'Bogota'),
(17, 4, 'Cali'),
(18, 4, 'Valledupar'),
(19, 4, 'Barranquilla'),
(29, 4, 'Cartagena');

-- Add 20 languages
INSERT INTO languages (id, language_name) VALUES 
(1, 'English'),
(2, 'German'),
(3, 'Serbian'),
(4, 'Spanish'),
(5, 'Russian'),
(6, 'Hindi'),
(7, 'Turksih'),
(8, 'French'),
(9, 'Japanese'),
(10, 'Chinese'),
(11, 'Portuguese'),
(12, 'Tagalog'),
(13, 'Thai'),
(14, 'Arabic'),
(15, 'Vietnamese'),
(16, 'Croatian'),
(17, 'Bosnian'),
(18, 'Tamil'),
(19, 'Swahili'),
(20, 'Creole');

-- Add landmark categories
INSERT INTO ladmark_categories (id, category_name) VALUES
(1, 'Museum'),
(2, 'Airport'),
(3, 'Bus station'),
(4, 'Hospital'),
(5, 'Cafe'),
(6, 'University'),
(7, 'Theater'),
(8, 'Tourist attraction'),
(9, 'Restaurant'),
(10, 'Train station');

-- Add 20 landmarks
INSERT INTO landmarks (id, city_id, landmark_name) VALUES
(1, 1, 'Pergamonmuseum'),
(2, 1, 'Neues Museum'),
(3, 1, 'Gemäldegalerie'),
(4, 1, 'Alte Nationalgalerie'),
(5, 5, 'National Museum'),
(6, 5, 'Nikola Tesla Museum'),
(7, 5, 'Museum of aviation'),
(8, 5, 'Nikola Tesla Airport'),
(9, 5, 'Ethnographic Museum'),
(10, 5, 'Historical Museum of Serbia'),
(11, 5, 'Zemun museum'),
(12, 16, 'Museo del Oro'),
(13, 16, 'Museo Nacional'),
(14, 16, 'Museo del Banco de la República'),
(15, 16, 'Cada de moneda'),
(16, 16, 'Museo Internacional De La Esmeralda'),
(17, 16, 'Casa Museo Quinta de Bolivar'),
(18, 16, 'Museo de Arte de la Republica'),
(19, 16, 'Centro Cultural Gabriel Garcia Marquez'),
(20, 16, 'El Dorado Airport');

-- Assign ladmarks to categories 
INSERT INTO landmarkcategories_landmarks (landmark_id, category_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 2),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 2);

-- Add 20 users
INSERT INTO useraccounts (id, email, first_name, last_name) VALUES
(1, 'estrauss@dietz.de', 'Sabina', 'Krebs'),
(2, 'rvoigt@rau.de', 'Marietta', 'Walter'),
(3, 'hellmut32@weise.de', 'Daniela', 'Neuhaus'),
(4, 'paula.naumann@burger.de', 'Madeleine', 'Busse-Noll'),
(5, 'paula.buchholz@rose.de', 'Fabian', 'Albrecht'),
(6, 'gabriel81@tovar.com', 'Vera', 'Cuellar Hijo'),
(7, 'mariapaula.rosario@naranjo.net', 'Helena', 'Ávila'),
(8, 'mariana.barrios@ulibarri.com', 'Marina', 'Alma Vargas'),
(9, 'emmanuel22@santiago.com', 'Luna Paula', 'Polanco'),
(10, 'jose46@madera.com', 'Natalia', 'Holguín'),
(11, 'alanis.antonia@barragan.net', 'Joan Alexandra', 'Calero'),
(12, 'carlos.chapa@reynoso.com', 'Olivia', 'Domínquez Castañeda'),
(13, 'tobie.gates@googlemail.com', 'Bella Andrea', 'Sanchez'),
(14, 'fwn2py0vbbn8@aol.com', 'Magdalena Julieta', 'Páez Lozada'),
(15, 'nikhil.price@googlemail.com', 'Valentina', 'Arroyo'),
(16, '3osq383esrpw@rediffmail.com', 'Horacio', 'Terrazas'),
(17, 'connor-david.velasquez@hotmail.com', 'Jerónimo', 'León Ontiveros'),
(18, 'andreas.raymond@rediffmail.com', 'Olivia', 'Ponce'),
(19, 'qj4tnx7e46jj3@googlemail.com', 'Gabriela Alessandra', 'Chapa Marín'),
(20, '5boty5jtqc56@msn.com', 'Ariadna Michelle', 'Zelaya Trujillo');

-- Add user languages
INSERT INTO userlanguages (user_id, language_id) VALUES 
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 2),
(4, 1),
(4, 2),
(4, 8),
(5, 2),
(5, 5),
(5, 7),
(6, 4),
(7, 4),
(7, 1),
(8, 4),
(9, 4),
(10, 5),
(10, 4),
(11, 4),
(11, 1),
(11, 5),
(11, 8),
(12, 4);

-- Add 20 properties
INSERT INTO properties (id, city_id, is_active, title, property_description, property_type, rate_currency, rate_amount) VALUES
(1, 1, FALSE, 'Nam liber tempor cum soluta', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'APARTMENT', 'EUR', 120.0),
(2, 1, TRUE, 'Ut wisi enim ad minim veniam', 'Duis pellentesque leo erat, non consequat nisl aliquam id', 'APARTMENT', 'EUR', 85.0),
(3, 1, FALSE, 'Donec dapibus pretium lorem malesuada', 'Quisque nec purus convallis, pharetra ipsum quis, molestie elit', 'HOUSE', 'EUR', 250.0),
(4, 1, TRUE, 'Morbi vehicula egestas mi', 'Quisque vestibulum massa sit amet est faucibus consectetur', 'HOUSE', 'EUR', 199.95),
(5, 1, TRUE, 'Maecenas sit amet eros', 'Lorem ipsum dolor sit amet', 'APARTMENT', 'EUR', 75.0),
(6, 1, TRUE, 'Phasellus tempor felis quis lacinia feugiat', 'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas', 'APARTMENT', 'EUR', 125.59),
(7, 5, TRUE, 'Donec non ante a nisi porttitor', 'Praesent rutrum purus eget hendrerit sagittis', 'APARTMENT', 'RSD', 6000.0),
(8, 5, TRUE, 'Nullam justo quam', 'Nullam ut ex erat', 'APARTMENT', 'RSD', 12000.0),
(9, 5, TRUE, 'Cras placerat purus nec elit laoreet', 'Class aptent taciti sociosqu ad litora torquent per conubia nostra', 'HOUSE', 'RSD', 7580.00),
(10, 5, TRUE, 'Nulla ultrices orci velit', 'Mauris at luctus eros, nec pharetra felis.', 'APARTMENT', 'RSD', 8000.0),
(11, 5, TRUE, 'Aliquam ut arcu felis', 'Vestibulum sem elit, finibus pellentesque pharetra sit amet, sodales nec ex', 'APARTMENT', 'EUR', 8500.0),
(12, 16, TRUE, 'Duis et pellentesque enim', 'Nam sagittis, felis ut blandit vulputate, purus metus', 'APARTMENT', 'USD', 100.0),
(13, 16, TRUE, 'Curabitur gravida', 'Fusce at varius lacus, sit amet varius nisi', 'HOUSE', 'USD', 120.0),
(14, 16, TRUE, 'Sed nisl diam', 'Mauris et posuere dolor', 'APARTMENT', 'USD', 80.0),
(15, 16, FALSE, 'Aliquam vestibulum risus', 'Nunc et nunc non ante facilisis luctus', 'APARTMENT', 'USD', 50.0),
(16, 16, TRUE, 'Duis auctor', 'Curabitur semper finibus dolor nec aliquet', 'HOUSE', 'USD', 350.0),
(17, 16, TRUE, 'Duis volutpat tellus a auctor sodales', 'Praesent ac velit luctus, lobortis magna at, aliquam metus', 'APARTMENT', 'USD', 90.0),
(18, 2, TRUE, 'Praesent in justo lobortis', 'Phasellus dapibus ante enim, eu volutpat quam vehicula at', 'HOUSE', 'EUR', 5000.0),
(19, 2, FALSE, 'Fusce tristique iaculis', 'Sed nibh turpis, suscipit eu faucibus sit amet, posuere non nibh', 'APARTMENT', 'EUR', 300.0),
(20, 3, FALSE, 'Aenean tincidunt', 'Etiam aliquet laoreet ultricies', 'APARTMENT', 'EUR', 250.0);

-- Add hosts
INSERT INTO hosts (user_id, property_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(6, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10),
(1, 11),
(2, 13),
(3, 12),
(4, 14),
(5, 15),
(6, 16),
(7, 17),
(1, 18),
(4, 19),
(20, 20);

-- Add reservations
INSERT INTO reservations (id, guest_id, property_id, reservation_status, from_date, to_date, is_paid) VALUES
(1, 10, 1, 'COMPLETED', '2024-05-12', '2024-05-16', TRUE),
(2, 3, 1, 'CREATED', '2025-04-15', '2025-06-14', FALSE),
(3, 4, 2, 'COMPLETED', '2024-12-01', '2024-12-10', TRUE),
(4, 5, 5, 'CANCELLED', '2024-12-25', '2025-01-02', FALSE),
(5, 5, 4, 'COMPLETED', '2024-12-25', '2025-01-02', TRUE),
(6, 4, 15, 'COMPLETED', '2024-05-18', '2024-05-22', TRUE),
(7, 8, 8, 'COMPLETED', '2024-07-25', '2025-08-02', TRUE),
(8, 6, 14, 'COMPLETED', '2024-05-12', '2024-05-16', TRUE),
(9, 9, 20, 'CREATED', '2025-04-15', '2025-06-14', FALSE),
(10, 20, 12, 'COMPLETED', '2024-12-01', '2024-12-10', TRUE),
(11, 4, 18, 'CANCELLED', '2024-12-25', '2025-01-02', FALSE),
(12, 17, 19, 'COMPLETED', '2024-02-12', '2025-02-18', TRUE),
(13, 17, 20, 'COMPLETED', '2024-03-25', '2024-04-02', TRUE),
(14, 4, 10, 'COMPLETED', '2024-07-25', '2025-08-02', TRUE),
(15, 4, 12, 'CANCELLED', '2024-05-12', '2024-05-16', TRUE),
(16, 4, 8, 'CREATED', '2025-04-15', '2024-06-14', FALSE),
(17, 4, 2, 'COMPLETED', '2024-12-01', '2024-12-10', TRUE),
(18, 9, 17, 'COMPLETED', '2023-08-25', '2023-09-02', TRUE),
(19, 9, 13, 'COMPLETED', '2023-12-25', '2024-01-12', TRUE),
(20, 2, 18, 'CREATED', '2025-05-10', '2025-05-20', FALSE),
(21, 20, 1, 'CONFIRMED', '2025-07-01', '2025-07-12', FALSE);

-- Add payment methods
INSERT INTO payment_methods (id, method_name) VALUES
(1, 'Credit card'),
(2, 'Debit card'),
(3, 'Google Pay'),
(4, 'Cash'),
(5, 'Bank transfer'),
(6, 'Prepaid card'),
(7, 'Cryptocurrency'),
(8, 'Nequi'),
(9, 'MercadoPago'),
(10, 'Apple Pay');


-- Add payments
INSERT INTO payments (reservation_id, payment_method_id, payment_status, payment_date) VALUES
(1, 1, 'COMPLETED', '2024-05-13'),
(3, 1, 'COMPLETED', '2024-12-02'),
(5, 2, 'COMPLETED', '2024-11-15'),
(6, 1, 'COMPLETED', '2024-05-01'),
(6, 2, 'DECLINED', '2024-05-10'),
(6, 2, 'DECLINED', '2024-05-11'),
(6, 1, 'COMPLETED', '2024-05-15'),
(7, 3, 'DECLINED', '2024-07-12'),
(7, 3, 'COMPLETED', '2024-07-15'),
(13, 1, 'COMPLETED', '2024-03-25'),
(14, 1, 'COMPLETED', '2024-07-15'),
(15, 2, 'DECLINED', '2024-05-10'),
(15, 2, 'DECLINED', '2024-05-11'),
(15, 3, 'COMPLETED', '2024-05-12'),
(16, 2, 'DECLINED', '2025-02-15'),
(17, 3, 'COMPLETED', '2024-12-01'),
(18, 2, 'COMPLETED', '2023-08-20'),
(19, 2, 'COMPLETED', '2023-12-25'),
(20, 3, 'DECLINED', '2025-03-01');

-- Add reviews
INSERT INTO reviews (reservation_id, rating, comment) VALUES
(1, 5, 'Nunc facilisis at dui quis sollicitudin'),
(3, 4, 'Aliquam sapien metus, pretium at dictum vitae, aliquet eu ex.'),
(5, 5, 'Maecenas mauris sem, auctor in efficitur eget, accumsan a neque. Integer tincidunt'),
(6, 3, 'Nam vulputate lobortis euismod.'),
(7, 5, NULL),
(8, 4, 'Quisque vel erat sed nisi viverra sollicitudin sed'),
(10, 5, NULL),
(12, 5, NULL),
(13, 4, NULL),
(17, 5, NULL),
(18, 5, 'Fusce sollicitudin eros ac faucibus tempus'),
(19, 4, NULL);

-- Add feature categories
INSERT INTO feature_categories (id, category_name) VALUES
(1, 'Safety'),
(2, 'Parking'),
(3, 'Kitchen'),
(4, 'Heating'),
(5, 'Internet and work'),
(6, 'Bedroom'),
(7, 'Bathroom'),
(8, 'View and location'),
(9, 'Services');

-- Add features
INSERT INTO features (id, category_id, feature_name) VALUES
(1, 1, 'Lock on bedroom door'),
(2, 3, 'Kitchen'),
(3, 5, 'Dedicated workspace'),
(4, 9, 'Luggage dropoff allowed'),
(5, 3, 'Refrigerator'),
(6, 8, 'Courtyard view'),
(7, 5, 'Wifi'),
(8, 6, 'Hair dryer'),
(9, 3, 'Washing machine'),
(10, 3, 'Drying rack for clothing'),
(11, 6, 'Room-darkening shades'),
(12, 4, 'Central heating'),
(13, 1, 'Smoke alarm'),
(14, 3,  'Microwave'),
(15, 3, 'Induction stove'),
(16, 3, 'Freezer'),
(17, 3, 'Dishes and silverware'),
(18, 3, 'Kettle'),
(19, 3, 'Coffee maker: espresso machine'),
(20, 2, 'Paid street parking off premises');

-- Add property features
INSERT INTO propertyfeatures (property_id, feature_id) VALUES 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(7, 1),
(7, 2),
(7, 3),
(7, 4),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(9, 1),
(9, 2),
(9, 3),
(9, 4),
(10, 5),
(10, 6),
(10, 7),
(10, 8);

INSERT INTO propertylandmarks (property_id, landmark_id, distance) VALUES
(1, 1, 8.2),
(1, 2, 12.3),
(1, 3, 18.4),
(1, 4, 15.2),
(2, 1, 0.5),
(2, 2, 1.3),
(2, 3, 5.2),
(2, 4, 7.0),
(3, 1, 8.2),
(3, 2, 12.3),
(3, 3, 18.4),
(3, 4, 15.2),
(4, 1, 6.1),
(4, 2, 3.9),
(4, 3, 4.0),
(4, 4, 12.0),
(5, 1, 0.2),
(5, 2, 0.3),
(5, 3, 0.4),
(5, 4, 1.0);

-- Add media
INSERT INTO media (property_id, media_type, media_path) VALUES
(1, 'PHOTO', 'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(2, 'PHOTO', 'https://images.pexels.com/photos/271624/pexels-photo-271624.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(2, 'PHOTO', 'https://images.pexels.com/photos/1918291/pexels-photo-1918291.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(3, 'PHOTO', 'https://images.pexels.com/photos/1571468/pexels-photo-1571468.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(3, 'PHOTO', 'https://images.pexels.com/photos/1643384/pexels-photo-1643384.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(3, 'PHOTO', 'https://images.pexels.com/photos/1428348/pexels-photo-1428348.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(4, 'PHOTO', 'https://images.pexels.com/photos/259962/pexels-photo-259962.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(4, 'PHOTO', 'https://images.pexels.com/photos/1743227/pexels-photo-1743227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(5, 'PHOTO', 'https://images.pexels.com/photos/271816/pexels-photo-271816.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(6, 'PHOTO', 'https://images.pexels.com/photos/1571453/pexels-photo-1571453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(7, 'PHOTO', 'https://images.pexels.com/photos/1776574/pexels-photo-1776574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(8, 'PHOTO', 'https://images.pexels.com/photos/2082087/pexels-photo-2082087.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(9, 'PHOTO', 'https://images.pexels.com/photos/1034584/pexels-photo-1034584.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(10, 'PHOTO', 'https://images.pexels.com/photos/271795/pexels-photo-271795.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(10, 'PHOTO', 'https://images.pexels.com/photos/260046/pexels-photo-260046.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(13, 'PHOTO', 'https://images.pexels.com/photos/2440471/pexels-photo-2440471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(12, 'PHOTO', 'https://images.pexels.com/photos/280212/pexels-photo-280212.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(14, 'PHOTO', 'https://images.pexels.com/photos/533157/pexels-photo-533157.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(17, 'PHOTO', 'https://images.pexels.com/photos/1457841/pexels-photo-1457841.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
(1, 'PHOTO', 'https://images.pexels.com/photos/2251247/pexels-photo-2251247.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');

