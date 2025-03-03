# Create a new instance of the bot
$bot = [NetworkDeviceBot]::new()

# Scan the network for devices
$devices = $bot.ScanNetwork()

# Check connectivity for a specific device
$deviceStatus = $bot.CheckDeviceConnectivity("192.168.1.10")

# Backup device configuration
$backupResult = $bot.BackupDeviceConfig("192.168.1.10")

# Restore device configuration from backup
$restoreResult = $bot.RestoreDeviceConfig("192.168.1.10", $backupResult.BackupPath)

# Discover network services
$services = $bot.DiscoverNetworkServices()

# Execute an automation task
$automationResult = $bot.ExecuteAutomationTask -taskName "update_devices" -parameters @{
    target_hosts = "all"
    extra_vars = @{
        update_type = "security"
    }
}

# Detect anomalies in traffic data
$anomalyResult = $bot.DetectAnomalies @{
    BytesIn = 1000000
    BytesOut = 800000
    PacketCount = 5000
    Timestamp = Get-Date
    DayOfWeek = (Get-Date).DayOfWeek.value__
}

# Start the dashboard
$dashboardResult = $bot.StartDashboard()

# Schedule a periodic health check task
$healthCheck = {
    $devices = $bot.ScanNetwork()
    $healthyDevices = $devices | Where-Object IsReachable
    $bot.Log("Health Check: Found $($healthyDevices.Count) healthy devices")
}
$bot.ScheduleTask -name "HealthCheck" -script $healthCheck -interval ([timespan]"00:05:00")

# Handle security operations
$encryptedData = $bot.HandleSecurity("EncryptData", @{
    Data = "Sensitive configuration data"
})
$decryptedData = $bot.HandleSecurity("DecryptData", @{
    Data = $encryptedData.EncryptedData
    Key = $encryptedData.Key
})
