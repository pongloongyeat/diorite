#!/usr/bin/bash

echo "Show a simple message to the user after some operations".

sleep 3

diorite --primary-text="It looks like the script file is done running!" \
        --secondary-text="You may now resume whatever you were doing." \
        --image-icon-name="process-completed"
