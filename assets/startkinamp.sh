#!/bin/sh

is_process_running() {
    local process_name="$1"
    pgrep -x "$process_name" > /dev/null 2>&1
}

# Check if process 'foo' is running
if is_process_running "KinAMP_minimal"; then
    echo "Kinamp is running in background. Stopping it..."
    pkill -x "KinAMP_minimal"
    sleep 2
    if is_process_running "KinAMP_minimal"; then
        echo "Process didn't terminate gracefully. Force killing..."
        pkill -9 -x "KinAMP_minimal"
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
        ./KinAMP_minimal &
    fi
fi
