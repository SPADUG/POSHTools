---
external help file: POSHTools-help.xml
Module Name: POSHTools
online version:
schema: 2.0.0
---

# Clear-VHDXProfile

## SYNOPSIS
Clear VHDX profile file in the specified path.

## SYNTAX

```
Clear-VHDXProfile [[-Path] <FileInfo>] [<CommonParameters>]
```

## DESCRIPTION
For each vhdx profile in a specified path, the function converts the SID to Username and try to find a user in AD.
If any user is find, the function remove the vhdx profile file

## EXAMPLES

### EXAMPLE 1
```
Clear-VHDXProfile -path C:\MyProfile
```

## PARAMETERS

### -Path
Path to vhdx file.

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Collections.Hashtable
## NOTES
General notes

## RELATED LINKS
