#!/usr/bin/env bash

IP_TO_BLOCK="192.81.241.171"
BLOCKED=false

while :; do
  echo "Press Enter to toggle block for $IP_TO_BLOCK"
  echo "Current state: $([ "$BLOCKED" = true ] && echo 'BLOCKED' || echo 'ALLOWED')"
  read -p "Press 1 + Enter to quit: " confirmation

  if [[ "$confirmation" == "1" ]]; then
    break
  fi

  if [ "$BLOCKED" = false ]; then
    echo "Blocking..."
    iptables -I OUTPUT -d "$IP_TO_BLOCK" -j DROP
    BLOCKED=true
  else
    echo "Allowing..."
    iptables -D OUTPUT -d "$IP_TO_BLOCK" -j DROP
    BLOCKED=false
  fi
done
