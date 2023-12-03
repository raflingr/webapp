import streamlit as st
from sqlalchemy import create_engine, text
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

# Define list_doctor dan list_symptom
list_doctor = ['', 'dr. Nurita', 'dr. Yogi', 'dr. Wibowo', 'dr. Ulama', 'dr. Ping']
list_symptom = ['', 'male', 'female']

engine = create_engine("postgresql://raflinugrahasyach26:OVv3xh7JBDiY@ep-round-dust-26397985.us-east-2.aws.neon.tech/web")

# Tambahkan kolom customer_name pada skema tabel
with engine.connect() as conn:
    query = text('CREATE TABLE IF NOT EXISTS schedule (id serial, customer_name varchar, doctor_name varchar, patient_name varchar, \
                                                       gender char(25), symptom text, handphone varchar, address text, waktu time, tanggal date);')
    conn.execute(query)

st.header('HOTEL RESERVATIONS & CAFE DATA MANAGEMENT SYSTEM')
page = st.sidebar.selectbox("Pilih Menu", ["View Data", "Edit Data"])

if page == "View Data":
    data = pd.read_sql_query('SELECT * FROM schedule ORDER By id;', engine).set_index('id')
    st.dataframe(data)

    # Visualize data using seaborn
    st.subheader("Data Visualization")
    
    # Countplot for Gender
    fig, ax = plt.subplots()
    sns.countplot(x='gender', data=data, ax=ax)
    st.pyplot(fig)
    
    # Bar plot for Doctor-wise patient count
    fig, ax = plt.subplots()
    sns.countplot(x='doctor_name', data=data, ax=ax)
    plt.xticks(rotation=45, ha='right')  # Rotate x-axis labels
    st.pyplot(fig)

    # Custom visualizations can be added based on your data and requirements

if page == "Edit Data":
    if st.button('Tambah Data'):
        with engine.connect() as conn:
            query = text('INSERT INTO schedule (customer_name, doctor_name, patient_name, gender, symptom, handphone, address, waktu, tanggal) \
                          VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9);')
            conn.execute(query, {'1': 'rafli', '2': 'dr. Nurita', '3': 'Ahmad Maulana', '4': 'male', '5': '["headache", "stomache"]', '6': '62838', '7': 'address1', '8': '08:00', '9': '2023-10-01'}),
            conn.execute(query, {'1': 'dhany', '2': 'dr. Yogi', '3': 'Renata Zahab', '4': 'female', '5': '["cough", "flu"]', '6': '62828', '7': 'address2', '8': '08:00', '9': '2022-11-02'})


    data = pd.read_sql_query('SELECT * FROM schedule ORDER By id;', engine)
    for _, result in data.iterrows():        
        id = result['id']
        customer_name_lama = result["customer_name"]
        doctor_name_lama = result["doctor_name"]
        patient_name_lama = result["patient_name"]
        gender_lama = result["gender"]
        symptom_lama = result["symptom"]
        handphone_lama = result["handphone"]
        address_lama = result["address"]
        waktu_lama = result["waktu"]
        tanggal_lama = result["tanggal"]

        with st.expander(f'a.n. {patient_name_lama}'):
            with st.form(f'data-{id}'):
                customer_name_baru = st.text_input("customer_name", customer_name_lama)
                doctor_name_baru = st.selectbox("doctor_name", list_doctor, list_doctor.index(doctor_name_lama))
                patient_name_baru = st.text_input("patient_name", patient_name_lama)
                gender_baru = st.selectbox("gender", list_symptom, list_symptom.index(gender_lama))
                symptom_baru = st.multiselect("symptom", ['cough', 'flu', 'headache', 'stomache'], eval(symptom_lama))
                handphone_baru = st.text_input("handphone", handphone_lama)
                address_baru = st.text_input("address", address_lama)
                waktu_baru = st.time_input("waktu", waktu_lama)
                tanggal_baru = st.date_input("tanggal", tanggal_lama)
                
                col1, col2 = st.columns([1, 6])

                with col1:
                    if st.form_submit_button('UPDATE'):
                        with engine.connect() as conn:
                            query = text('UPDATE schedule \
                                          SET customer_name=:1, doctor_name=:2, patient_name=:3, gender=:4, symptom=:5, \
                                          handphone=:6, address=:7, waktu=:8, tanggal=:9 \
                                          WHERE id=:10;')
                            conn.execute(query, {'1': customer_name_baru, '2': doctor_name_baru, '3': patient_name_baru,
                                                 '4': gender_baru, '5': str(symptom_baru), '6': handphone_baru,
                                                 '7': address_baru, '8': waktu_baru, '9': tanggal_baru, '10': id})

                with col2:
                    if st.form_submit_button('DELETE'):
                        with engine.connect() as conn:
                            query = text(f'DELETE FROM schedule WHERE id=:1;')
                            conn.execute(query, {'1': id})
