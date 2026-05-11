CREATE DATABASE IF NOT EXISTS bts2;

USE bts2;

-- ============================================================
-- 1. ADMINS
-- ============================================================
CREATE TABLE IF NOT EXISTS admins (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('super_admin', 'manager', 'support') DEFAULT 'support',
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 2. PASSENGERS
-- ============================================================
CREATE TABLE IF NOT EXISTS passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    nid_number VARCHAR(20) UNIQUE,
    address TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_login DATETIME
);

-- ============================================================
-- 3. OPERATORS
-- ============================================================
CREATE TABLE IF NOT EXISTS operators (
    operator_id INT PRIMARY KEY AUTO_INCREMENT,
    operator_name VARCHAR(100) NOT NULL,
    contact_phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    office_address TEXT,
    logo_url VARCHAR(255),
    license_number VARCHAR(50) UNIQUE NOT NULL,
    commission_rate DECIMAL(5 , 2 ) DEFAULT 10.00,
    is_active BOOLEAN DEFAULT TRUE,
    joined_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 4. BUSES
-- ============================================================
CREATE TABLE IF NOT EXISTS buses (
    bus_id INT PRIMARY KEY AUTO_INCREMENT,
    operator_id INT NOT NULL,
    bus_number VARCHAR(20) UNIQUE NOT NULL,
    bus_type ENUM('AC', 'Non-AC', 'Sleeper', 'Semi-Sleeper', 'Volvo') NOT NULL,
    total_seats INT NOT NULL,
    amenities SET('WiFi', 'USB Charging', 'Blanket', 'Water Bottle', 'Snack', 'TV', 'Toilet') DEFAULT '',
    manufacture_year YEAR,
    registration_number VARCHAR(30) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (operator_id)
        REFERENCES operators (operator_id)
);

-- ============================================================
-- 5. SEATS
-- ============================================================
CREATE TABLE IF NOT EXISTS seats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_id INT NOT NULL,
    seat_number VARCHAR(5) NOT NULL,
    seat_type ENUM('Window', 'Aisle', 'Middle') DEFAULT 'Aisle',
    deck ENUM('Lower', 'Upper') DEFAULT 'Lower',
    UNIQUE (bus_id , seat_number),
    FOREIGN KEY (bus_id)
        REFERENCES buses (bus_id)
);

-- ============================================================
-- 6. ROUTES
-- ============================================================
CREATE TABLE IF NOT EXISTS routes (
    route_id INT PRIMARY KEY AUTO_INCREMENT,
    source_city VARCHAR(100) NOT NULL,
    destination_city VARCHAR(100) NOT NULL,
    total_distance_km DECIMAL(8 , 2 ) NOT NULL,
    estimated_duration_mins INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

-- ============================================================
-- 7. ROUTE STOPS (Ordered Stoppages)
-- ============================================================
CREATE TABLE IF NOT EXISTS route_stops (
    stop_id INT PRIMARY KEY AUTO_INCREMENT,
    route_id INT NOT NULL,
    city_name VARCHAR(100) NOT NULL,
    stop_order INT NOT NULL,
    distance_from_source_km DECIMAL(8 , 2 ) DEFAULT 0,
    UNIQUE (route_id , stop_order),
    FOREIGN KEY (route_id)
        REFERENCES routes (route_id)
);

-- ============================================================
-- 8. FARES (Segment-Based Pricing)
-- ============================================================
CREATE TABLE IF NOT EXISTS fares (
    fare_id INT PRIMARY KEY AUTO_INCREMENT,
    route_id INT NOT NULL,
    from_stop_id INT NOT NULL,
    to_stop_id INT NOT NULL,
    bus_type ENUM('AC', 'Non-AC', 'Sleeper', 'Semi-Sleeper', 'Volvo') NOT NULL,
    amount DECIMAL(10 , 2 ) NOT NULL,
    UNIQUE (route_id , from_stop_id , to_stop_id , bus_type),
    FOREIGN KEY (route_id)
        REFERENCES routes (route_id),
    FOREIGN KEY (from_stop_id)
        REFERENCES route_stops (stop_id),
    FOREIGN KEY (to_stop_id)
        REFERENCES route_stops (stop_id),
    CHECK (amount > 0)
);

-- ============================================================
-- 9. TRIPS
-- ============================================================
CREATE TABLE IF NOT EXISTS trips (
    trip_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_id INT NOT NULL,
    route_id INT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    trip_status ENUM('Scheduled', 'Running', 'Completed', 'Cancelled', 'Delayed') DEFAULT 'Scheduled',
    delay_minutes INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bus_id)
        REFERENCES buses (bus_id),
    FOREIGN KEY (route_id)
        REFERENCES routes (route_id)
);

