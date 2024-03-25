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
