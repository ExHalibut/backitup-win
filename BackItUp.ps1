<#
.SYNOPSIS
  Name: BackItUp.ps1
  A powershell script meant to backup file systems
  
.DESCRIPTION
  BackItUp uses Compress-Archive to create a zip of a given file directory

.PARAMETER InitialDirectory
  The initial directory which this example script will use.
  
.PARAMETER Add

  param (
    [string[]]$Name,
    [string[]]$Source,
    [string[]]$Destination
  )

.NOTES
  Version: 0.002a
  Author: ExHalibut
  Creation Date: 2019-06-02

.EXAMPLE 
  .\BackItUp.ps1 BackupName 'C:\Path\To\Source\Files' 'C:\Path\To\Destination'

#>


# A small powershell script meant to backup file systems

param (
  [string[]]$Name,
  [string[]]$Source,
  [string[]]$Destination
)

# Get ISO date
$isoDate = (Get-Date -UFormat '+%Y-%m-%d-%H-%M-%S')

# Declare intent
Write-Host "BackItUp - Backup $Name beginning"
Write-Host "BackItUp - Source: $Source"
Write-Host "BackItUp - Destination: $Destination"

# Check the destination folder exists
If (Test-Path $Destination) {
    Write-Host "BackItUp - $Destination already exists - Continuing"
    }
Else {
  Write-Host "BackItUp - $Destination does not exist - Creating"
  New-Item -ItemType Directory -Force -Path $Destination
}

# Wrap it up
Write-Host "BackItUp - Creating zip file at destination"
Compress-Archive -Path "$Source" -CompressionLevel Optimal -DestinationPath "$Destination\$Name-$isoDate.zip"

# I'll take it
If (Test-Path "$Destination\$Name-$isoDate.zip") {
  Write-Host "BackItUp - $Destination\$Name-$isoDate.zip exists"
  Write-Host "BackItUp - backup complete"
}
Else {
  Write-Host "BackItUp - $Destination does not exist"
  Write-Host "BackItUp - Backup failed"
}

