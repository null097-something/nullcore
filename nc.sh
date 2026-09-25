#!/bin/bash

packages=("figlet", "lolcat", "pv")

for package in "${packages[@]}"; do
    command -v "$package" || pacman -S "$package" || apk add "$package" || apt install "$package" || dnf install "$package" || zypper install "$package" || emerge "$package" || xbps-install "$package" || nix-env -iA "nixpkgs.$package"
done

#define colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; BLUE='\033[0;34m'; PURPLE='\033[0;35m'; CYAN='\033[0;36m'; RESET='\033[0m'
clear
NAME="nullCore"
#cmd handler name
CMDH="NC"
CREDITS="made by Null"

echo -e -n "${RED}"
figlet "${NAME}"
echo -n -e "${RESET}"


while true; do
  echo -e -n "${BLUE}"

  #options go here

  echo "0. ping"
  echo "1. ping tool"
  echo "2. fake boot seq."
  echo "3. $SHELL"

  #exit and extras

  echo ""
  echo ""
  echo -e "${RED}exit${RESET}"
  echo -e "${RED}extra${RESET}"
  echo ""
  echo ""
  echo -n -e "${RESET}"
  echo -n "{multi-tool} "
  read cmd




  case "$cmd" in
    0)
      echo -n -e "[${CMDH}]: ${RED}"
      echo -e "pong!${RESET}"
      ;;
    1)
      echo -n -e "${RED}[${CMDH}]: "
      echo -n -e "enter target: "
      read target
      echo -n -e "enter count: ${RESET}"
      read count
      echo -n -e "${GREEN}"
      ping -A -c $count $target
      echo -n -e "${RESET}"
      ;;
    2)
      echo -e -n "${RED}[$CMDH]: "
      echo -e "password may be requested.${RESET}"
      clear
      echo -e -n "${GREEN}"
      echo "sudo cat /var/log/boot.log | head -n 10000 | pv -q -L 1000 | grep 'OK'" | bash
      echo -e -n "${RESET}"
      ;;
    3)
      echo "welcome to ${NAME}'s $SHELL emulator."
      echo -e "${RED}[$CMDH]: use end to exit.${GREEN}"
      while true; do
        echo -e -n "${GREEN}[$SHELL]: "
        read ECMD
        case "$ECMD" in
          *)
            echo "$ECMD" | bash 2>/dev/null || sh 2>/dev/null || echo "shell unsupported"
            ;;
          end)
            break
            ;;
        esac
      done
      ;;
    exit)
      break
      ;;

    extra)
      echo -e "${RED}help${RESET}"
      echo -e "${RED}template credits${RESET}"
      echo -e "${RED}credits${RESET}"
      echo -n "$option: " | lolcat
      read option
      case "$option" in
        help)
          echo "run them and find out lmao"
          ;;
        "template credits")
          echo "Made Originally by Null (something)"
          ;;
        credits)
          echo "${CREDITS}"
          ;;
        *)
          echo -n -e "[${CMDH}]: ${RED}"
          echo -e "Unknown option.${RESET}"
          ;;
      esac
      ;;
    *)
      echo -n -e "[${CMDH}]: ${RED}"
      echo -e "Unknown command.${RESET}"
      ;;
  esac
done
