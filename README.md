# Praktikum-Sisop-1-2024-MH-IT01

## Anggota
### Nayla Raissa Azzahra (5027231054)
### Ryan Adya Purwanto (5027231046)
### Rafael Gunawan (5027231019)

## Ketentuan
### Struktur repository seperti berikut : 
    —soal_1:
     — sandbox.sh
                                        
    —soal_2:
     — login.sh
     — register.sh
    				
    —soal_3:
     — awal.sh
     — search.sh
    				
    —soal_4:
     — aggregate_minutes_to_hourly_log.sh
     — minute_log.sh

## Soal 1
> Rafael
### Soal
#### Cipung dan abe ingin mendirikan sebuah toko bernama “SandBox”, sedangkan kamu adalah manajer penjualan yang ditunjuk oleh Cipung dan Abe untuk melakukan pelaporan penjualan dan strategi penjualan kedepannya yang akan dilakukan. 
#### Setiap tahun Cipung dan Abe akan mengadakan rapat dengan kamu untuk mengetahui laporan dan strategi penjualan dari “SandBox”. Buatlah beberapa kesimpulan dari data penjualan “Sandbox.csv” untuk diberikan ke cipung dan abe 

#### a). Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan total sales paling tinggi
#### b). Karena karena Cipung dan Abe ingin mengefisienkan penjualannya, mereka ingin merencanakan strategi penjualan untuk customer segment yang memiliki profit paling kecil. Tampilkan customer segment yang memiliki profit paling kecil
#### c). Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. Tampilkan 3 category yang memiliki total profit paling tinggi 
#### d). Karena ada seseorang yang lapor kepada Cipung dan Abe bahwa pesanannya tidak kunjung sampai, maka mereka ingin mengecek apakah pesanan itu ada. Cari purchase date dan amount (quantity) dari nama adriaens

### Penyelesaian
    #!/bin/bash
    
    curl -L -o SandBox.csv 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'
    
    echo "Analisis Data Penjualan dari SandBox"
    echo "Nama Pembeli dan Total Sales Tertinggi:"
    awk -F ',' 'NR>1 && $17 > max {max=$17; line=$6 " = " $17} END {print line}' max=0 SandBox.csv
    echo ""
    
    echo "Segment Pelanggan dengan Profit Terendah:"
    awk -F ',' '$NF > 0 && ($NF < min || min == 0) {min=$NF; segment=$7} END {print segment, min}' min=0 SandBox.csv
    echo ""
    
    echo "3 Kategori Barang dengan Profit Paling Tinggi:"
    awk -F ',' '{ if ($NF > max[$14]) { max[$14] = $NF; category[$14] = $14 } } END { PROCINFO["sorted_in"] = "@val_num_desc"; for (i in max) print category[i], max[i] }' SandBox.csv | head -n 3
    echo""
    
    echo "Tanggal dan Jumlah Pemesanan dari Adriaens:"
    grep 'Adriaens' SandBox.csv | awk -F ',' '{print $2, $18}'

    chmod +x Sales.sh
    ./Sales.sh

### Penjelasan
#### - Pertama, kita download file yang bernama "Sandbox.csv" yang dimana file itu berisikan data penjualan dari toko bernama "SandBox". Di dalam data tersebut, terdapat 20 kolom yang setiap kolomnya berisi kategori yang berbeda. 
    curl -L -o SandBox.csv 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'
    
#### - Kemudian, pada poin (a), kita diminta untuk menampilkan nama pembeli dengan total sales paling tinggi
    awk -F ',' 'NR>1 && $17 > max {max=$17; line=$6 " = " $17} END {print line}' max=0 SandBox.csv
##### Fungsi dari kode awk tersebut adalah untuk mencari nilai maksimum dari kolom ke-17 dalam file 'SandBox.csv'. Kemudian, kode tersebut mencetak baris yang memiliki nilai maksimum tersebut dengan format yang ditentukan, yaitu kombinasi dari nilai kolom ke-6 dengan nilai kolom ke-17 yang terbesar dan disimpan dalam variabel max.

#### -  Lalu, pada poin (b), kita diminta untuk menampilkan customer segment yang memiliki profit paling kecil
    awk -F ',' '$NF > 0 && ($NF < min || min == 0) {min=$NF; segment=$7} END {print segment, min}' min=0 SandBox.csv
##### Kita menggunakan Kode awk tersebut untuk mencari nilai minimum dari kolom terakhir (kolom NF) dalam file 'SandBox.csv', dengan syarat nilai kolom terakhir harus lebih besar dari 0. Setelah mencari nilai minimum, kode tersebut akan mencetak nilai minimum beserta nilai kolom ke-7 dari baris yang memiliki nilai minimum tersebut.

