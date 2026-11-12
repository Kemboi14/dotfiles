#!/usr/bin/env bash
# Feeds the eww dynamic island. Usage: island.sh music
set -u
cache="${XDG_CACHE_HOME:-$HOME/.cache}/island"
mkdir -p "$cache"

json_escape() {
  local s=${1//\\/\\\\}
  s=${s//\"/\\\"}
  printf '%s' "$s"
}

art_path() {
  local url=$1 f
  case $url in
    file://*) printf '%s' "${url#file://}" ;;
    http://*|https://*)
      f="$cache/$(printf '%s' "$url" | md5sum | cut -c1-16).img"
      [[ -s $f ]] || curl -fsSL --max-time 5 -o "$f" "$url" 2>/dev/null
      [[ -s $f ]] && printf '%s' "$f" ;;
  esac
}

emit() {
  printf '{"status":"%s","title":"%s","artist":"%s","art":"%s"}\n' \
    "${1:-Stopped}" "$(json_escape "$2")" "$(json_escape "$3")" "$(json_escape "$4")"
}

case "${1:-}" in
  music)
    emit "Stopped" "" "" ""
    playerctl --follow metadata --format $'{{status}}\t{{artist}}\t{{title}}\t{{mpris:artUrl}}' 2>/dev/null |
      while IFS=$'\t' read -r status artist title url; do
        emit "$status" "$title" "$artist" "$(art_path "$url")"
      done ;;
  *) echo "usage: island.sh music" >&2; exit 1 ;;
esac
