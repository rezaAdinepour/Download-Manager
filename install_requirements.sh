#!/bin/bash

# Requirements installer for download_scheduler

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${YELLOW}Warning: Not running as root. Some installations may require sudo privileges.${NC}"
fi

# Function to check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check and install wget
if ! command_exists wget; then
  echo -e "${YELLOW}Installing wget...${NC}"
  if command_exists apt-get; then
    sudo apt-get update && sudo apt-get install -y wget
  elif command_exists yum; then
    sudo yum install -y wget
  elif command_exists brew; then
    brew install wget
  else
    echo -e "${RED}Error: Could not detect package manager to install wget${NC}"
    exit 1
  fi
  echo -e "${GREEN}wget installed successfully${NC}"
else
  echo -e "${GREEN}wget is already installed${NC}"
fi

# Check and install libnotify-bin (for notify-send)
if [ "$(uname)" == "Linux" ]; then
  if ! command_exists notify-send; then
    echo -e "${YELLOW}Installing libnotify-bin for desktop notifications...${NC}"
    if command_exists apt-get; then
      sudo apt-get install -y libnotify-bin
    elif command_exists yum; then
      sudo yum install -y libnotify
    else
      echo -e "${YELLOW}Could not install notify-send automatically. You may need to install it manually for desktop notifications.${NC}"
    fi
    echo -e "${GREEN}notify-send installed successfully${NC}"
  else
    echo -e "${GREEN}notify-send is already installed${NC}"
  fi
else
  echo -e "${YELLOW}Desktop notifications (notify-send) are only available on Linux${NC}"
fi

echo -e "\n${GREEN}All requirements checked!${NC}"
