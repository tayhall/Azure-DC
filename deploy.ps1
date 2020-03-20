# Inital Variables
$Location = "East US" 
$AdminUsername = Andrew
$AdminPassword = "https://coronavirus.vault.azure.net/secrets/ITSecret/4beac336dbde423498234823cf2dde86"
$DomainName = "SCUKDOM.local"
$DnsPrefix = "SCUKDOM"
$VmSize = "Standard_DS1_V2"
$_artifactsLocation = ""
$_artifactsLocationSasToken ""
$VirtualMachineName = "MYDC1"
$VirtualNetworkName = "adLAN"
$VirtualNetworkAddressRange = "172.16.1.0/24"
$LoadBalancerFEIPName = "LBFE"
$BackendAddressPoolName = "LBBE"
$ResourceGroupName = $DnsPrefix + "rg"
$InboundNatRulesName = "adRDP"
$NetworkInterfaceName = "adNic"
$PrivateIPAddress = "172.16.100.100"
$SubnetName = "adSubnet"
$SubnetRange = "172.16.100.0/24"
$PublicIPAddressName = "adPublicIP"
$AvailabilitySetName = "adAvailabiltySet"
$LoadBalancerName  = "adLoadBalancer"



# Deploy the new domain
New-AzResourceGroup -Name $ResourceGroupName -Location $Location 
New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateURI "https://github.com/tayhall/Azure-DC/blob/master/azuredeploy.json"