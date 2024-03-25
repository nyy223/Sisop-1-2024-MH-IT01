#!/bin/bash
# * * * * * /home/nayla/minute_log.sh

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

target_path="/home/$(whoami)/log"
mkdir -p "$target_path"
dir_size=$(du -sh "$target_path" | awk '{print $1}')

current_time=$(date "+%Y%m%d%H%M%S")

echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" >> "/home/$(whoami)/log/metrics_$current_time.log"
echo "$ram_metrics,$target_path,$dir_size" >> "/home/$(whoami)/log/metrics_$current_time.log"
chmod 600 /home/$(whoami)/log/metrics_$current_time.log
