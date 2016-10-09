configuration ChangeRegistry
{ 
# Import DSC Modules
Import-DscResource -ModuleName PSDesiredStateConfiguration

Node "localhost"
	{

# This is for Windows Server 2008 R2 - Default Execution Policy is set to Restricted
Registry ExecutionPolicy {

        Ensure = 'Present';
        Key = 'HKEY_LOCAL_MACHINE\Software\MicrosoftPowerShell\1\ShellIds\Microsoft.PowerShell'
        ValueName = 'ExecutionPolicy'
        ValueData = 'RemoteSigned'
        ValueType = 'String'
	Force = $true 
 }
}