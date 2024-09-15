apt-get update && apt install -y npm bash-completion emacs

sudo useradd -m gh && sudo mkdir -p /home/gh/.ssh && sudo cp ~/.ssh/authorized_keys /home/gh/.ssh/ && sudo chown -R gh:gh /home/gh/.ssh && sudo chmod 700 /home/gh/.ssh && sudo chmod 600 /home/gh/.ssh/authorized_keys

sudo adduser gh sudo
echo "gh ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

sudo usermod -s /bin/bash gh
sudo cp .bashrc /home/gh/.bashrc
sudo chown gh:gh /home/gh/.bashrc
echo "source ~/.bashrc" | sudo tee -a /home/gh/.bash_profile
echo "export EDITOR='emacs'" | sudo tee -a /home/gh/.bash_profile
sudo chown gh:gh /home/gh/.bash_profile


# login to new user now
follow https://github.com/clement2026/etcd-benchmark-action/settings/actions/runners/new?arch=x64&os=linux


echo 'ACTIONS_RUNNER_HOOK_JOB_COMPLETED=/home/gh/cleanup.sh' > actions-runner/.env
echo 'echo "$(TZ=Asia/Singapore date) change /home/gh/monitor" | tee >> /home/gh/monitor' > cleanup.sh
chmod a+x cleanup.sh

echo '#!/bin/bash

      output_file="/home/gh/memory_swap_usage.log"

      while true; do
        current_time=$(date +"%I:%M:%S %p")
        mem_usage=$(free -h | awk "/Mem:/ {print $3}")
        swap_usage=$(free -h | awk "/Swap:/ {print $3}")
        disk_usage=$(df -h / | awk "NR==2 {print $3}")

        echo "$current_time  mem: $mem_usage swap: $swap_usage disk: $disk_usage" | tee >> $output_file

        sleep 1
      done
' > record-memory.sh
chmod a+x record-memory.sh


crontab -e

@reboot /home/gh/record-memory.sh
@reboot /home/gh/actions-runner/run.sh
@reboot echo "$(TZ=Asia/Singapore date)" >> /home/gh/reboot.log
@reboot touch /home/gh/monitor && while inotifywait -r /home/gh/monitor -e create,delete,modify; do { echo "reboot in 15s" && sleep 15 && sudo reboot; }; done

sudo reboot