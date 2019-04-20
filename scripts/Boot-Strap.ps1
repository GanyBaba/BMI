Function Write-Log {
    Param ($Message,$Level="INFO")
    "$(Get-Date) `t $Level `t $Message" | Out-file -Append C:\temp\BuildLogs.txt
    write-host "$(Get-Date) `t $Level `t $Message"
}


MD -Path c:\temp -Force -ErrorAction SilentlyContinue

# Disable Firewall

#Configure WinRM
Write-Log "Seting TS connection"
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" –Value "0"


Write-Log "configure firewall"
NetSh Advfirewall set allprofiles state off

start-sleep -Seconds 5


Write-Log "WINRM settings"
winrm quickconfig -q
winrm quickconfig -transport:http
winrm set winrm/config '@{MaxTimeoutms="7200000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="0"}'
winrm set winrm/config/winrs '@{MaxProcessesPerShell="0"}'
winrm set winrm/config/winrs '@{MaxShellsPerUser="0"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/listener?Address=*+Transport=HTTP '@{Port="5985"} '
write-Host "WINRM settings completed"
net stop winrm
sc.exe config winrm start= auto
net start winrm
start-sleep -Seconds 5

