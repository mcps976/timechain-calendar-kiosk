# Raspberry Pi Timechain Calendar Kiosk

A plug-and-play Bitcoin Timechain Calendar display using a Raspberry Pi 4 and 3.5" touchscreen. Perfect for displaying the [Timechain Calendar](https://timechaincalendar.com) as a dedicated kiosk device.

![Timechain Calendar Kiosk](docs/images/kiosk-preview.jpg)

## Features

- ✅ Full-screen Timechain Calendar display
- ✅ Touch-enabled 3.5" LCD interface
- ✅ Auto-start on boot (no keyboard/mouse needed after setup)
- ✅ Clean kiosk mode (no browser UI elements)
- ✅ Low power consumption
- ✅ Compact form factor

## Hardware Requirements

### Required Components

- **Raspberry Pi 4** (2GB RAM minimum, 4GB recommended)
- **3.5" TFT LCD Touchscreen** with XPT2046 touch controller and ILI9486 driver
  - Compatible models: Waveshare 3.5" RPi LCD, similar SPI displays
- **MicroSD Card** (16GB minimum, Class 10 recommended)
- **Power Supply** (Official Raspberry Pi 5V/3A USB-C power supply)

### Optional Components

- Case for Raspberry Pi + display
- USB keyboard/mouse (for initial setup only)

## Software Requirements

- **Raspberry Pi OS Bookworm (32-bit)** - Legacy or standard version
- Internet connection for initial setup

## Installation

### Step 1: Flash the Operating System

