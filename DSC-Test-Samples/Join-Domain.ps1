configuration JoinBMSLDomain
{ 
	
Import-DscResource -Module xDSCDomainjoin 
 
	$Credential = Get-AutomationPSCredential -Name "DomainJoinCreds" 
	
	Node "localhost"
	{

xDSCDomainjoin JoinDomain
{
Domain = 'demo.com' 
Credential = $Credential
JoinOU = "OU=Azure East US,DC=DEMO,DC=COM"
}


	}
}

