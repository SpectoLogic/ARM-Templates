
# ARM Ubunto with VSCode and ASP.NET Core

<p style="color:red">Not yet completly stable! - Use at own risk!</p>

This ARM Templates creates a linux Ubuntu machine configured with Visual Studio Code 
and ASP.NET Core which <b>can be used with Remote Desktop</b> from your PC. 
The template is based the <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/docker-simple-on-ubuntu">Ubunto-Simple template</a> from Corey Sanders.

## Features  
- Docker (from Docker Extension)
- Ubuntu Desktop with XRDP and xfce4 
- Visual Studio Code
- .NET Core SDK
- NodeJS and NPM v6
- Yeoman with ASP.NET Generator
- C# Extension for Visual Studio Code

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https:%2F%2Fraw.githubusercontent.com%2FSpectoLogic%2FARM-Templates%2Fmaster%2FUbuntoXRDPVSCode%2FUbuntoXRDPVSCode%2FTemplates%2FUbuntuVSCode.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https:%2F%2Fraw.githubusercontent.com%2FSpectoLogic%2FARM-Templates%2Fmaster%2FUbuntoXRDPVSCode%2FUbuntoXRDPVSCode%2FTemplates%2FUbuntuVSCode.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

### Known Issues
- Ubuntu Desktop installation has error with the component "dictionaries" and this presents a system error that startup, which seems to have no impact on the functionality of VSCode,... (Details can be found after the installation in the directory /var/crash )!
- Sometimes the XRDP with xfce does not install/configure correctly. This prevents logging on with remote desktop presenting the error: "Unable to load a failsafe session". As possible causes it is listing xconfd not running (D-Bus setup issue) or environment variable $XD_CONFIG_DIRS. However i tried all sorts of presented fixes of online communities, but nothing worked! I even removed all ubuntu desktop, dbus, xfce components and have reinstalled everything with no success. Any hints of an ubuntu pro are appreciated.
