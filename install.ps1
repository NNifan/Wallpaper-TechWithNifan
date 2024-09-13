$PackageName = "Wallpaper"
$Version = 1

# Set image file names for desktop background
$WallpaperIMG = "BG.jpg"

Start-Transcript -Path "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs\$PackageName-install.log" -Force
$ErrorActionPreference = "Stop"

# Set variables for registry key path and names of registry values to be modified
$RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$DesktopPath = "DesktopImagePath"
$DesktopStatus = "DesktopImageStatus"
$DesktopUrl = "DesktopImageUrl"
$StatusValue = "1"

# Local path of the image
$WallpaperLocalIMG = "C:\Windows\System32\Desktop.jpg"

# Check whether the image file variable has a value, output warning message and exit if missing
if (!$WallpaperIMG) {
    Write-Warning "WallpaperIMG must have a value."
} else {
    # Check whether registry key path exists, create it if it does not
    if (!(Test-Path $RegKeyPath)) {
        Write-Host "Creating registry path: $($RegKeyPath)."
        New-Item -Path $RegKeyPath -Force
    }
    
    # Set the desktop wallpaper
    Write-Host "Copy wallpaper ""$($WallpaperIMG)"" to ""$($WallpaperLocalIMG)"""
    Copy-Item ".\Data\$WallpaperIMG" $WallpaperLocalIMG -Force
    Write-Host "Creating regkeys for wallpaper"
    New-ItemProperty -Path $RegKeyPath -Name $DesktopStatus -Value $StatusValue -PropertyType DWORD -Force
    New-ItemProperty -Path $RegKeyPath -Name $DesktopPath -Value $WallpaperLocalIMG -PropertyType STRING -Force
    New-ItemProperty -Path $RegKeyPath -Name $DesktopUrl -Value $WallpaperLocalIMG -PropertyType STRING -Force
}

New-Item -Path "C:\ProgramData\TechwithNifan\Validation\$PackageName" -ItemType "file" -Force -Value $Version

Stop-Transcript
