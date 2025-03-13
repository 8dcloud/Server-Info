# ============================================
#  8Dweb LLC / mjs
#  WordPress Version Finder Script
#  Date: $(date +'%Y-%m-%d')
#
#  This script scans only 'httpdocs' and 'public_html' 
#  subdirectories inside /var/www for WordPress installations.
# ============================================

#!/bin/bash

# Function to get WordPress version
get_wp_version() {
    local wp_config="$1/wp-includes/version.php"
    if [ -f "$wp_config" ]; then
        grep "\$wp_version =" "$wp_config" | awk -F"'" '{print $2}'
    else
        echo "Unknown"
    fi
}

# Print header
printf "%-15s %-40s %-10s %-60s\n" "User" "Site" "Version" "Directory"
echo "$(printf -- '-%.0s' {1..130})"

# Initialize site counter
site_count=0

# Create a temporary file to store find output
temp_file=$(mktemp)
find /var/www -type d \( -name "httpdocs" -o -name "public_html" \) -exec find {} -maxdepth 1 -type f -name "wp-config.php" \; > "$temp_file"

# Read from temporary file
while IFS= read -r wp_config; do
    wp_dir=$(dirname "$wp_config")
    wp_version=$(get_wp_version "$wp_dir")
    site_name=$(basename "$(dirname "$wp_dir")")
    user=$(ls -ld "$wp_dir" | awk '{print $3}')

    printf "%-15s %-40s %-10s %-60s\n" "$user" "$site_name" "$wp_version" "$wp_dir"
    site_count=$((site_count+1))
done < "$temp_file"

# Remove temporary file
rm -f "$temp_file"

# Print total count
echo "$(printf -- '-%.0s' {1..130})"
echo "Total WordPress sites found: $site_count"
