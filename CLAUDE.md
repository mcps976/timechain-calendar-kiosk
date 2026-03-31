# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Raspberry Pi kiosk configuration project** — not a traditional software project. There is no build system, package manager, or test suite. The entire project consists of shell scripts and configuration files that set up a Raspberry Pi 4 to display the [Timechain Calendar](https://timechaincalendar.com) (a Bitcoin block time calendar) on a 3.5" touchscreen in full-screen kiosk mode.

## Installation

The primary artifact is `install.sh`, which is run directly on a Raspberry Pi:

```bash
chmod +x install.sh
./install.sh
```

This script must be run on the target hardware — there is no local development build step.

## Architecture

The system works as a layered stack:

1. **Hardware**: Raspberry Pi 4 + 3.5" SPI TFT LCD (ILI9486 display driver, XPT2046 touch controller)
2. **OS**: Raspberry Pi OS Bookworm 32-bit (Trixie/64-bit are explicitly incompatible)
3. **Display driver**: `piscreen` kernel overlay via SPI, configured in `/boot/firmware/config.txt`
4. **Touch input**: `evdev` X11 driver reading from `/dev/input/event0`
5. **Desktop**: LXDE with lightdm auto-login (user-session must be `LXDE`, not `LXDE-pi-labwc`)
6. **Kiosk**: Chromium launched via `~/.config/lxsession/LXDE/autostart` with `--kiosk --app=URL` flags

**Boot sequence**: Pi boots → lightdm auto-logins → LXDE starts → autostart runs → Chromium opens in kiosk mode displaying the calendar URL.

## Key Configuration Files

These are the files installed/modified by `install.sh` on the target device:

| File | Purpose |
|------|---------|
| `config.txt.snippet` | Appended to `/boot/firmware/config.txt` — enables SPI and loads piscreen overlay |
| `10-touchscreen.conf` | Copied to `/etc/X11/xorg.conf.d/` — maps ADS7846 touch device to evdev driver |
| `autostart` | Copied to `~/.config/lxsession/LXDE/autostart` — launches Chromium with kiosk flags |

### Chromium kiosk flags (in `autostart`)
- `--kiosk` — fullscreen, no browser UI
- `--overscroll-history-navigation=0` — prevents swipe back/forward
- `--disable-pinch` — disables pinch zoom
- `--app=URL` — app mode (change this to customize the displayed URL)

## Customization

The URL displayed is set in the `autostart` file's `--app=` flag. The display rotation is controlled by the `rotate=` parameter in `config.txt.snippet` (values: 0, 90, 180, 270).

Touch calibration, if needed, uses `xinput_calibrator` and writes output to `/etc/X11/xorg.conf.d/99-calibration.conf`.

## Home Lab Infrastructure

### Network & Security
- **Router**: OPNsense on Protectli VP2420 — runs Suricata (IDS/IPS), Unbound DNS, HAProxy
- **VPN**: Tailscale for remote access; Mullvad VPN on all devices

### Servers
- **TrueNAS** on Terramaster F4-423 — runs Dockge with the full ARR stack (Sonarr, Radarr, Lidarr, Prowlarr, Jellyfin, Jellyseerr, Audiobookshelf, Homarr), Nextcloud, and SMB shares
- **Bitcoin node** on Beelink (Ubuntu) — runs Mempool.space and Alby Hub

### Workstations
- **Primary Linux**: Beelink SER running Debian KDE
- **Primary Mac**: MacBook Pro M3 Pro

### Git Remotes
- `origin` — GitHub (mcps976)
- `truenas` — bare repos on TrueNAS at `/mnt/tank/git-repos/`

### Shell Scripts
Scripts in this repo target **bash 5.x** on Debian/Ubuntu.
