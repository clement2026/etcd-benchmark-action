apt-get update && apt install -y npm bash-completion

sudo useradd -m gh && sudo mkdir -p /home/gh/.ssh && sudo cp ~/.ssh/authorized_keys /home/gh/.ssh/ && sudo chown -R gh:gh /home/gh/.ssh && sudo chmod 700 /home/gh/.ssh && sudo chmod 600 /home/gh/.ssh/authorized_keys

sudo adduser gh sudo
echo "gh ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

sudo usermod -s /bin/bash gh
sudo cp .bashrc /home/gh/.bashrc
sudo chown gh:gh /home/gh/.bashrc
echo "source ~/.bashrc" | sudo tee -a /home/gh/.bash_profile
sudo chown gh:gh /home/gh/.bash_profile

crontab -e
@reboot /home/gh/actions-runner/run.sh
@reboot echo "$(TZ=Asia/Singapore date)" >> /home/gh/reboot.log
@reboot touch /home/gh/monitor && while inotifywait -r /home/gh/monitor -e create,delete,modify; do { echo "reboot in 15s" && sleep 15 && sudo reboot; }; done


echo 'ACTIONS_RUNNER_HOOK_JOB_COMPLETED=/home/gh/cleanup.sh' > actions-runner/.env
echo 'echo "$(TZ=Asia/Singapore date) change /home/gh/monitor" | tee >> /home/gh/monitor' > cleanup.sh
chmod a+x cleanup.sh


# login to new user now

follow https://github.com/clement2026/etcd-benchmark-action/settings/actions/runners/new?arch=x64&os=linux

