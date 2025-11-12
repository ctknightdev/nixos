#!/usr/bin/env bash
# Temporary private lobby script for Red Dead Online

echo "🤠 Starting Red Dead Online private lobby..."

# Function to cleanup firewall rules
cleanup() {
  echo "🧹 Cleaning up firewall rules..."
  sudo iptables -D OUTPUT -p udp --dport 6672 -j DROP 2>/dev/null
  sudo iptables -D OUTPUT -p udp --dport 61455:61458 -j DROP 2>/dev/null
  sudo iptables -D INPUT -p udp --dport 6672 -j DROP 2>/dev/null
  sudo iptables -D INPUT -p udp --dport 61455:61458 -j DROP 2>/dev/null
  echo "✅ Private lobby disabled"
  exit 0
}

# Set trap to cleanup on exit
trap cleanup EXIT INT TERM

# Add firewall rules
echo "🔒 Blocking Red Dead Online matchmaking ports..."
sudo iptables -A OUTPUT -p udp --dport 6672 -j DROP
sudo iptables -A OUTPUT -p udp --dport 61455:61458 -j DROP
sudo iptables -A INPUT -p udp --dport 6672 -j DROP
sudo iptables -A INPUT -p udp --dport 61455:61458 -j DROP

echo "✅ Private lobby active! Launch Red Dead Online now."
echo "Press Ctrl+C to disable private lobby and restore normal connectivity."

# Keep script running
while true; do
    sleep 1
done
