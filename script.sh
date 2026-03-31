#!/bin/bash
# Log setup
LOG_FILE="/var/log/ubuntu_setup.log"
exec > >(tee -a "$LOG_FILE") 2>&1
exec 2>&1
echo "========== Ubuntu 20.04 System Setup Started =========="
# 1. Check for root permission
if [ "$EUID" -ne 0 ]; then
 echo "Please run as root or with sudo."
 exit 1
fi
# 2. Update system packages
echo "Updating system..."
sudo apt update -y
# 3. Install jq for JSON handling
echo "Installing jq..."
sudo apt install jq -y
# 4. Install htop
echo "Installing htop..."
sudo apt install htop -y
# 5. Install and configure OpenSSH Server
echo "Installing OpenSSH Server..."
sudo apt install openssh-server -y
sudo systemctl enable ssh
sudo systemctl start ssh
sudo ufw allow ssh
# 6. Install and configure XRDP
echo "Installing XRDP..."
sudo apt install xrdp -y
sudo systemctl enable xrdp
sudo systemctl start xrdp
sudo ufw allow 3389/tcp
# 8. Disable UFW firewall if enabled
echo "Checking UFW firewall..."
if sudo ufw status | grep -q "Status: active"; then
 echo "Disabling UFW firewall..."
 sudo ufw disable
else
 echo "UFW already disabled."
fi
# 7. Install and configure Mosquitto (MQTT Broker)
echo "Installing Mosquitto..."
sudo apt install mosquitto -y
sudo systemctl enable mosquitto
sudo systemctl start mosquitto

# 9. Install VLC
echo "Installing VLC Media Player..."
sudo apt install vlc -y
# 10. Install Google Chrome
echo "Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp/
sudo apt install /tmp/google-chrome-stable_current_amd64.deb -y
sudo rm /tmp/google-chrome-stable_current_amd64.deb
# 11. Install additional monitoring tools
echo "Installing system monitoring tools..."
sudo apt install glances net-tools lm-sensors nmon iotop sysstat -y
