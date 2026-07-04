#!/usr/bin/env bash

# Method with common commands
#   Searches all processes, removes grep from list, gets pid, passes to kill
#ps aux | grep noctalia | grep -v grep | awk {'print $2'} | xargs kill

# Much nicer method
#   Returns pid and passes to `kill`
# pgrep -f noctalia | xargs kill
pgrep -f noctalia | xargs kill

sleep .5s

# Start noctalia in background
#   Redirects stdout to /dev/null, and stderr to stdout
#   (prevents printing in terminal)
noctalia > /dev/null 2>&1 &
