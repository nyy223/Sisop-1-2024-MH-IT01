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
> Rafael (5027231019)
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

### Kendala
#### Tidak terdapat kendala.

## Soal 2
> Rafael (5027231019)
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
    
        if grep -q "^$email:" users.txt; then
            echo "Email sudah terdaftar!"
            log_message "REGISTER FAILED" "Failed registration attempt for user with email $email"
            exit 1
        fi
    
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
    #!/bin/bash
    
    log_message() {
        local type=$1
        local message=$2
        local timestamp=$(date +"[%d/%m/%y %H:%M:%S]")
    
        echo "$timestamp [$type] $message" >> auth.log
    }
    
    echo "Selamat Datang di Menu Registrasi"
    
    read -p "Masukkan email: " email
    read -p "Masukkan username: " username
    read -p "Masukkan pertanyaan keamanan: " security_question
    read -p "Masukkan jawaban: " security_answer
    read -s -p "Masukkan password: " password
    echo
    
    if grep -q "^$email:" users.txt; then
        echo "Email sudah terdaftar!"
        log_message "REGISTER FAILED" "Registration failed for user with email $email. Email already registered."
        exit 1
    fi
    
    if [ ${#password} -lt 8 ]; then
        echo "Password harus lebih dari 8 karakter!"
        log_message "REGISTER FAILED" "Registration failed for user with email $email. Password too short."
        exit 1
    fi
    
    if ! echo "$password" | grep -q '[[:lower:]]' || ! echo "$password" | grep -q '[[:upper:]]' || ! echo "$password" | grep -q '[[:digit:]]'; then
        echo "Password harus mengandung minimal 1 huruf kecil, 1 huruf kapital, dan 1 angka!"
        log_message "REGISTER FAILED" "Registration failed for user with email $email. Weak password."
        exit 1
    fi
    
    password_hash=$(echo -n "$password" | base64)
    
    if echo "$email" | grep -q "admin"; then
        role="admin"
    else
        role="user"
    fi
    
    echo "$email:$username:$security_question:$security_answer:$password_hash:$role" >> users.txt
    
    echo "Registrasi berhasil!"
    log_message "REGISTER SUCCESS" "User with email $email registered successfully."

### Penjelasan
#### - Pada bagian (a), kita diminta untuk membuat 2 program yaitu login.sh dan register.sh. Kita bisa membuatnya dengan command di bawah ini.
    touch login.sh register.sh
    
#### - Pada bagian (b), kita diminta untuk membuat file register.sh agar pengguna bisa menggunakan email, username, pertanyaan keamanan dan jawaban, dan password untuk register user.
    read -p "Masukkan email: " email
    read -p "Masukkan username: " username
    read -p "Masukkan pertanyaan keamanan: " security_question
    read -p "Masukkan jawaban: " security_answer
    read -s -p "Masukkan password: " password
    echo
##### Kode ini kita gunakan untuk meminta pengguna memasukkan email, username, pertanyaan keamanan, jawaban keamanan, dan password. '-p' digunakan untuk menampilkan pesan prompt sebelum meminta input, sementara '-s' pada perintah 'read' digunakan untuk menyembunyikan input password dari tampilan layar saat dimasukkan.

#### - Pada bagian (c), kita diminta untuk membuat email yang mengandung kata admin dikategorikan menjadi admin    
    if echo "$email" | grep -q "admin"; then
        role="admin"
    else
        role="user"
    fi
##### Kode ini berfungsi untuk melakukan pengecekan apakah email mengandung kata 'admin'. Jika iya, maka variabel 'role' akan diatur sebagai 'admin'. Jika tidak, maka variabel 'role' akan diatur sebagai 'user'.

#### - Pada bagian (d), kita diminta untuk mengatur password agar berkeamanan tinggi dengan ketentuan password tersebut harus di encrypt menggunakan base64, harus lebih dari 8 karakter, harus terdapat paling sedikit 1 huruf kapital dan 1 huruf kecil, dan harus terdapat paling sedikit 1 angka.
    if [ ${#password} -lt 8 ]; then
        echo "Password harus lebih dari 8 karakter!"
        exit 1
    fi
    
    if ! echo "$password" | grep -q '[[:lower:]]' || ! echo "$password" | grep -q '[[:upper:]]' || ! echo "$password" | grep -q '[[:digit:]]'; then
        echo "Password harus mengandung minimal 1 huruf kecil, 1 huruf kapital, dan 1 angka!"
        exit 1
    fi
    
    password_hash=$(echo -n "$password" | base64)
##### Kode ini kita gunakan untuk memeriksa panjang dan persyaratan password yang akan dimasukkan. Jika password kurang dari 8 karakter, atau tidak mengandung minimal satu huruf kecil, satu huruf kapital, dan satu angka, maka program akan menampilkan pesan kesalahan dan keluar. Jika password memenuhi syarat, program akan menghasilkan hash password menggunakan base64.

#### - Pada bagian (e), kita diminta untuk menyimpan catatan seluruh email, username, pertanyaan keamanan dan jawaban, dan password hash ke dalam folder users file users.txt.
    echo "$email:$username:$security_question:$security_answer:$password_hash:$role" >> users.txt
##### Kode ini digunakan untuk menyimpan seluruh data register yang mengandung catatan seluruh email, username, pertanyaan keamanan dan jawaban, dan password hash ke dalam folder users file users.txt.

#### - Pada bagian (f), kita diminta untuk melakukan login yang dimana login ini hanya dilakukan menggunakan email dan password.
    if [ "$option" == "1" ]; then
        read -p "Masukkan email: " email
        read -s -p "Masukkan password: " password
        echo
    
        user_data=$(grep "^$email:" users.txt)
    
        if [ -z "$user_data" ]; then
            echo "Email tidak terdaftar!"
            exit 1
        fi
    
        password_hash=$(echo "$user_data" | cut -d':' -f5)
        role=$(echo "$user_data" | cut -d':' -f6)
    
        input_password_hash=$(echo -n "$password" | base64)
    
        if [ "$input_password_hash" != "$password_hash" ]; then
            echo "Password salah!"
            exit 1
        fi
##### Kode ini kita gunakan untuk meminta pengguna memasukkan email dan password. Kemudian, program akan mencari data pengguna berdasarkan email yang dimasukkan dalam file "users.txt". Jika email tidak ditemukan, program akan menampilkan pesan "Email tidak terdaftar!" dan keluar dengan kode status 1. Selanjutnya, program akan mengambil hash password dan peran (role) dari data pengguna yang ditemukan. Jika hash password tidak cocok, program akan menampilkan pesan "Password salah!" dan keluar dengan kode status 1.

#### - Pada bagian (g), kita diminta untuk membuat pilihan lupa password dan akan keluar pertanyaan keamanan dan ketika dijawab dengan benar bisa memunculkan password ketika login.
    elif [ "$option" == "2" ]; then
        read -p "Masukkan email: " email
        read -p "Masukkan pertanyaan keamanan: " security_question
        read -p "Masukkan jawaban: " security_answer
    
        user_data=$(grep "^$email:" users.txt)
    
        if [ -z "$user_data" ]; then
            echo "Email tidak terdaftar!"
            exit 1
        fi
    
        saved_security_answer=$(echo "$user_data" | cut -d':' -f4)
        if [ "$security_answer" != "$saved_security_answer" ]; then
            echo "Jawaban keamanan salah!"
            exit 1
        fi
    
        saved_password_hash=$(echo "$user_data" | cut -d':' -f5)
        saved_password=$(echo "$saved_password_hash" | base64 -d)
        echo "Password anda adalah: $saved_password"
    else
        echo "Opsi tidak valid."
    fi
##### Kode ini digunakan untuk meminta pengguna untuk memasukkan email, pertanyaan keamanan, dan jawaban keamanan. Kemudian, program akan mencari data pengguna berdasarkan email yang dimasukkan dalam file "users.txt". Jika email tidak ditemukan (tidak ada data yang cocok), program akan menampilkan pesan "Email tidak terdaftar!" dan keluar dengan kode status 1.Selanjutnya, program akan membandingkan jawaban keamanan yang dimasukkan pengguna dengan jawaban keamanan yang tersimpan dalam data pengguna. Jika jawaban keamanan tidak cocok, program akan menampilkan pesan "Jawaban keamanan salah!" dan keluar dengan kode status 1. Jika jawaban keamanan cocok, program akan mengambil hash password dari data pengguna, mendekode hash password tersebut menggunakan base64, dan menampilkan password asli kepada pengguna.

#### - Pada bagian (h), kita diminta agar setelah user melakukan login akan keluar pesan sukses, namun setelah seorang admin melakukan login, admin bisa menambah, mengedit (username, pertanyaan keamanan dan jawaban, dan password), dan menghapus user . 
    add_user() {
        read -p "Masukkan email: " email
        read -p "Masukkan username: " username
        read -p "Masukkan pertanyaan keamanan: " security_question
        read -p "Masukkan jawaban: " security_answer
        read -s -p "Masukkan password: " password
        echo
    
        if grep -q "^$email:" users.txt; then
            echo "Email sudah terdaftar!"
            exit 1
        fi
    
        if [ ${#password} -lt 8 ]; then
            echo "Password harus lebih dari 8 karakter!"
            exit 1
        fi
    
        if ! echo "$password" | grep -q '[[:lower:]]' || ! echo "$password" | grep -q '[[:upper:]]' || ! echo "$password" | grep -q '[[:digit:]]'; then
            echo "Password harus mengandung minimal 1 huruf kecil, 1 huruf kapital, dan 1 angka!"
            exit 1
        fi
    
        password_hash=$(echo -n "$password" | base64)
    
        if echo "$email" | grep -q "admin"; then
            role="admin"
        else
            role="user"
        fi
    
        echo "$email:$username:$security_question:$security_answer:$password_hash:$role" >> users.txt
        echo "Registrasi berhasil!"
    }
    
    edit_user() {
        read -p "Masukkan email user yang ingin diedit: " edit_email
    
        user_data=$(grep "^$edit_email:" users.txt)
    
        if [ -z "$user_data" ]; then
            echo "User dengan email $edit_email tidak ditemukan!"
            exit 1
        fi
    
        read -p "Masukkan username baru: " new_username
        read -p "Masukkan pertanyaan keamanan baru: " new_security_question
        read -p "Masukkan jawaban baru: " new_security_answer
        read -s -p "Masukkan password baru: " new_password
        echo
    
        if [ ${#new_password} -lt 8 ]; then
            echo "Password baru harus lebih dari 8 karakter!"
            exit 1
        fi
    
        if ! echo "$new_password" | grep -q '[[:lower:]]' || ! echo "$new_password" | grep -q '[[:upper:]]' || ! echo "$new_password" | grep -q '[[:digit:]]'; then
            echo "Password baru harus mengandung minimal 1 huruf kecil, 1 huruf kapital, dan 1 angka!"
            exit 1
        fi
    
        new_password_hash=$(echo -n "$new_password" | base64)
    
        sed -i "s/^$edit_email:.*/$edit_email:$new_username:$new_security_question:$new_security_answer:$new_password_hash:${user_data##*:}/" users.txt
        echo "User dengan email $edit_email berhasil diedit!"
    }
    
    delete_user() {
        read -p "Masukkan email user yang ingin dihapus: " delete_email
    
        user_data=$(grep "^$delete_email:" users.txt)
    
        if [ -z "$user_data" ]; then
            echo "User dengan email $delete_email tidak ditemukan!"
            exit 1
        fi
    
        sed -i "/^$delete_email:.*/d" users.txt
        echo "User dengan email $delete_email berhasil dihapus!"
    }
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
##### Kode ini digunakan untuk mengecek apakah pengguna memiliki hak admin atau tidak setelah berhasil login. Jika pengguna adalah admin, maka akan ditampilkan menu admin yang berisi opsi untuk tambah user, edit user, delete user, dan logout. Jika pengguna bukan admin, akan muncul pesan "Anda Tidak Memiliki Hak Admin" dengan opsi untuk logout. Jika pengguna memilih untuk logout, akan muncul pesan "Anda Berhasil Keluar."

#### - Pada bagian (i), kita diminta agar saat admin ingin melakukan edit atau hapus user, maka akan keluar input email untuk identifikasi user yang akan di hapus atau di edit
    edit_user() {
        read -p "Masukkan email user yang ingin diedit: " edit_email
    
        user_data=$(grep "^$edit_email:" users.txt)
    
        if [ -z "$user_data" ]; then
            echo "User dengan email $edit_email tidak ditemukan!"
            exit 1
        fi
	
    delete_user() {
        read -p "Masukkan email user yang ingin dihapus: " delete_email
    
        user_data=$(grep "^$delete_email:" users.txt)
    
        if [ -z "$user_data" ]; then
            echo "User dengan email $delete_email tidak ditemukan!"
            exit 1
        fi
##### Kode ini digunakan untuk meminta pengguna memasukkan email dari pengguna yang ingin diedit dan dihapus. Kemudian, program mencari data pengguna berdasarkan email tersebut dalam file "users.txt". Jika data pengguna tidak ditemukan, pesan "User dengan email $edit_email tidak ditemukan!" ditampilkan dan program keluar dengan kode status 1.

#### Terakhir, pada bagian (j), kita diminta untuk membuat program yang bisa mencatat seluruh log ke dalam folder users file auth.log, baik login ataupun register.
	log_message() {
	    local type=$1
	    local message=$2
	    local timestamp=$(date +"[%d/%m/%y %H:%M:%S]")
	
	    echo "$timestamp [$type] $message" >> auth.log
	}
	
	log_message "REGISTER FAILED" "Failed registration attempt for user with email $email"
	log_message "REGISTER SUCCESS" "User $username registered successfully with email $email"
	log_message "USER EDIT FAILED" "Failed user edit attempt for email $edit_email"
	log_message "USER EDIT SUCCESS" "User with email $edit_email edited successfully"
	log_message "USER DELETE FAILED" "Failed user delete attempt for email $delete_email"
	log_message "USER DELETE SUCCESS" "User with email $delete_email deleted successfully"
	log_message "LOGIN FAILED" "Failed login attempt on user with email $email"
	log_message "LOGOUT" "User $email logged out"
	log_message "PASSWORD RESET FAILED" "Failed password reset attempt for user with email $email"
	log_message "PASSWORD RESET SUCCESS" "Password reset successful for user with email $email"
##### Kode ini  digunakan untuk mencatat kejadian yang terjadi dalam skrip Anda ke dalam file "auth.log". Kode ini berisi berbagai jenis pesan log seperti registrasi berhasil/gagal, edit user berhasil/gagal, delete user berhasil/gagal, login berhasil/gagal, logout, serta reset password berhasil/gagal.

### Dokumentasi
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/151918510/8c73038a-50b7-471e-bf8d-00378da8c67e)
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/151918510/241a8a05-6fbe-4100-a689-45d4de0e71dc)
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/151918510/b8dcb980-a6df-4206-b93c-40b325f59b58)
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/151918510/5e2af1d5-e126-4495-90d8-7bcfc9e44e72)
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/151918510/b2910729-275d-4952-8dc2-cf9c01b7e37f)
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/151918510/8cd08bb7-ce82-49e3-978d-931f3f008bab)
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/151918510/24c4d0f6-55a9-41dd-a41e-6b862d1eaadd)
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/151918510/479172b2-7ce9-4c14-8bee-c097ee0cbebd)
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/151918510/4f662fe2-8adf-4eec-bb2f-6bd473f7b87a)

### Kendala
#### Tidak terdapat kendala.

## Soal 3
> Ryan 5027231046

### Soal 3
Alyss adalah seorang gamer yang sangat menyukai bermain game Genshin Impact. Karena hobinya, dia ingin mengoleksi foto-foto karakter Genshin Impact. Suatu saat Yanuar memberikannya sebuah Link yang berisi koleksi kumpulan foto karakter dan sebuah clue yang mengarah ke penemuan gambar rahasia. Ternyata setiap nama file telah dienkripsi dengan menggunakan hexadecimal. Karena penasaran dengan apa yang dikatakan Yanuar, Alyss tidak menyerah dan mencoba untuk mengembalikan nama file tersebut kembali seperti semula.

a. Alyss membuat script bernama awal.sh, untuk download file yang diberikan oleh Yanuar dan unzip terhadap file yang telah diunduh dan decode setiap nama file yang terenkripsi dengan hex . Karena pada file list_character.csv terdapat data lengkap karakter, Alyss ingin merename setiap file berdasarkan file tersebut. Agar semakin rapi, Alyss mengumpulkan setiap file ke dalam folder berdasarkan region tiap karakter
Format: Region - Nama - Elemen - Senjata.jpg
Karena tidak mengetahui jumlah pengguna dari tiap senjata yang ada di folder "genshin_character".Alyss berniat untuk menghitung serta menampilkan jumlah pengguna untuk setiap senjata yang ada
- Format: [Nama Senjata] : [jumlah]
	 Untuk menghemat penyimpanan. Alyss menghapus file - file yang tidak ia gunakan, yaitu genshin_character.zip, list_character.csv, dan genshin.zip

b. Namun sampai titik ini Alyss masih belum menemukan clue dari the secret picture yang disinggung oleh Yanuar. Dia berpikir keras untuk menemukan pesan tersembunyi tersebut. Alyss membuat script baru bernama search.sh untuk melakukan pengecekan terhadap setiap file tiap 1 detik. Pengecekan dilakukan dengan cara meng-ekstrak sebuah value dari setiap gambar dengan menggunakan command steghide. Dalam setiap gambar tersebut, terdapat sebuah file txt yang berisi string. Alyss kemudian mulai melakukan dekripsi dengan hex pada tiap file txt dan mendapatkan sebuah url. Setelah mendapatkan url yang ia cari, Alyss akan langsung menghentikan program search.sh serta mendownload file berdasarkan url yang didapatkan.

c. Dalam prosesnya, setiap kali Alyss melakukan ekstraksi dan ternyata hasil ekstraksi bukan yang ia inginkan, maka ia akan langsung menghapus file txt tersebut. Namun, jika itu merupakan file txt yang dicari, maka ia akan menyimpan hasil dekripsi-nya bukan hasil ekstraksi. Selain itu juga, Alyss melakukan pencatatan log pada file image.log untuk setiap pengecekan gambar
Format: [date] [type] [image_path]
Ex: 
- [24/03/20 17:18:19] [NOT FOUND] [image_path]
- [24/03/20 17:18:20] [FOUND] [image_path]

Hasil Akhir:
genshin_character
search.sh
awal.sh
image.log
[filename].txt
[image].jpg

### Penyelesaian
#### awal.sh

	#!/bin/bash
	
	# Download file genshin.zip
	wget -O genshin.zip --no-check-certificate -r 'https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'
	
	# Ekstrak genshin.zip yang berisi genshin_character.zip dan list_character.csv
	unzip genshin.zip
	
	# Ekstrak genshin_character.zip ke direktori genshin_character
	unzip genshin_character.zip
	
	# Masuk ke direktori genshin_character
	cd genshin_character
	
	# Loop melalui setiap file .jpg dalam direktori genshin_character
	for file in *.jpg; do
	    # Menghapus bagian '0a.jpg' dari nama file untuk mendapatkan hex string yang sesuai
	    hexname=$(echo $file | sed 's/0a.jpg//')
	
	    # Dekode hex string menjadi teks biasa
	    decoded_name=$(echo -n $hexname | xxd -r -p)
	
	    # Tambahkan kembali ekstensi .jpg ke nama file yang telah didekode
	    new_name="${decoded_name}.jpg"
	
	    # Rename file lama ke nama baru
	    mv "$file" "$new_name"
	
	    echo "File $file telah di-rename menjadi $new_name"
	done
	
	# Kembali ke direktori utama
	cd ..
	
	# Membaca list_character.csv dan merename file berdasarkan data di dalamnya
	while IFS=, read -r name region element weapon; do
	    # Skip header
	    if [ "$name" == "Nama" ]; then
	        continue
	    fi
	
	    # Membangun path baru dan nama file
	    new_filename="${region} - ${name} - ${element} - ${weapon}.jpg"
	    old_filename="./genshin_character/${name}.jpg"
	
	    # Cek jika file dengan nama karakter tersebut ada, lalu rename dan pindah
	    if [ -f "$old_filename" ]; then
	        # Membuat direktori berdasarkan region jika belum ada
	        mkdir -p "./genshin_character/$region"
	        # Merename dan memindahkan file ke direktori yang sesuai
	        mv "$old_filename" "./genshin_character/$region/$new_filename"
	    else
	        echo "File untuk $name tidak ditemukan."
	    fi
	done < list_character.csv
	
	# Menggunakan sed dan awk untuk menghitung jumlah penggunaan senjata dari file CSV
	echo "Jumlah pengguna untuk setiap senjata:"
	sed 's/\r//' list_character.csv | awk -F, 'NR > 1 {gsub(/^ +| +$/, "", $4); count[$4]++} END {for (weapon in count) print weapon " = " count[weapon]}'
	
	# Hapus file zip dan CSV yang tidak lagi dibutuhkan
	rm -f genshin.zip genshin_character.zip list_character.csv
	
	echo "File sudah di dekode dan terorganisir, file zip dan csv juga sudah dihapus."

#### search.sh

#### sebelum direvisi

	#!/bin/bash
	
	# Tentukan direktori tempat gambar disimpan dan lokasi file log.
	direktori_gambar="genshin_character"
	log_file="image.log"
	
	# Bersihkan file log dari pencarian sebelumnya.
	echo "" > "$log_file"
	
	# Fungsi untuk mendekripsi teks dari hexadecimal.
	dekripsi_hex() {
	    echo "$1" | xxd -r -p
	}
	
	# Mulai pencarian di setiap file gambar.
	find "$direktori_gambar" -type f -name "*.jpg" | while read gambar; do
	    # Tampilkan proses pencarian di log file.
	    echo "$(date) [CHECKING] $gambar" >> "$log_file"
	    
	    # Mengekstrak teks dari gambar. Ganti dengan lokasi/tempat menyimpan file ekstraksi.
	    ekstrak_file="temp_extracted.txt"
	    steghide extract -sf "$gambar" -xf "$ekstrak_file" -p "" >& /dev/null
	    
	    # Cek apakah ekstraksi berhasil.
	    if [ -f "$ekstrak_file" ]; then
	        # Baca dan dekripsi isi file.
	        hex_content=$(cat "$ekstrak_file")
	        dekripsi=$(dekripsi_hex "$hex_content")
	        
	        # Cek apakah hasil dekripsi adalah URL.
	        if [[ $dekripsi =~ ^https?:// ]]; then
	            echo "$(date) [FOUND] $gambar" >> "$log_file"
	            # Lakukan sesuatu dengan URL, misalnya mendownload konten.
	            wget "$dekripsi" -O "downloaded_$(basename "$gambar" .jpg).jpg"
	            # Setelah menemukan URL yang valid, hentikan pencarian.
	            break
	        else
	            # Jika teks yang diekstraksi bukan URL yang diharapkan, catat sebagai NOT FOUND.
	            echo "$(date) [NOT FOUND] $gambar" >> "$log_file"
	            # Hapus file teks yang tidak mengandung URL yang dicari.
	            rm -f "$ekstrak_file"
	        fi
	    else
	        # Jika ekstraksi gagal, catat kejadian tersebut.
	        echo "$(date) [ERROR] Ekstraksi gagal untuk $gambar" >> "$log_file"
	    fi
	    
	    # Tunggu 1 detik sebelum memeriksa gambar berikutnya.
	    sleep 1
	done


#### setelah direvisi

	#!/bin/bash

	direktori_gambar="genshin_character"
	log_file="image.log"

	# Bersihkan file log dari pencarian sebelumnya.
	echo "" > "$log_file"

	# Mencari file dan memproses tanpa subshell
		while IFS= read -r gambar; do
    		# Format tanggal dan waktu untuk log.
    		waktu=$(date +"[%d/%m/%y %H:%M:%S]")
    		echo "$waktu [CHECKING] $gambar" >> "$log_file"
    
    		ekstrak_file="${gambar%.jpg}.txt"
    		dekripsi_file="$(basename "${gambar%.jpg}")_decoded.txt"

    		if steghide extract -sf "$gambar" -xf "$ekstrak_file" -p "" >& /dev/null; then
        		if [ -s "$ekstrak_file" ]; then
            		dekripsi=$(base64 --decode -i "$ekstrak_file")
            		if [[ $dekripsi =~ ^https?:// ]]; then
                		echo "$waktu [FOUND] $gambar" >> "$log_file"
                		echo "$dekripsi" > "$dekripsi_file"
                		# Proses pengunduhan konten dari URL yang ditemukan.
                		wget "$dekripsi" -O "$(basename "${gambar%.jpg}")" >& /dev/null
                		echo "Ketemu Nih Bang! $(basename "${gambar%.jpg}")"
                		# Memberikan umpan balik langsung di terminal.
                		echo "File berhasil ditemukan dan diunduh: $dekripsi"
                		# Menghentikan loop setelah menemukan dan mengunduh file yang diinginkan.
                		break
            		else
                		echo "$waktu [NOT FOUND] $gambar" >> "$log_file"
            		fi
            		rm -f "$ekstrak_file"
        	else
            		echo "$waktu [ERROR] File kosong setelah ekstraksi untuk $gambar" >> "$log_file"
        	fi
    	else
        	echo "$waktu [ERROR] Ekstraksi gagal untuk $gambar" >> "$log_file"
    	fi
	done < <(find "$direktori_gambar" -type f -name "*.jpg")

### Penjelasan awal.sh

1. Download File: Script memulai dengan mendownload sebuah file ZIP dari URL yang disediakan, yang berisi gambar karakter Genshin Impact dan file CSV dengan detail karakter.

		# Download file genshin.zip
		wget -O genshin.zip --no-check-certificate -r 'https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'


2. Ekstraksi File: Setelah file ZIP didownload, script mengekstrak isinya untuk mengakses gambar karakter dan file CSV yang berisi informasi tentang karakter tersebut.

		# Ekstrak genshin.zip yang berisi genshin_character.zip dan list_character.csv
		unzip genshin.zip

		# Ekstrak genshin_character.zip ke direktori genshin_character
		unzip genshin_character.zip


3. Dekode Nama File: Setiap nama file gambar dienkripsi dalam format hexadecimal. Script menghapus '0a' pada nama file jpg lalu mengdekode dari hexadecimal ke teks biasa dan merename file.

		# Loop melalui setiap file .jpg dalam direktori genshin_character
		for file in *.jpg; do
    			# Menghapus bagian '0a.jpg' dari nama file untuk mendapatkan hex string yang sesuai
	    		hexname=$(echo $file | sed 's/0a.jpg//')

    			# Dekode hex string menjadi teks biasa
    			decoded_name=$(echo -n $hexname | xxd -r -p)

    			# Tambahkan kembali ekstensi .jpg ke nama file yang telah didekode
    			new_name="${decoded_name}.jpg"

    			# Rename file lama ke nama baru
    			mv "$file" "$new_name"

    			echo "File $file telah di-rename menjadi $new_name"
		done

4. Reorganisasi File: Berdasarkan data dari file CSV, script mengorganisir ulang gambar ke dalam direktori yang sesuai dengan region karakter, dan merename file gambar sesuai dengan format Region - Nama - Elemen - Senjata.jpg.

		# Membaca list_character.csv dan merename file berdasarkan data di dalamnya
		while IFS=, read -r name region element weapon; do
		    # Skip header
		    if [ "$name" == "Nama" ]; then
		        continue
		    fi
		
		    # Membangun path baru dan nama file
		    new_filename="${region} - ${name} - ${element} - ${weapon}.jpg"
		    old_filename="./genshin_character/${name}.jpg"
		
		    # Cek jika file dengan nama karakter tersebut ada, lalu rename dan pindah
		    if [ -f "$old_filename" ]; then
		        # Membuat direktori berdasarkan region jika belum ada
		        mkdir -p "./genshin_character/$region"
		        # Merename dan memindahkan file ke direktori yang sesuai
		        mv "$old_filename" "./genshin_character/$region/$new_filename"
		    else
		        echo "File untuk $name tidak ditemukan."
		    fi
		done < list_character.csv

5. Hitung Pengguna Senjata: Script menghitung jumlah karakter yang menggunakan setiap jenis senjata dan menampilkan hasilnya.

		# Menggunakan sed dan awk untuk menghitung jumlah penggunaan senjata dari file CSV
		echo "Jumlah pengguna untuk setiap senjata:"
		sed 's/\r//' list_character.csv | awk -F, 'NR > 1 {gsub(/^ +| +$/, "", $4); count[$4]++} END {for (weapon in count) print weapon " = " count[weapon]}'


6. Pembersihan: Sebagai langkah terakhir, script menghapus file yang tidak lagi diperlukan untuk menghemat ruang penyimpanan.

		# Hapus file zip dan CSV yang tidak lagi dibutuhkan
		rm -f genshin.zip genshin_character.zip list_character.csv

### Penjelasan search.sh

1. Menetapkan direktori tempat gambar disimpan dan nama file untuk pencatatan log proses dan membersihkan log sebelumnya.

		direktori_gambar="genshin_character"
		log_file="image.log"
		echo "" > "$log_file"

2. Menyimpan waktu saat ini ke dalam variabel waktu dan mencatat ke file log bahwa script sedang memeriksa file gambar tertentu sesuai format soal.

		waktu=$(date +"[%d/%m/%y %H:%M:%S]")
		echo "$waktu [CHECKING] $gambar" >> "$log_file"

3. Menyiapkan nama file untuk hasil ekstraksi dan hasil dekripsi. Hasil dekripsi akan disimpan dengan tambahan _decoded pada nama file asli.

		ekstrak_file="${gambar%.jpg}.txt"
		dekripsi_file="$(basename "${gambar%.jpg}")_decoded.txt"

4. Menggunakan steghide untuk mengekstrak data tersembunyi dari gambar ke file teks. 

		 if steghide extract -sf "$gambar" -xf "$ekstrak_file" -p "" >& /dev/null; then
		        if [ -s "$ekstrak_file" ]; then
		            dekripsi=$(base64 --decode -i "$ekstrak_file")

5. Jika teks yang didekode merupakan URL yang valid, script mengunduh konten dari URL tersebut dan memberikan umpan balik ke terminal.

		            if [[ $dekripsi =~ ^https?:// ]]; then
		                echo "$waktu [FOUND] $gambar" >> "$log_file"
		                echo "$dekripsi" > "$dekripsi_file"
		                # Proses pengunduhan konten dari URL yang ditemukan.
		                wget "$dekripsi" -O "$(basename "${gambar%.jpg}")" >& /dev/null
		                echo "Ketemu Nih Bang! $(basename "${gambar%.jpg}")"
		                # Memberikan umpan balik langsung di terminal.
		                echo "File berhasil ditemukan dan diunduh: $dekripsi"
		                # Menghentikan loop setelah menemukan dan mengunduh file yang diinginkan.
		                break

6. Menghapus file ekstraksi setelah selesai diproses. Jika URL ditemukan dan konten berhasil diunduh. Jika tidak menemukan url yang valid akan mengoutput NOT FOUND.

		            else
		                echo "$waktu [NOT FOUND] $gambar" >> "$log_file"
		            fi
		            rm -f "$ekstrak_file"

7. Menggunakan find untuk mencari file gambar .jpg dalam direktori yang ditentukan dan memproses setiap file satu per satu.

		done < <(find "$direktori_gambar" -type f -name "*.jpg")


### Dokumentasi

1. File jpg sebelum didekode

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/aa56e49c-aade-4ad3-91ca-4faed25dfbc7)

2. File jpg setelah didekode namun belum diorganisir dan belum di rename sesuai format

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/a755672b-5c5e-44d2-8d73-ed150b14c065)

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/5c3b44b4-92e4-441f-9754-0c256f6a56e9)

3. File jpg setelah di organisir dan di rename sesuai format

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/f7fb4137-303d-44a2-8189-51f36089b383)

Fontaine

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/53572a46-c131-4797-b43f-e5c4d0818b98)

Inazuma

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/7e89394d-4408-4f7a-bbd0-b02a8c242139)

Liyue

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/09d90fc8-c5b2-47f9-8864-5ce1c772ef65)

