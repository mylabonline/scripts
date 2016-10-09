Configuration InstallApplications
{
Import-DscResource -ModuleName PSDesiredStateConfiguration


Node $env:ComputerName
{
     File CopyCoreSoftwareFolder
{
           Type = "Directory"
            Ensure = 'Present'
            Recurse = $true
            SourcePath = '\\TDAY-DSCDC01\Share\ServerTools'
            DestinationPath = 'C:\ServerTools\'
            Force = $true
 
        }

   Package DTC
    {
        Ensure = "Present"
        Name = "ManageEngine Desktop Central 9 - Agent"
        Path = "C:\ServerTools\DTC\dssetup\DesktopCentralAgent.msi"
        ProductId = '6AD2231F-FF48-4D59-AC26-405AFAE23DB7'
        Arguments = 'TRANSFORMS="DesktopCentralAgent.mst" ENABLESILENT=yes REBOOT=ReallySuppress /lv Agentinstalllog.txt /quiet'

        }

Package NimSoft
    {
        Ensure = "Present"
        Name = "Nimsoft Robot x64 version 7.70"
        Path = "C:\ServerTools\NimSoft\NimBUSRobot.exe"
        ProductId = 'D4BD8ECF-3D32-4F3E-A4DB-A87052CFD4EA'
        Arguments = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'

        }
 Package SEP
    {
        Ensure = "Present"
        Name = "Symantec Endpoint Protection"
        Path = "C:\ServerTools\SEP\SEP.exe"
        ProductId = 'B53661DC-CD94-4B14-B15F-D9DDCFF72558'
        Arguments = '/s /v"/l*v log.txt /qn RUNLIVEUPDATE=0 REBOOT=FORCE"'

        }

    }
}
InstallApplications