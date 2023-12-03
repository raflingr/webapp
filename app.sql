-- Drop existing table if it exists
DROP TABLE IF EXISTS SCHEDULE;

-- Create a new table with the corrected schema
CREATE TABLE SCHEDULE (
    id SERIAL,
    doctor_name VARCHAR,
    patient_name VARCHAR,
    customer_name VARCHAR, -- Add the customer_name column
    gender CHAR(25),
    symptom TEXT,
    handphone VARCHAR,
    address TEXT,
    waktu TIME,
    tanggal DATE
);

-- Insert sample data into the schedule table
INSERT INTO SCHEDULE (doctor_name, patient_name, customer_name, gender, symptom, handphone, address, waktu, tanggal)
VALUES
    ('dr. Nurita', 'Ahmad Maulana', 'Rafli', 'male', '["headache", "stomache"]', '62838', 'address1', '08:00', '2023-10-01'),
    ('dr. Ping', 'Zizah Lana', 'qwdd', 'female', '["flu", "stomache", "headache"]', '62838', 'address7', '09:00', '2022-10-07'),
    ('dr. Nurita', 'Alif Iman', 'rewrq', 'male', '["cough", "flu", "headache"]', '62838', 'address8', '10:00', '2022-10-08'),
    ('dr. Ping', 'Zaka Zaki', 'erewf', 'female', '["cough", "stomache", "headache"]', '62838', 'address9', '11:00', '2022-10-09'),
    ('dr. Wibowo', 'Faus Rahmi', 'efawf', 'male', '["cough"]', '62838', 'address10', '12:00', '2022-10-11');
