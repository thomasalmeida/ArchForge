#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

log() {
    local level=$1
    local message=$2
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local formatted_message="${timestamp} [${level}] ${message}"

    # Console output with colors
    case $level in
        "INFO")     echo -e "${BLUE}${formatted_message}${NC}" ;;
        "SUCCESS")  echo -e "${GREEN}${formatted_message}${NC}" ;;
        "WARNING")  echo -e "${YELLOW}${formatted_message}${NC}" ;;
        "ERROR")    echo -e "${RED}${formatted_message}${NC}" ;;
    esac

    # Log to file
    echo "$formatted_message" >> "$ARCHFORGE_LOG"
}
