#!/bin/bash

# Download file genshin.zip
wget -O genshin.zip  --no-check-certificate -r 'https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'

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

file_csv="list_character.csv"

# Bersihkan data dan olah dengan awk
sed 's/\r//' "$file_csv" | awk -F, 'NR > 1 {gsub(/^ +| +$/, "", $4); count[$4]++} END {for (weapon in count) print weapon " = " count[weapon]}'

# Hapus file zip dan CSV yang tidak lagi dibutuhkan
rm -f genshin.zip genshin_character.zip list_character.csv

echo "File sudah di dekode dan terorganisir, file zip dan csv juga sudah dihapus."
