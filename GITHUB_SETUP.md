# How to Upload This Project to GitHub

This guide walks you through creating a GitHub repository for your Raspberry Pi Timechain Calendar Kiosk project.

## Prerequisites

- [ ] GitHub account ([sign up here](https://github.com/join) if you don't have one)
- [ ] Git installed on your computer
- [ ] Project files downloaded to your computer

---

## Step 1: Create a New Repository on GitHub

1. Go to [github.com](https://github.com) and log in
2. Click the **+** icon in the top-right corner
3. Select **New repository**
4. Configure your repository:
   - **Repository name:** `raspberry-pi-timechain-kiosk` (or your preferred name)
   - **Description:** "A plug-and-play Bitcoin Timechain Calendar display using Raspberry Pi 4 and 3.5" touchscreen"
   - **Visibility:** Public (recommended) or Private
   - **Do NOT** initialize with README, .gitignore, or license (we already have these)
5. Click **Create repository**

---

## Step 2: Prepare Your Local Files

Open a terminal/command prompt and navigate to the directory containing the project files:

```bash
cd /path/to/raspberry-pi-timechain-kiosk
```

Initialize a git repository:

```bash
git init
```

Add all files:

```bash
git add .
```

Check what's being added:

```bash
git status
```

Create your first commit:

```bash
git commit -m "Initial commit: Raspberry Pi Timechain Calendar Kiosk project"
```

---

## Step 3: Connect to GitHub

Add your GitHub repository as the remote origin (replace YOUR_USERNAME):

```bash
git remote add origin https://github.com/YOUR_USERNAME/raspberry-pi-timechain-kiosk.git
```

Verify it was added:

```bash
git remote -v
```

---

## Step 4: Push Your Code to GitHub

Push your code to GitHub:

```bash
git branch -M main
git push -u origin main
```

You may be prompted to log in to GitHub. Enter your credentials or use a personal access token.

---

## Step 5: Verify Upload

1. Go to your repository URL: `https://github.com/YOUR_USERNAME/raspberry-pi-timechain-kiosk`
2. You should see all your files listed
3. The README.md should display automatically on the main page

---

## Step 6: Update Installation Script URL

Now that your repository is live, update the installation script URL in the README:

1. Open `README.md` in a text editor
2. Find the installation script section
3. Replace `YOUR_USERNAME` with your actual GitHub username
4. Save the file

Commit and push the change:

```bash
git add README.md
git commit -m "Update README with correct GitHub username"
git push
```

---

## Step 7: Optional - Add Topics and About

Make your repository more discoverable:

1. On your GitHub repository page, click **⚙️ Settings** (top right)
2. Under "About", click **⚙️ Edit**
3. Add:
   - **Description:** "Raspberry Pi Bitcoin Timechain Calendar Kiosk"
   - **Website:** `https://timechaincalendar.com`
   - **Topics:** `raspberry-pi`, `bitcoin`, `kiosk`, `touchscreen`, `timechain`, `iot`
4. Click **Save changes**

---

## Step 8: Add Images (Optional)

Make your README more attractive with images:

1. Create a `docs/images/` directory in your project:
   ```bash
   mkdir -p docs/images
   ```

2. Add photos of your completed kiosk:
   - Take a photo of your working kiosk
   - Name it `kiosk-preview.jpg`
   - Place it in `docs/images/`

3. Commit and push:
   ```bash
   git add docs/images/kiosk-preview.jpg
   git commit -m "Add kiosk preview image"
   git push
   ```

The README already references this image, so it will display automatically!

---

## Managing Your Repository

### Making Changes

After uploading, if you make changes:

```bash
# Make your edits to files
git add .
git commit -m "Description of changes"
git push
```

### Creating Releases

When you have a stable version:

1. Go to your GitHub repo
2. Click **Releases** → **Create a new release**
3. Tag version: `v1.0.0`
4. Release title: `Version 1.0.0 - Initial Release`
5. Description: Summary of features
6. Click **Publish release**

### Accepting Contributions

Enable Issues and Discussions:

1. Go to repository **Settings**
2. Scroll to **Features**
3. Check ✓ **Issues** and ✓ **Discussions**
4. Save

---

## Best Practices

### Keep Your README Updated

- Document new features
- Update troubleshooting based on issues
- Add verified hardware compatibility

### Respond to Issues

- Thank people for reporting bugs
- Ask for clarification when needed
- Close issues when resolved

### Credit Contributors

When someone contributes, add them to the credits section of your README.

### Use GitHub Actions (Advanced)

You could set up automated testing or documentation building with GitHub Actions.

---

## Example Repository Structure

Your final repository should look like this:

```
raspberry-pi-timechain-kiosk/
├── .gitignore
├── LICENSE
├── README.md
├── CONTRIBUTING.md
├── configs/
│   ├── config.txt.snippet
│   ├── 10-touchscreen.conf
│   └── autostart
├── scripts/
│   └── install.sh
└── docs/
    ├── FAQ.md
    ├── HARDWARE.md
    ├── QUICKSTART.md
    └── images/
        └── kiosk-preview.jpg
```

---

## Promoting Your Project

Once uploaded:

1. **Share on social media**
   - Twitter/X with hashtags: #RaspberryPi #Bitcoin #Timechain
   - Reddit: r/raspberry_pi, r/Bitcoin
   - Hacker News

2. **Add to awesome lists**
   - [Awesome Raspberry Pi](https://github.com/thibmaek/awesome-raspberry-pi)
   - [Awesome Bitcoin](https://github.com/igorbarinov/awesome-bitcoin)

3. **Write a blog post** about building it

4. **Make a video** tutorial

---

## Troubleshooting Git Issues

### Authentication Failed

Use a Personal Access Token instead of password:
1. GitHub → Settings → Developer Settings → Personal Access Tokens
2. Generate new token (classic)
3. Use token as password when pushing

### Large Files Warning

If you added large image files:
```bash
git rm --cached large-file.jpg
echo "*.jpg filter=lfs diff=lfs merge=lfs -text" >> .gitattributes
git add .gitattributes
git commit -m "Use Git LFS for images"
```

### Wrong Remote URL

```bash
git remote set-url origin https://github.com/YOUR_USERNAME/correct-repo.git
```

---

## Need Help?

- [GitHub Docs](https://docs.github.com/)
- [Git Basics Tutorial](https://git-scm.com/book/en/v2/Getting-Started-Git-Basics)
- [GitHub Community Forums](https://github.community/)

---

**You're all set!** Your project is now live on GitHub and ready to share with the world. 🎉
