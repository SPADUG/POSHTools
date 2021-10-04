<#
.SYNOPSIS
List all windows server

.DESCRIPTION
List all windows server

.PARAMETER HVServer
HyperV server name

.PARAMETER VCServer
VCenter server name

.PARAMETER Credential
credential to connect to server

.EXAMPLE
Get-EDLVm -HVServer MyHypervServer -VCServer MyVCServer -Credential "Get-Credential"

.NOTES
General notes
#>
Function Get-EDLVm
{
    #Start Function Get-EDLVm
    [CmdletBinding()]
    [OutputType([System.Object[]])]
    param (
        [System.String[]]$HVServer,
        [System.String[]]$VCServer,
        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$Credential
    )

    Begin
    {
        Write-Verbose ('[{0:O}] Starting {1}' -f (Get-Date), $myinvocation.mycommand)
        Write-Verbose ('[{0:O}] Checking the prerequisites...' -f (Get-Date))
        Write-Verbose ('[{0:O}] Checking if {1} module is present ...' -f (Get-Date), 'VMware.PowerCLI')
        if (!(Get-Module -ListAvailable -Name VMware.PowerCLI))
        {
            Write-Verbose ('[{0:O}] Install module {1}' -f (Get-Date), 'VMware.PowerCLI')
            Install-Module -Name VMware.PowerCLI -Force -AllowClobber -Scope CurrentUser
        }
        if (!(Get-Module -ListAvailable -Name Hyper-V))
        {
            Write-Verbose ('[{0:O}] Install module {1}' -f (Get-Date), 'Hyper-V')
            Install-Module -Name Hyper-V -Force -AllowClobber -Scope CurrentUser
        }
    }

    Process
    {
        $HVVms = foreach ($HVComputer in $HVServer)
        {
            Write-Verbose ('[{0:O}] Treatment of server {1}' -f (Get-Date), $HVComputer)
            Hyper-V\Get-VM -ComputerName $HVComputer | ForEach-Object {
                if ($_.Name -like 'SRV-*')
                {
                    [PSCustomObject]@{
                        Name  = $_.Name
                        State = if ($_.State -eq 'Running')
                        {
                            'ON'
                        }
                        else
                        {
                            'OFF'
                        }
                    }
                }
            }
        }

        $VCVms = foreach ($VCComputer in $VCServer)
        {
            Write-Verbose ('[{0:O}] Treatment of server {1}' -f (Get-Date), $VCComputer)
            $null = Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
            $null = Connect-VIServer -Server $VCComputer -Credential $Credential
            Get-VM | ForEach-Object {
                if ($_.GuestId -like 'win*')
                {
                    [PSCustomObject]@{
                        Name  = $_.Name
                        State = if ($_.PowerState -eq 'PoweredOn')
                        {
                            'ON'
                        }
                        else
                        {
                            'OFF'
                        }
                    }
                }
            }
        }
    }

    End
    {
        Write-Verbose ('[{0:O}] Ending {1}' -f (Get-Date), $myinvocation.mycommand)
        $AllVms = $HVVms + $VCVms
        return $AllVms | Sort-Object Name
    }
}
