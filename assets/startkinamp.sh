#!/bin/sh

is_process_running() {
    local process_name="$1"
    pgrep "$process_name" > /dev/null 2>&1
}

# Check if KinAMP is running in background
if is_process_running "KinAMP-minimal"; then
    echo "Kinamp is running in background. Stopping it..."
    pkill "KinAMP-minimal"
    sleep 2
    if is_process_running "KinAMP-minimal"; then
        echo "Process didn't terminate gracefully. Force killing..."
        pkill -9 "KinAMP_minimal"
    fi
    # Display pillow dialog
    lipc-set-prop com.lab126.pillow customDialog '{"name": "dialogs/stopping", "clientParams": {"dismiss": true}}'
else
    echo "Starting KinAMP GUI..."
    cd /nmt/us/KinAMP
    ./KinAMP
    exit_code=$?
    
    # Check if exit code is 10
    if [ $exit_code -eq 10 ]; then
        # Pillow dialog
        lipc-set-prop com.lab126.pillow customDialog '{"name": "dialogs/background", "clientParams": {"dismiss": true}}'
        ./KinAMP-minimal &
    fi
fi
