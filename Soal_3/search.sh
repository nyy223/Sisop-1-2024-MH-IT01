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
