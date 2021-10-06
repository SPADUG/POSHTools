Function Get-RdsServerList {
    [CmdletBinding()]
    [OutputType([System.Collections.ArrayList])]
    param (
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
            Filter = 'Name -like "*"'
        }
        if ($PSBoundParameters['Server']) {
            $ADParams.Add('Server', $Server)
        }

        if ($PSBoundParameters['Credential']) {
            $ADParams.add('credential', $Credential)
        }
    }

    Process {
        $Result = (Get-ADComputer @ADParams | Where-Object { $_.name -match "^SRV-RDS[\d].*|^TS[\d].*|^SRV-RDSCTA-[\d].*|^SRV-RDSCTAHM-[\d].*|^SRV-RDSCTACH-[\d].*|^SRV-RDSHM-[\d].*" } | Select-Object Name).Name
    }

    End {
        Write-Verbose ('[{0:O}] Ending {1}' -f (get-date), $myinvocation.mycommand)
        Return $Result
    }
}