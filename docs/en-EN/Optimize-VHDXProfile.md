---
external help file: POSHTools-help.xml
Module Name: POSHTools
online version:
schema: 2.0.0
---

# Optimize-VHDXProfile

## SYNOPSIS
Clear content from VHDX profile

## SYNTAX

### ByDirectory (Default)
```
Optimize-VHDXProfile [-VHDXPath <FileInfo>] [<CommonParameters>]
```

### ByUserName
```
Optimize-VHDXProfile [-VHDXPath <FileInfo>] [-UserName <String[]>] [<CommonParameters>]
```

### ByFile
```
Optimize-VHDXProfile [-VHDXName <FileInfo[]>] [<CommonParameters>]
```

## DESCRIPTION
Clear content from VHDX profile

## EXAMPLES

### EXAMPLE 1
```
Optimize-VHDXProfile -VHDXPath C:\VHDX\
```

### EXAMPLE 2
```
Optimize-VHDXProfile -VHDXName "C:\VHDX\MyVHDXFile.vhdx"
```

## PARAMETERS

### -VHDXPath
Directive to specify the path to the VHDX file

```yaml
Type: FileInfo
Parameter Sets: ByDirectory, ByUserName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VHDXName
Name of one or more VHDX files

```yaml
Type: FileInfo[]
Parameter Sets: ByFile
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
Name of one or more users

```yaml
Type: String[]
Parameter Sets: ByUserName
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

## NOTES
General notes

## RELATED LINKS
