class Tpds < Formula
  # Description of the formula
  desc "Microchip Trust Platform Design Suite (TPDS)"
  homepage "https://www.microchip.com"

  # Dependencies required for TPDS
  depends_on "python@3.10"  # Python version required for the virtual environment
  depends_on "libusb"        # Required for USB communication with Microchip devices

  def install
    # Define the virtual environment path
    venv_path = libexec/"venv"
    python = Formula["python@3.10"].opt_bin/"python3.10"

    # Create a Python virtual environment
    system python, "-m", "venv", venv_path
    
    # Upgrade pip and essential packaging tools
    system venv_path/"bin/pip", "install", "--upgrade", "pip", "setuptools", "wheel"
    
    # Install TPDS and its required extensions
    system venv_path/"bin/pip", "install", "tpds-application[ext]", "tpds-extension-ta010-support", "tpds-extension-ecc204-support"
    
    # Create a wrapper script to launch TPDS from the command line
    (bin/"tpds").write <<~EOS
      #!/bin/bash
      source "#{venv_path}/bin/activate"
      export QTWEBENGINE_CHROMIUM_FLAGS="--no-sandbox"
      exec python "#{venv_path}/bin/tpds" "$@"
    EOS
    chmod 0755, bin/"tpds"

    # Create a macOS application bundle for Finder launch
    app_path = prefix/"Applications/TPDS.app/Contents/MacOS"
    app_path.mkpath
    (app_path/"tpds").write <<~EOS
      #!/bin/bash
      exec #{bin}/tpds "$@"
    EOS
    chmod 0755, app_path/"tpds"
  end

  def caveats
    <<~EOS
      TPDS has been installed in a virtual environment.
      To launch it from the terminal, run:
        tpds
      To launch it from Finder, go to:
        #{opt_prefix}/Applications/TPDS.app
    EOS
  end

  # Define a test to verify installation
  test do
    system "#{bin}/tpds", "--version"
  end
end
