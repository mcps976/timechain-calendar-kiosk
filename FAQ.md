# Frequently Asked Questions (FAQ)

## General Questions

### What is this project?

This project turns a Raspberry Pi 4 with a small 3.5" touchscreen into a dedicated display for the [Timechain Calendar](https://timechaincalendar.com), which shows Bitcoin block time instead of traditional time.

### Why would I want this?

- Educational Bitcoin display piece
- Unique desk/wall decoration
- Learn about Raspberry Pi and Linux
- Always-on Bitcoin block height monitor
- Conversation starter about Bitcoin

### Can I display something other than the Timechain Calendar?

Absolutely! Just change the URL in the autostart configuration file. This can display any website.

### How much does it cost to build?

$75-120 USD depending on component choices. See the [Hardware Shopping List](HARDWARE.md) for details.

---

## Hardware Questions

### Which Raspberry Pi models work?

**Tested and working:**
- Raspberry Pi 4 Model B (2GB, 4GB, 8GB)

**Should work but untested:**
- Raspberry Pi 5
- Raspberry Pi 3 Model B+ (may be slower)

**Not recommended:**
- Raspberry Pi Zero (too slow for modern web browsing)
- Raspberry Pi 3 Model A+ (limited RAM)

### My 3.5" display is a different brand - will it work?

If it has these specs, it should work:
- Display driver: ILI9486
- Touch controller: XPT2046 or ADS7846
- Interface: SPI (plugs into GPIO pins)

### Can I use a different size display?

Yes! Alternatives:
- **HDMI displays** (5", 7", 10"): Use standard HDMI setup, skip the piscreen overlay
- **Other SPI displays**: May work with different overlays (check manufacturer docs)
- **Official Pi touchscreen**: Works great but more expensive

### Does the touchscreen actually work?

Yes, but it's not perfectly calibrated out of the box. Basic touching/tapping works for most displays. Fine-tuning calibration is optional.

### Can I adjust the display brightness?

Most SPI displays don't support software brightness control. You'd need to modify the hardware (add a physical potentiometer) or use an HDMI display instead.

---

## Software Questions

### Which Raspberry Pi OS version should I use?

**Recommended:** Raspberry Pi OS Bookworm (32-bit)

**Works:** Legacy versions (Bullseye)

**Don't use:** 
- Trixie/Debian 13 (incompatible)
- 64-bit versions (unnecessary, may have issues)
- Ubuntu/other distros (not tested)

### Why not use the LCD-show scripts?

The LCD-show repository is outdated (last updated 2019) and doesn't work with modern Raspberry Pi OS. This project uses the built-in kernel driver (`piscreen`) which is more reliable.

### How much RAM/CPU does it use?

- RAM: ~800MB (out of 2GB/4GB)
- CPU: 5-15% idle, 30-50% when loading pages
- Power: ~3-5W total

### Can I run other software on the Pi at the same time?

Yes, but the kiosk takes over the display. You could:
- Run background services (web server, etc.)
- SSH in and use command line
- Schedule tasks with cron

But you can't use the display for anything except the kiosk.

### How do I update the Timechain Calendar site when it changes?

The kiosk loads the live website from the internet. It automatically shows the latest version whenever the website updates. No action needed!

---

## Setup Questions

### Do I need a keyboard and mouse?

Only during initial setup. After configuration, the kiosk runs completely standalone.

### Can I set this up headless (without monitor)?

Yes! Use SSH for all setup steps, then the display will work when you reboot.

### How long does installation take?

- Automated script: ~15 minutes
- Manual installation: ~30-45 minutes
- First-time learners: 1-2 hours

### I got an error during installation. What do I do?

1. Read the error message carefully
2. Check the [Troubleshooting section](README.md#troubleshooting)
3. Search existing [GitHub Issues](../../issues)
4. If still stuck, open a new issue with full error details

---

## Usage Questions

### How do I turn it on/off?

**On:** Plug in power - it boots automatically

**Off (proper):** 
```bash
sudo shutdown now
```

**Off (quick but not ideal):** Unplug power (can corrupt SD card if done repeatedly)

### Does it auto-start after power outage?

Yes! As long as power is restored, it will boot up and launch the kiosk automatically.

### Can I put it to sleep?

Not really. It's designed to run 24/7. The display doesn't support sleep mode, and there's no benefit to sleeping the Pi.

### How much does it cost to run 24/7?

About $0.50-1.00 USD per month in electricity (depending on your rates). Very minimal.

### Can I schedule it to turn on/off at certain times?

You could use a smart plug on a schedule, or use cron jobs to blank the screen at night (though the Pi stays on).

---

## Customization Questions

### How do I change what website is displayed?

Edit `~/.config/lxsession/LXDE/autostart` and change the URL, then reboot.

### Can I add multiple websites on a rotation?

Not built-in, but you could:
1. Create a simple HTML page with iframe rotation
2. Use a browser extension (requires modification)
3. Create a custom web app that rotates pages

### Can I show local files instead of a website?

Yes! Change the URL to a `file://` path:
```
@chromium-browser --kiosk ... --app=file:///home/pi/my-page.html
```

### How do I remove the kiosk and use it as a normal Pi?

Remove the autostart file:
```bash
rm ~/.config/lxsession/LXDE/autostart
```

Or comment out the Chromium line with `#`

### Can I use this for other cryptocurrencies?

Sure! Just point it to any crypto-related website (price trackers, mempool, etc.)

---

## Troubleshooting Quick Answers

### Black screen after boot

Check `/boot/firmware/config.txt` has the piscreen overlay configured correctly.

### "Failed to start session" error

Ensure lightdm is configured for `user-session=LXDE` (not LXDE-pi-labwc).

### Touchscreen doesn't respond

Install evdev driver: `sudo apt install xserver-xorg-input-evdev -y`

### Calendar shows "no internet"

Check WiFi: `iwconfig` or try `ping google.com`

### Touch coordinates are wrong

Run calibration: `sudo apt install xinput-calibrator -y && DISPLAY=:0 xinput_calibrator`

---

## Advanced Questions

### Can I use this for a commercial product?

Yes! This project is MIT licensed. You can use it commercially, just include the license.

### Can I contribute to this project?

Absolutely! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Can I use a different calendar/Bitcoin service?

Of course! The URL is easily customizable to any Bitcoin-related (or unrelated) website.

### Can I add buttons or other hardware controls?

Yes! You could add GPIO buttons to control functions like:
- Screen rotation
- Brightness (if supported)
- URL switching
- Refresh

You'd need to write custom Python scripts.

---

## Still Have Questions?

- Check the [main README](README.md)
- Browse [existing issues](../../issues)
- Start a [discussion](../../discussions)
- Open a [new issue](../../issues/new)

**Pro tip:** Before asking, search existing issues - someone may have already answered your question!
