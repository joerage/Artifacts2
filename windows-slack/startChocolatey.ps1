Param(
    # comma or semicolon separated list of chocolatey packages.
    [ValidateNotNullOrEmpty()]
    [Parameter(Mandatory=$True)]
    [string] $packageList,

    [Parameter(Mandatory=$True)]
    [string] $username,

    [Parameter(Mandatory=$True)]
    [string] $password
)


[Environment]::UserName
[Environment]::UserDomainName
[Environment]::MachineName

Write-Host [Environment]::UserName
Write-Host [Environment]::UserDomainName
Write-Host [Environment]::MachineName

Write-Host "UserName: " + [Environment]::UserName
Write-Host "UserDomainName: " + [Environment]::UserDomainName
Write-Host "MachineName: " + [Environment]::MachineName
Write-Host "Password is $password"

$secPassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("$env:COMPUTERNAME\$($username)", $secPassword)

$command = $PSScriptRoot + "\ChocolateyPackageInstaller.ps1"

# Run Chocolatey as the specifyed user
Enable-PSRemoting –Force -SkipNetworkProfileCheck

# Ensure that current process can run scripts. 
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force 

Invoke-Command -FilePath $command -Credential $credential -ComputerName $env:COMPUTERNAME -ArgumentList $packageList