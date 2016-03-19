---
layout: page
title: brewterpolate
permalink: /help/brewterpolate/
---


<hr>
Interpolation of colors between starting and ending color values.
<hr>
 
__brewterpolate__ -- Stata program to interpolate an arbitrary number of colors between a starting and ending color.
 
## Syntax
 
brewterpolate, scolor(string) ecolor(string) colors(int) [cmod(string)
icspace(string) rcspace(string) inverse grayscale ]
 
## Description
 
__brewterpolate__ is a program used to interpolate color values between the start and end colors for an arbitrary number of points.  The program can accept input in several formats and provides output in rgb, rgba, srgb, srgba, hsv, and hsva formats.
 
## Options
 
scolor is a required argument that takes a value conforming to one of the formats listed in Input Color Spaces.
 
scolor is a required argument that takes a value conforming to one of the formats listed in Input Color Spaces.
 
colors is a required argument that takes a value to define the number of points between the starting and ending colors to interpolate.
 
cmod is an optional argument that can take one of the following values: brighter, darker, saturated, desaturated, or nothing and is used to modify the interpolated colors.  A value of "brighter" will return colors that are arbitrarily brighter than the normal interpolated value, "darker" will return colors that are arbitrarily darker than the normal interpolated colors,  "saturated" will return arbitrarily more saturated colors, and "desaturated" will return arbitrarily less saturated colors.  If no argument is passed to this parameter, the colors are interpolated without modification.
 
icspace is an optional argument used to specify the input color space used for the starting and ending colors.  If no argument is passed, RGB is assumed.
 
rcspace is an optional argument used to specify the return color space used for passing the interpolated colors back to Stata.  This can be any of the values listed in Input Color Spaces except for the web-based formats.
 
inverse is an optional argument used to return the inverse of the interpolated colors.  This is implemented after any of the luminance modifications have been made to the colors.
 
grayscale is an optional argument used to force the returned color values into a grayscale.  This is the last transformation that is applied to the colors. In other words, if you requested the inverse of the colors that are arbitrarily less saturated, the method would first get the less saturated interpolated color, invert it, and then transform it to a gray scale value.
 
