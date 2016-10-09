$ConfigData = @{
	AllNodes = @(
		@{
			NodeName = 'localhost'
			PsDscAllowDomainUser = $true
			PSDscAllowPlainTextPassword = $true
		}
	)
} 

Start-AzureRmAutomationDscCompilationJob  -ResourceGroupName "AUTOMATION-STG-RG" -AutomationAccountName "BCOPREPRODAUTOMATION" `
-ConfigurationName "BCODSCS_DJ_WU_SEP" -ConfigurationData $ConfigData
