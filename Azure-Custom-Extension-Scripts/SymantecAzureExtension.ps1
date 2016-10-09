$source = 'C:\SymantecEndpointProtectionInstaller' 

If (!(Test-Path -Path $source -PathType Container)) {New-Item -Path $source -ItemType Directory | Out-Null} 
 
$packages = @( 
@{title='Symantec Endpoint Protection';url='https://automationdsc.blob.core.windows.net/customscriptfiles/SEP.exe';Arguments=' /s /v"/qn RUNLIVEUPDATE=1 REBOOT=ReallySuppress"';Destination=$source}
) 
 
 
foreach ($package in $packages) { 
        $packageName = $package.title 
        $fileName = 'SEP.exe'
        $destinationPath = $source + "\" + $fileName 
 
If (!(Test-Path -Path $destinationPath -PathType Leaf)) { 
 
    Write-Host "Downloading $packageName" 
    $webClient = New-Object System.Net.WebClient 
    $webClient.DownloadFile($package.url,$destinationPath) 
    } 
    }
 
 
#Once we've downloaded all our files lets install them. 
foreach ($package in $packages) { 
    $packageName = $package.title 
    $fileName = 'SEP.exe'
    $destinationPath = $source + "\" + $fileName 
    $Arguments = $package.Arguments 
    Write-Output "Installing $packageName" 
 
 
$appsetup = Start-Process $destinationPath -ArgumentList $Arguments -PassThru -Wait
If ($appsetup.exitcode -eq 0){
write-host "Install completed without errors"
}
}