<table>
<th>Argument</th><th>Color Space</th> 
<tr><td>rgb</td><td>Red, Green, Blue (ex., 0 0 255).</td></tr>
<tr><td>rgba</td><td>Red, Green, Blue, Alpha (ex., 0 0 255 0.5)</td></tr>
<tr><td>srgb</td><td>RGB Decimal (ex., 0.0 0.0 1.0).</td></tr>
<tr><td>srgba</td><td>RGB Decimal (ex., 0.0 0.0 1.0 0.5).</td></tr>
<tr><td>hsb</td><td>Hue, Saturation, Brightness (ex., 270.0 1.0 1.0)</td></tr>
<tr><td>hsba</td><td>Hue, Saturation, Brightness (ex., 270.0 1.0 1.0 0.5)</td></tr>
<tr><td>web</td><td>Hex string (ex., 0000FF) [returned with leading # added]</td></tr>
<tr><td>weba</td><td>Hex string w/Decimal Alpha (ex., 0000FF .27) [returned with leading # added]</td></tr>
<tr><td>weba</td><td>Hex string w/Hex Alpha (ex., 0000FF00)  [returned with leading # added]</td></tr>
<tr><td>hex</td><td>Hexadecimal (ex., 0000FF)</td></tr>
<tr><td>hexa</td><td>Hexadecimal w/Alpha (ex., 0000FF 0.5)</td></tr>
<tr><td>hexa</td><td>Hex w/Alpha scaled as RGB Integer (e.g., 0000FFFF)</td></tr>
<tr><td>hexa web</td><td>Web Hexadecimal w/Alpha (ex., )</td></tr>
<tr><td>rgb web</td><td>Web RGB (ex., )</td></tr>
<tr><td>rgba web</td><td>Web RGB w/Alpha (ex., )</td></tr>
<tr><td>srgb</td><td>Web sRGB (ex., )</td></tr>
<tr><td>srgba</td><td>Web sRGB w/Alpha (ex., )</td></tr>
<tr><td>hsl</td><td>Hue, Saturation, Lightness (ex., hex, rgb, hsl)</td></tr>
<tr><td>hsla</td><td>Hue, Saturation, Lightness w/Alpha (ex., hex, rgb, hsl)</td></tr>
</table>
 
## Examples

### Ex 1. 
Interpolating four points between start and end in RGB color space
  
```
// Interpolate four points between `rgb(197, 115, 47)` and `rgb(5, 37, 249)`.  
// Note that the program is set up to automatically handle parsing commas for 
// rgb values.
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(4)

ret li

    macros:
    r(colorstring) : ""197 115 47"  "159 99 87" "120 84 128" "82 68 168" "43 53 209" "5 37 249""
    r(end) : "5 37 249"
    r(start) : "197 115 47"
    r(terpcolor4) : "43 53 209"
    r(terpcolor3) : "82 68 168"
    r(terpcolor2) : "120 84 128"
    r(terpcolor1) : "159 99 87"
```

### Ex 2. 
Inverse interpolation with 9 colors in rgb color space


```
// Same as the example above, except we pass the value `9` to the `colors()` 
// parameter and specify the `inverse` option with the abbreviation `inv`.
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(9) inv

ret li

    macros:
    r(colorstring) : ""197 115 47"  "178 107 67" "159 99 87" "139 92 108" "120 84 128" "101 76 148" "82 68 .."
    r(end) : "5 37 249"
    r(start) : "197 115 47"
    r(terpcolor9) : "24 45 229"
    r(terpcolor8) : "43 53 209"
    r(terpcolor7) : "63 60 188"
    r(terpcolor6) : "82 68 168"
    r(terpcolor5) : "101 76 148"
    r(terpcolor4) : "120 84 128"
    r(terpcolor3) : "139 92 108"
    r(terpcolor2) : "159 99 87"
    r(terpcolor1) : "178 107 67"
```

### Ex 3. 
Interpolate 18 colors in RGB color space and return the interpolated values in HSB colorspace

```
// Here, we use the `rcspace()` parameter with a value of `"hsb"` to denote the
// desired color space in which to return the interpolated colors.
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(18) rcs("hsb")

ret li

    macros:
    r(colorstring) : ""197 115 47"  "24.723128291137353 0.6916361508757953 0.7329205274581909" "21.29970809.."
    r(end) : "5 37 249"
    r(start) : "197 115 47"
    r(terpcolor18) : "233.01272673615335 0.9366306456523714 0.9347781538963318"
    r(terpcolor17) : "234.07484231488388 0.8892997633195094 0.8930856585502625"
    r(terpcolor16) : "235.3792708584508 0.8373333310930657 0.8513932228088379"
    r(terpcolor15) : "237.0196039367932 0.7800153321529706 0.8097007274627686"
    r(terpcolor14) : "239.14478297128935 0.716474066048689 0.7680082321166992"
    r(terpcolor13) : "241.9420782891363 0.6672349897505712 0.7263157963752747"
    r(terpcolor12) : "245.51256883070747 0.6234548570255474 0.6846233010292053"
    r(terpcolor11) : "250.20134158813386 0.5739967867509566 0.6429308652877808"
    r(terpcolor10) : "256.63129663364066 0.5176794000499846 0.6012384295463562"
    r(terpcolor9) : "265.99348212475775 0.45296940450207684 0.5595459342002869"
    r(terpcolor8) : "280.88606873862415 0.377839790795268 0.5178534984588623"
    r(terpcolor7) : "307.26315489489764 0.3167986450361176 0.4951496422290802"
    r(terpcolor6) : "333.3638506541267 0.33732147968232146 0.5347781181335449"
    r(terpcolor5) : "353.44129235146414 0.35501259527916734 0.574406623840332"
    r(terpcolor4) : "8.100465715967324 0.42823530839270807 0.6140351295471191"
    r(terpcolor3) : "16.258994001488595 0.5266813809680345 0.6536635756492615"
    r(terpcolor2) : "21.29970809937576 0.6138731674672362 0.6932920813560486"
    r(terpcolor1) : "24.723128291137353 0.6916361508757953 0.7329205274581909"
```

### Ex 4. 
Inverse interpolation with 37 colors that are arbitrarily brighter and returned in HSB colorspace

```Stata
// With the exception of the `cmod()` parameter, all of the other parameters 
// and syntax should be familiar by now.  For all but the HSB colorspace, this 
// parameter controls brightness/darkness.  For the HSB colorspace the 
// arguments `"brighter"` and `"darker"` control saturation and desaturation 
// respectively.
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(37) inv cm("brighter") rcs("hsb")

ret li

    macros:
    r(colorstring) : ""197 115 47"  "26.053522991350288 0.7274472130909729 0.7527347803115845" "24.72312829.."
    r(end) : "5 37 249"
    r(start) : "197 115 47"
    r(terpcolor37) : "232.55237496473137 0.9587472889808564 0.9556243419647217"
    r(terpcolor36) : "233.01272673615335 0.9366306456523714 0.9347781538963318"
    r(terpcolor35) : "233.51791980929517 0.9135049992392341 0.9139319062232971"
    r(terpcolor34) : "234.07484231488388 0.8892997633195094 0.8930856585502625"
    r(terpcolor33) : "234.69186355451228 0.8639375416417528 0.8722394704818726"
    r(terpcolor32) : "235.3792708584508 0.8373333310930657 0.8513932228088379"
    r(terpcolor31) : "236.14983102514077 0.8093936063366098 0.8305469155311584"
    r(terpcolor30) : "237.0196039367932 0.7800153321529706 0.8097007274627686"
    r(terpcolor29) : "238.00907850510296 0.7490842690117601 0.7888544797897339"
    r(terpcolor28) : "239.14478297128935 0.716474066048689 0.7680082321166992"
    r(terpcolor27) : "240.45819764034133 0.6872927751697646 0.7471619844436646"
    r(terpcolor26) : "241.9420782891363 0.6672349897505712 0.7263157963752747"
    r(terpcolor25) : "243.61412842939382 0.6459917842582028 0.70546954870224"
    r(terpcolor24) : "245.51256883070747 0.6234548570255474 0.6846233010292053"
    r(terpcolor23) : "247.6867209615445 0.599502511239787 0.6637771129608154"
    r(terpcolor22) : "250.20134158813386 0.5739967867509566 0.6429308652877808"
    r(terpcolor21) : "253.1432040047124 0.5467816528515123 0.6220846176147461"
    r(terpcolor20) : "256.63129663364066 0.5176794000499846 0.6012384295463562"
    r(terpcolor19) : "260.8333311343773 0.48648648787428633 0.5803921818733215"
    r(terpcolor18) : "265.99348212475775 0.45296940450207684 0.5595459342002869"
    r(terpcolor17) : "272.48161719329585 0.41685822152338586 0.5386996865272522"
    r(terpcolor16) : "280.88606873862415 0.377839790795268 0.5178534984588623"
    r(terpcolor15) : "292.2029590042226 0.335548207221579 0.49700725078582764"
    r(terpcolor14) : "307.26315489489764 0.3167986450361176 0.4951496422290802"
    r(terpcolor13) : "321.2239868594206 0.3274548998455958 0.5149638652801514"
    r(terpcolor12) : "333.3638506541267 0.33732147968232146 0.5347781181335449"
    r(terpcolor11) : "344.01719120916346 0.34648304113830314 0.5545923709869385"
    r(terpcolor10) : "353.44129235146414 0.35501259527916734 0.574406623840332"
    r(terpcolor9) : "1.7827332631705928 0.3740882575151173 0.5942208766937256"
    r(terpcolor8) : "8.100465715967324 0.42823530839270807 0.6140351295471191"
    r(terpcolor7) : "12.72603841933376 0.4789970629741118 0.6338493227958679"
    r(terpcolor6) : "16.258994001488595 0.5266813809680345 0.6536635756492615"
    r(terpcolor5) : "19.045575767373172 0.5715599221635951 0.673477828502655"
    r(terpcolor4) : "21.29970809937576 0.6138731674672362 0.6932920813560486"
    r(terpcolor3) : "23.160687982046525 0.6538350371060903 0.7131063342094421"
    r(terpcolor2) : "24.723128291137353 0.6916361508757953 0.7329205274581909"
    r(terpcolor1) : "26.053522991350288 0.7274472130909729 0.7527347803115845"
```

```Stata
// Four colors interpolated in RGB color space
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(2)

// Display the returned values
ret li

macros:
        r(colorsdelim) : "197 115 47", "133 89 114", "69 63 182", "5 37 249"
        r(colorstring) : "197 115 47" "133 89 114" "69 63 182" "5 37 249"
          r(interpend) : "3"
        r(interpstart) : "2"
        r(totalcolors) : "4"
                r(end) : "5 37 249"
              r(start) : "197 115 47"
         r(terpcolor4) : "5 37 249"
         r(terpcolor3) : "69 63 182"
         r(terpcolor2) : "133 89 114"
         r(terpcolor1) : "197 115 47"

// Four colors interpolated and returned as web formatted hexadecimal strings
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(3) rcs(web)

// Display the returned values
ret li

macros:
        r(colorsdelim) : "#c5732f", "#956062", "#654c94", "#3539c6", "#0525f9"
        r(colorstring) : "#c5732f" "#956062" "#654c94" "#3539c6" "#0525f9"
          r(interpend) : "4"
        r(interpstart) : "2"
        r(totalcolors) : "5"
                r(end) : "#0525f9"
              r(start) : "#c5732f"
         r(terpcolor5) : "#0525f9"
         r(terpcolor4) : "#3539c6"
         r(terpcolor3) : "#654c94"
         r(terpcolor2) : "#956062"
         r(terpcolor1) : "#c5732f"

// Four colors less saturated colors returned as hex strings with alpha parameters
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(3) rcs(hexa) cm(desaturated)

// Display the returned values
ret li

macros:
        r(colorsdelim) : "c5732f 1.0", "957071 1.0", "736294 1.0", "6163c6 1.0", "4e65.."
        r(colorstring) : "c5732f 1.0" "957071 1.0" "736294 1.0" "6163c6 1.0" "4e65f9 1.."
          r(interpend) : "4"
        r(interpstart) : "2"
        r(totalcolors) : "5"
                r(end) : "4e65f9 1.0"
              r(start) : "c5732f 1.0"
         r(terpcolor5) : "4e65f9 1.0"
         r(terpcolor4) : "6163c6 1.0"
         r(terpcolor3) : "736294 1.0"
         r(terpcolor2) : "957071 1.0"
         r(terpcolor1) : "c5732f 1.0"

// Three interpolated colors returned in RGB as a gray scale
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(2) g

// Display the returned values
ret li

macros:
        r(colorsdelim) : "197 115 47", "99 99 99", "72 72 72", "45 45 45"
        r(colorstring) : "197 115 47" "99 99 99" "72 72 72" "45 45 45"
          r(interpend) : "3"
        r(interpstart) : "2"
        r(totalcolors) : "4"
                r(end) : "45 45 45"
              r(start) : "197 115 47"
         r(terpcolor4) : "45 45 45"
         r(terpcolor3) : "72 72 72"
         r(terpcolor2) : "99 99 99"
         r(terpcolor1) : "197 115 47"

// Arbitrariliy brighter version of example above
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(3) g cm(brighter)

// Display the returned values
ret li

macros:
        r(colorsdelim) : "197 115 47", "151 151 151", "122 122 122", "84 84 84", "46 4.."
        r(colorstring) : "197 115 47" "151 151 151" "122 122 122" "84 84 84" "46 46 46"
          r(interpend) : "4"
        r(interpstart) : "2"
        r(totalcolors) : "5"
                r(end) : "46 46 46"
              r(start) : "197 115 47"
         r(terpcolor5) : "46 46 46"
         r(terpcolor4) : "84 84 84"
         r(terpcolor3) : "122 122 122"
         r(terpcolor2) : "151 151 151"
         r(terpcolor1) : "197 115 47"

/* The use of mata below is primarily for the display/formatting of results but 
would otherwise be completely superfluous. */

// Initalize null matrices to store results for he next three examples
mata: hsb1 = J(6, 3, .)

// Return the inverse of the original results in HSB color space
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(4) rcs("hsb") inv

// Loop over returned results 
forv i = 1/6 {   

    // Store the results from the command above in a Mata matrix
    mata: hsb1[`i', .] = strtoreal(tokens(st_global("r(terpcolor`i')")))

} // End Loop over returned results

// Return the matrices to Stata
mata: st_matrix("hsb1", hsb1)

// Add column names to each of the matrices
mat colnames hsb1 = "Hue" "Saturation" "Brightness"

// Add rownames to each of the matrices
mat rownames hsb1 = "Color 1" "Color 2" "Color 3" "Color 4" "Color 5" "Color 6"

// Print the first result set to the screen RGB input returned in HSB color space
mat li hsb1

hsb1[6,3]
                Hue  Saturation  Brightness
Color 1   27.199999   .76142132   .77254903
Color 2   190.11235   .42482094   .65725487
Color 3   109.63636   .25700934   .67137253
Color 4   68.160001   .53533196   .73254901
Color 5   56.658594   .78071837   .82980394
Color 6   52.131148        .976   .98039216
```

 
## References
[Java Color Documentation](https://docs.oracle.com/javase/8/docs/api/java/awt/Color.html)
 
 
