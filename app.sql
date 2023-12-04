drop table if exists RESERVATION;
CREATE TABLE IF NOT EXISTS RESERVATION (id serial, \
                                                       Nama varchar, \
                                                       Makan text[], \
                                                       Minum text[], \
                                                       Pembayaran varchar, \
                                                       No_Kamar varchar, \
                                                       No_Meja varchar, \
                                                       PRIMARY KEY (id));

insert into RESERVATION (Nama, Makan, Minum, Pembayaran, No_Kamar, No_Meja) 
values
	{'John Doe', 'Nasi Goreng', 'Es Teh', 'Debit', '101', 'A1', '27000'},
	{'John Doi', 'Mie Goreng', 'Es Teh', 'Debit', '103', 'A2', '28000'};