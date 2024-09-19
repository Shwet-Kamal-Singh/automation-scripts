#!/bin/bash

# Function to display usage examples
show_examples() {
    echo "Examples:"
    echo "  Daily:   0 2 * * * /path/to/your/script.sh"
    echo "  Weekly:  0 2 * * 0 /path/to/your/script.sh"
    echo "  Monthly: 0 2 1 * * /path/to/your/script.sh"
}

# Function to schedule the cron job
schedule_cron_job() {
    local schedule="$1"
    local script_path="$2"
    (crontab -l 2>/dev/null; echo "$schedule $script_path") | crontab -
    echo "Cron job scheduled: $schedule $script_path"
}

# Ask for the script path
read -p "Enter the full path of the script to automate: " script_path

# Ask for the schedule type
echo "When do you want the script to run?"
echo "1) Daily"
echo "2) Weekly"
echo "3) Monthly"
read -p "Enter your choice (1/2/3): " choice

# Determine the cron schedule based on user input
case $choice in
    1)
        schedule="0 2 * * *"
        ;;
    2)
        schedule="0 2 * * 0"
        ;;
    3)
        schedule="0 2 1 * *"
        ;;
    *)
        echo "Invalid choice. Please run the script again and select a valid option."
        exit 1
        ;;
esac

# Show examples to the user
show_examples

# Confirm and schedule the cron job
read -p "Do you want to schedule this cron job? (y/n): " confirm
if [[ $confirm == "y" || $confirm == "Y" ]]; then
    schedule_cron_job "$schedule" "$script_path"
else
    echo "Cron job not scheduled."
fi