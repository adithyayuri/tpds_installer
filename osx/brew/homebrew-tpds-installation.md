# Homebrew and TPDS Installation Guide

## Installing Homebrew

### Prerequisites
- macOS (Intel or Apple Silicon)
- Command Line Tools for Xcode

### Installation Steps

1. Open Terminal

2. Install Homebrew by running the official installation script:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. Verify the installation:
   ```bash
   brew --version
   ```

4. Update Homebrew to ensure you have the latest version:
   ```bash
   brew update
   ```

## Installing TPDS Formula Locally

### Preparation

1. Create a local tap (repository) for your formula:
   ```bash
   mkdir -p $(brew --repo)/Library/Taps/user_name/homebrew-tpds
   ```

2. Navigate to the tap directory:
   ```bash
   cd $(brew --repo)/Library/Taps/user_name/homebrew-tpds
   ```

3. Create a `Formula` directory:
   ```bash
   mkdir Formula
   ```

4. Paste `tpds_brew.rb` into `Formula` directory:



### Installing the Formula

1. Link the tap:
   ```bash
   brew tap-new user_name/tpds
   ```

2. Install the formula:
   ```bash
   brew install --build-from-source user_name/tpds/tpds
   ```

### Testing the Installation

1. Verify the installation:
   ```bash
   tpds --version
   ```

2. Launch the application from the terminal or Finder

## Troubleshooting

- Ensure all dependencies are installed
- Check that Python 3.10 is available
- Verify libusb is installed
- Consult Microchip's documentation for specific TPDS requirements

## Uninstalling

To remove the TPDS formula:
```bash
brew uninstall tpds
brew untap user_name/tpds
```

## Notes

- This installation creates a Python virtual environment
- The application can be launched from both terminal and Finder
- Requires an active internet connection during installation
