import streamlit as st
from sqlalchemy import create_engine, text
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

# Define list_doctor dan list_symptom
list_doctor = ['', 'dr. Nurita', 'dr. Yogi', 'dr. Wibowo', 'dr. Ulama', 'dr. Ping']
list_symptom = ['', 'male', 'female']

# Buat engine
engine = create_engine("postgresql://raflinugrahasyach26:OVv3xh7JBDiY@ep-round-dust-26397985.us-east-2.aws.neon.tech/web")

# Tambahkan kolom customer_name pada skema tabel
with engine.connect() as conn:
    query = text('CREATE TABLE IF NOT EXISTS SCHEDULE (id serial, doctor_name varchar, patient_name varchar, customer_name varchar, \
                                                       gender char(25), symptom text, handphone varchar, address text, waktu time, tanggal date);')
    conn.execute(query)

# Buat aplikasi Streamlit
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
            query = text('INSERT INTO schedule (doctor_name, patient_name, customer_name, gender, symptom, handphone, address, waktu, tanggal) \
                          VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9);')
            conn.execute(query, {'1': 'dr. Nurita', '2': 'Ahmad Maulana', '3': 'Rafli', '4': 'male', '5': '[]', '6': '0', '7': 'address1', '8': '08:00', '9': '2023-10-01'})

    data = pd.read_sql_query('SELECT * FROM schedule ORDER By id;', engine)
    for _, result in data.iterrows():        
        id = result['id']
        doctor_name_lama = result["doctor_name"]
        patient_name_lama = result["patient_name"]
        customer_name_lama = result["customer_name"] if "customer_name" i
