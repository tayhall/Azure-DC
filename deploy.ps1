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
$Location = "West US 2" 
$domainName = "corp.UKTSTDOM.local"
$domainNameLabel ="UKTSTDOM"
$dnsPrefix = "myDNSPre"
#$resourceGroupName = "azDomrg"
$VmSize = "Standard_DS1_V2"

$projectName = Read-Host -Prompt "Enter a project name that is used for generating resource names"

# Create a keyVault

# $upn = Read-Host -Prompt "Enter your user principal name (email address) used to sign in to Azure"
$upn = "Andrew Hall"
$secretValue = Read-Host -Prompt "Enter the virtual machine administrator password" -AsSecureString
$resourceGroupName = $projectName + "rg"
$keyVaultName = 'mySecretLocker99'
$adUserId = (Get-AzADUser -DisplayName $upn).Id
$templateUri = "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/tutorials-use-key-vault/CreateKeyVault.json"

New-AzResourceGroup -Name $resourceGroupName -Location $location
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateUri -keyVaultName $keyVaultName -adUserId $adUserId -secretValue $secretValue


# Deploy the DC
New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName `
-TemplateURI "https://raw.githubusercontent.com/tayhall/Azure-DC/master/azuredeploy.json" -TemplateParameterURI "https://raw.githubusercontent.com/tayhall/Azure-DC/master/azuredeploy.parameters.json"`
-domainName $domainName -dnsPrefix $dnsPrefix
