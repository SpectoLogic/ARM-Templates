
# ARM Ubunto with VSCode and ASP.NET Core

This ARM Templates creates a linux Ubuntu machine configured with Visual Studio Code 
and ASP.NET Core which <b>can be used with Remote Desktop</b> from your PC. 
The template is based the <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/docker-simple-on-ubuntu">Ubunto-Simple template</a> from Corey Sanders.

## Features  
- Docker (from Docker Extension)
- Ubuntu Desktop with XRDP and xfce4 (Full or Minimal) 
- Visual Studio Code
- .NET Core SDK
- NodeJS and NPM v6
- Yeoman with ASP.NET Generator
- C# Extension for Visual Studio Code

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https:%2F%2Fraw.githubusercontent.com%2FSpectoLogic%2FARM-Templates%2Fmaster%2FUbuntoXRDPVSCode%2FUbuntoXRDPVSCode%2FTemplates%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https:%2F%2Fraw.githubusercontent.com%2FSpectoLogic%2FARM-Templates%2Fmaster%2FUbuntoXRDPVSCode%2FUbuntoXRDPVSCode%2FTemplates%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

## Parameters

The template requires following parameter: 
- <b>vm_vsCodeVM_adminUser</b>: Your admin username NOT admin, Administrator,...
- <b>vm_vsCodeVM_adminPassword</b>: Password
- <b>net_domainName</b>: Domainname to reach machine at 
   <br />domainname.resource-group-location.cloudapp.azure.com. <br />Example: <b>mytest</b>.westeurope.cloudapp.azure.com
- <b>ubunto_desktop</b>: true = Full Desktop, false = Minimum Desktop

