
# ARM Ubunto with VSCode and ASP.NET Core

<p style="color:red">NOT YET COMPLETLY STABLE / TESTED ! - Use at own risk!</p>

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
- Ubuntu Desktop presents an system error that can be reported!
- Logfile /home/(user)/specto_status.txt shows ERROR installing ubuntu-desktop package! Check log specto_xrdp_Log0.txt for details. Hints are appreciated! 
- Sometimes the XRDP does not install correctly. Have not yet narrowed down the issue!
