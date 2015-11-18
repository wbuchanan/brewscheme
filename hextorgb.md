---
layout: page
title: hextorgb
permalink: /hextorgb/
---

# Hexadecimal RGB Values to Decimal RGB Values in Stata
This is a utility program that converts hexadecimal RGB encoded colors into decimal values.  It takes a sole argument which can be either a string value or a variable.  If a variable is passed to the program, it returns the RGB values in a new variable called rgb.  If string values are passed to the program it will print a table showing the individual component values, a comma separated RGB value, and a Stata formatted RGB string.

## Examples
Each of these examples shows conversions of [d3.scale.category10()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category10) or [d3.scale.category20()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20) Hexadecimal RGB values to Decimal RGB values.  


Convert the color palette from [d3.scale.category10()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category10) to RGB values

```Stata
hextorgb, hex("#1f77b4" "#ff7f0e" "#2ca02c" "#d62728" "#9467bd" "#8c564b" ///   
"#e377c2" "#7f7f7f" "#bcbd22" "#17becf")
________________________________________________________________________________
          Red       Green     Blue      RGB               RGB String                 
________________________________________________________________________________

          31       119       180       31, 119, 180      "31 119 180"
          255      127       14        255, 127, 14      "255 127 14"
          44       160       44        44, 160, 44       "44 160 44"
          214      39        40        214, 39, 40       "214 39 40"
          148      103       189       148, 103, 189     "148 103 189"
          140      86        75        140, 86, 75       "140 86 75"
          227      119       194       227, 119, 194     "227 119 194"
          127      127       127       127, 127, 127     "127 127 127"
          188      189       34        188, 189, 34      "188 189 34"
          23       190       207       23, 190, 207      "23 190 207"
________________________________________________________________________________
```

Show the returned macros available after the command above

```
. ret li, all

macros:
         r(rgbcomma10) : "23, 190, 207"
              r(rgb10) : "23 190 207"
             r(blue10) : "207"
            r(green10) : "190"
              r(red10) : "23"
          r(rgbcomma9) : "188, 189, 34"
               r(rgb9) : "188 189 34"
              r(blue9) : "34"
             r(green9) : "189"
               r(red9) : "188"
          r(rgbcomma8) : "127, 127, 127"
               r(rgb8) : "127 127 127"
              r(blue8) : "127"
             r(green8) : "127"
               r(red8) : "127"
          r(rgbcomma7) : "227, 119, 194"
               r(rgb7) : "227 119 194"
              r(blue7) : "194"
             r(green7) : "119"
               r(red7) : "227"
          r(rgbcomma6) : "140, 86, 75"
               r(rgb6) : "140 86 75"
              r(blue6) : "75"
             r(green6) : "86"
               r(red6) : "140"
          r(rgbcomma5) : "148, 103, 189"
               r(rgb5) : "148 103 189"
              r(blue5) : "189"
             r(green5) : "103"
               r(red5) : "148"
          r(rgbcomma4) : "214, 39, 40"
               r(rgb4) : "214 39 40"
              r(blue4) : "40"
             r(green4) : "39"
               r(red4) : "214"
          r(rgbcomma3) : "44, 160, 44"
               r(rgb3) : "44 160 44"
              r(blue3) : "44"
             r(green3) : "160"
               r(red3) : "44"
          r(rgbcomma2) : "255, 127, 14"
               r(rgb2) : "255 127 14"
              r(blue2) : "14"
             r(green2) : "127"
               r(red2) : "255"
          r(rgbcomma1) : "31, 119, 180"
               r(rgb1) : "31 119 180"
              r(blue1) : "180"
             r(green1) : "119"
               r(red1) : "31"
```

Program can also handle larger lists of colors:

```Stata
. hextorgb, hex("#1f77b4" "#aec7e8" "#ff7f0e" "#ffbb78" "#2ca02c" "#98df8a" ///   
"#d62728" "#ff9896" "#9467bd" "#c5b0d5" "#8c564b" "#c49c94" "#e377c2" ///   
"#f7b6d2" "#7f7f7f" "#c7c7c7" "#bcbd22" "#dbdb8d" "#17becf" "#9edae5")
________________________________________________________________________________
          Red       Green     Blue      RGB               RGB String                 
________________________________________________________________________________

          31       119       180       31, 119, 180      "31 119 180"
          174      199       232       174, 199, 232     "174 199 232"
          255      127       14        255, 127, 14      "255 127 14"
          255      187       120       255, 187, 120     "255 187 120"
          44       160       44        44, 160, 44       "44 160 44"
          152      223       138       152, 223, 138     "152 223 138"
          214      39        40        214, 39, 40       "214 39 40"
          255      152       150       255, 152, 150     "255 152 150"
          148      103       189       148, 103, 189     "148 103 189"
          197      176       213       197, 176, 213     "197 176 213"
          140      86        75        140, 86, 75       "140 86 75"
          196      156       148       196, 156, 148     "196 156 148"
          227      119       194       227, 119, 194     "227 119 194"
          247      182       210       247, 182, 210     "247 182 210"
          127      127       127       127, 127, 127     "127 127 127"
          199      199       199       199, 199, 199     "199 199 199"
          188      189       34        188, 189, 34      "188 189 34"
          219      219       141       219, 219, 141     "219 219 141"
          23       190       207       23, 190, 207      "23 190 207"
          158      218       229       158, 218, 229     "158 218 229"
________________________________________________________________________________

```
