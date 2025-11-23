# Contributing to Raspberry Pi Timechain Calendar Kiosk

Thank you for your interest in contributing! This project welcomes contributions from everyone.

## How to Contribute

### Reporting Issues

If you encounter a problem:

1. Check the [Troubleshooting section](README.md#troubleshooting) in the README
2. Search existing [GitHub Issues](../../issues) to see if it's already reported
3. If not found, open a new issue with:
   - Clear description of the problem
   - Hardware you're using (Pi model, display model)
   - OS version (`cat /etc/os-release`)
   - Steps to reproduce
   - Any error messages or logs

### Suggesting Enhancements

Have an idea for improvement? Open an issue with the "enhancement" label describing:
- What you'd like to see
- Why it would be useful
- Possible implementation approach (if you have one)

### Contributing Code

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/raspberry-pi-timechain-kiosk.git
   cd raspberry-pi-timechain-kiosk
   ```

3. **Create a branch** for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes**

5. **Test your changes** on actual hardware if possible

6. **Commit with clear messages**:
   ```bash
   git commit -m "Add feature: description of what you did"
   ```

7. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

8. **Open a Pull Request** on GitHub

## Pull Request Guidelines

- One feature/fix per PR
- Update README.md if you add new features or change installation steps
- Add yourself to the contributors list
- Test on actual Raspberry Pi hardware when possible
- Include screenshots for UI changes

## Code Style

- Bash scripts: Follow [Google's Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- Config files: Use consistent indentation (spaces preferred)
- Markdown: Use proper headings and formatting

## Testing

Before submitting:

- [ ] Fresh install works on Raspberry Pi OS Bookworm
- [ ] Display driver loads correctly
- [ ] Touchscreen responds to input
- [ ] Chromium launches in kiosk mode
- [ ] Auto-login works after reboot

## Documentation

When adding features:

- Update README.md with new configuration options
- Add troubleshooting tips for common issues
- Document any new dependencies
- Update HARDWARE.md if hardware requirements change

## Areas Where Help is Needed

- **Testing:** Verify compatibility with different 3.5" display models
- **Documentation:** Improve troubleshooting guides
- **Scripts:** Enhance the automated installer
- **Features:** Add configuration options (brightness control, refresh scheduling, etc.)
- **Compatibility:** Test with Raspberry Pi 5 and other models

## Community Guidelines

- Be respectful and inclusive
- Help others in issues and discussions
- Share your successful builds and modifications
- Credit others' work and ideas

## Questions?

Open a [GitHub Discussion](../../discussions) for general questions or ideas.

---

Thank you for contributing to this project! Every contribution, no matter how small, is appreciated. 🙏
