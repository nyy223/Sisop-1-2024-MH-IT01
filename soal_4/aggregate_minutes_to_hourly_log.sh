#!/bin/bash
#0 * * * * /home/nayla/aggregate_minutes_to_hourly_log.sh

log_dir="/home/$(whoami)/log/"

timestamp=$(date "+%Y%m%d%H")

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

calculate_min() {
    echo "$@" | tr ' ' '\n' | sort -n | head -n1
}

calculate_max() {
    echo "$@" | tr ' ' '\n' | sort -rn | head -n1
}

calculate_avg() {
    local sum=0
    local count=0
    for val in $@; do
        sum=$(echo "$sum + $val" | bc)
        ((count++))
    done
    printf "%.f" $(echo "scale=2; $sum / $count" | bc)
}

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

echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > "${log_dir}metrics_agg_${timestamp}.log"
echo "minimum,$min_mem_total,$min_mem_used,$min_mem_free,$min_mem_shared,$min_mem_buff,$min_mem_available,$min_swap_total,$min_swap_used,$min_swap_free,$log_dir,$min_path_size M" >> "${log_dir}metrics_agg_${timestamp}.log"
echo "maximum,$max_mem_total,$max_mem_used,$max_mem_free,$max_mem_shared,$max_mem_buff,$max_mem_available,$max_swap_total,$max_swap_used,$max_swap_free,$log_dir,$max_path_size M" >> "${log_dir}metrics_agg_${timestamp}.log"
echo "average,$avg_mem_total,$avg_mem_used,$avg_mem_free,$avg_mem_shared,$avg_mem_buff,$avg_mem_available,$avg_swap_total,$avg_swap_used,$avg_swap_free,$log_dir,$avg_path_size M" >> "${log_dir}metrics_agg_${timestamp}.log"
chmod 600 "$log_dir/metrics_agg_${current_hour}.log"
