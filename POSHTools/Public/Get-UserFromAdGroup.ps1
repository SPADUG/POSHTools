#region <Get-UserFromAdGroup>	
#After building the function and defining the parameters
#Place yourself here and do ## to generate help
Function Get-UserFromAdGroup {	
    [CmdletBinding(DefaultParameterSetName = 'ByRegex')]
    param (
        [Parameter(ParameterSetName = 'ByRegex')]
        [System.String]$Regex
    )

    Begin {
        Write-Verbose ('[{0:O}] Starting {1}' -f (get-date), $myinvocation.mycommand)
        $result = @()
    }

    Process {
        switch ($PsCmdlet.ParameterSetName) {
            'ByRegex' { 
                $AdGroupList = (Get-ADGroup -filter * | Where-Object { $_.Name -match $Regex }).Name
            } 
        }

        ForEach ($Group in $AdGroupList) {
            Get-ADGroupMember -Identity $Group | ForEach-Object {
                $MyUser = [PSCustomObject]@{
                    Name = $_.Name
                    Group = $Group
                }
                $result += $MyUser
            }
        }
    }

    End {
        Write-Verbose ('[{0:O}] Ending {1}' -f (get-date), $myinvocation.mycommand)
        return $result
    }
    
}