Mondstat

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/cb1a6b28-3fce-43ba-a1bc-55e76210136c)

Sumeru

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/281c3c18-62dc-4b40-9bdb-d618127b98c1)

4. Penghitungan jumlah pengguna senjata dan akhir dari awal.sh

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/ff09d8c9-28c2-4ed3-8b1a-26f8cbee0463)

5. Pencarian secret picture lalu diekstrak menggunakan steghide

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/ab6f3313-ca79-4dc8-9f92-4a2d6623b1ba)
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/0363aee4-e680-4533-8bbc-3a8b523eff28)

6. Isi dari file txt yang sudah didekode beserta secret picturenya

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/f72623bc-a05a-49b8-ba27-47b1e3948202)
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/92a8e29c-e519-4500-89eb-3544acf20876)

7. Hasil akhir dari pengerjaan soal Nomor 3

![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/791a6f2f-1ceb-4c77-a26d-8b842611c7a3)


### Apa saja yang direvisi?

1. Format Tanggal dan Waktu:
- Script awal menggunakan $(date) untuk menampilkan tanggal dan waktu saat ini dalam format default.
- Pada revisi, saya menentukan format tanggal dan waktu menjadi [%d/%m/%y %H:%M:%S], agar sesuai dengan perintah soal.

2. Penanganan File Hasil Ekstraksi:
- Dalam script awal, nama file hasil ekstraksi selalu temp_extracted.txt, yang berarti file hasil ekstraksi terakhir akan menimpa file sebelumnya jika script dijalankan pada banyak gambar.
- Pada revisi, saya mengubah pendekatan ini dengan membuat nama file hasil ekstraksi dinamis berdasarkan nama gambar, dan juga menyimpan file hasil dekripsi dalam format baru (_decoded.txt).

