#!/bin/bash

output_file="/home/gh/memory_swap_usage.log"

while true; do
  current_time=$(date +"%I:%M:%S %p")
  mem_usage=$(free -h | awk "/Mem:/ {print $3}")
  swap_usage=$(free -h | awk "/Swap:/ {print $3}")
  disk_usage=$(df -h / | awk "NR==2 {print $3}")

  echo "$current_time  mem: $mem_usage swap: $swap_usage disk: $disk_usage" >> $output_file

  sleep 1
done
