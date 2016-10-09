$ConfigData = @{
	AllNodes = @(
		@{
			NodeName = 'localhost'
			PsDscAllowDomainUser = $true
			PSDscAllowPlainTextPassword = $true
		}
	)
} 

Start-AzureRmAutomationDscCompilationJob  -ResourceGroupName "AUTOMATION-STG-RG" -AutomationAccountName "PREPRODAUTOMATION" `
-ConfigurationName "DSCS_DJ_WU_SEP" -ConfigurationData $ConfigData
