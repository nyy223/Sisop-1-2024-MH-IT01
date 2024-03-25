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
