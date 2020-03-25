<#
Default Parameters

Name                          Type                       Value
============================  =========================  ==========
adminUsername                 String                     Andrew
adminPassword                 SecureString
domainName                    String                     corp.SCUKDOM.local
dnsPrefix                     String                     andybuswan
vmSize                        String                     Standard_D2s_v3
_artifactsLocation            String                     https://raw.githubusercontent.com/tayhall/Azure-DC/master/azuredeploy.json
_artifactsLocationSasToken    SecureString
location                      String                     eastus
virtualMachineName            String                     adVM
virtualNetworkName            String                     adVNET
virtualNetworkAddressRange    String                     10.0.0.0/16
loadBalancerFrontEndIPName    String                     LBFE
backendAddressPoolName        String                     LBBE
inboundNatRulesName           String                     adRDP
networkInterfaceName          String                     adNic
privateIPAddress              String                     10.0.0.4
subnetName                    String                     adSubnet
subnetRange                   String                     10.0.0.0/24
publicIPAddressName           String                     adPublicIP
availabilitySetName           String                     adAvailabiltySet
loadBalancerName              String                     adLoadBalancer

#>
# Inital Variables
$Location = "East US" 
$AdminUsername = "Andrew"
$AdminPassword = "https://coronavirus.vault.azure.net/secrets/ITSecret/4beac336dbde423498234823cf2dde86"
$domainName = "corp.SCUKDOM.local"
$domainNameLabel ="SCUKDOM"
$dnsPrefix = "andybuswan6"
$VmSize = "Standard_DS1_V2"
$VirtualMachineName = "MYDC1"
$VirtualNetworkName = "adLAN"
$VirtualNetworkAddressRange = "172.16.1.0/24"
$LoadBalancerFEIPName = "LBFE"
$BackendAddressPoolName = "LBBE"
#$ResourceGroupName = "IAASrg6"
$InboundNatRulesName = "adRDP"
$NetworkInterfaceName = "adNic"
$PrivateIPAddress = "172.16.100.100"
$SubnetName = "adSubnet" 
$SubnetRange = "172.16.100.0/24"
$PublicIPAddressName = "adPublicIP"
$AvailabilitySetName = "adAvailabiltySet"
$LoadBalancerName  = "adLoadBalancer"

$projectName = Read-Host -Prompt "Enter a project name that is used for generating resource names"

# Deploy the new resource group
#New-AzResourceGroup -Name $ResourceGroupName -Location $Location 

# Create a keyVault

# $upn = Read-Host -Prompt "Enter your user principal name (email address) used to sign in to Azure"
$upn = "AndyBusTrain_outlook.com#EXT#@AndyBusTrainoutlook.onmicrosoft.com"
$secretValue = Read-Host -Prompt "Enter the virtual machine administrator password" -AsSecureString
$resourceGroupName = "${projectName}rg"
$keyVaultName = $projectName
$adUserId = (Get-AzADUser -UserPrincipalName $upn).Id
$templateUri = "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/tutorials-use-key-vault/CreateKeyVault.json"

New-AzResourceGroup -Name $resourceGroupName -Location $location
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateUri -keyVaultName $keyVaultName -adUserId $adUserId -secretValue $secretValue

#$Pass = "ILikeSecurePassword1!"
#$SecurePass = ConvertTo-SecureString -String $Pass -AsPlainText -Force

# Deploy the DC
New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName `
-TemplateURI "https://raw.githubusercontent.com/tayhall/Azure-DC/master/azuredeploy.json" `
-adminUsername $AdminUsername -adminPassword $SecurePass -domainName $domainName -dnsPrefix $dnsPrefix
