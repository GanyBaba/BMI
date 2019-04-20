$DNS="172.31.27.166"
#Get the Network card that matches up to the Network Parameter    
$nics = Get-WMIObject Win32_NetworkAdapterConfiguration | Where-Object {$_.IpEnabled -eq 'True'}
#Set DNS
foreach ($nic in $nics) {
    $nic.SetDNSServerSearchOrder($DNS)
}