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
#### login.sh
    #!/bin/bash
    
    log_message() {
        local type=$1
        local message=$2
        local timestamp=$(date +"[%d/%m/%y %H:%M:%S]")
    
        echo "$timestamp [$type] $message" >> auth.log
    }
    
    add_user() {
        read -p "Masukkan email: " email
        read -p "Masukkan username: " username
        read -p "Masukkan pertanyaan keamanan: " security_question
        read -p "Masukkan jawaban: " security_answer
        read -s -p "Masukkan password: " password
        echo
    
        # Validasi email unique
        if grep -q "^$email:" users.txt; then
            echo "Email sudah terdaftar!"
            log_message "REGISTER FAILED" "Failed registration attempt for user with email $email"
            exit 1
        fi
    
        # Validasi panjang password
        if [ ${#password} -lt 8 ]; then
            echo "Password harus lebih dari 8 karakter!"
            log_message "REGISTER FAILED" "Failed registration attempt for user with email $email"
            exit 1
        fi
    
        if ! echo "$password" | grep -q '[[:lower:]]' || ! echo "$password" | grep -q '[[:upper:]]' || ! echo "$password" | grep -q '[[:digit:]]'; then
            echo "Password harus mengandung minimal 1 huruf kecil, 1 huruf kapital, dan 1 angka!"
            log_message "REGISTER FAILED" "Failed registration attempt for user with email $email"
            exit 1
        fi
    
        password_hash=$(echo -n "$password" | base64)
    
        if echo "$email" | grep -q "admin"; then
            role="admin"
        else
            role="user"
        fi
    
        echo "$email:$username:$security_question:$security_answer:$password_hash:$role" >> users.txt
        log_message "REGISTER SUCCESS" "User $username registered successfully with email $email"
        echo "Registrasi berhasil!"
    }
    
    edit_user() {
        read -p "Masukkan email user yang ingin diedit: " edit_email
    
        user_data=$(grep "^$edit_email:" users.txt)
    
        if [ -z "$user_data" ]; then
            echo "User dengan email $edit_email tidak ditemukan!"
            log_message "USER EDIT FAILED" "Failed user edit attempt for email $edit_email"
            exit 1
        fi
    
        read -p "Masukkan username baru: " new_username
        read -p "Masukkan pertanyaan keamanan baru: " new_security_question
        read -p "Masukkan jawaban baru: " new_security_answer
        read -s -p "Masukkan password baru: " new_password
        echo
    
        if [ ${#new_password} -lt 8 ]; then
            echo "Password baru harus lebih dari 8 karakter!"
            log_message "USER EDIT FAILED" "Failed user edit attempt for email $edit_email"
            exit 1
        fi
    
        if ! echo "$new_password" | grep -q '[[:lower:]]' || ! echo "$new_password" | grep -q '[[:upper:]]' || ! echo "$new_password" | grep -q '[[:digit:]]'; then
            echo "Password baru harus mengandung minimal 1 huruf kecil, 1 huruf kapital, dan 1 angka!"
            log_message "USER EDIT FAILED" "Failed user edit attempt for email $edit_email"
            exit 1
        fi
    
        new_password_hash=$(echo -n "$new_password" | base64)
    
        sed -i "s/^$edit_email:.*/$edit_email:$new_username:$new_security_question:$new_security_answer:$new_password_hash:${user_data##*:}/" users.txt
        log_message "USER EDIT SUCCESS" "User with email $edit_email edited successfully"
        echo "User dengan email $edit_email berhasil diedit!"
    }
    
    delete_user() {
        read -p "Masukkan email user yang ingin dihapus: " delete_email
    
        user_data=$(grep "^$delete_email:" users.txt)
    
        if [ -z "$user_data" ]; then
            echo "User dengan email $delete_email tidak ditemukan!"
            log_message "USER DELETE FAILED" "Failed user delete attempt for email $delete_email"
            exit 1
        fi
    
        sed -i "/^$delete_email:.*/d" users.txt
        log_message "USER DELETE SUCCESS" "User with email $delete_email deleted successfully"
        echo "User dengan email $delete_email berhasil dihapus!"
    }
    
    echo "Selamat Datang di Menu Login"
    echo "1. Login"
    echo "2. Lupa Password"
    
    read -p "Pilih opsi (1/2): " option
    
    if [ "$option" == "1" ]; then
        read -p "Masukkan email: " email
        read -s -p "Masukkan password: " password
        echo
    
        user_data=$(grep "^$email:" users.txt)
    
        if [ -z "$user_data" ]; then
            echo "Email tidak terdaftar!"
            log_message "LOGIN FAILED" "Failed login attempt on user with email $email"
            exit 1
        fi
    
        password_hash=$(echo "$user_data" | cut -d':' -f5)
        role=$(echo "$user_data" | cut -d':' -f6)
    
        input_password_hash=$(echo -n "$password" | base64)
    
        if [ "$input_password_hash" != "$password_hash" ]; then
            echo "Password salah!"
            log_message "LOGIN FAILED" "Failed login attempt on user with email $email"
            exit 1
        fi
    
        echo "Login berhasil!"
        if [ "$role" == "admin" ]; then
            admin_menu() {
                echo "Menu Admin:"
                echo "1. Tambah User"
                echo "2. Edit User"
                echo "3. Delete User"
                echo "4. Logout"
                read -p "Pilih opsi (1/2/3/4): " admin_option
    
                case $admin_option in
                    1)
                        add_user
                        ;;
                    2)
                        edit_user
                        ;;
                    3)
                        delete_user
                        ;;
                    4)
                        echo "Anda Berhasil Keluar."
                        log_message "LOGOUT" "User $email logged out"
                        ;;
                    *)
                        echo "Opsi tidak valid."
                        ;;
                esac
            }
            admin_menu
        else
            echo "Anda Tidak Memiliki Hak Admin!"
            read -p "Log out? (y/n): " logout_option
    
            if [ "$logout_option" == "y" ]; then
                echo "Anda Berhasil Keluar."
                log_message "LOGOUT" "User $email logged out"
            else
                echo "Wlee Kamu Harus Keluar"
            fi
        fi
    elif [ "$option" == "2" ]; then
        read -p "Masukkan email: " email
        read -p "Masukkan pertanyaan keamanan: " security_question
        read -p "Masukkan jawaban: " security_answer
    
        user_data=$(grep "^$email:" users.txt)
    
        if [ -z "$user_data" ]; then
            echo "Email tidak terdaftar!"
            log_message "PASSWORD RESET FAILED" "Failed password reset attempt for user with email $email"
            exit 1
        fi
    
        saved_security_answer=$(echo "$user_data" | cut -d':' -f4)
        if [ "$security_answer" != "$saved_security_answer" ]; then
            echo "Jawaban keamanan salah!"
            log_message "PASSWORD RESET FAILED" "Failed password reset attempt for user with email $email"
            exit 1
        fi
    
        saved_password_hash=$(echo "$user_data" | cut -d':' -f5)
        saved_password=$(echo "$saved_password_hash" | base64 -d)
        echo "Password anda adalah: $saved_password"
        log_message "PASSWORD RESET SUCCESS" "Password reset successful for user with email $email"
    else
        echo "Opsi tidak valid."
    fi
#### register.sh