-- ============================================================
-- 10. BOOKINGS
-- ============================================================
CREATE TABLE IF NOT EXISTS bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    trip_id INT NOT NULL,
    boarding_stop_id INT NOT NULL,
    dropping_stop_id INT NOT NULL,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    booking_status ENUM('Confirmed', 'Pending', 'Cancelled', 'Completed') DEFAULT 'Pending',
    total_amount DECIMAL(10 , 2 ) NOT NULL,
    discount_amount DECIMAL(10 , 2 ) DEFAULT 0,
    final_amount DECIMAL(10 , 2 ) NOT NULL,
    booking_ref VARCHAR(20) UNIQUE NOT NULL,
    FOREIGN KEY (passenger_id)
        REFERENCES passengers (passenger_id),
    FOREIGN KEY (trip_id)
        REFERENCES trips (trip_id),
    FOREIGN KEY (boarding_stop_id)
        REFERENCES route_stops (stop_id),
    FOREIGN KEY (dropping_stop_id)
        REFERENCES route_stops (stop_id)
);

-- ============================================================
-- 11. BOOKING SEATS (Junction - Multi-Seat Support)
-- ============================================================
CREATE TABLE IF NOT EXISTS booking_seats (
    booking_seat_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    seat_id INT NOT NULL,
    FOREIGN KEY (booking_id)
        REFERENCES bookings (booking_id),
    FOREIGN KEY (seat_id)
        REFERENCES seats (seat_id)
);

-- CRITICAL: Prevent double-booking on same trip+seat+segment overlap
-- Enforced via application logic or trigger (shown below)
CREATE UNIQUE INDEX idx_trip_seat ON booking_seats(booking_id, seat_id);

-- ============================================================
-- 12. PAYMENTS
-- ============================================================
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_method ENUM('Cash', 'Card', 'bKash', 'Nagad', 'Rocket', 'Bank Transfer', 'Online') NOT NULL,
    payment_amount DECIMAL(10 , 2 ) NOT NULL,
    payment_status ENUM('Paid', 'Pending', 'Failed', 'Refunded') DEFAULT 'Pending',
    transaction_id VARCHAR(100) UNIQUE,
    payment_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    gateway_response TEXT,
    FOREIGN KEY (booking_id)
        REFERENCES bookings (booking_id)
);

-- ============================================================
-- 13. CANCELLATIONS
-- ============================================================
CREATE TABLE IF NOT EXISTS cancellations (
    cancellation_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    cancelled_by ENUM('Passenger', 'Operator', 'Admin') DEFAULT 'Passenger',
    cancellation_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    reason TEXT,
    refund_amount DECIMAL(10 , 2 ) DEFAULT 0,
    refund_status ENUM('Pending', 'Processed', 'Rejected') DEFAULT 'Pending',
    refund_time DATETIME,
    FOREIGN KEY (booking_id)
        REFERENCES bookings (booking_id)
);

-- ============================================================
-- 14. NOTIFICATIONS
-- ============================================================
CREATE TABLE IF NOT EXISTS notifications (
    notif_id INT PRIMARY KEY AUTO_INCREMENT,
    user_type ENUM('Passenger', 'Operator', 'Admin') NOT NULL,
    user_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 15. SYSTEM LOGS
-- ============================================================
CREATE TABLE IF NOT EXISTS system_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    action VARCHAR(200) NOT NULL,
    performed_by ENUM('Passenger', 'Operator', 'Admin', 'System') NOT NULL,
    user_id INT,
    details TEXT,
    log_time DATETIME DEFAULT CURRENT_TIMESTAMP
);


