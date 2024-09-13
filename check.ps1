$PackageName = "Wallpaper"
$Version = 1

$ProgramVersion_current = Get-Content -Path "C:\ProgramData\TechwithNifan\Validation\$PackageName" 

if($ProgramVersion_current -eq $Version){
    Write-Host "Found it!"
}