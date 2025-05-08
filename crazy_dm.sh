#!/bin/bash

# Developer: https://github.com/rezaAdinepour

display_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h, --help       Show this help message"
    echo "  -t, --time       Set download time in HH:MM format"
    echo "  -l, --links      Path to file containing download links (one per line)"
    echo "  -d, --directory  Set download directory (default: current directory)"
    echo "  -o, --log        Set log file path (default: download_log.txt in download directory)"
    exit 0
}


calculate_remaining_time() {
    local target_hour=$1
    local target_min=$2
    local current_hour=$(date +%H)
    local current_min=$(date +%M)
    
    local target_total=$((target_hour * 60 + target_min))
    local current_total=$((current_hour * 60 + current_min))
    
    if [ $target_total -gt $current_total ]; then
        echo $((target_total - current_total))
    else
        echo $(( (24*60 - current_total) + target_total ))
    fi
}


DOWNLOAD_DIR=$(pwd)
LOG_FILE="$DOWNLOAD_DIR/download_log.txt"
LINKS_FILE=""


while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            display_help
            ;;
        -t|--time)
            shift
            IFS=':' read -r inp_hour inp_minute <<< "$1"
            ;;
        -l|--links)
            shift
            LINKS_FILE="$1"
            ;;
        -d|--directory)
            shift
            DOWNLOAD_DIR="$1"
            ;;
        -o|--log)
            shift
            LOG_FILE="$1"
            ;;
        *)
            echo "Unknown option: $1"
            display_help
            ;;
    esac
    shift
done

# If no arguments provided, ask interactively
if [ -z "$inp_hour" ] || [ -z "$inp_minute" ]; then
    read -p "Please Enter Hour (HH): " inp_hour
    read -p "Please Enter Minute (MM): " inp_minute
fi

# Validate time input
if ! [[ "$inp_hour" =~ ^[0-9]+$ ]] || [ "$inp_hour" -gt 23 ]; then
    echo "Error: Invalid hour (must be 0-23)"
    exit 1
fi

if ! [[ "$inp_minute" =~ ^[0-9]+$ ]] || [ "$inp_minute" -gt 59 ]; then
    echo "Error: Invalid minute (must be 0-59)"
    exit 1
fi

# Get links if not provided via file
if [ -z "$LINKS_FILE" ]; then
    echo "Enter download links (one per line, press Ctrl+D when done):"
    LINKS=$(cat)
else
    if [ ! -f "$LINKS_FILE" ]; then
        echo "Error: Links file not found: $LINKS_FILE"
        exit 1
    fi
    LINKS=$(cat "$LINKS_FILE")
fi

# Validate we have links
if [ -z "$LINKS" ]; then
    echo "Error: No download links provided"
    exit 1
fi

# Create download directory if it doesn't exist
mkdir -p "$DOWNLOAD_DIR" || {
    echo "Error: Cannot create download directory: $DOWNLOAD_DIR"
    exit 1
}

# Create log file directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")" || {
    echo "Error: Cannot create directory for log file: $(dirname "$LOG_FILE")"
    exit 1
}

log_message() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $1" | tee -a "$LOG_FILE"
}

log_message "Script started - Scheduled for $inp_hour:$inp_minute"

# Wait until the scheduled time using fixed calculation
remaining=$(calculate_remaining_time $inp_hour $inp_minute)
while [ $remaining -gt 0 ]; do
    log_message "Waiting for scheduled time... $remaining minutes remaining"
    sleep 60
    remaining=$(calculate_remaining_time $inp_hour $inp_minute)
done

log_message "Download Started..."
success_count=0
fail_count=0


while IFS= read -r url; do
    # Skip empty lines
    if [ -z "$url" ]; then
        continue
    fi
    
    log_message "Downloading: $url"
    
    filename=$(basename "$url")
    
    if wget -q --show-progress -P "$DOWNLOAD_DIR" "$url"; then
        log_message "Successfully downloaded: $filename"
        ((success_count++))
    else
        log_message "Failed to download: $filename"
        ((fail_count++))
    fi
done <<< "$LINKS"

sys_hour=$(date +%H)
sys_minute=$(date +%M)
status_message="Download completed at $sys_hour:$sys_minute - $success_count succeeded, $fail_count failed"

log_message "$status_message"

if command -v notify-send &> /dev/null; then
    if [ "$fail_count" -eq 0 ]; then
        notify-send "Download Complete" "$status_message"
    else
        notify-send "Download Completed with Errors" "$status_message"
    fi
fi

exit 0
