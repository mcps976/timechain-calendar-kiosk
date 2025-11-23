# Project Structure

This document explains the organization and purpose of each file in the Raspberry Pi Timechain Calendar Kiosk project.

## Directory Tree

```
raspberry-pi-timechain-kiosk/
│
├── README.md                      # Main project documentation
├── LICENSE                        # MIT License
├── CONTRIBUTING.md                # Contribution guidelines
├── .gitignore                     # Git ignore rules
│
├── configs/                       # Configuration files
│   ├── config.txt.snippet        # Boot config for display driver
│   ├── 10-touchscreen.conf       # X11 touchscreen input config
│   └── autostart                 # LXDE kiosk mode autostart
│
├── scripts/                       # Automation scripts
│   └── install.sh                # Automated installation script
│
└── docs/                          # Additional documentation
    ├── FAQ.md                    # Frequently asked questions
    ├── HARDWARE.md               # Hardware shopping list
    ├── QUICKSTART.md             # Quick start guide
    ├── GITHUB_SETUP.md           # GitHub upload instructions
    └── images/                   # Project images
        └── kiosk-preview.jpg     # Photo of completed kiosk
```

---

## File Purposes

### Root Level Files

#### README.md
**Purpose:** Main project documentation  
**Contains:**
- Project overview and features
- Complete installation instructions
- Hardware requirements
- Troubleshooting guide
- Customization options

**Used by:** Everyone - this is the first file people read

#### LICENSE
**Purpose:** Legal license (MIT)  
**Contains:** Permission to use, modify, and distribute the project  
**Used by:** Anyone wanting to use or fork the project

#### CONTRIBUTING.md
**Purpose:** Guidelines for contributing  
**Contains:**
- How to report issues
- How to submit pull requests
- Code style guidelines
- Testing requirements

**Used by:** Contributors wanting to improve the project

#### .gitignore
**Purpose:** Tells Git which files to ignore  
**Contains:** Patterns for OS files, backups, logs, etc.  
**Used by:** Git automatically when committing

---

### configs/ Directory

Configuration files that get copied to the Raspberry Pi during installation.

#### config.txt.snippet
**Install location:** `/boot/firmware/config.txt`  
**Purpose:** Configures the display driver at boot  
**Contains:**
- SPI enable command
- piscreen overlay configuration
- Optional rotation setting

**How it's used:** Manually added to existing config.txt file

#### 10-touchscreen.conf
**Install location:** `/etc/X11/xorg.conf.d/10-touchscreen.conf`  
**Purpose:** Tells X11 to use the touchscreen  
**Contains:**
- Input device matching rules
- evdev driver specification

**How it's used:** Copied directly to system

#### autostart
**Install location:** `~/.config/lxsession/LXDE/autostart`  
**Purpose:** Launches Chromium kiosk on desktop start  
**Contains:**
- Desktop component startup commands
- Screen blanking prevention
- Chromium kiosk mode command

**How it's used:** Copied to user's LXDE config

---

### scripts/ Directory

Automation scripts to simplify installation.

#### install.sh
**Purpose:** Automated installer  
**What it does:**
1. Updates system packages
2. Installs required software
3. Configures display driver
4. Sets up touchscreen
5. Enables auto-login
6. Configures kiosk mode

**How to use:**
```bash
chmod +x install.sh
./install.sh
```

**Note:** Requires internet connection and sudo access

---

### docs/ Directory

Additional documentation files.

#### FAQ.md
**Purpose:** Answers common questions  
**Organized by:**
- General questions
- Hardware questions
- Software questions
- Setup questions
- Usage questions
- Customization questions

**Used by:** Users looking for quick answers

#### HARDWARE.md
**Purpose:** Shopping list and component guide  
**Contains:**
- Recommended components with links
- Price ranges
- Specifications to verify
- Compatible alternative options
- What to avoid

**Used by:** People planning to build the kiosk

#### QUICKSTART.md
**Purpose:** Condensed installation guide  
**Contains:**
- Minimal steps to get running fast
- Quick fixes for common issues
- Checklist format

**Used by:** Experienced users who want speed

#### GITHUB_SETUP.md
**Purpose:** Instructions for uploading to GitHub  
**Contains:**
- Step-by-step GitHub repo creation
- Git commands
- Best practices for maintenance

**Used by:** Project creators sharing their work

#### images/
**Purpose:** Store project photos and screenshots  
**Should contain:**
- kiosk-preview.jpg - Photo of working kiosk
- Optional: build process photos
- Optional: troubleshooting screenshots

**Used by:** README.md to display visual examples

---

## Installation Flow

Here's how the files are used during installation:

### Manual Installation
1. User reads **README.md**
2. User manually adds **config.txt.snippet** → `/boot/firmware/config.txt`
3. User copies **10-touchscreen.conf** → `/etc/X11/xorg.conf.d/`
4. User copies **autostart** → `~/.config/lxsession/LXDE/`
5. User reboots

### Automated Installation
1. User reads **README.md** or **QUICKSTART.md**
2. User downloads and runs **install.sh**
3. Script automatically handles all file copying and configuration
4. User reboots

---

## Customization Points

Users typically modify these files:

### Change Display URL
**File:** `configs/autostart`  
**Line:** Last line with `--app=https://...`

### Adjust Display Rotation
**File:** `configs/config.txt.snippet`  
**Line:** Add `,rotate=90` to piscreen line

### Customize Installation
**File:** `scripts/install.sh`  
**Modify:** URL variable, additional packages, etc.

---

## Maintenance

### Adding New Features

1. Update relevant config files in `configs/`
2. Update `install.sh` if needed
3. Document in `README.md`
4. Add to `FAQ.md` if it answers a common question
5. Update `QUICKSTART.md` if it affects quick setup

### Fixing Bugs

1. Fix the issue in config files or scripts
2. Update troubleshooting in `README.md`
3. Add to `FAQ.md` if it's commonly encountered
4. Commit with clear description

### Improving Documentation

- Keep README concise - move detailed info to docs/
- Update FAQ when patterns emerge in issues
- Add screenshots to docs/images/
- Keep HARDWARE.md current with tested components

---

## Dependencies

### External
- Raspberry Pi OS Bookworm
- Chromium browser (installed via apt)
- unclutter (installed via apt)
- xserver-xorg-input-evdev (installed via apt)

### Internal
- All files in this repository
- Internet connection (for downloading packages and viewing website)

---

## Version Control

### What to Commit
✅ All config files  
✅ Documentation  
✅ Scripts  
✅ Small images (<1MB)

### What NOT to Commit
❌ OS-specific files (.DS_Store)  
❌ Backup files (*.backup)  
❌ Large images (>1MB) - use Git LFS  
❌ Personal configurations  
❌ Logs and temporary files

See `.gitignore` for complete list.

---

## Questions About Structure?

Open an issue or discussion if:
- You think a file should be organized differently
- You need clarification on a file's purpose
- You want to propose adding new files/directories

---

**This structure keeps the project organized and easy to navigate!**
