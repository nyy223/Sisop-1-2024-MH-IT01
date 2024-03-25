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

### Penjelasan
#### - Pertama, kita download file yang bernama "Sandbox.csv" yang dimana file itu berisikan data penjualan dari toko bernama "SandBox". Di dalam data tersebut, terdapat 20 kolom yang setiap kolomnya berisi kategori yang berbeda. 
    curl -L -o SandBox.csv 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'
    
#### - Kemudian, pada poin (a), kita diminta untuk menampilkan nama pembeli dengan total sales paling tinggi
    awk -F ',' 'NR>1 && $17 > max {max=$17; line=$6 " = " $17} END {print line}' max=0 SandBox.csv
##### Fungsi dari kode awk tersebut adalah untuk mencari nilai maksimum dari kolom ke-17 dalam file 'SandBox.csv'. Kemudian, kode tersebut mencetak baris yang memiliki nilai maksimum tersebut dengan format yang ditentukan, yaitu kombinasi dari nilai kolom ke-6 dengan nilai kolom ke-17 yang terbesar dan disimpan dalam variabel max.

#### -  Lalu, pada poin (b), kita diminta untuk menampilkan customer segment yang memiliki profit paling kecil
    awk -F ',' '$NF > 0 && ($NF < min || min == 0) {min=$NF; segment=$7} END {print segment, min}' min=0 SandBox.csv
##### Kita menggunakan Kode awk tersebut untuk mencari nilai minimum dari kolom terakhir (kolom NF) dalam file 'SandBox.csv', dengan syarat nilai kolom terakhir harus lebih besar dari 0. Setelah mencari nilai minimum, kode tersebut akan mencetak nilai minimum beserta nilai kolom ke-7 dari baris yang memiliki nilai minimum tersebut.

#### Selanjutnya, pada poin (c), kita diminta untuk menampilkan 3 category yang memiliki total profit tertinggi
    awk -F ',' '{ if ($NF > max[$14]) { max[$14] = $NF; category[$14] = $14 } } END { PROCINFO["sorted_in"] = "@val_num_desc"; for (i in max) print category[i], max[i] }' SandBox.csv | head -n 3
##### Kita menggunakan kode awk ini untuk mencari nilai maksimum dari setiap kategori (diidentifikasi oleh kolom ke-14) dalam file 'SandBox.csv'. Kemudian, kode tersebut mencetak tiga baris pertama dari hasil pengolahan tersebut dengan urutan berdasarkan nilai maksimum.

#### Terakhir, pada poin (d), kita diminta untuk menampilkan purchase date dan amount (quantity) dari nama adriaens
    grep 'Adriaens' SandBox.csv | awk -F ',' '{print $2, $18}'
##### Kode ini melakukan pencarian atas nama 'Adriaens' dalam file 'SandBox.csv' menggunakan grep, dan kemudian menggunakan awk untuk mencetak kolom kedua dan kolom kedelapan belas dari setiap baris yang mengandung nama tersebut.

