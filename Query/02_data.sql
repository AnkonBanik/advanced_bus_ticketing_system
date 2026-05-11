

-- SAMPLE DATA — BUS TICKETING SYSTEM (1000+ Records)


-- ADMINS
INSERT INTO admins (full_name, email, password, role) VALUES
('Ankon Banik',    'ankon@busadmin.bd',   'ankon', 'super_admin'),
('Mehejabin Tabassum',     'mehejabin@busadmin.bd',  'mejehabin', 'manager'),
('Atoshi Chowdhury',    'atoshi@busadmin.bd',   'atoshi', 'support'),
('Supti Pramanik',     'supti@busadmin.bd',   'supti', 'support'),
('Mahbubur Rahman Mukul',    'mukul@busadmin.bd','mukul', 'manager');

-- OPERATORS (12)
INSERT INTO operators (operator_name, contact_phone, email, office_address, license_number, commission_rate) VALUES
('Hanif Enterprise',     '01711-100001', 'info@hanif.bd',     'Kamalapur, Dhaka',       'LIC-HANIF-001', 8.00),
('Green Line Paribahan', '01711-100002', 'info@greenline.bd', 'Kalyanpur, Dhaka',       'LIC-GREEN-002', 9.00),
('Shohagh Paribahan',    '01711-100003', 'info@shohagh.bd',   'Arambag, Dhaka',         'LIC-SHOH-003',  9.50),
('Ena Transport',        '01711-100004', 'info@ena.bd',       'Mohakhali, Dhaka',       'LIC-ENA-004',   10.00),
('S Alam Paribahan',     '01711-100005', 'info@salam.bd',     'Chittagong',             'LIC-SALAM-005', 8.50),
('Saintmartin Tourism',  '01711-100006', 'info@smtour.bd',    'Cox Bazar',              'LIC-SAINT-006', 10.00),
('Royal Coach',          '01711-100007', 'info@royal.bd',     'Sylhet',                 'LIC-ROYAL-007', 9.00),
('Night Queen',          '01711-100008', 'info@nightq.bd',    'Rajshahi',               'LIC-NIGHTQ-008',9.50),
('Desh Travels',         '01711-100009', 'info@desh.bd',      'Jessore',                'LIC-DESH-009',  10.00),
('Agomoni Express',      '01711-100010', 'info@agomoni.bd',   'Comilla',                'LIC-AGOM-010',  8.00),
('Saudia Paribahan',     '01711-100011', 'info@saudia.bd',    'Khulna',                 'LIC-SAUDIA-011',9.00),
('Unique Bus Service',   '01711-100012', 'info@unique.bd',    'Mymensingh',             'LIC-UNIQUE-012',10.00);

-- BUSES (36 buses, 3 per operator)
INSERT INTO buses (operator_id, bus_number, bus_type, total_seats, amenities, manufacture_year, registration_number) VALUES
-- Hanif Enterprise
(1,'HANIF-AC-001','AC',40,'WiFi,USB Charging,Water Bottle,Snack',2021,'DHAKA-A-11-0001'),
(1,'HANIF-AC-002','AC',40,'WiFi,USB Charging,Water Bottle',2020,'DHAKA-A-11-0002'),
(1,'HANIF-SL-001','Sleeper',30,'WiFi,USB Charging,Blanket,Water Bottle,TV',2022,'DHAKA-A-11-0003'),
-- Green Line
(2,'GREEN-AC-001','AC',40,'WiFi,USB Charging,Water Bottle,Snack',2021,'DHAKA-A-12-0001'),
(2,'GREEN-AC-002','Volvo',36,'WiFi,USB Charging,Blanket,Water Bottle,Snack,TV,Toilet',2023,'DHAKA-A-12-0002'),
(2,'GREEN-NAC-001','Non-AC',45,'USB Charging',2019,'DHAKA-A-12-0003'),
-- Shohagh
(3,'SHOH-AC-001','AC',40,'WiFi,USB Charging,Water Bottle',2020,'DHAKA-A-13-0001'),
(3,'SHOH-SL-001','Sleeper',32,'WiFi,USB Charging,Blanket,Water Bottle,TV',2022,'DHAKA-A-13-0002'),
(3,'SHOH-NAC-001','Non-AC',50,'USB Charging',2018,'DHAKA-A-13-0003'),
-- Ena Transport
(4,'ENA-AC-001','AC',40,'WiFi,USB Charging,Water Bottle,Snack',2021,'DHAKA-A-14-0001'),
(4,'ENA-VL-001','Volvo',36,'WiFi,USB Charging,Blanket,Water Bottle,Snack,TV,Toilet',2023,'DHAKA-A-14-0002'),
(4,'ENA-SS-001','Semi-Sleeper',38,'WiFi,USB Charging,Water Bottle',2020,'DHAKA-A-14-0003'),
-- S Alam
(5,'SALAM-AC-001','AC',40,'WiFi,USB Charging,Water Bottle',2021,'CTG-A-15-0001'),
(5,'SALAM-SL-001','Sleeper',30,'WiFi,USB Charging,Blanket,Water Bottle,TV',2022,'CTG-A-15-0002'),
(5,'SALAM-NAC-001','Non-AC',50,'USB Charging',2019,'CTG-A-15-0003'),
-- Saintmartin
(6,'SAINT-AC-001','AC',40,'WiFi,USB Charging,Water Bottle,Snack',2022,'COX-A-16-0001'),
(6,'SAINT-VL-001','Volvo',36,'WiFi,USB Charging,Blanket,Water Bottle,Snack,TV,Toilet',2023,'COX-A-16-0002'),
(6,'SAINT-NAC-001','Non-AC',45,'USB Charging',2020,'COX-A-16-0003'),
-- Royal Coach
(7,'ROYAL-AC-001','AC',40,'WiFi,USB Charging,Water Bottle',2021,'SYL-A-17-0001'),
(7,'ROYAL-SL-001','Sleeper',32,'WiFi,USB Charging,Blanket,Water Bottle,TV',2022,'SYL-A-17-0002'),
(7,'ROYAL-NAC-001','Non-AC',50,'',2018,'SYL-A-17-0003'),
-- Night Queen
(8,'NIGHTQ-SL-001','Sleeper',30,'WiFi,USB Charging,Blanket,Water Bottle,TV',2022,'RAJ-A-18-0001'),
(8,'NIGHTQ-AC-001','AC',40,'WiFi,USB Charging,Water Bottle,Snack',2021,'RAJ-A-18-0002'),
(8,'NIGHTQ-NAC-001','Non-AC',50,'USB Charging',2019,'RAJ-A-18-0003'),
-- Desh Travels
(9,'DESH-AC-001','AC',40,'WiFi,USB Charging,Water Bottle',2020,'JES-A-19-0001'),
(9,'DESH-SS-001','Semi-Sleeper',38,'WiFi,USB Charging,Water Bottle',2021,'JES-A-19-0002'),
(9,'DESH-NAC-001','Non-AC',50,'',2018,'JES-A-19-0003'),
-- Agomoni
(10,'AGOM-AC-001','AC',40,'WiFi,USB Charging,Water Bottle,Snack',2021,'COM-A-20-0001'),
(10,'AGOM-AC-002','AC',40,'WiFi,USB Charging,Water Bottle',2020,'COM-A-20-0002'),
(10,'AGOM-NAC-001','Non-AC',50,'USB Charging',2019,'COM-A-20-0003'),
-- Saudia
(11,'SAUDIA-VL-001','Volvo',36,'WiFi,USB Charging,Blanket,Water Bottle,Snack,TV,Toilet',2023,'KHL-A-21-0001'),
(11,'SAUDIA-AC-001','AC',40,'WiFi,USB Charging,Water Bottle',2021,'KHL-A-21-0002'),
(11,'SAUDIA-NAC-001','Non-AC',50,'USB Charging',2019,'KHL-A-21-0003'),
-- Unique
(12,'UNIQUE-AC-001','AC',40,'WiFi,USB Charging,Water Bottle,Snack',2022,'MYM-A-22-0001'),
(12,'UNIQUE-SS-001','Semi-Sleeper',38,'WiFi,USB Charging,Water Bottle',2021,'MYM-A-22-0002'),
(12,'UNIQUE-NAC-001','Non-AC',50,'USB Charging',2019,'MYM-A-22-0003');


