    <#
.SYNOPSIS
Clear VHDX profile file in the specified path.

.DESCRIPTION
For each vhdx profile in a specified path, the function converts the SID to Username and try to find a user in AD.
If any user is find, the function remove the vhdx profile file

.PARAMETER Path
Path to vhdx file.

.EXAMPLE
Clear-VHDXProfile -path C:\MyProfile

.NOTES
General notes
#>

Function Clear-VHDXProfile
{
    #Start Function Clear-VHDXProfile
    [CmdletBinding()]
    [OutputType([System.Collections.HashTable])]
    param(
        [ValidateScript({
                if ( -Not ($_ | Test-Path) )
                {
                    throw 'File or folder does not exist'
                }
                return $true
            })]
        [System.IO.FileInfo]$Path
    )

    Begin
    {
        Write-Verbose ('[{0:O}] Starting {1}' -f (Get-Date), $myinvocation.mycommand)
    }

    Process
    {
        Write-Verbose ('[{0:O}] Retrieve all vhdx files from {1}' -f (Get-Date), $Path)
        $VHDXFiles = (Get-ChildItem -Path $Path -Recurse -Include *.vhdx -Exclude *template.vhdx).FullName
        Write-Verbose ('[{0:O}] {1} files retrieve' -f (Get-Date), $VHDXFiles.Count)

        foreach ($VHDXFile in $VHDXFiles)
        {
            $VHDXFile -match '(S-.*).vhdx'
            $VHDXUid = $Matches[1]
            Write-Verbose ('[{0:O}] Convert {1} to AD User' -f (Get-Date), $VHDXUid)
            try {
                $ADUser = Convert-User2SID -SID $VHDXUid
                Write-Verbose ('[{0:O}] {1} found in AD => nothing to do !' -f (get-date),$ADUser)
            }
            catch {
                Write-Warning ('[{0:O}] {1} not found in AD => delete vhdx profile !' -f (get-date),$VHDXUid)
                remove-item -path $VHDXFile -force -Confirm:$false
            }
        }
    }

    End
    {
        Write-Verbose ('[{0:O}] Ending {1}' -f (Get-Date), $myinvocation.mycommand)
    }
}

