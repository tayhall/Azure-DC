# Inital Variables
$Location = "East US" 
$AdminUsername = "Andrew"
$AdminPassword = "https://coronavirus.vault.azure.net/secrets/ITSecret/4beac336dbde423498234823cf2dde86"
$DomainName = "SCUKDOM"
$domainNameLabel ="SCUKDOM"
$DnsPrefix = "SCUKDOM"
$VmSize = "Standard_DS1_V2"
$_artifactsLocation = ""
$_artifactsLocationSasToken = ""
$VirtualMachineName = "MYDC1"
$VirtualNetworkName = "adLAN"
$VirtualNetworkAddressRange = "172.16.1.0/24"
$LoadBalancerFEIPName = "LBFE"
$BackendAddressPoolName = "LBBE"
$ResourceGroupName = "IAASrg"
$InboundNatRulesName = "adRDP"
$NetworkInterfaceName = "adNic"
$PrivateIPAddress = "172.16.100.100"
$SubnetName = "adSubnet" 
$SubnetRange = "172.16.100.0/24"
$PublicIPAddressName = "adPublicIP"
$AvailabilitySetName = "adAvailabiltySet"
$LoadBalancerName  = "adLoadBalancer"



# Deploy the new resource group
New-AzResourceGroup -Name $ResourceGroupName -Location $Location 

# Assign public IP Range
New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateParameterUri "https://raw.githubusercontent.com/tayhall/Azure-DC/5a8dcc0c14ecd08c290d9c3ef3f9c31baff87765/publicip/parameters.json" -TemplateURI "https://raw.githubusercontent.com/tayhall/Azure-DC/5a8dcc0c14ecd08c290d9c3ef3f9c31baff87765/publicip/template.json"


# Deploy the DC
New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateURI "https://raw.githubusercontent.com/tayhall/Azure-DC/master/azuredeploy.json";
-adminUsername $AdminUsername -adminPassword $AdminPassword