-- ROUTES (10 major routes)
INSERT INTO routes (source_city, destination_city, total_distance_km, estimated_duration_mins) VALUES
('Dhaka','Chittagong',242,300),    -- route 1
('Dhaka','Sylhet',243,360),        -- route 2
('Dhaka','Cox Bazar',412,480),     -- route 3
('Dhaka','Rajshahi',259,360),      -- route 4
('Dhaka','Khulna',273,360),        -- route 5
('Dhaka','Mymensingh',120,150),    -- route 6
('Chittagong','Cox Bazar',152,180),-- route 7
('Dhaka','Comilla',100,120),       -- route 8
('Dhaka','Jessore',170,240),       -- route 9
('Sylhet','Comilla',160,240);      -- route 10

-- ROUTE STOPS
-- Route 1: Dhaka → Cumilla → Feni → Chittagong
INSERT INTO route_stops (route_id, city_name, stop_order, distance_from_source_km) VALUES
(1,'Dhaka',1,0),(1,'Cumilla',2,100),(1,'Feni',3,170),(1,'Chittagong',4,242),
-- Route 2: Dhaka → Narsingdi → Brahmanbaria → Sylhet
(2,'Dhaka',1,0),(2,'Narsingdi',2,57),(2,'Brahmanbaria',3,120),(2,'Sylhet',4,243),
-- Route 3: Dhaka → Cumilla → Chittagong → Cox Bazar
(3,'Dhaka',1,0),(3,'Cumilla',2,100),(3,'Chittagong',3,242),(3,'Cox Bazar',4,412),
-- Route 4: Dhaka → Tangail → Sirajganj → Rajshahi
(4,'Dhaka',1,0),(4,'Tangail',2,90),(4,'Sirajganj',3,160),(4,'Rajshahi',4,259),
-- Route 5: Dhaka → Faridpur → Jessore → Khulna
(5,'Dhaka',1,0),(5,'Faridpur',2,120),(5,'Jessore',3,200),(5,'Khulna',4,273),
-- Route 6: Dhaka → Gazipur → Mymensingh
(6,'Dhaka',1,0),(6,'Gazipur',2,40),(6,'Mymensingh',3,120),
-- Route 7: Chittagong → Chakaria → Cox Bazar
(7,'Chittagong',1,0),(7,'Chakaria',2,100),(7,'Cox Bazar',3,152),
-- Route 8: Dhaka → Narayan→ Cumilla
(8,'Dhaka',1,0),(8,'Narayanganj',2,25),(8,'Cumilla',3,100),
-- Route 9: Dhaka → Faridpur → Jessore
(9,'Dhaka',1,0),(9,'Faridpur',2,120),(9,'Jessore',3,170),
-- Route 10: Sylhet → Habiganj → Comilla
(10,'Sylhet',1,0),(10,'Habiganj',2,70),(10,'Comilla',3,160);


