---
layout: page
title: brewcolordb
permalink: /help/brewcolordb/
---

<hr>
Command to build local dataset of named colors and simulated color values
<hr>

<br>
__brewcolordb__ -- is a program to build a database of locally installed colors defined by StataCorp.  It includes the RGB values for each color as well as transformed RGB values that simulate varying forms of color sight impairments.

## Syntax

__brewcolordb__ [, <u>dis</u>play <u>rep</u>lace <u>over</u>ride ]

## Description

__brewcolordb__ builds a local database of named RGB colors on the user's system.  It also includes transformed RGB values for different forms of color sight impairments.

## Options

<u>dis</u>play is an optional argument to display the color information in the results window during the program's execution.

<u>rep</u>lace is an optional argument used to overwrite an existing copy of the library.

<u>over</u>ride is an optional argument used to override a user prompt before clearing data from memory.

## Examples

### Ex 1.
Build the database and display the results and suppress the warning message about dropping any data in memory

```Stata
brewcolordb, dis over
```


