drop table if exists schedule;
create table schedule (
	id serial,
	customer text,
	doctor_name text,
	patient_name text,
	gender text,
	symptom text,
	handphone text,
	address text,
	waktu time,
	tanggal date
);

insert into schedule (customer, doctor_name, patient_name, gender, symptom, handphone, address, waktu, tanggal) 
values
	('Rafli', 'dr. Nurita', 'Ahmad Maulana', 'male', '["headache", "stomache"]', 62838, 'address1', '08:00', '2023-10-01'),
	('qwdd', 'dr. Ping', 'Zizah Lana', 'female', '["flu", "stomache", "headache"]', 62838, 'address7', '09:00', '2022-10-07'),
	('rewrq', 'dr. Nurita', 'Alif Iman', 'male', '["cough", "flu", "headache"]', 62838, 'address8', '10:00', '2022-10-08'),
	('erewf', 'dr. Ping', 'Zaka Zaki', 'female', '["cough", "stomache", "headache"]', 62838, 'address9', '11:00', '2022-10-09'),
	('efawf', 'dr. Wibowo', 'Faus Rahmi', 'male', '["cough"]', 62838, 'address10', '12:00', '2022-10-11')
	;