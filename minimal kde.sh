#!/bin/bash

set -x;

sudo apt-get update -yq

packages=(
  # can I haz sandwich?
  aspell-en
  hunspell-en-us
  hyphen-en-us

  aspell-pt-br
  hunspell-pt-br
  hyphen-pt-br

  # Apps
  ark
  btrfs-progs
  dolphin
  gwenview
  kate
  kde-spectacle
  kmenuedit
  konsole
  neofetch
  okular
  qml-module-org-kde-newstuff
  systemsettings

  # Services
  alsa-util
  bluedevil
  khotkeys
  kscreen
  kwalletmanager
  plasma-nm
  plasma-pa
  powerdevil
  polkit-kde-agent-1
  upower

  # DE
  kwin-x11
  plasma-desktop
  plasma-workspace
  sddm
  xorg

  # Theming
  breeze-gtk-theme
  kde-config-gtk-style
  kde-config-gtk-style-preview
  sddm-theme-breeze

  # Libs and Plugins
  libqtspell-qt5-0
  qtvirtualkeyboard-plugin
  plasma-browser-integration
  plasma-runners-addons
  pulseaudio-module-bluetooth
  apt-transport-https
  # Ark tooling
  unzip
)

arguments=(
   -y
   -q
  --no-install-recommends
)

sudo apt-get install "${arguments[@]}" "${packages[@]}"