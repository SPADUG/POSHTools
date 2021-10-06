function Test-FileIsLocked {
    param (
        [parameter(Mandatory = $true)]
        [string]$Path
    )

    $oFile = New-Object System.IO.FileInfo $Path

    $oStream = $oFile.Open([System.IO.FileMode]::Open, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::None)

    if ($oStream) {
        $false
        $oStream.Close()
    }
    Else {
        $true
    }
}