    <#
.SYNOPSIS
Convert user name to SID

.DESCRIPTION
Convert user name to SID

.PARAMETER UserName
Username to convert to SID

.PARAMETER Domain
AD Domain to convert the username to SID

.PARAMETER SID
SID to convert to username

.EXAMPLE
Convert-User2SID -UserName "MyUser" -Domain "MyDomain.local"

.EXAMPLE
Convert-User2SID -SID "S-1-5-21-1234567890-1234567890-1234567890-1234567890"

.NOTES
General notes
#>
Function Convert-User2SID
{
    #Start Function Convert-User2SID
    [CmdletBinding()]
    [OutputType([System.Collections.HashTable])]
    param (
        [Parameter(ParameterSetName = 'ByUserName')]
        [System.String]$UserName,
        [Parameter(ParameterSetName = 'ByUserName')]
        [System.String]$Domain,
        [Parameter(ParameterSetName = 'BySID')]
        [System.String]$SID
    )

    Begin
    {

    }

    Process
    {
        switch ($PSCmdlet.ParameterSetName)
        {
            'ByUserName'
            {
                $objUser = New-Object System.Security.Principal.NTAccount($Domain, $UserName)
                $strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
                $result = $strSID.Value
            }
            'BySID'
            {
                $objSID = New-Object System.Security.Principal.SecurityIdentifier($SID)
                $objUser = $objSID.Translate( [System.Security.Principal.NTAccount])
                $result = $objUser.Value
            }
        }
    }

    End
    {
        return $result
    }
}
