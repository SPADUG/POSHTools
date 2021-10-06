---
external help file: POSHTools-help.xml
Module Name: POSHTools
online version:
schema: 2.0.0
---

# Convert-User2SID

## SYNOPSIS
Convert user name to SID

## SYNTAX

### ByUserName
```
Convert-User2SID [-UserName <String>] [-Domain <String>] [<CommonParameters>]
```

### BySID
```
Convert-User2SID [-SID <String>] [<CommonParameters>]
```

## DESCRIPTION
Convert user name to SID

## EXAMPLES

### EXAMPLE 1
```
Convert-User2SID -UserName "MyUser" -Domain "MyDomain.local"
```

### EXAMPLE 2
```
Convert-User2SID -SID "S-1-5-21-1234567890-1234567890-1234567890-1234567890"
```

## PARAMETERS

### -UserName
Username to convert to SID

```yaml
Type: String
Parameter Sets: ByUserName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domain
AD Domain to convert the username to SID

```yaml
Type: String
Parameter Sets: ByUserName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SID
SID to convert to username

```yaml
Type: String
Parameter Sets: BySID
Aliases:

Required: False
Position: Named
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
