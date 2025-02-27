# Create a new instance of the bot
$bot = [NetworkDeviceBot]::new()

# Scan the network for devices
$devices = $bot.ScanNetwork()

# Check connectivity for a specific device
$deviceStatus = $bot.CheckDeviceConnectivity("192.168.1.10")

# Access a shared folder
$shareResult = $bot.AccessSharedFolder("192.168.1.10", "SharedFolder")

# Execute a remote PowerShell command
$remoteResult = $bot.ExecuteRemoteCommand("192.168.1.10", { Get-Process })

# Scan ports
$openPorts = $bot.ScanPorts("192.168.1.10")

# Get SNMP information
$snmpInfo = $bot.GetSNMPInfo("192.168.1.10")

# Execute SSH command
$sshResult = $bot.ExecuteSSHCommand("192.168.1.10", "ls -l")

# Get WMI information
$wmiInfo = $bot.GetWMIInfo("192.168.1.10")
