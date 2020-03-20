# Inital Variables
$Location = "East US" 
$AdminUsername = Andrew
$AdminPassword = "https://coronavirus.vault.azure.net/secrets/ITSecret/4beac336dbde423498234823cf2dde86"
$DomainName = "SCUKDOM"
$DnsPrefix
$VmSize = "Standard_DS1_V2"
$_artifactsLocation
$_artifactsLocationSasToken
$VirtualMachineName = "MYDC1"
$VirtualNetworkName = "adLAN"
$VirtualNetworkAddressRange = "172.16.1.0/24"
$LoadBalancerFEIPName
$BackendAddressPoolName
$ResourceGroupName = $DomainName + "rg"
$InboundNatRulesName "adRDP"
Network Interface Name
adNic
Private IP Address
10.0.0.4
Subnet Name
adSubnet
Subnet Range
10.0.0.0/24
Public IP Address Name
adPublicIP
Availability Set Name
adAvailabiltySet
Load Balancer Name
adLoadBalancer



# Deploy the new domain
New-AzResourceGroup -Name $ResourceGroupName -Location $Location 
New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile <path-to-template> 