drop table if exists ppp;
create table ppp (
	id serial,
	customer_name text,
	doctor_name text,
	patient_name text,
	gender text,
	symptom text,
	handphone text,
	address text,
	waktu time,
	tanggal date
);

insert into ppp (customer_name, doctor_name, patient_name, gender, symptom, handphone, address, waktu, tanggal) 
values
	('rafli', 'dr. Nurita', 'Ahmad Maulana', 'male', '["headache", "stomache"]', 62838, 'address1', '08:00', '2023-10-01')
	;