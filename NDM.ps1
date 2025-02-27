class NetworkDeviceBot {
    # Constructor
    NetworkDeviceBot() {
        $this.IPRange = "192.168.1"
        $this.MaxPorts = 1024
        $this.Credentials = $null
    }

    # Method to ping and check device connectivity
    [PSCustomObject] CheckDeviceConnectivity([string]$ipAddress) {
        try {
            $pingResult = Test-Connection -ComputerName $ipAddress -Count 2 -ErrorAction Stop
            $tcpResult = Test-NetConnection -ComputerName $ipAddress -Port 80 -InformationLevel Detailed
            
            return [PSCustomObject]@{
                IPAddress = $ipAddress
                IsReachable = $pingResult.Count -gt 0
                ResponseTime = if ($pingResult.Count -gt 0) {$pingResult[0].ResponseTime} else {0}
                TcpPort80Open = $tcpResult.TcpTestSucceeded
                Error = $null
            }
        }
        catch {
            return [PSCustomObject]@{
                IPAddress = $ipAddress
                IsReachable = $false
                ResponseTime = 0
                TcpPort80Open = $false
                Error = $_.Exception.Message
            }
        }
    }

    # Method to scan network for devices
    [array] ScanNetwork() {
        $devices = @()
        1..254 | ForEach-Object {
            $ip = "$($this.IPRange).$_"
            $device = $this.CheckDeviceConnectivity($ip)
            if ($device.IsReachable) {
                $devices += $device
            }
        }
        return $devices
    }

    # Method to access shared folders
    [PSCustomObject] AccessSharedFolder([string]$ipAddress, [string]$shareName) {
        try {
            $sharePath = "\\$ipAddress\$shareName"
            New-PSDrive -Name "NetworkBot" -PSProvider FileSystem -Root $sharePath -Persist -ErrorAction Stop
            return [PSCustomObject]@{
                Success = $true
                DriveLetter = "NetworkBot"
                SharePath = $sharePath
                Error = $null
            }
        }
        catch {
            return [PSCustomObject]@{
                Success = $false
                DriveLetter = $null
                SharePath = $null
                Error = $_.Exception.Message
            }
        }
    }

    # Method for remote PowerShell access
    [PSCustomObject] ExecuteRemoteCommand([string]$ipAddress, [scriptblock]$scriptBlock) {
        try {
            if (-not $this.Credentials) {
                $this.Credentials = Get-Credential
            }
            
            $result = Invoke-Command -ComputerName $ipAddress -ScriptBlock $scriptBlock -Credential $this.Credentials -ErrorAction Stop
            return [PSCustomObject]@{
                Success = $true
                Output = $result
                Error = $null
            }
        }
        catch {
            return [PSCustomObject]@{
                Success = $false
                Output = $null
                Error = $_.Exception.Message
            }
        }
    }

    # Method to scan ports
    [array] ScanPorts([string]$ipAddress) {
        $openPorts = @()
        1..$this.MaxPorts | ForEach-Object {
            try {
                $result = Test-NetConnection -ComputerName $ipAddress -Port $_ -InformationLevel Quiet
                if ($result) {
                    $openPorts += [PSCustomObject]@{
                        IPAddress = $ipAddress
                        Port = $_
                        Protocol = "TCP"
                        IsOpen = $true
                        Error = $null
                    }
                }
            }
            catch {
                $openPorts += [PSCustomObject]@{
                    IPAddress = $ipAddress
                    Port = $_
                    Protocol = "TCP"
                    IsOpen = $false
                    Error = $_.Exception.Message
                }
            }
        }
        return $openPorts
    }

    # Method for SNMP access
    [PSCustomObject] GetSNMPInfo([string]$ipAddress) {
        try {
            $snmp = Get-WmiObject -Namespace root\SNMP\Microsoft -Class SNMP_RFC1213_MIB_system -ComputerName $ipAddress -ErrorAction Stop
            return [PSCustomObject]@{
                Success = $true
                SystemInfo = $snmp
                Error = $null
            }
        }
        catch {
            return [PSCustomObject]@{
                Success = $false
                SystemInfo = $null
                Error = $_.Exception.Message
            }
        }
    }

    # Method for SSH access
    [PSCustomObject] ExecuteSSHCommand([string]$ipAddress, [string]$command) {
        try {
            $sshProcess = Start-Process -FilePath "ssh" -ArgumentList "$ipAddress $command" -Wait -PassThru -NoNewWindow
            return [PSCustomObject]@{
                Success = $true
                Output = $sshProcess.ExitCode
                Error = $null
            }
        }
        catch {
            return [PSCustomObject]@{
                Success = $false
                Output = $null
                Error = $_.Exception.Message
            }
        }
    }

    # Method for WMI access
    [PSCustomObject] GetWMIInfo([string]$ipAddress) {
        try {
            if (-not $this.Credentials) {
                $this.Credentials = Get-Credential
            }
            
            $wmi = Get-WmiObject Win32_ComputerSystem -ComputerName $ipAddress -Credential $this.Credentials -ErrorAction Stop
            return [PSCustomObject]@{
                Success = $true
                SystemInfo = $wmi
                Error = $null
            }
        }
        catch {
            return [PSCustomObject]@{
                Success = $false
                SystemInfo = $null
                Error = $_.Exception.Message
            }
        }
    }
}
