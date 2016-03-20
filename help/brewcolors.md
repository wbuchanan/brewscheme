---
layout: page
title: brewcolors
permalink: /help/brewcolors/
---


<hr>
Command to create new named color styles and add to existing color dataset.
<hr>

<br>  
__brewcolors__ -- is a program used to create new named color styles and/or add colors to the color dataset.  The program includes sub-commands to create these colors manually or to add colors from the XKCD color survey.
 
## Syntax
 
__brewcolors__ <em>xkcd</em> | <em>new</em> [, <u>ma</u>ke <u>inst</u>all <u>col</u>ors(string) <u>rep</u>lace <u>over</u>ride ]
 
## Description
 
__brewcolors__ builds a local database of named RGB colors on the user's system.  It also includes transformed RGB values for different forms of color sight impairments.
 
## Options
 
<u>ma</u>ke is an optional argument used to append the resulting color dataset to the master colordata set used by brewscheme.
 
<u>inst</u>all is an optional argument used to create each of the named color style files and place them on the ADOPATH to be accessible in Stata.
 
<u>col</u>ors is an optional argument used to pass the color name and RGB values when using the new subcommand.
 
<u>rep</u>lace is an optional argument used to overwrite an existing version of the color dataset being created.
 
<u>over</u>ride is an optional argument used to suppress the warning message printed to the console by brewcolordb.
 
## Examples

### Ex 1. 
Creates the dataset with all of the XKCD colors and installs them as named color styles for Stata to use.

```Stata
brewcolors xkcd, mk inst over rep
``` 

You should then be able to access the named color styles from XKCD in the graph menus:

![brewcolorsEx1](http://wbuchanan.github.io/brewscheme/img/brewcolorsex1.png)

And will also have access to versions of the colors that simulate their appearance under different forms of color sight impairments:

![brewcolorsEx2](http://wbuchanan.github.io/brewscheme/img/brewcolorsex2.png)

Once you've done this you should be all set.  If the look up database is not present when `brewscheme` is called it will build the file automatically for you, but before you can create a scheme/theme file you'll need to have the data set and modified named color styles created by `brewcolordb`.

### Ex 2.
Add a new color style to the color database and make it available in Stata using the default name constructor

```Stata
brewcolors new, ma inst colors("117 200 47")
```

### Ex 3.
Add a new named color style to the color database using a user specified name

```Stata
brewcolors new, ma inst colors(`""mycolor 117 200 47""')
```



