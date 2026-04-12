#!/bin/bash
# Pick one random fastfetch quote from the local quotes file.

# Set the random quote in the $RAND variable
RAND=$(shuf -n 1 "$HOME/.config/fastfetch/lines.txt")

# Output the value of $RAND
echo "$RAND"