3. Penggunaan Fungsi dekripsi_hex:
- Dalam script awal, saya mendefinisikan dan menggunakan fungsi dekripsi_hex untuk mendekripsi isi file dari hexadecimal.
- Pada revisi, fokus perubahannya adalah pada penanganan data base64 dan URL tanpa mencantumkan penggunaan eksplisit fungsi dekripsi_hex, yang menunjukkan adanya perubahan pada cara data didekode.

4. Penanganan Hasil Dekripsi:
- Script awal mengandalkan dekripsi data hexadecimal untuk menentukan langkah selanjutnya, termasuk pengunduhan konten dari URL yang ditemukan.
- Pada revisi, saya menambahkan pengecekan untuk URL yang valid langsung dari data yang diekstrak dan didekode dari base64, serta memberikan konfirmasi di terminal tentang keberhasilan pengunduhan.

### Kendala yang dialami

Script search.sh sebelumnya tidak menemukan satupun gambar yang terenkripsi
![image](https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/162680331/74d02807-3db5-451f-a7f1-8354de3eade4)


## Soal 4
> Nayla 5027231054

Soal nomor 4 meminta kita untuk membuat sebuah program untuk monitoring RAM dan size suatu directory. Kita diminta untuk membuat dua script. Script pertama, minute_log.sh, yaitu script untuk mencatat semua metrics hasil monitoring ke sebuah file log, dimana pencatatan metrics dalam script ini diharapkan untuk berjalan secara otomatis setiap menit. Sedangkan script kedua, aggregate_minutes_to_hourly_log.sh, yaitu script untuk mencatat info metrics yang tergenerate setiap menit dalam satu jam. Dalam hasil file agregasi tersebut, terdapat nilai minimum, maximum, dan rata-rata dari tiap-tiap metrics. Adapun ketentuan untuk pengerjaan soal ini adalah :
1. Pastikan semua file log hanya dapat dibaca oleh user pemilik file. 
2. Semua file log terletak di /home/{user}/log
3. Semua konfigurasi cron dapat ditaruh di file skrip .sh nya masing-masing dalam bentuk comment
### Penyelesaian
#### minute_log.sh
```bash
#!/bin/bash
# * * * * * /home/nayla/minute_log.sh
```
Baris pertama adalah shebang, yang memberi tahu sistem operasi bahwa skrip ini harus dijalankan dengan bash shell. Baris kedua merupakan perintah crontab, yaitu perintah atau script yang dijalankan secara otomatis pada waktu tertentu. * * * * * menunjukkan bahwa script minute_log.sh akan dijalankan setiap menit.
```bash
ram_metrics=$(free -m | awk 'NR==2 || NR==3 {
    if (NR == 2) {
        ram_values = $2","$3","$4","$5","$6","$7;
    } else {
        dir_values = $2","$3","$4;
    }
}
END {
    print ram_values "," dir_values;
}')
```
Potongan kode di atas merupakan kode yang berfungsi untuk menampilkan penggunaan memori pada sistem dengan menggunakan command 'free -m'. 
```bash
target_path="/home/$(whoami)/log"
mkdir -p "$target_path"
dir_size=$(du -sh "$target_path" | awk '{print $1}')
```
Digunakan untuk menampilkan hasil monitor size dari direktori target dengan menggunakan command 'du -sh'. 
```bash
current_time=$(date "+%Y%m%d%H%M%S")

echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" >> "/home/$(whoami)/log/metrics_$current_time.log"
echo "$ram_metrics,$target_path,$dir_size" >> "/home/$(whoami)/log/metrics_$current_time.log"
chmod 600 /home/$(whoami)/log/metrics_$current_time.log
```
Nantinya, hasil monitor RAM dan size dari direktori target akan disimpan ke dalam file log yang memuat waktu saat script dijalankan di nama file tersebut. Chmod 600 berfungsi untuk mengatur izin agar hanya pemilik file yang dapat membaca dan menulis ke file tersebut.
#### aggregate_minutes_to_hourly_log.sh
##### code sebelum revisi 
```bash
#!/bin/bash
#0 * * * * /home/nayla/aggregate_minutes_to_hourly_log.sh

log_dir="/home/$(whoami)/log/"
current_hour=$(date "+%Y%m%d%H")
declare -A metrics_array

for file in $log_dir/metrics_${current_hour}*.log; do
    # Membaca metrics dari setiap file
    while IFS=',' read -r mem_total mem_used mem_free mem_shared mem_buff mem_available swap_total swap_used swap_free path path_size; do
        # Memasukkan metrics ke dalam array
        metrics_array["mem_total"]+=" $mem_total"
        metrics_array["mem_used"]+=" $mem_used"
        metrics_array["mem_free"]+=" $mem_free"
        metrics_array["mem_shared"]+=" $mem_shared"
        metrics_array["mem_buff"]+=" $mem_buff"
        metrics_array["mem_available"]+=" $mem_available"
        metrics_array["swap_total"]+=" $swap_total"
        metrics_array["swap_used"]+=" $swap_used"
        metrics_array["swap_free"]+=" $swap_free"
        metrics_array["path_size"]+=" $path_size"
    done < "$file"
done

min_values=""
max_values=""
avg_values=""

for metric in "mem_total" "mem_used" "mem_free" "mem_shared" "mem_buff" "mem_available" "swap_total" "swap_used" "swap_free" "path_size"; do
    IFS=' ' read -r -a values_array <<< "${metrics_array[$metric]}"
    values_array=("${values_array[@]/%M/}")
    values_array=($(echo "${values_array[@]}" | grep -o '[0-9]*'))
    min=$(printf '%s\n' "${values_array[@]}" | sort -n | head -n1)
    max=$(printf '%s\n' "${values_array[@]}" | sort -n | tail -n1)
    sum=0
    count=0
    for value in "${values_array[@]}"; do
        sum=$((sum + value))
        ((count++))
    done
    if ((count > 0)); then
        avg=$(echo "scale=2; $sum / $count" | bc)
    else
        avg="N/A"
    fi
    min_values+="$min,"
    max_values+="$max,"
    avg_values+="$avg,"
done

echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" >> "$log_dir/metrics_agg_${current_hour}.log"
echo "minimum,$min_values" >> "$log_dir/metrics_agg_${current_hour}.log"
echo "maximum,$max_values" >> "$log_dir/metrics_agg_${current_hour}.log"
echo "average,$avg_values" >> "$log_dir/metrics_agg_${current_hour}.log"
chmod 600 "$log_dir/metrics_agg_${current_hour}.log"
```
##### code setelah revisi 
```bash
#!/bin/bash
#0 * * * * /home/nayla/aggregate_minutes_to_hourly_log.sh
```
Baris pertama adalah shebang, yang memberi tahu sistem operasi bahwa skrip ini harus dijalankan dengan bash shell. Baris kedua merupakan perintah crontab, yaitu perintah atau script yang dijalankan secara otomatis pada waktu tertentu. 0 * * * * menunjukkan bahwa script aggregate_minutes_to_hourly_log.sh akan dijalankan setiap jam.
```bash
log_dir="/home/$(whoami)/log/"
timestamp=$(date "+%Y%m%d%H")
```
Baris pertama digunakan untuk menyimpan informasi tempat script minute_log.sh dan aggregate_minutes_to_hourly_log.sh diletakkan. Baris kedua digunakan untuk menyimpan informasi waktu saat ini dalam bentuk jam.
```bash
mem_total_arr=()
mem_used_arr=()
mem_free_arr=()
mem_shared_arr=()
mem_buff_arr=()
mem_available_arr=()
swap_total_arr=()
swap_used_arr=()
swap_free_arr=()
path_size_arr=()
```
Merupakan bagian untuk inisialisasi beberapa array kosong, yang nantinya akan digunakan untuk menyimpan metrics dari file log.
```bash
for file in "$log_dir"metrics_${timestamp}*.log; do
    while IFS=, read -r mem_total mem_used mem_free mem_shared mem_buff mem_available swap_total swap_used swap_free path path_size; do
        mem_total_arr+=("$mem_total")
        mem_used_arr+=("$mem_used")
        mem_free_arr+=("$mem_free")
        mem_shared_arr+=("$mem_shared")
        mem_buff_arr+=("$mem_buff")
        mem_available_arr+=("$mem_available")
        swap_total_arr+=("$swap_total")
        swap_used_arr+=("$swap_used")
        swap_free_arr+=("$swap_free")
        path_size_val=$(echo "$path_size" | tr -d '[:alpha:]')
        path_size_arr+=("$path_size_val")
    done < "$file"
done
```
For loop berlaku untuk semua file yang ada di directory log_dir yang memiliki pola nama metrics_${timestamp}*.log. Loop ini akan membaca setiap baris dari file log, lalu menyimpannya ke dalam variabel array yang sudah dideklarasikan, seperti mem_total_arr, mem_used_arr, dan lain-lain.
```bash
calculate_min() {
    echo "$@" | tr ' ' '\n' | sort -n | head -n1
}
```
Menghitung nilai minimal dengan cara mengurutkan angka terlebih dahulu dari yang terkecil hingga terbesar, lalu menggunakan perintah head -n1 untuk mencetak angka pertama, yaitu angka yang paling kecil.
```bash
calculate_max() {
    echo "$@" | tr ' ' '\n' | sort -rn | head -n1
}
```
Menghitung nilai maksimal dengan cara mengurutkan angka terlebih dahulu dari yang terbesar hingga terkecil, lalu menggunakan perintah head -n1 untuk mencetak angka pertama, yaitu angka yang paling besar.
```bash
calculate_avg() {
    local sum=0
    local count=0
    for val in $@; do
        sum=$(echo "$sum + $val" | bc)
        ((count++))
    done
    printf "%.f" $(echo "scale=2; $sum / $count" | bc)
}
```
Fungsi untuk menghitung rata-rata. Mendeklarasikan variabel sum dan count dahulu secara lokal dan men-set nya ke angka 0. Lalu akan dilakukan loop untuk menjumlahkan nilai-nilai yang ada di dalam array. Variabel count digunakan untuk menghitung jumlah penjumlahan yang terjadi, sehingga secara tidak langsung dapat berguna untuk menghitung jumlah data yang ada di dalam array. Penghitungan rata-rata dilakukan dengan membagi sum (jumlah dari semua nilai dalam array) dengan count (banyaknya nilai yang ada dalam array).
```bash
mem_total_arr=($(echo "${mem_total_arr[@]}" | grep -o '[0-9]*'))
min_mem_total=$(calculate_min "${mem_total_arr[@]}")
max_mem_total=$(calculate_max "${mem_total_arr[@]}")
avg_mem_total=$(calculate_avg "${mem_total_arr[@]}")

mem_used_arr=($(echo "${mem_used_arr[@]}" | grep -o '[0-9]*'))
min_mem_used=$(calculate_min "${mem_used_arr[@]}")
max_mem_used=$(calculate_max "${mem_used_arr[@]}")
avg_mem_used=$(calculate_avg "${mem_used_arr[@]}")

mem_free_arr=($(echo "${mem_free_arr[@]}" | grep -o '[0-9]*'))
min_mem_free=$(calculate_min "${mem_free_arr[@]}")
max_mem_free=$(calculate_max "${mem_free_arr[@]}")
avg_mem_free=$(calculate_avg "${mem_free_arr[@]}")

mem_shared_arr=($(echo "${mem_shared_arr[@]}" | grep -o '[0-9]*'))
min_mem_shared=$(calculate_min "${mem_shared_arr[@]}")
max_mem_shared=$(calculate_max "${mem_shared_arr[@]}")
avg_mem_shared=$(calculate_avg "${mem_shared_arr[@]}")

mem_buff_arr=($(echo "${mem_buff_arr[@]}" | grep -o '[0-9]*'))
min_mem_buff=$(calculate_min "${mem_buff_arr[@]}")
max_mem_buff=$(calculate_max "${mem_buff_arr[@]}")
avg_mem_buff=$(calculate_avg "${mem_buff_arr[@]}")

mem_available_arr=($(echo "${mem_available_arr[@]}" | grep -o '[0-9]*'))
min_mem_available=$(calculate_min "${mem_available_arr[@]}")
max_mem_available=$(calculate_max "${mem_available_arr[@]}")
avg_mem_available=$(calculate_avg "${mem_available_arr[@]}")

swap_total_arr=($(echo "${swap_total_arr[@]}" | grep -o '[0-9]*'))
min_swap_total=$(calculate_min "${swap_total_arr[@]}")
max_swap_total=$(calculate_max "${swap_total_arr[@]}")
avg_swap_total=$(calculate_avg "${swap_total_arr[@]}")

swap_used_arr=($(echo "${swap_used_arr[@]}" | grep -o '[0-9]*'))
min_swap_used=$(calculate_min "${swap_used_arr[@]}")
max_swap_used=$(calculate_max "${swap_used_arr[@]}")
avg_swap_used=$(calculate_avg "${swap_used_arr[@]}")

swap_free_arr=($(echo "${swap_free_arr[@]}" | grep -o '[0-9]*'))
min_swap_free=$(calculate_min "${swap_free_arr[@]}")
max_swap_free=$(calculate_max "${swap_free_arr[@]}")
avg_swap_free=$(calculate_avg "${swap_free_arr[@]}")

path_size_arr=($(echo "${path_size_arr[@]}" | grep -o '[0-9]*'))
min_path_size=$(calculate_min "${path_size_arr[@]}")
max_path_size=$(calculate_max "${path_size_arr[@]}")
avg_path_size=$(calculate_avg "${path_size_arr[@]}")
```
Pada bagian ini, data yang ada di array akan diubah agar menjadi nilai numerik saja. Hal ini dilakukan agar perhitungan nilai maksimal, minimal, dan rata-rata dapat dilakukan. Setelah mengubahnya menjadi angka, dilakukan perhitungan nilai maksimal, minimal, dan rata-rata untuk masing-masing array dengan memanggil fungsi yang sudah dibuat pada bagian sebelumnya.
```bash
echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > "${log_dir}metrics_agg_${timestamp}.log"
echo "minimum,$min_mem_total,$min_mem_used,$min_mem_free,$min_mem_shared,$min_mem_buff,$min_mem_available,$min_swap_total,$min_swap_used,$min_swap_free,$log_dir,$min_path_size M" >> "${log_dir}metrics_agg_${timestamp}.log"
echo "maximum,$max_mem_total,$max_mem_used,$max_mem_free,$max_mem_shared,$max_mem_buff,$max_mem_available,$max_swap_total,$max_swap_used,$max_swap_free,$log_dir,$max_path_size M" >> "${log_dir}metrics_agg_${timestamp}.log"
echo "average,$avg_mem_total,$avg_mem_used,$avg_mem_free,$avg_mem_shared,$avg_mem_buff,$avg_mem_available,$avg_swap_total,$avg_swap_used,$avg_swap_free,$log_dir,$avg_path_size M" >> "${log_dir}metrics_agg_${timestamp}.log"
chmod 600 "$log_dir/metrics_agg_${current_hour}.log"
```
Mencetak informasi nilai maksimal, minimal, dan rata-rata pada masing-masing array sesuai dengan format yang telah ditentukan di soal. Chmod 600 berfungsi untuk mengatur akses file log agar hanya pemilik file yang dapat mengakses file tersebut. 
### Dokumentasi
Melihat perintah yang dijalankan oleh crontab untuk kedua script sh
<img width="547" alt="Screenshot 2024-03-29 at 22 39 03" src="https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/80509033/88628c11-ee8f-49a5-a7f1-391770eba927">

