#!/bin/bash
flatpak run org.vinegarhq.Sober $@ &
sleep 2s

log_file="$HOME/.var/app/org.vinegarhq.Sober/data/sober/sober_logs/latest.log" 

tail -n 0 -F "$log_file" | while read -r line; do
    if [[ -z $(pidof sober) ]]; then break; fi
    
    if [[ "$line" == *"[FLog::SingleSurfaceApp] leaveUGCGameInternal"* ]]; then
        kill $(pidof sober)
        break
    fi
done
