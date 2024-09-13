$PackageName = "Wallpaper"

# Set image file names for desktop background
# Leave blank if you wish not to set
$WallpaperIMG = "BG.jpg"

Start-Transcript -Path "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs\$PackageName-uninstall.log" -Force
$ErrorActionPreference = "Stop"

# Set variables for registry key path and names of registry values to be modified
$RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$DesktopPath = "DesktopImagePath"
$DesktopStatus = "DesktopImageStatus"
$DesktopUrl = "DesktopImageUrl"

# Check whether the image file variable has a value, output warning message and exit if missing
if (!$WallpaperIMG) {
    Write-Warning "WallpaperIMG must have a value."
} else {
    # Check whether registry key path exists
    if (!(Test-Path $RegKeyPath)) {
        Write-Warning "The path ""$RegKeyPath"" does not exist. Therefore no wallpaper is set by this package."
    } else {
        # Remove registry keys related to the wallpaper
        Write-Host "Deleting regkeys for wallpaper"
        Remove-ItemProperty -Path $RegKeyPath -Name $DesktopStatus -Force
        Remove-ItemProperty -Path $RegKeyPath -Name $DesktopPath -Force
        Remove-ItemProperty -Path $RegKeyPath -Name $DesktopUrl -Force
    }
}

# Remove the validation file and directory
Write-Host "Deleting Validation file."
Remove-Item -Path "C:\ProgramData\TechwithNifan\Validation\$PackageName" -Force
Remove-Item -Path "C:\ProgramData\TechwithNifan" -Force -Recurse 

Stop-Transcript
