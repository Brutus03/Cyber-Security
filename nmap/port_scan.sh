#!/bin/bash

function target_setting ($1)
{
  if [[ -z "$1" ]]
  then
    ip=localhost
  else
    ip="$1"
  fi
}

function check_nmap ()
{
  which nmap > /dev/null
  if [[ ! $? -eq 0 ]]
  then
    echo -e "\e[00;31mnmap is not included\e[00m"
    exit 1
  fi
}

function menu ()
{
  clear
  echo -e "\n\e[00;31m##################\e[00m" 
  echo -e "\e[00;31m#\e[00m" "\e[00;33mPort scan tool\e[00m" "\e[00;31m#\e[00m"
  echo -e "\e[00;31m##################\e[00m"
  echo " *Detailed scan :1"
  echo " *Full scan     :2"
  echo -e "\n"
  echo -e " \e[00;33m***Select scanning method by number***\e[00m"
}

function detailed_scan ()
{
  ports=$(nmap -p- --min-rate=1000 -T4 "${ip}" | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)
  nmap -sC -sV -p$ports "${ip}"

  if [[ $? -eq 0 ]]
  then
    echo -e "\e[00;32mScan completed\e[00m"
  else
    echo -e "\e[00;31mIgnore ICMP and try again\e[00m"
    nmap -Pn "${ip}"
  fi
}

function full_scan ()
{
  nmap -Pn -p- "${ip}"
}

menu
read how_to_scan
check_nmap
target_setting

case "${how_to_scan}" in
  1)
    detailed_scan
    ;;
  2) 
    full_scan
    ;;
esac
