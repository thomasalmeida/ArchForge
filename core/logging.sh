#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    local level=$1
    local message=$2
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    case $level in
        "INFO") echo -e "${BLUE}${timestamp} [INFO] ${message}${NC}" ;;
        "SUCCESS") echo -e "${GREEN}${timestamp} [SUCCESS] ${message}${NC}" ;;
        "WARNING") echo -e "${YELLOW}${timestamp} [WARNING] ${message}${NC}" ;;
        "ERROR") echo -e "${RED}${timestamp} [ERROR] ${message}${NC}" ;;
    esac

    echo "${timestamp} [${level}] ${message}" >> "/var/log/archforge.log"
}
