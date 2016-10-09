Configuration InstallWindowsUpdates
{
Import-DscResource -ModuleName PSDesiredStateConfiguration

$PackageCredential = Get-AutomationPSCredential -Name "bcoazureautomationdsc"

Node "localhost"
{
File CopyWUpdatePSModule
        {
            Type = "Directory"
            Ensure = 'Present'
            Recurse = $true
            SourcePath = '\\bcoazureautomationdsc.file.core.windows.net\dscfiles\Modules\PSWindowsUpdate'
            DestinationPath = 'C:\Program Files\WindowsPowerShell\Modules\PSWindowsUpdate'
            Credential = $PackageCredential
            Force = $true
        }

Script InstallWindowsUpdates
 	 {
          GetScript = {
		Import-Module PSWindowsUpdate
 
          }
 
          SetScript = {
              
		$winupdate = Start-Job { Get-WUInstall -Verbose -AcceptAll }
		Wait-Job $winupdate
		Receive-Job $winupdate
          }
 
TestScript = {
      	$WUSettings = (Get-WUInstall -ListOnly)
      		if ($WUSettings -ne $null) 
			{
        	return $true } 
			else 
			{
     		return $false }
	}
		  }
	}
	}