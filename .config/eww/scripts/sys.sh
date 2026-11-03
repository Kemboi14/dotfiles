#!/usr/bin/env bash
# Data feeds for the eww dashboard.
set -u
fmt() {
  local b=$1
  if (( b >= 1048576 )); then echo "$(( b / 1048576 )).$(( (b % 1048576) * 10 / 1048576 )) MB/s"
  elif (( b >= 1024 )); then echo "$(( b / 1024 )) KB/s"
  else echo "$b B/s"; fi
}
read_bytes() {
  local rx tx
  rx=$(cat "/sys/class/net/$1/statistics/rx_bytes" 2>/dev/null || echo 0)
  tx=$(cat "/sys/class/net/$1/statistics/tx_bytes" 2>/dev/null || echo 0)
  echo "$rx $tx"
}
case "${1:-}" in
  temp)
    for f in /sys/devices/platform/coretemp.0/hwmon/hwmon*/temp*_label; do
      if grep -q "Package" "$f"; then echo $(( $(cat "${f%_label}_input") / 1000 )); exit 0; fi
    done
    echo 0 ;;
  power)
    p=/sys/class/power_supply/BAT0/power_now
    if [[ -r $p ]]; then v=$(cat "$p"); echo "$(( v / 1000000 )).$(( (v / 100000) % 10 ))"; else echo 0; fi ;;
  uptime)
    uptime -p | cut -c4- ;;
  date)
    date "+%A, %d %B" ;;
  player)
    exec playerctl --follow metadata --format "{{ artist }} — {{ title }}" 2>/dev/null ;;
  net)
    while true; do
      iface=$(ip route show default 2>/dev/null | head -1 | cut -d" " -f5)
      if [[ -z $iface ]]; then
        echo "{\"iface\":\"offline\",\"down\":\"0 B/s\",\"up\":\"0 B/s\"}"; sleep 2; continue
      fi
      read -r rx1 tx1 <<< "$(read_bytes "$iface")"
      sleep 1
      read -r rx2 tx2 <<< "$(read_bytes "$iface")"
      echo "{\"iface\":\"$iface\",\"down\":\"$(fmt $(( rx2 - rx1 )))\",\"up\":\"$(fmt $(( tx2 - tx1 )))\"}"
    done ;;
  *) echo "usage: sys.sh temp|power|uptime|date|player|net" >&2; exit 1 ;;
esac
