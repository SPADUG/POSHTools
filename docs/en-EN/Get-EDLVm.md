---
external help file: POSHTools-help.xml
Module Name: POSHTools
online version:
schema: 2.0.0
---

# Get-EDLVm

## SYNOPSIS
List all windows server

## SYNTAX

```
Get-EDLVm [[-HVServer] <String[]>] [[-VCServer] <String[]>] [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
List all windows server

## EXAMPLES

### EXAMPLE 1
```
Get-EDLVm -HVServer MyHypervServer -VCServer MyVCServer -Credential "Get-Credential"
```

## PARAMETERS

### -HVServer
HyperV server name

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VCServer
VCenter server name

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
credential to connect to server

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Object[]
## NOTES
General notes

## RELATED LINKS