Output yang ditampilkan setelah kedua script dijalankan
<img width="800" alt="Screenshot 2024-03-29 at 22 38 50" src="https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/80509033/a2d2948a-b8d7-48a1-a6f6-6fe7be90e8d6">

Mengecek apakah user lain bisa mengakses file log atau tidak
<img width="637" alt="Screenshot 2024-03-29 at 22 38 37" src="https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/80509033/b88664ae-bc94-49cb-b907-5894b588eb58">

### Kendala yang dialami
1. Saat menggunakan code awal (sebelum revisi), perhitungan untuk nilai maksimum, minimum, dan rata-rata dilakukan secara bersamaan untuk semua variabel dengan cara menggabungkannya ke dalam sebuah array. Hal ini menyebabkan format isi file aggregate_minutes_to_hourly_log.sh tidak sesuai dengan ketentuan di soal.
2. Setelah menggunakan code yang sudah direvisi dan mencoba untuk menjalankannya, muncul pesan yang menunjukkan kesalahan. Namun ketika dicoba untuk menampilkan isi dari file log, outputnya baik-baik saja tanpa ada kesalahan.
<img width="813" alt="Screenshot 2024-03-29 at 23 54 44" src="https://github.com/nyy223/Sisop-1-2024-MH-IT01/assets/80509033/afd74b31-fc4b-4c31-b571-2e61c2c84584">


