#!/bin/bash
echo "(c) nullCore"
echo ""
echo "fetching Electrum"
sleep 0.5
wget https://download.electrum.org/4.5.8/electrum-4.5.8-x86_64.AppImage
echo "creating the executable.."
chmod +x electrum-4.5.8-x86_64.AppImage
echo "creating global alias.."
echo -e "\nalias 'Electrum'='./electrum-4.5.8-x86_64.AppImage'\nalias
'electrum'='./electrum-4.5.8-x86_64.AppImage'" >> ~/.bashrc
echo "alias Electrum|electrum can now be used to operate electrum wallet."
echo "fetching Onionshare GUI (for anonymous file sharing)"
flatpak remote-add --if-not-exists flathub
https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.onionshare.OnionShare
echo "Onionshare GUI installed."
echo "istalling Onionshare CLI"
sudo apt install tor python3-pip python3-stem
pip3 install --user onionshare-cli
export PATH="$HOME/.local/bin:$PATH"
echo "onionshare installed! run it by typing 'onionshare-cli help'"
echo "Downloading gocryptfs.."
sudo apt install gocryptfs
echo "creating folder.."
mkdir ~/nc-encrypted.cipher
mkdir ~/nc-encrypted
echo "mounting to ~/nc-encrypted.."
gocryptfs -init ~/nc-encrypted.cipher
echo "nc-e command will access these files."
echo "alias 'nc-e'='gocryptfs ~/nc-encrypted.cipher ~/nc-encrypted'" >> ~/.bashrc 
echo "installing Tor and Tor services.."
sudo apt install torbrowser-launcher -y
echo "tor browser installed."
echo "downloading tor system-wide VPN"
git clone https://github.com/Nekosune/torctl.git
cd torctl
sudo mv service/* /etc/systemd/system/
sed -i 's/TOR_UID="tor"/TOR_UID="debian-tor"/' torctl
sudo mv torctl /usr/local/bin/torctl
cd .. && rm -rf torctl
echo "starting routing.."
sudo torctl start
echo "creating persistent routing.."
sudo tee -a /etc/systemd/system/torctl-autostart.service > /dev/null << 'EOF'
[Unit]
Description=Start Torctl Transparent Proxy at Boot
After=network-online.target tor.service
Wants=network-online.target tor.service
[Service]
Type=oneshot
ExecStart=/usr/local/bin/torctl start
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target
EOF
echo "applying changes.."
sudo systemctl daemon-reload
echo "Tor set!"