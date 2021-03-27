#!/usr/bin/bash

echo "Confirm the operation"

diorite --primary-text="Permanently delete \"/usr\"?" \
        --secondary-text="This operation is not reversible." \
        --image-icon-name="dialog-warning" \
        --ok-text="Delete" \
        --destructive
