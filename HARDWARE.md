# Hardware Shopping List

This document provides purchasing recommendations for building the Timechain Calendar Kiosk.

## Required Components

### 1. Raspberry Pi 4

**Recommended:** Raspberry Pi 4 Model B (4GB RAM)

**Where to buy:**
- [Official Raspberry Pi retailers](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)
- Amazon, Adafruit, SparkFun, CanaKit

**Price range:** $35-65 USD (depending on RAM)

**Notes:**
- 2GB version will work but 4GB is recommended for better browser performance
- 8GB is overkill for this project
- Raspberry Pi 5 should also work but hasn't been tested

### 2. 3.5" TFT LCD Touchscreen

**Compatible models:**
- Waveshare 3.5" RPi LCD (A) - ILI9486 driver
- Kuman 3.5" TFT LCD - XPT2046 touch
- Any 3.5" SPI display with ILI9486 driver and XPT2046 touch controller

**Where to buy:**
- Amazon: Search "3.5 inch Raspberry Pi LCD ILI9486"
- AliExpress: Search "3.5 TFT LCD Raspberry Pi"
- Waveshare official store

**Price range:** $15-30 USD

**Important specifications to verify:**
- Display driver: ILI9486
- Touch controller: XPT2046 or ADS7846
- Interface: SPI (connects via GPIO)
- Resolution: 480x320

**Warning:** Avoid displays that only list "LCD-show support" without mentioning the driver chip.

### 3. MicroSD Card

**Recommended:** 
- SanDisk Extreme 32GB Class 10 A2
- Samsung EVO Plus 32GB Class 10 U3

**Minimum specs:**
- Size: 16GB
- Speed: Class 10 (UHS-I recommended)

**Where to buy:**
- Amazon, Best Buy, any electronics retailer

**Price range:** $8-15 USD

### 4. Power Supply

**Recommended:** Official Raspberry Pi USB-C Power Supply (5V/3A)

**Where to buy:**
- Official Raspberry Pi retailers
- Amazon, Adafruit

**Price range:** $8-12 USD

**Notes:**
- Must be 5V/3A minimum
- USB-C connector (for Pi 4)
- Cheap power supplies cause stability issues - buy quality!

## Optional Components

### Case

**Options:**
- Generic Raspberry Pi 4 case with 3.5" display cutout
- 3D printed custom case (files available on Thingiverse)
- DIY wooden/acrylic case

**Price range:** $8-20 USD (or free if 3D printing)

### Cooling

**Options:**
- Small heatsink kit (usually included with cases)
- Active cooling fan (not necessary for kiosk use)

**Price range:** $5-10 USD

### USB Keyboard/Mouse (for setup)

Only needed during initial configuration. Can be borrowed temporarily.

## Total Cost Estimate

**Budget build:** $75-90 USD
- Raspberry Pi 4 (2GB): $35
- 3.5" LCD: $15
- MicroSD Card: $8
- Power Supply: $10
- Basic Case: $8

**Recommended build:** $95-120 USD
- Raspberry Pi 4 (4GB): $55
- Quality 3.5" LCD: $25
- Fast MicroSD Card: $12
- Official Power Supply: $10
- Nice Case: $15

## Where NOT to Buy

❌ Avoid extremely cheap unbranded displays from unknown sellers
❌ Avoid "LCD-show only" displays without proper driver specs
❌ Avoid cheap no-name power supplies (cause crashes and SD card corruption)
❌ Avoid counterfeit SD cards (buy from reputable sellers)

## Alternative Display Options

If you have trouble sourcing a 3.5" ILI9486 display, these alternatives may work:

- **5" HDMI Display:** Easier to find, but larger and requires HDMI cable
- **7" HDMI Display:** Official Raspberry Pi touchscreen, premium option
- **2.8" SPI Display:** Smaller alternative with similar setup

**Note:** HDMI displays don't require the piscreen overlay - use standard HDMI configuration instead.

## Verified Compatible Displays

Community members have confirmed these specific models work:

- Waveshare 3.5" RPi LCD (A) - Model 13587
- Kuman 3.5" TFT LCD - Model SC6A
- Kedei 3.5" TFT LCD - V5.0

_If you successfully use a different display, please submit a PR to add it to this list!_
