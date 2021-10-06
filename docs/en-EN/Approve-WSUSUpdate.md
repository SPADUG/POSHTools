---
external help file: POSHTools-help.xml
Module Name: POSHTools
online version:
schema: 2.0.0
---

# Approve-WSUSUpdate

## SYNOPSIS
Approves updates on a WSUS server

## SYNTAX

```
Approve-WSUSUpdate [[-TargetGroup] <String[]>] [-WSUSName <String>] [-UseSSL <Boolean>] [-Port <Int32>]
 [-ViewOnly] [<CommonParameters>]
```

## DESCRIPTION
Approves necessary updates on a computer group in WSUS

## EXAMPLES

### EXAMPLE 1
```
Approve-WSUSUpdate -TargetGroup "MYGROUP1" -WSUSName "SRVWSUS" -ViewOnly
```

Shows all updates pending approval on the MYGROUP1 computer group

### EXAMPLE 2
```
Approve-WSUSUpdate -TargetGroup "MYGROUP1","MYGROUP2" -WSUSName "SRVWSUS" -ViewOnly
```

Displays all updates pending approval on each of the computer groups: MYGROUP1 and MYGROUP2

### EXAMPLE 3
```
Approve-WSUSUpdate -TargetGroup "MYGROUP1" -WSUSName "SRVWSUS"
```

Approves all pending updates on the MYGROUP1 computer group

### EXAMPLE 4
```
Approve-WSUSUpdate -TargetGroup "MYGROUP1","MYGROUP2" -WSUSName "SRVWSUS"
```

Approves all pending updates on each of the computer groups: MYGROUP1 and MYGROUP2

## PARAMETERS

### -TargetGroup
Computer group name in WSUS

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

### -WSUSName
WSUS server name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL
Use or not SSL (False by default)

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
Port used to connect to the WSUS server (8530 by default)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 8530
Accept pipeline input: False
Accept wildcard characters: False
```

### -ViewOnly
Show necessary updates without approving them

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS
