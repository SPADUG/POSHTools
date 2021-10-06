function Test-IfPrinterExist {
    <#
    .SYNOPSIS
        Test if a printer exists on a computer
    .DESCRIPTION
        This function lets you know if a printer, whose name has been passed in parameter, exists on a computer.
        This function uses a CimSession to connect to the computer and check if the printer exists on this machine
    .PARAMETER Computer
        The name of the computer on which to search for the printer
    .PARAMETER PrinterName
        The name of the printer to search for on the computer passed in parameter
    .PARAMETER Credential
        The credential of an account which has the rights to connect to the computer passed in parameter via a CimSession
    .PARAMETER Authentication
        The connection protocol to use for the CimSession
    .EXAMPLE
        PS C:\> Test-IfPrinterExist -Computer 'MyServer' -PrinterName 'MyPrinter' -Credential MyCreds -Authentication Kerberos

        Check if the printer 'MyPrinter' exists on the computer 'MyServer' by opening a CimSession with MyCreds credentials and the Kerberos protocol
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Boolean
    .NOTES
        General notes
    #>
    [CmdletBinding()]
    [OutputType([Boolean])]
    param (
        [parameter(Mandatory = $True)]
        [System.String]$Computer,
        [parameter(Mandatory = $True)]
        [System.String]$PrinterName,
        [System.Management.Automation.PSCredential]$Credential,
        [PasswordAuthenticationMechanism]$Authentication
    )

    begin {
        $ScriptName = (Get-Variable -name MyInvocation -Scope 0 -ValueOnly).Mycommand
        $Cim = $null
        $Result = $false
    }

    process {
        try {

            Write-Verbose "[$Scriptname] - Computer processing : $($Computer)"
            $CIMSessionParams = @{
                ComputerName = $($Computer)
                ErrorAction  = "Stop"
            }

            if ($PSBoundParameters['Credential']) {
                Write-Verbose "[$Scriptname] - Add Credential to CIMSession parameter"
                $CIMSessionParams.add('credential', $Credential)
            }

            if ($PSBoundParameters['Authentication']) {
                Write-Verbose "[$Scriptname] - Add Authentication method $($Authentication) to CIMSession parameter"
                $CIMSessionParams.add('Authentication', $Authentication)
            }

            Write-Verbose "[$Scriptname] - Create New CIMSession"
            $Cim = New-CimSession @CIMSessionParams

            $PrinterList = Get-Printer -CimSession $Cim | Select-Object Name

            Write-Verbose "[$Scriptname] - printer processing : $($PrinterName)"
            if ($PrinterName -in $PrinterList.Name) {
                $Result = $true
            }
        } catch {
            throw
        } finally {
            if ($null -ne $Script:Cim) {
                Remove-CimSession $Cim
            }
        }
    }

    end {
        $Result
    }
}