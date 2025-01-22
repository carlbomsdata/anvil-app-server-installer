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

## 🛠️ How to Build the Installer Yourself

To build the installer, follow these steps:

1. **Clone the Repository**:  
   Use the following command in your terminal or Git Bash:  
   `git clone https://github.com/carlbomsdata/anvil-app-server-installer.git`

2. **Download Required Executables**:  
   The following files need to be downloaded manually and placed in the directory where you cloned this repository:  
   - Git (version 2.47): [Download Git](https://github.com/git-for-windows/git/releases/download/v2.47.1.windows.2/Git-2.47.1.2-64-bit.exe)  
   - Python (version 3.13.1): [Download Python](https://www.python.org/ftp/python/3.13.1/python-3.13.1-amd64.exe)  
   - vcredist 2013: [Download vcredist]([https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170#visual-studio-2013-vc-120))  
   - Amazon Corretto (version 21.0.5.11.1): [Download Corretto](https://corretto.aws/downloads/latest/amazon-corretto-21-x64-windows-jdk.msi)

3. **Update Paths**:  
   Ensure the paths to these executables are correctly referenced in the installer script files.

4. **Customize the Installer** (optional):  
   Modify the batch scripts (`install.bat` and `run.bat`) or other resources as needed for your specific use case.

5. **Create the Installer**:  
   Package the scripts and required files into an installer using tools like [Inno Setup](https://jrsoftware.org/isinfo.php) or other Windows installer frameworks.

6. **Test**:  
   Test the installer on a clean machine or virtual environment to ensure it works as expected.

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
