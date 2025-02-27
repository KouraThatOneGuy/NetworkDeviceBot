# NetworkDeviceBot

## Overview
**NetworkDeviceBot** is a PowerShell-based automation tool designed to scan, access, and interact with devices on a local network. It provides functionalities such as:
- Device discovery and connectivity checking
- Network scanning
- Remote access via PowerShell, SSH, SNMP, and WMI
- Port scanning
- Shared folder access
- Credential management for authenticated operations

This bot is intended for **educational purposes only**. Unauthorized use on networks without permission may violate cybersecurity laws.

---

## Repository Structure

This repository contains the following files:

### **1. Main Code**
- `NetworkDeviceBot.ps1`: The core PowerShell script containing the bot's functionality.
- `Modules/`: Additional PowerShell modules that support the bot's operations.

### **2. Example Usage**
- `examples.ps1`: A script demonstrating how to initialize and use the bot's features.
- `config.json`: A sample configuration file for defining network parameters and authentication settings.

### **3. Documentation**
- `NetworkDeviceBot_Guide.pdf`: A detailed PDF explaining how the bot works, including setup, commands, and best practices.
- `README.md` (this file): Overview of the repository and usage instructions.

---

## Installation & Setup
### **Prerequisites**
- Windows with PowerShell 5.1 or later.
- Administrator privileges for certain operations (e.g., WMI queries, remote PowerShell execution).
- OpenSSH installed for SSH functionality.

### **Usage**
1. Clone the repository:
   ```powershell
   git clone https://github.com/yourusername/NetworkDeviceBot.git
   cd NetworkDeviceBot
   ```

2. Run the bot:
   ```powershell
   .\NetworkDeviceBot.ps1
   ```

3. Use example commands from `examples.ps1` to interact with network devices.

---

## Features & Commands
### **Device Connectivity Check**
```powershell
$bot.CheckDeviceConnectivity("192.168.1.10")
```
Checks if a device is reachable via ICMP ping and verifies if TCP port 80 is open.

### **Network Scanning**
```powershell
$devices = $bot.ScanNetwork()
```
Scans the subnet for active devices.

### **Remote Command Execution**
```powershell
$bot.ExecuteRemoteCommand("192.168.1.10", { Get-Process })
```
Runs PowerShell commands on a remote machine using WinRM.

### **Port Scanning**
```powershell
$openPorts = $bot.ScanPorts("192.168.1.10")
```
Scans for open ports on a target device.

### **Accessing Shared Folders**
```powershell
$bot.AccessSharedFolder("192.168.1.10", "SharedFolder")
```
Maps a network share as a local drive.

### **SNMP & WMI Information Retrieval**
```powershell
$snmpInfo = $bot.GetSNMPInfo("192.168.1.10")
$wmiInfo = $bot.GetWMIInfo("192.168.1.10")
```
Fetches system information using SNMP or WMI queries.

---

## Security & Compliance
- **Use on authorized networks only.** Running network scans or remote commands without permission is illegal.
- **Centralized authentication management** ensures secure credential handling.
- **Error handling mechanisms** prevent crashes and unauthorized access.
- **Secure communication protocols** (WinRM, SSH, SNMP) are used where applicable.

---

## Disclaimer
**This bot is for educational and ethical network administration purposes only.** Unauthorized scanning, access, or command execution on networks or devices without explicit permission may violate local and international laws. The repository owner is **not responsible for any misuse** of this tool.

---

## Future Enhancements
- Multi-threading for faster scanning.
- Logging and reporting of scan results.
- GUI interface for easier interaction.
- Customizable port scanning range.

---

## License
This project is licensed under the MIT License. See `LICENSE` for details.

---

## Contact & Contributions
- Contributions are welcome! Please submit a pull request.
- For issues or feature requests, open an issue on GitHub.

Enjoy exploring **NetworkDeviceBot** responsibly! 🚀

