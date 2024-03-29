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
