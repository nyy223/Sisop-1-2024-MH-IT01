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

# Kategorisasi admin
if echo "$email" | grep -q "admin"; then
    role="admin"
else
    role="user"
fi

echo "$email:$username:$security_question:$security_answer:$password_hash:$role" >> users.txt

echo "Registrasi berhasil!"
log_message "REGISTER SUCCESS" "User with email $email registered successfully."
