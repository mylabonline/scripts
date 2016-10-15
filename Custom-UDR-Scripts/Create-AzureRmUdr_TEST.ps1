Param(
    [parameter(mandatory)][string]$udrName,
    [parameter(mandatory)][string]$resourceGroup,
    [parameter(mandatory)][string]$location,
    [parameter(mandatory)][string]$tagName,
    [parameter(mandatory)][string]$tagValue,
    [parameter(mandatory)][string]$routeCsv
) 

$udrtable = (Get-AzureRmRouteTable | Where-Object {$_.Name -like "RouteAzureServices"} | Sort-Object Priority)

$downloadUri = "https://www.microsoft.com/en-in/download/confirmation.aspx?id=41653"

$downloadPage = Invoke-WebRequest -Uri $downloadUri

$xmlFileUri = ($downloadPage.RawContent.Split('"') -like "https://*PublicIps*")[0]

$response = Invoke-WebRequest -Uri $xmlFileUri

[xml]$xmlResponse = [System.Text.Encoding]::UTF8.GetString($response.Content)

$regions = $xmlResponse.AzurePublicIpAddresses.Region

$selectedRegions = $regions.Name | Out-GridView -Title "Select Azure Datacenter Regions …" -PassThru

$ipRange = ( $regions | where-object Name -In $selectedRegions ).IpRange

#route array

$routesArray = @()

ForEach ($subnet in $ipRange.Subnet) { $ruleName = "Allow_Azure_Out_" + $subnet.Replace("/","-") }

#add routes

foreach ($subnet in $ipRange.Subnet)
{
    $udrRoute = New-AzureRmRouteConfig -Name $ruleName -NextHopType Internet -AddressPrefix ($ipRange | Out-String)
    $routesArray += $udrRoute
}


#create udr

$udr = New-AzureRmRouteTable -Name $udrName -ResourceGroupName SERVERS -Location $location -Route $routesArray -Tag @{Name=$tagName;Value=$tagValue}