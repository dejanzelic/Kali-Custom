#!/bin/bash

#set Gnome Extension settings:

echo "==Setting Gnome Extensions==";
gsettings set org.gnome.shell enabled-extensions "['apps-menu@gnome-shell-extensions.gcampax.github.com', 'places-menu@gnome-shell-extensions.gcampax.github.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com', 'ProxySwitcher@flannaghan.com', 'EasyScreenCast@iacopodeenosee.gmail.com', 'refresh-wifi@kgshank.net', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'window-list@gnome-shell-extensions.gcampax.github.com', 'alternate-tab@gnome-shell-extensions.gcampax.github.com']";
echo "..done";

#set Gnome Workspace settings:
echo "==Changing Workspace Settings==";
gsettings set org.gnome.shell.overrides dynamic-workspaces 'false';
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4;
echo "..done";

#set Gnome Desktop Icons
echo "==Changing Desktop Settings==";
gsettings set org.gnome.nautilus.desktop trash-icon-visible true;
gsettings set org.gnome.nautilus.desktop home-icon-visible true;
echo "..done"

#set Gnome Time Settings
echo "==Changing Top Bar Settings=="
gsettings set org.gnome.desktop.interface clock-show-date true;
gsettings set org.gnome.desktop.interface clock-show-seconds true;
echo "..done"

#set Favorites
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'gnome-terminal.desktop', 'org.gnome.Screenshot.desktop', 'iceweasel.desktop', 'chromium.desktop', 'burp-pro.desktop', 'wireshark.desktop', 'org.gnome.gedit.desktop', 'gnome-tweak-tool.desktop']";

#set Keybindings

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'screenshot'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-screenshot -i'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary><Alt>s'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command '/usr/bin/gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Super>t'

#set "software" to "Do not run"
gsettings set org.gnome.desktop.media-handling autorun-x-content-start-app '@as []';

#set screenlock
gsettings get org.gnome.desktop.screensaver lock-delay 'uint32 1800';

#set ssh on boot
systemctl enable ssh;

#Install Fish
apt-get --assume-yes install fish
chsh -s /usr/bin/fish
mkdir -p ~/.config/fish
echo "set -g -x PATH /usr/local/bin $PATH" > ~/.config/fish/config.fish
fish -c fish_update_completions

##Install fisher
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher

##Install fzf
fish -c "fisher fzf"

##Install OMF
curl -L http://get.oh-my.fish | fish

##Install Burp StartUp Script
echo "[+] Installing burp start up script into ~/Resources"
mkdir ~/Resources
echo "#!/bin/bash
java -jar -server -Xms512m -Xmx4g -XX:-DisableExplicitGC -XX:+UseTLAB -XX:+UseThreadPriorities -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -XX:+UseLargePages -XX:+OptimizeStringConcat -XX:ReservedCodeCacheSize=96m -XX:+UseCodeCacheFlushing -XX:+UseG1GC -XX:UseSSE=4 -XX:+UseStringDeduplication burpsuite.jar" > ~/Resources/start_burp.sh
chmod +x ~/Resources/start_burp.sh
