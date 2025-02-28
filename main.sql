-- Copyright 2025 Iurii Mednikov <iurii.mednikov@iu-study.org>

-- Use of this source code is governed by an MIT-style
-- license that can be found in the LICENSE file or at
-- https://opensource.org/licenses/MIT

-- This file descirbes the structure of the database

CREATE TABLE countries(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
);

CREATE TABLE cities(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    country_id BIGINT NOT NULL,
    city_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT fk_cities_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
);

CREATE TABLE languages(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
);

CREATE TABLE landmarks (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    city_id BIGINT NOT NULL,
    landmark_category ENUM ('ATTRACTION', 'AIRPORT', 'MUSEUM', 'OTHER') NOT NULL,
    landmark_name VARCHAR(500) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT fk_landmarks_city FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE CASCADE,
    UNIQUE (city_id, landmark_name)
);

CREATE TABLE useraccounts(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    is_verified BOOLEAN DEFAULT 0,
    is_superuser BOOLEAN DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
);

CREATE TABLE confirmationtokens (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    token_string VARCHAR(255) NOT NULL UNIQUE,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_confirmationtokens_user FOREIGN KEY (user_id) REFERENCES useraccounts(id) ON DELETE CASCADE
);

CREATE TABLE reports (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    owner_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT fk_reports_owner FOREIGN KEY (owner_id) REFERENCES useraccounts(id) ON DELETE CASCADE,
    CONSTRAINT fk_reports_user FOREIGN KEY (user_id) REFERENCES useraccounts(id) ON DELETE CASCADE,
    CONSTRAINT report_not_same_user CHECK(owner_id <> user_id)
);

CREATE TABLE userlanguages(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    language_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    UNIQUE (user_id, language_id),
    CONSTRAINT fk_userlanguages_user FOREIGN KEY (user_id) REFERENCES useraccounts(id) ON DELETE CASCADE,
    CONSTRAINT fk_userlanguages_language FOREIGN KEY (language_id) REFERENCES languages(id) ON DELETE CASCADE
);

CREATE TABLE properties (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    city_id BIGINT NOT NULL,
    is_active BOOLEAN NOT NULL,
    title VARCHAR(128) NOT NULL,
    property_description TEXT NOT NULL,
    property_type ENUM('APARTMENT', 'HOUSE') NOT NULL,
    rate_currency VARCHAR(3) NOT NULL,
    rate_amount DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT fk_properties_city FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE CASCADE,
    CONSTRAINT ch_rate_supported_currency CHECK(rate_currency IN ('EUR', 'RSD', 'MXN', 'USD')),
    CONSTRAINT ch_amount_is_positive CHECK(rate_amount > 0)
);

CREATE TABLE propertyfeatures (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    property_id BIGINT NOT NULL,
    feature_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    UNIQUE (property_id, feature_name),
    CONSTRAINT fk_propertyfeatures_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

CREATE TABLE propertylandmarks (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    landmark_id BIGINT NOT NULL,
    property_id BIGINT NOT NULL,
    distance DECIMAL(6,3) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT fk_propertylandmarks_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    CONSTRAINT fk_propertylandmarks_landmark FOREIGN KEY (landmark_id) REFERENCES landmarks(id) ON DELETE CASCADE,
    CONSTRAINT ch_propertylandmarks_distance_is_positive CHECK(distance > 0)
);

CREATE TABLE hosts (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    property_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT fk_hosts_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    CONSTRAINT fk_hosts_user FOREIGN KEY (user_id) REFERENCES useraccounts(id) ON DELETE CASCADE
);

CREATE TABLE reservations (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    guest_id BIGINT NOT NULL,
    property_id BIGINT NOT NULL,
    reservation_status ENUM('CREATED', 'CONFIRMED', 'COMPLETED', 'CANCELLED') NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    is_paid BOOLEAN DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT fk_reservations_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    CONSTRAINT fk_reservations_guest FOREIGN KEY (guest_id) REFERENCES useraccounts(id) ON DELETE CASCADE,
    CONSTRAINT ch_to_date_after_from_date CHECK (to_date > from_date)
);

CREATE TABLE payments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    reservation_id BIGINT NOT NULL,
    payment_method ENUM('DEBIT_CARD', 'CREDIT_CARD', 'PAYPAL', 'CASH') NOT NULL,
    payment_status ENUM('COMPLETED', 'DECLINED') NOT NULL,
    payment_datetime TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT fk_payments_reservation FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE
);

ALTER TABLE reservations ADD COLUMN payment_id BIGINT;
ALTER TABLE reservations ADD CONSTRAINT fk_reservations_payment FOREIGN KEY (payment_id) REFERENCES payments(id) ON DELETE SET NULL;

CREATE TABLE reviews (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    reservation_id BIGINT NOT NULL,
    rating INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT fk_reviews_reservation FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE,
    CONSTRAINT ch_review_rating CHECK (rating BETWEEN 1 AND 5)
);

ALTER TABLE reservations ADD COLUMN review_id BIGINT;
ALTER TABLE reservations ADD CONSTRAINT fk_reservations_review FOREIGN KEY (review_id) REFERENCES reviews(id) ON DELETE SET NULL;

CREATE TABLE media (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    media_path VARCHAR(512) NOT NULL,
    property_id BIGINT NOT NULL,
    media_type ENUM('PHOTO', 'VIDEO') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT fk_media_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

CREATE TABLE comments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    property_id BIGINT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT fk_comments_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    CONSTRAINT fk_comments_user FOREIGN KEY (user_id) REFERENCES useraccounts(id) ON DELETE CASCADE
);

CREATE TABLE reactions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    comment_id BIGINT NOT NULL,
    reaction_type ENUM('POSITIVE', 'NEGATIVE') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    UNIQUE (user_id, comment_id),
    CONSTRAINT fk_reactions_comment FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE,
    CONSTRAINT fk_reaction_user FOREIGN KEY (user_id) REFERENCES useraccounts(id) ON DELETE CASCADE
);

CREATE TABLE messages (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    sender_id BIGINT NOT NULL,
    recipient_id BIGINT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT ch_messages_not_same_user CHECK (sender_id <> recipient_id),
    CONSTRAINT fk_messages_sender FOREIGN KEY (sender_id) REFERENCES useraccounts(id) ON DELETE CASCADE,
    CONSTRAINT fk_messages_recipient FOREIGN KEY (recipient_id) REFERENCES useraccounts(id) ON DELETE CASCADE
);

CREATE TABLE chats (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    owner_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    is_read BOOLEAN DEFAULT 0,
    last_message_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    UNIQUE(owner_id, user_id),
    CONSTRAINT ch_chats_not_same_user CHECK (owner_id <> user_id),
    CONSTRAINT fk_chats_owner FOREIGN KEY (owner_id) REFERENCES useraccounts(id) ON DELETE CASCADE,
    CONSTRAINT fk_chats_recipient FOREIGN KEY (user_id) REFERENCES useraccounts(id) ON DELETE CASCADE,
    CONSTRAINT fk_chats_last_message FOREIGN KEY(last_message_id) REFERENCES messages(id) ON DELETE SET NULL
);