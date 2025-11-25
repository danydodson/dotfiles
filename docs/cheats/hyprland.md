# --- // DEPS:
yay -S gdb ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus hyprlang hyprcursor

# --- // PKGS_I_FOUND_NECCESARY_TO_WORK_TOGETHER:
[[ -f wayfire-desktop ]] && source xdg-desktop-portal-hyprland-git 
 
# --- AUR:
hyprland-git (AUR) - compiles from latest source
hyprland - binary x86 tagged release

# --- BUILD_FROM_SOURCE:
#with cmake
git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all && sudo make install
#wih meson
meson subprojects update --reset
meson setup build
ninja -C build
ninja -C build install --tags runtime,man

# --- // PERMISSIONS:
sudo chmod 777 usr/lib/libwayland-client.so.0 /usr/lib/libwayland-cursor.so /usr/lib/libwayland-cursor.so.0 /usr/lib/libwayland-egl.so /usr/lib/libwayland-egl.so.1 /usr/lib/libwayland-server.so /usr/lib/libwayland-server.so.0

# --- // MYPRPM_REPO:
hyprpm add https://github.com/hyprwm/hyprland-plugins

Resolve errors about headers, clone hyprland, checkout to your version, build hyprland, 
and run sudo make installheaders. Then build your plugin(s).
To load plugins manually, use hyprctl plugin load path !NOTE: Path HAS TO BE ABSOLUTE!
You can unload plugins with hyprctl plugin unload path.
