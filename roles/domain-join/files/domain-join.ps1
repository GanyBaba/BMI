"Checking if server is added to Domain" | Out-File -Append c:\temp\join.txt
$username = "Test\rahamath"
$secpasswd = ConvertTo-SecureString “Passw0rd123” -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
If (!((Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain)) {
    "Server is not part of Domain" | Out-File -Append c:\temp\join.txt
    
    Add-Computer Test.com -Credential $mycreds
    write-Host "CHANGED"
}