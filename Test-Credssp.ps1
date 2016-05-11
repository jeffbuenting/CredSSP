$block = {
  Write-Host ("hello, world: {0}, {1}" -f $env:USERNAME, (hostname))
}
  

$testCred = get-credential

$serverName = 'jeffb-crm01.stratuslivedemo.com'

Write-output  "basic"       
 Invoke-Command $block 

Write-Output "remote"      
Invoke-Command $block -computername $serverName 

Write-Output  "credentialA" 
Invoke-Command $block -computername $serverName -credential $testCred  

Write-Output "credentialB" 
Invoke-Command $block -computername $serverName -credential $testCred  -Authentication Credssp

Write-Output  "session"     
$testSession = New-PSSession -computername $serverName -credential $testCred -Authentication Credssp
if ($testSession) { Invoke-Command $block -Session $testSession; Remove-PSSession $testSession }

