# System font fallback (not in $HOME):
sudo ln -sf /usr/share/fontconfig/conf.avail/10-nerd-font-symbols.conf /etc/fonts/conf.d/

# Login screen: SDDM + astronaut theme (post-apocalyptic_hacker)
sudo pacman -S sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg xorg-server sddm-astronaut-theme
printf "[Theme]\nCurrent=sddm-astronaut-theme\n" | sudo tee /etc/sddm.conf.d/theme.conf
sudo sed -i "s|^ConfigFile=.*|ConfigFile=Themes/post-apocalyptic_hacker.conf|" /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
sudo install -Dm644 ~/.face /usr/share/sddm/faces/nick.face.icon
sudo systemctl disable greetd; sudo systemctl enable sddm

# SDDM: restore custom preset (nick.conf)
sudo install -m644 ~/.config/sddm/nick.conf /usr/share/sddm/themes/sddm-astronaut-theme/Themes/nick.conf
sudo sed -i "s|^ConfigFile=.*|ConfigFile=Themes/nick.conf|" /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
