$timer = Get-Date
while (((Get-Date) - $timer).TotalSeconds -le 600) {
    Write-Host "Time ealpsed " ((Get-Date) - $timer).Minutes "Minutes and" ((Get-Date) - $timer).Seconds "seconds"
    Start-sleep  -Seconds 30
}