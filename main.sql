-- Copyright 2025 Iurii Mednikov <iurii.mednikov@iu-study.org>

-- Use of this source code is governed by an MIT-style
-- license that can be found in the LICENSE file or at
-- https://opensource.org/licenses/MIT

-- This file descirbes the structure of the database

CREATE TABLE countries(
    id BIGSERIAL PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE cities(
    id BIGSERIAL PRIMARY KEY,
    country_id BIGINT NOT NULL,
    city_name VARCHAR(255) NOT NULL,
    CONSTRAINT fk_cities_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
);

CREATE TABLE languages(
    id BIGSERIAL PRIMARY KEY,
    language_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE ladmark_categories(
    id BIGSERIAL PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

CREATE TABLE landmarks (
    id BIGSERIAL PRIMARY KEY,
    city_id BIGINT NOT NULL,
    landmark_name VARCHAR(500) NOT NULL,
    CONSTRAINT fk_landmarks_city FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE CASCADE
);

CREATE TABLE landmarkcategories_landmarks(
    id BIGSERIAL PRIMARY KEY,
    landmark_id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    UNIQUE(landmark_id, category_id),
    CONSTRAINT fk_landmarkcategories_landmarks_landmark FOREIGN KEY (landmark_id) REFERENCES landmarks(id) ON DELETE CASCADE,
    CONSTRAINT fk_landmarkcategories_landmarks_category FOREIGN KEY (category_id) REFERENCES ladmark_categories(id) ON DELETE CASCADE
);

CREATE TABLE useraccounts(
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    is_superuser BOOLEAN DEFAULT FALSE
);

CREATE TABLE userlanguages(
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    language_id BIGINT NOT NULL,
    UNIQUE (user_id, language_id),
    CONSTRAINT fk_userlanguages_user FOREIGN KEY (user_id) REFERENCES useraccounts(id) ON DELETE CASCADE,
    CONSTRAINT fk_userlanguages_language FOREIGN KEY (language_id) REFERENCES languages(id) ON DELETE CASCADE
);

CREATE TYPE PROPERTY_TYPES AS ENUM('APARTMENT', 'HOUSE');

CREATE TABLE properties (
    id BIGSERIAL PRIMARY KEY,
    city_id BIGINT NOT NULL,
    is_active BOOLEAN NOT NULL,
    title VARCHAR(128) NOT NULL,
    property_description TEXT NOT NULL,
    property_type PROPERTY_TYPES NOT NULL,
    rate_currency VARCHAR(3) NOT NULL,
    rate_amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_properties_city FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE CASCADE,
    CONSTRAINT ch_rate_supported_currency CHECK(rate_currency IN ('EUR', 'RSD', 'MXN', 'USD')),
    CONSTRAINT ch_amount_is_positive CHECK(rate_amount > 0)
);

CREATE TABLE feature_categories(
    id BIGSERIAL PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE features (
    id BIGSERIAL PRIMARY KEY,
    category_id BIGINT NOT NULL,
    feature_name VARCHAR(255) NOT NULL UNIQUE,
    CONSTRAINT fk_features_category FOREIGN KEY (category_id) REFERENCES feature_categories(id) ON DELETE CASCADE
);

CREATE TABLE propertyfeatures (
    id BIGSERIAL PRIMARY KEY,
    property_id BIGINT NOT NULL,
    feature_id BIGINT NOT NULL,
    UNIQUE (property_id, feature_id),
    CONSTRAINT fk_propertyfeatures_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    CONSTRAINT fk_propertyfeatures_feature FOREIGN KEY (feature_id) REFERENCES features(id) ON DELETE CASCADE
);

CREATE TABLE propertylandmarks (
    id BIGSERIAL PRIMARY KEY,
    landmark_id BIGINT NOT NULL,
    property_id BIGINT NOT NULL,
    distance DECIMAL(6,3) NOT NULL,
    CONSTRAINT fk_propertylandmarks_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    CONSTRAINT fk_propertylandmarks_landmark FOREIGN KEY (landmark_id) REFERENCES landmarks(id) ON DELETE CASCADE,
    CONSTRAINT ch_propertylandmarks_distance_is_positive CHECK(distance > 0)
);

CREATE TABLE hosts (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    property_id BIGINT NOT NULL,
    CONSTRAINT fk_hosts_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    CONSTRAINT fk_hosts_user FOREIGN KEY (user_id) REFERENCES useraccounts(id) ON DELETE CASCADE,
    UNIQUE(user_id, property_id)
);

CREATE TYPE RESERVATION_STATUSES AS ENUM('CREATED', 'CONFIRMED', 'COMPLETED', 'CANCELLED');

CREATE TABLE reservations (
    id BIGSERIAL PRIMARY KEY,
    guest_id BIGINT NOT NULL,
    property_id BIGINT NOT NULL,
    reservation_status RESERVATION_STATUSES NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    is_paid BOOLEAN NOT NULL,
    CONSTRAINT fk_reservations_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    CONSTRAINT fk_reservations_guest FOREIGN KEY (guest_id) REFERENCES useraccounts(id) ON DELETE CASCADE
);

CREATE TABLE payment_methods (
    id BIGSERIAL PRIMARY KEY,
    method_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TYPE PAYMENT_STATUSES AS ENUM('COMPLETED', 'DECLINED');

CREATE TABLE payments (
    id BIGSERIAL PRIMARY KEY,
    reservation_id BIGINT NOT NULL,
    payment_method_id BIGINT NOT NULL,
    payment_status PAYMENT_STATUSES NOT NULL,
    payment_date DATE NOT NULL,
    CONSTRAINT fk_payments_reservation FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE,
    CONSTRAINT fk_payments_payment_method FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id) ON DELETE CASCADE
);

CREATE TABLE reviews (
    id BIGSERIAL PRIMARY KEY,
    reservation_id BIGINT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    CONSTRAINT fk_reviews_reservation FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE,
    CONSTRAINT ch_review_rating CHECK (rating BETWEEN 1 AND 5)
);

CREATE TYPE MEDIA_TYPES AS ENUM('PHOTO', 'VIDEO');

CREATE TABLE media (
    id BIGSERIAL PRIMARY KEY,
    media_path VARCHAR(512) NOT NULL,
    property_id BIGINT NOT NULL,
    media_type MEDIA_TYPES NOT NULL,
    CONSTRAINT fk_media_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);