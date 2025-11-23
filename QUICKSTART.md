# Quick Start Guide

**Want to get your Timechain Calendar Kiosk running in under 30 minutes?** Follow this guide.

## Prerequisites

- [ ] Raspberry Pi 4 (2GB or more)
- [ ] 3.5" LCD with ILI9486 driver
- [ ] MicroSD card (16GB+)
- [ ] Power supply
- [ ] Internet connection
- [ ] Computer for flashing SD card

## Super Quick Installation (Automated)

### Step 1: Flash OS (5 minutes)

1. Download [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
2. Insert microSD card
3. In Imager:
   - OS: **Raspberry Pi OS (32-bit)**
   - Storage: Your microSD card
   - Settings (⚙️):
     - Enable SSH ✓
     - Set username/password
     - Configure WiFi ✓
4. Click **Write**
5. Insert SD card into Pi and power on

### Step 2: Run Automated Installer (10 minutes)

SSH into your Pi:
```bash
ssh pi@raspberrypi.local
```

Run the automated installer:
```bash
wget https://raw.githubusercontent.com/YOUR_USERNAME/raspberry-pi-timechain-kiosk/main/scripts/install.sh
chmod +x install.sh
./install.sh
```

Follow the prompts and reboot when asked.

### Step 3: Done! ✅

After reboot, your kiosk should be running automatically!

---

## Manual Installation (Step-by-Step)

Prefer to understand each step? Follow the [full installation guide](README.md#installation) in the main README.

---

## First Boot Checklist

After your kiosk boots up:

- [ ] Display shows the Timechain Calendar website
- [ ] Display is in correct orientation (not rotated wrong)
- [ ] Touchscreen responds when you tap it
- [ ] No browser UI elements visible (true fullscreen)
- [ ] No mouse cursor visible

## Quick Fixes

### Display Rotated Wrong?

Edit `/boot/firmware/config.txt`:
```bash
sudo nano /boot/firmware/config.txt
```

Find the line with `dtoverlay=piscreen` and add `,rotate=90`:
```ini
dtoverlay=piscreen,drm,speed=18000000,rotate=90
```

Options: `0`, `90`, `180`, `270`

Reboot: `sudo reboot`

### Touchscreen Not Working?

```bash
sudo evtest /dev/input/event0
```

Tap the screen. If you see events, the hardware works - it's a config issue. See [Troubleshooting](README.md#troubleshooting).

### Wrong URL Displaying?

Edit the autostart file:
```bash
nano ~/.config/lxsession/LXDE/autostart
```

Change the URL in the last line, save, and reboot.

---

## Next Steps

- **Customize:** Change the displayed URL or add your own content
- **Mount:** Install in a case or mount on wall
- **Optimize:** Adjust display brightness (if supported by your screen)
- **Share:** Post your build on social media and tag the project!

---

## Need Help?

- Read the full [README](README.md)
- Check [Troubleshooting](README.md#troubleshooting)
- Open a [GitHub Issue](../../issues)

**Estimated total time:** 15-30 minutes from start to working kiosk! 🚀