#### - Selanjutnya, pada poin (c), kita diminta untuk menampilkan 3 category yang memiliki total profit tertinggi
    awk -F ',' '{ if ($NF > max[$14]) { max[$14] = $NF; category[$14] = $14 } } END { PROCINFO["sorted_in"] = "@val_num_desc"; for (i in max) print category[i], max[i] }' SandBox.csv | head -n 3
##### Kita menggunakan kode awk ini untuk mencari nilai maksimum dari setiap kategori (diidentifikasi oleh kolom ke-14) dalam file 'SandBox.csv'. Kemudian, kode tersebut mencetak tiga baris pertama dari hasil pengolahan tersebut dengan urutan berdasarkan nilai maksimum.

#### - Kemudian, pada poin (d), kita diminta untuk menampilkan purchase date dan amount (quantity) dari nama adriaens
    grep 'Adriaens' SandBox.csv | awk -F ',' '{print $2, $18}'
##### Kode ini melakukan pencarian atas nama 'Adriaens' dalam file 'SandBox.csv' menggunakan grep, dan kemudian menggunakan awk untuk mencetak kolom kedua dan kolom kedelapan belas dari setiap baris yang mengandung nama tersebut.

#### - Setelah itu, kita gunakan command ini untuk memberikan izin eksekusi pada file 'Sales.sh'.
    chmod +x Sales.sh

#### - Terakhir, kita jalankan file 'Sales.sh' menggunakan code di bawah ini.
    ./Sales.sh

### Dokumentasi
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/151918510/0429edd0-90ec-41cc-a049-02fc58dd88e7)
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/151918510/56afbcd7-52f1-417e-a166-83c1cb29ba1e)
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/151918510/2542546d-f890-4a04-bdce-f86b3fe2e081)

## Soal 2
> Rafael
### Soal
#### Oppie merupakan seorang peneliti bom atom, ia ingin merekrut banyak peneliti lain untuk mengerjakan proyek bom atom nya, Oppie memiliki racikan bom atom rahasia yang hanya bisa diakses penelitinya yang akan diidentifikasi sebagai user, Oppie juga memiliki admin yang bertugas untuk memanajemen peneliti,  bantulah oppie untuk membuat program yang akan memudahkan tugasnya
#### a). Buatlah 2 program yaitu login.sh dan register.sh
#### b). Setiap admin maupun user harus melakukan register terlebih dahulu menggunakan email, username, pertanyaan keamanan dan jawaban, dan password
#### c). Username yang dibuat bebas, namun email bersifat unique. setiap email yang mengandung kata admin akan dikategorikan menjadi admin
#### d). Karena resep bom atom ini sangat rahasia Oppie ingin password nya memuat keamanan tingkat tinggi
     a). Password tersebut harus di encrypt menggunakan base64
     b). Password yang dibuat harus lebih dari 8 karakter
     c). Harus terdapat paling sedikit 1 huruf kapital dan 1 huruf kecil
     d). Harus terdapat paling sedikit 1 angka
#### e). Karena Oppie akan memiliki banyak peneliti dan admin ia berniat untuk menyimpan seluruh data register yang ia lakukan ke dalam folder users file users.txt. Di dalam file tersebut, terdapat catatan seluruh email, username, pertanyaan keamanan dan jawaban, dan password hash yang telah ia buat.
#### f). Setelah melakukan register, program harus bisa melakukan login. Login hanya perlu dilakukan menggunakan email dan password.
#### g). Karena peneliti yang di rekrut oleh Oppie banyak yang sudah tua dan pelupa maka Oppie ingin ketika login akan ada pilihan lupa password dan akan keluar pertanyaan keamanan dan ketika dijawab dengan benar bisa memunculkan password
#### h). Setelah user melakukan login akan keluar pesan sukses, namun setelah seorang admin melakukan login Oppie ingin agar admin bisa menambah, mengedit (username, pertanyaan keamanan dan jawaban, dan password), dan menghapus user untuk memudahkan kerjanya sebagai admin.
#### i). Ketika admin ingin melakukan edit atau hapus user, maka akan keluar input email untuk identifikasi user yang akan di hapus atau di edit
#### j). Oppie ingin programnya tercatat dengan baik, maka buatlah agar program bisa mencatat seluruh log ke dalam folder users file auth.log, baik login ataupun register.
     Format: [date] [type] [message]
     Type: REGISTER SUCCESS, REGISTER FAILED, LOGIN SUCCESS, LOGIN FAILED
     Ex:
        [23/09/17 13:18:02] [REGISTER SUCCESS] user [username] registered successfully
        [23/09/17 13:22:41] [LOGIN FAILED] ERROR Failed login attempt on user with email [email]

### Penyelesaian
