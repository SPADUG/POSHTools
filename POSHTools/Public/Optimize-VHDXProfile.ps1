<#
.SYNOPSIS
Clear content from VHDX profile

.DESCRIPTION
Clear content from VHDX profile

.PARAMETER VHDXPath
Directive to specify the path to the VHDX file

.PARAMETER VHDXName
Name of one or more VHDX files

.PARAMETER UserName
Name of one or more users

.EXAMPLE
Optimize-VHDXProfile -VHDXPath C:\VHDX\

.EXAMPLE
Optimize-VHDXProfile -VHDXName "C:\VHDX\MyVHDXFile.vhdx"

.NOTES
General notes
#>
Function Optimize-VHDXProfile {
    [CmdletBinding(DefaultParameterSetName = 'ByDirectory')]
    param (
        [Parameter(ParameterSetName = 'ByDirectory')]
        [Parameter(ParameterSetName = 'ByUserName')]
        [System.IO.FileInfo]$VHDXPath,
        [Parameter(ParameterSetName = 'ByFile')]
        [System.IO.FileInfo[]]$VHDXName,
        [Parameter(ParameterSetName = 'ByUserName')]
        [System.String[]]$UserName

    )

    Begin {
        Write-Verbose ('[{0:O}] Start {1}' -f (Get-Date), $myinvocation.mycommand)
        Write-Verbose ('[{0:O}] Create array with directory' -f (Get-Date))
        $ClearDirectory = @(
            '\AppData\Roaming\Microsoft\Teams\Service Worker\CacheStorage'
            '\AppData\Roaming\Microsoft\Teams\blob_storage'
            '\AppData\Roaming\Microsoft\Teams\Cache'
            '\AppData\Roaming\Microsoft\Teams\databases'
            '\AppData\Roaming\Microsoft\Teams\GPUCache'
            '\AppData\Roaming\Microsoft\Teams\IndexedDB'
            '\AppData\Roaming\Microsoft\Teams\Local Storage'
            '\AppData\Local\Microsoft\Teams\previous\*'
            '\AppData\Local\Microsoft\Windows\INetCache\*'
            '\AppData\Local\Microsoft\Windows\WebCache\*'
            '\AppData\Local\Microsoft\Terminal Server Client\Cache\*'
            '\AppData\Local\Google\Chrome\User Data\Default\Service Worker\CacheStorage\*'
            '\AppData\Local\Google\Chrome\User Data\Default\Cache\*'
            '\AppData\Local\WebEx'
            '\AppData\Local\GoToMeeting'
            '\AppData\Local\Temp\*'
            '\AppData\Roaming\Zoom\logs\*'
        )


        switch ($PSCmdlet.ParameterSetName) {
            'ByDirectory' {
                Write-Verbose ('[{0:O}] Get VHDX File list ' -f (Get-Date))
                $VHDXs = Get-ChildItem -Path $VHDXPath -Recurse -Include *.vhdx
            }
            'ByFile' {
                $VHDXs = $VHDXName
            }
            'ByUserName' {
                $VHDXs = @()
                foreach ($User in $UserName) {
                    Write-Verbose ('[{0:O}] convert {1} to SID' -f (Get-Date), $User)
                    $SID = Convert-User2SID -UserName $User -Domain 'netintra.local'
                    Write-Verbose ('[{0:O}] Search VHDX file for {1}' -f (Get-Date), $SID)
                    $VHDXs += Get-ChildItem -Path $VHDXPath -Recurse -Include "*$SID*"
                }
            }
        }

    }

    Process {
        $taille = 0
        foreach ($VHDX in $VHDXs) {
            try {
                if (!(Test-FileIsLocked -Path $VHDX.FullName )) {
                    $DriveLetter = (Mount-VHD -Path $VHDX.FullName -Passthru | Get-Disk | Get-Partition | Get-Volume).DriveLetter
                    Write-Verbose ('[{0:O}] Clear File name {1}' -f (Get-Date), $VHDX.FullName)
                    foreach ($item in $ClearDirectory) {
                        $Path = ($DriveLetter + ':' + $item)
                        if (Test-Path -Path $Path) {
                            Write-Verbose ('[{0:O}] Clear path {1}' -f (Get-Date), $Path)
                            Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
                        }
                    }
                    Dismount-VHD -Path $VHDX.FullName
                }
            }
            catch [Microsoft.HyperV.PowerShell.VirtualizationException] {
                Write-Warning ('[{0:O}] Error with HyperV Administration Tools' -f (Get-Date))
            }
            catch [System.Management.Automation.MethodInvocationException] {
                Write-Warning ('[{0:O}] Profile {1} locked' -f (Get-Date), $VHDX.name)
            }
            catch {
                Write-Warning ('[{0:O}] Error while mounting {1}' -f (Get-Date), $VHDX.Name)
                Write-Warning ('[{0:O}] ErrorId : ${1}' -f (Get-Date), $_.Exception.Message)
                Write-Warning ('[{0:O}] Exception : ${1}' -f (Get-Date), $_.FullyQualifiedErrorId)
                Write-Warning ('[{0:O}] Category : ${1}' -f (Get-Date), ($_.Exception.GetType() | Select-Object -ExpandProperty UnderlyingSystemType).FullName)
            }
        }
    }

    End {
        Write-Verbose ('[{0:O}] End {1}' -f (Get-Date), $myinvocation.mycommand)
    }
}