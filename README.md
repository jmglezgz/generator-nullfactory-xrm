# generator-nullfactory-xrm
> Dynamics CRM Solution Template

[![Build status](https://ci.appveyor.com/api/projects/status/4dmqta7pnueqxa11?svg=true)](https://ci.appveyor.com/project/shanec-/generator-nullfactory-xrm)

A yeoman template for managing [Solution Packager](https://msdn.microsoft.com/en-us/library/jj602987.aspx)-compatible Dynamics CRM solutions.

## Installation

First, install [Yeoman](http://yeoman.io) and generator-nullfactory-xrm using [npm](https://www.npmjs.com/) (we assume you have pre-installed [node.js](https://nodejs.org/)).

```bash
npm install -g yo
npm install -g generator-nullfactory-xrm
```

Then generate your new project:

```bash
yo nullfactory-xrm
```

## Execution

Template questions and their purpose:

1. Visual Studio solution file name?  `The visual studio solution filename.`
2. Visual Studio project prefix?  `The prefix for the projects generated. This can be an organization name or preferred convention.`
3. Source CRM server url? `This is the source CRM server url. Example:[https://sndbx.crm6.dynamics.com](https://sndbx.crm6.dynamics.com)`
4. Source CRM solution name? `The name of the CRM solution to be extracted.`
5. Add *.WebResource project? `Specifies if a new project should be created to manage the web resouces.`
6. Add *.Plugin project? `Specifies if a new plugin project should be created.`
7. Add *.Workflow project? `Specifies if a new workflow project should be created`

## Post Installation Setup

Start off by updating the packages for the `Nullfactory.Xrm.Tooling` project. Open up the `Package Manager Console` in Visual Studio and execute the following command:

```
Update-Package -reinstall -Project Nullfactory.Xrm.Tooling
```

Next, if you opted to add either a plugin or workflow project, ensure that the assembly is signed with a new key.  

Optionally, install the [`Microsoft.Xrm.Data.PowerShell`](https://github.com/seanmcne/Microsoft.Xrm.Data.PowerShell) powershell module. On a Windows 10 or later, do this by executing the included powershell script `Nullfactory.Xrm.Tooling\_Install\Install-Microsoft.Xrm.Data.PowerShell.ps1` or manually running the following command:

```
Install-Module -Name Microsoft.Xrm.Data.PowerShell -Scope CurrentUser -Force
```

Even if you skip the above step, the sychrnoization powershell script would attempt to install it automatically.

## Syncing a Solution to the Project

Anytime the CRM solution needs to be synchronized back to the project, execute the script located at `Nullfactory.Xrm.Tooling\Scripts\Pull-CrmSolution.Param.ps1`.

### Resource Mapping

Edit the mapping file to map to the appropriate resource project. They are located in the `Nullfactory.Xrm.Tooling\Mapping` folder. 
More information on the structure of the mapping file can be found [here](https://msdn.microsoft.com/en-us/library/jj602987.aspx#use_command)

## Building the CRM Solution

The repackaging the extracted solution is integrated as a post-build step of the solution class library. Simply build it to output both a managed as well as unmanaged CRM solution package. 

### Source Control, CI Builds and Release Management

More information on source control management, setting up continuous integration builds and automated releases:

- [Release Strategy for Dynamics CRM - Part 1 - Preparation](http://www.nullfactory.net/2016/10/release-strategy-for-dynamics-crm-prepping-part-1/)
- [Release Strategy for Dynamics CRM - Part 2 - Setting Up the Build](http://www.nullfactory.net/2016/11/release-strategy-for-dynamics-crm-setting-up-the-build-part-2/)
- [Release Strategy for Dynamics CRM - Part 3 - Setting Up the Release](http://www.nullfactory.net/2016/11/release-strategy-for-dynamics-crm-setting-up-the-release-part-3/)
- [Release Strategy for Dynamics CRM - Part 4 - Versioning](http://www.nullfactory.net/2016/11/release-strategy-for-dynamics-crm-versioning-part-4/)

## Feedback

Please submit any feature requests or issues found to [https://github.com/shanec-/generator-nullfactory-xrm/issues](https://github.com/shanec-/generator-nullfactory-xrm/issues)

## License

Apache-2.0 © [Shane Carvalho](http://www.nullfactory.net)