1. Download [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
2. Insert your microSD card
3. In Raspberry Pi Imager:
   - Choose **Raspberry Pi OS (32-bit)** (Bookworm)
   - Select your microSD card
   - Click the **gear icon** for advanced options:
     - Enable SSH
     - Set username: `pi` (or your preference)
     - Set password
     - Configure WiFi (optional)
   - Click **Write**

4. Insert the microSD card into your Raspberry Pi and power it on

### Step 2: Initial System Setup

SSH into your Raspberry Pi or connect a keyboard/monitor:

```bash
ssh pi@raspberrypi.local
```

Update the system:

```bash
sudo apt update && sudo apt upgrade -y
```

### Step 3: Configure the Display

Edit the boot configuration:

```bash
sudo nano /boot/firmware/config.txt
```

Add these lines to the `[all]` section at the bottom:

```ini
[all]
dtparam=spi=on
dtoverlay=piscreen,drm,speed=18000000
```

Save and exit (Ctrl+X, Y, Enter).

### Step 4: Configure Auto-Login

Run the Raspberry Pi configuration tool:

```bash
sudo raspi-config
```

Navigate to:
1. **System Options** (S5)
2. **Boot / Auto Login** (S5)
3. Select **Desktop Autologin** (B4)
4. Finish and reboot when prompted

### Step 5: Configure the Touchscreen

Create the touchscreen input configuration:

```bash
sudo nano /etc/X11/xorg.conf.d/10-touchscreen.conf
```

Add this content:

```
Section "InputClass"
    Identifier "ADS7846 Touchscreen"
    MatchProduct "ADS7846"
    MatchDevicePath "/dev/input/event0"
    Driver "evdev"
EndSection
```

Save and exit.

### Step 6: Install Required Software

Install Chromium and screen blanking prevention:

```bash
sudo apt install chromium-browser unclutter -y
```

### Step 7: Configure Chromium Kiosk Mode

Create the autostart directory:

```bash
mkdir -p ~/.config/lxsession/LXDE/
```

Create the autostart file:

```bash
nano ~/.config/lxsession/LXDE/autostart
```

Add this content:

```
@lxpanel --profile LXDE
@pcmanfm --desktop --profile LXDE
@xscreensaver -no-splash
@xset s off
@xset -dpms
@xset s noblank
@unclutter -idle 0
@chromium-browser --kiosk --noerrdialogs --disable-infobars --no-first-run --disable-pinch --overscroll-history-navigation=0 --app=https://timechaincalendar.com
```

Save and exit.

### Step 8: Reboot

```bash
sudo reboot
```

After rebooting, your Raspberry Pi should automatically display the Timechain Calendar in full-screen kiosk mode!

## Customization

### Changing the Display URL

To display a different website, edit the autostart file:

```bash
nano ~/.config/lxsession/LXDE/autostart
```

Change the URL in the last line:

```
@chromium-browser --kiosk ... --app=https://your-website-here.com
```

### Adjusting Display Rotation

If your display is rotated incorrectly, edit `/boot/firmware/config.txt`:

```bash
sudo nano /boot/firmware/config.txt
```

Modify the piscreen line to include rotation:

```ini
dtoverlay=piscreen,drm,speed=18000000,rotate=90
```

Options:
- `rotate=0` - No rotation (default)
- `rotate=90` - 90 degrees clockwise
- `rotate=180` - 180 degrees
- `rotate=270` - 270 degrees clockwise

### Touchscreen Calibration

If touch coordinates are inaccurate, you may need to calibrate. The calibration file should exist at:

```bash
/etc/X11/xorg.conf.d/99-calibration.conf
```

Install the calibration tool:

```bash
sudo apt install xinput-calibrator -y
```

Run calibration from the desktop:

```bash
DISPLAY=:0 xinput_calibrator
```

Follow the on-screen prompts to tap calibration points.

## Troubleshooting

### Display Not Working

**Issue:** Display shows console but no desktop appears

**Solutions:**
1. Verify `/boot/firmware/config.txt` has the correct piscreen overlay
2. Check that you're using Raspberry Pi OS Bookworm (not Trixie/Debian 13)
3. Ensure you selected "Desktop Autologin" in raspi-config
4. Check that lightdm is running: `systemctl status lightdm`

**Issue:** "Failed to start session" error on display

**Solution:**
Edit `/etc/lightdm/lightdm.conf`:

```bash
sudo nano /etc/lightdm/lightdm.conf
```

In the `[Seat:*]` section, ensure:

```ini
user-session=LXDE
```

NOT `LXDE-pi-labwc` or `LXDE-pi-x`.

### Touchscreen Not Responding

**Issue:** Touch input doesn't work

**Solutions:**
1. Verify the touchscreen config exists: `cat /etc/X11/xorg.conf.d/10-touchscreen.conf`
2. Check if touch events are detected: `sudo evtest /dev/input/event0` (tap the screen)
3. Install evdev driver if missing: `sudo apt install xserver-xorg-input-evdev -y`
4. Reboot after making changes

**Issue:** Touch coordinates are inverted or wrong

**Solution:**
The calibration values in `/etc/X11/xorg.conf.d/99-calibration.conf` may need adjustment. Use `xinput_calibrator` to recalibrate.

### Chromium Not Auto-Starting

**Issue:** Desktop loads but Chromium doesn't launch

**Solutions:**
1. Verify autostart file exists: `cat ~/.config/lxsession/LXDE/autostart`
2. Check the file path is correct (capital LXDE)
3. Ensure chromium-browser is installed: `which chromium-browser`
4. Check for errors: Look in `~/.xsession-errors`

### Display Shows Wrong OS Version Warning

**Issue:** LCD-show scripts don't work with newer OS versions

**Solution:**
This project uses the native `piscreen` kernel driver, NOT the older LCD-show scripts. The LCD-show repository is outdated and incompatible with Raspberry Pi OS Bookworm. Stick with the instructions in this README.

### System Date/Time Wrong

**Issue:** Repositories show "invalid for another X days" errors

**Solution:**
```bash
sudo date -s "2025-11-19 12:00:00"
sudo systemctl enable systemd-timesyncd
sudo systemctl start systemd-timesyncd
```

### Bluetooth Keyboard Won't Pair

**Issue:** Apple Magic Keyboard with Touch ID won't pair

**Solution:**
Magic Keyboards with Touch ID use proprietary Bluetooth protocols that don't work reliably with Linux. Use a standard Bluetooth keyboard without Touch ID, or a USB keyboard.

## File Structure

```
raspberry-pi-timechain-kiosk/
├── README.md                          # This file
├── configs/
│   ├── config.txt.snippet            # Boot configuration snippet
│   ├── 10-touchscreen.conf           # X11 touchscreen configuration
│   └── autostart                     # LXDE autostart configuration
├── scripts/
│   └── install.sh                    # Automated installation script
└── docs/
    └── images/
        └── kiosk-preview.jpg         # Project preview image
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Known Limitations

- Touch calibration may vary between different 3.5" display manufacturers
- Some Apple Bluetooth keyboards (with Touch ID) are not compatible
- Display brightness cannot be adjusted via software on most SPI displays
- Display refresh rate is limited by SPI bus speed

## Credits

- [Timechain Calendar](https://timechaincalendar.com) - The displayed Bitcoin block time calendar
- Raspberry Pi Foundation - For the Raspberry Pi platform
- Linux kernel developers - For the piscreen/fbtft display drivers

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For issues or questions:
1. Check the [Troubleshooting](#troubleshooting) section above
2. Open an issue on this GitHub repository
3. Consult the [Raspberry Pi Forums](https://forums.raspberrypi.com/)

---

**Enjoy your Bitcoin Timechain Calendar Kiosk!** 🚀₿
