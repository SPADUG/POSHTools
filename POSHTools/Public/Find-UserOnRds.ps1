Function Find-UserOnRDS {
    [CmdletBinding()]
    [OutputType([System.Collections.ArrayList])]
    param (
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [System.String[]]$Username,
        [parameter(Mandatory = $false)]
        [Alias("ServerAD")]
        [System.String]$Server,
        [parameter(Mandatory = $false)]
        [System.Management.Automation.PSCredential]$Credential
    )

    Begin {
        Write-Verbose ('[{0:O}] Starting {1}' -f (get-date), $myinvocation.mycommand)
        Write-Verbose ('[{0:O}] Creating an empty Array' -f (get-date))
        $Result = @()
        $ADParams = @{
        }
        if ($PSBoundParameters['Server']) {
            $ADParams.Add('Server', $Server)
        }

        if ($PSBoundParameters['Credential']) {
            $ADParams.add('credential', $Credential)
        }
    }

    Process {
        $ServersRDS = Get-RdsServerList @ADParams
        foreach ($RDS in $ServersRDS) {
            Write-Verbose ('[{0:O}] Starting {1}' -f (get-date), $RDS)
            if (Test-Connection $RDS -Count 1 -Quiet) {
                if (Get-TSSession -ComputerName $RDS -UserName "*$username*") {
                    $Found = Get-TSSession -ComputerName $RDS -UserName "*$username*"
                    Foreach ($User in $Found) {
                        $myObject = New-Object -TypeName PSObject
                        $myObject | Add-Member -MemberType NoteProperty -Name "Server" -Value $User.Server.ServerName
                        $myObject | Add-Member -MemberType NoteProperty -Name "UserName" -Value $User.UserName
                        $myObject | Add-Member -MemberType NoteProperty -Name "ClientName" -Value $User.ClientName
                        $myObject | Add-Member -MemberType NoteProperty -Name "State" -Value $User.State

                        $Result += $myObject
                    }

                }
            }
            else {
                Write-Output ('{0} not ping ' -f $RDS)
            }
        }
    }

    End {
        Write-Verbose ('[{0:O}] Ending {1}' -f (get-date), $myinvocation.mycommand)
        return $Result
    }
}