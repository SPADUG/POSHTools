
function Approve-WSUSUpdate
{
    <#
.SYNOPSIS
Approves updates on a WSUS server

.DESCRIPTION
Approves necessary updates on a computer group in WSUS

.PARAMETER TargetGroup
Computer group name in WSUS

.PARAMETER WSUSName
WSUS server name

.PARAMETER UseSSL
Use or not SSL (False by default)

.PARAMETER Port
Port used to connect to the WSUS server (8530 by default)

.PARAMETER ViewOnly
Show necessary updates without approving them

.EXAMPLE
Approve-WSUSUpdate -TargetGroup "MYGROUP1" -WSUSName "SRVWSUS" -ViewOnly

Shows all updates pending approval on the MYGROUP1 computer group

.EXAMPLE
Approve-WSUSUpdate -TargetGroup "MYGROUP1","MYGROUP2" -WSUSName "SRVWSUS" -ViewOnly

Displays all updates pending approval on each of the computer groups: MYGROUP1 and MYGROUP2

.EXAMPLE
Approve-WSUSUpdate -TargetGroup "MYGROUP1" -WSUSName "SRVWSUS"

Approves all pending updates on the MYGROUP1 computer group

.EXAMPLE
Approve-WSUSUpdate -TargetGroup "MYGROUP1","MYGROUP2" -WSUSName "SRVWSUS"

Approves all pending updates on each of the computer groups: MYGROUP1 and MYGROUP2

.NOTES
General notes
#>
    [CmdletBinding(DefaultParameterSetName = 'ByTargetGroup')]
    param (
        [Parameter(ParameterSetName = 'ByTargetGroup', Position = 0)]
        [System.String[]]$TargetGroup,
        [System.String]$WSUSName,
        [bool]$UseSSL = $false,
        [System.Int32]$Port = 8530,
        [Switch]$ViewOnly
    )

    begin
    {
        try
        {
            [reflection.assembly]::LoadWithPartialName('Microsoft.UpdateServices.Administration') | Out-Null
            $Wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer($WSUSName, $UseSSL, $Port)
        }
        catch
        {
            throw
        }


        $updateScope = New-Object Microsoft.UpdateServices.Administration.UpdateScope
        $updateScope.ApprovedStates = 'Any'
        $updateScope.IncludedInstallationStates = 'NotInstalled'
    }

    process
    {
        switch ($PsCmdlet.ParameterSetName)
        {
            'ByTargetGroup'
            {
                foreach ($Group in $TargetGroup)
                {
                    if (($wsus.GetComputerTargetGroups() | Where-Object { $_.Name -eq $Group }).count -ne 0)
                    {
                        Write-Verbose ('[{0:O}] Treatment of TargetGroup {1}' -f (Get-Date), $Group)
                        $MyGroup = $wsus.GetComputerTargetGroups() | Where-Object { $_.Name -eq $Group }
                        if (($MyGroup.GetComputerTargets()).count -ne 0)
                        {
                            Write-Verbose ('[{0:O}] Treatment of all computer in TargetGroup {1}' -f (Get-Date), $MyGroup.Name)
                            $MyGroup.GetComputerTargets() | ForEach-Object {
                                $ComputerName = $_.fullDomainName
                                Write-Verbose ('[{0:O}] Retrieve update(s) for computer {1}' -f (Get-Date), $_.fullDomainName)
                                $_.GetUpdateInstallationInfoPerUpdate($updateScope) | ForEach-Object {
                                    $update = $_.GetUpdate()
                                    if (!$ViewOnly)
                                    {
                                        Write-Verbose ('[{0:O}] Valide update(s) {1} for computer {2}' -f (Get-Date), $update.Title, $ComputerName)
                                        $update.Approve('install', $MyGroup)
                                    }
                                    else
                                    {
                                        [PsCustomObject]@{
                                            ComputerName = $ComputerName
                                            TargetGroup  = $MyGroup
                                            UpdateTitle  = $Update.Title
                                            State        = $Update.State
                                            IsApproved   = $update.IsApproved
                                            IsDeclined   = $update.IsDeclined
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    end
    {
    }
}
