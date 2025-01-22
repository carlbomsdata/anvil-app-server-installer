# Anvil App Server Windows Installer

The **Anvil App Server Windows Installer** is a simple tool designed to save time and ensure consistency when setting up the Anvil App Server on Windows. If you've struggled with installation and configuration in the past, this installer will streamline the process and get you up and running quickly.

---

## 🚀 Features

This installer automates the installation of:

- **Git** (version 2.47)
- **Python** (version 3.13.1)
- **vcredist 2013**
- **Amazon Corretto** (version 21.0.5.11.1)

All components are installed to their default locations, and the following files are placed in `C:\AnvilAppServer` (default location, customizable):

- `nssm.exe`: Tool for registering a Windows service.
- `install.bat`: Script to initialize your Anvil project and set up the Windows service.
- `run.bat`: Script that runs the Anvil App Server in a controlled environment.

---

## 🛠️ Installation Guide

1. **Create a Windows user account** called `anvil-user` with non-admin rights.
2. **Download the installer** from the [releases page](https://github.com/carlbomsdata/anvil-app-server-installer/releases).
3. Follow the instructions provided by the installer.
4. **Download your Anvil project** (e.g., using `git clone`) inside `C:\AnvilAppServer` (or your chosen location).
5. Run `install.bat` and you're done! 🎉

---

## ⚙️ Behind the Scenes

Here’s a general overview of what happens when the provided scripts are executed:

### `install.bat`

- **Creates a log directory**: Ensures logs are stored in `C:\AnvilAppServer\log` for debugging and monitoring purposes.
- **Checks for an existing service**: If the Anvil App Server service (`AnvilAppService`) already exists, it stops and removes the service to avoid conflicts.
- **Registers a new service**: Uses `nssm.exe` to create a Windows service called `AnvilAppService`, configured to run as the non-admin user `anvil-user`.
- **Sets up logging**: Configures the service to log all output (both `stdout` and `stderr`) to a single log file.
- **Starts the service**: Ensures the service is up and running after setup.

### `run.bat`

- **Sets up a Python environment**:
  - Checks for an existing virtual environment. If it doesn’t exist, it creates one.
  - Activates the virtual environment and upgrades `pip` to the latest version.
- **Installs the Anvil App Server**: Downloads and installs the `anvil-app-server` Python package into the virtual environment.
- **Configures SSL certificates**: Points the `SSL_CERT_FILE` environment variable to the appropriate certificate file for secure connections.
- **Starts the Anvil App Server**: Launches the server, using a placeholder for the project name that you replace with your actual project.

---

## ⚠️ Important Notes

- This installer is in **early development**. It's recommended to test it on a fresh computer or virtual machine to avoid any conflicts with existing installations.
- The scripts are designed to work with the default setup. Adjustments might be needed for custom configurations.
- Feedback and contributions are welcome!

---

## 🌟 Why Use This Installer?

Setting up the Anvil App Server on Windows can be tricky and time-consuming. This installer ensures:

- Consistent installation across projects.
- Quick setup with minimal manual configuration.
- Preconfigured environment for running Anvil App Server as a Windows service.

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---
