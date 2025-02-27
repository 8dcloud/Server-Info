#!/bin/sh
####################################################
# Script by cPFence Team, https://cpfence.app      #
# Modified by 8Dweb to show in GB                  # 
####################################################

mysql -e "show variables; show status" | awk '
{
VAR[$1]=$2
}
END {
MAX_CONN = VAR["max_connections"]
MAX_USED_CONN = VAR["Max_used_connections"]
BASE_MEM=VAR["key_buffer_size"] + VAR["query_cache_size"] + VAR["innodb_buffer_pool_size"] + VAR["innodb_additional_mem_pool_size"] + VAR["innodb_log_buffer_size"]
MEM_PER_CONN=VAR["read_buffer_size"] + VAR["read_rnd_buffer_size"] + VAR["sort_buffer_size"] + VAR["join_buffer_size"] + VAR["binlog_cache_size"] + VAR["thread_stack"] + VAR["tmp_table_size"] + VAR["max_heap_table_size"]
MEM_TOTAL_MIN=BASE_MEM + MEM_PER_CONN*MAX_USED_CONN
MEM_TOTAL_MAX=BASE_MEM + MEM_PER_CONN*MAX_CONN
printf "+------------------------------------------+--------------------+\n"
printf "| %40s | %15.3f GB |\n", "key_buffer_size", VAR["key_buffer_size"]/1073741824
printf "| %40s | %15.3f GB |\n", "query_cache_size", VAR["query_cache_size"]/1073741824
printf "| %40s | %15.3f GB |\n", "innodb_buffer_pool_size", VAR["innodb_buffer_pool_size"]/1073741824
printf "| %40s | %15.3f GB |\n", "innodb_additional_mem_pool_size", VAR["innodb_additional_mem_pool_size"]/1073741824
printf "| %40s | %15.3f GB |\n", "innodb_log_buffer_size", VAR["innodb_log_buffer_size"]/1073741824
printf "+------------------------------------------+--------------------+\n"
printf "| %40s | %15.3f GB |\n", "BASE MEMORY", BASE_MEM/1073741824
printf "+------------------------------------------+--------------------+\n"
printf "| %40s | %15.3f GB |\n", "sort_buffer_size", VAR["sort_buffer_size"]/1073741824
printf "| %40s | %15.3f GB |\n", "read_buffer_size", VAR["read_buffer_size"]/1073741824
printf "| %40s | %15.3f GB |\n", "read_rnd_buffer_size", VAR["read_rnd_buffer_size"]/1073741824
printf "| %40s | %15.3f GB |\n", "join_buffer_size", VAR["join_buffer_size"]/1073741824
printf "| %40s | %15.3f GB |\n", "thread_stack", VAR["thread_stack"]/1073741824
printf "| %40s | %15.3f GB |\n", "binlog_cache_size", VAR["binlog_cache_size"]/1073741824
printf "| %40s | %15.3f GB |\n", "tmp_table_size", VAR["tmp_table_size"]/1073741824
printf "| %40s | %15.3f GB |\n", "max_heap_table_size", VAR["max_heap_table_size"]/1073741824
printf "+------------------------------------------+--------------------+\n"
printf "| %40s | %15.3f GB |\n", "MEMORY PER CONNECTION", MEM_PER_CONN/1073741824
printf "+------------------------------------------+--------------------+\n"
printf "| %40s | %18d |\n", "Max_used_connections", MAX_USED_CONN
printf "| %40s | %18d |\n", "max_connections", MAX_CONN
printf "| %40s | %18d |\n", "max_user_connections", VAR["max_user_connections"]
printf "+------------------------------------------+--------------------+\n"
printf "| %40s | %18d |\n", "open_files_limit", VAR["open_files_limit"]
printf "| %40s | %18d |\n", "table_open_cache", VAR["table_open_cache"]
printf "| %40s | %18d |\n", "innodb_open_files", VAR["innodb_open_files"]
printf "| %40s | %18d |\n", "innodb_file_per_table", VAR["innodb_file_per_table"]
printf "+------------------------------------------+--------------------+\n"
printf "| %40s | %15.3f GB |\n", "TOTAL (MIN)", MEM_TOTAL_MIN/1073741824
printf "| %40s | %15.3f GB |\n", "TOTAL (MAX)", MEM_TOTAL_MAX/1073741824
printf "+------------------------------------------+--------------------+\n"
printf "| %40s | %18s |\n", "wait_timeout", VAR["wait_timeout"]
printf "| %40s | %18s |\n", "interactive_timeout", VAR["interactive_timeout"]
printf "+------------------------------------------+--------------------+\n"
}'
