{smcl}
{* *! version 0.0.0  06NOV2015}{...}
{cmd:help hextorgb}
{hline}

{title:Title}

{hi:hextorgb {hline 2}} A utility to convert Hexadecimal encoded RGB values to decimal encoded RGB values.

{title:Syntax}

{p 4 4 4}{cmd:hextorgb} , {cmdab:hex:color(}{it:varname|string}{opt )} {break}

{title:Description}

{p 4 4 4}{cmd:hextorgb} is used to convert RGB values encoded as hexadecimal 
values to decimal values. {p_end}

{title:Options}
{p 4 4 8}{cmdab:hex:color} is the only required argument and can accept either a 
variable with the hexadecimal encoded string or a series of raw string values.  
If string values are passed to the option, the red, green, and blue component 
values are returned in local macros, as are a comma delimited and a Stata 
formatted RGB string.  If a hexadecimal value is passed to the argument, it will 
return a Stata formatted RGB string in the variable {hi: rgb}. {p_end}

{marker examples}{title:Examples}{break}

{p 4 4 4} Get the RGB values for the {browse `"https://github.com/mbostock/d3/wiki/Ordinal-Scales#ordinal"':D3js} ordinal scale color palettes. {p_end}

{p 4 4 4} This returns the RGB values for the colors listed under d3.scale.category10(). {p_end}
{p 8 8 12}{stata hextorgb, hex("#1f77b4" "#ff7f0e" "#2ca02c" "#d62728" "#9467bd" "#8c564b" "#e377c2" "#7f7f7f" "#bcbd22" "#17becf")}{p_end}

{p 4 4 4} This returns the RGB values for the colors listed under d3.scale.category20(). {p_end}
{p 8 8 12}{stata hextorgb, hex("#1f77b4" "#aec7e8" "#ff7f0e" "#ffbb78" "#2ca02c" "#98df8a" "#d62728" "#ff9896" "#9467bd" "#c5b0d5" "#8c564b" "#c49c94" "#e377c2" "#f7b6d2" "#7f7f7f" "#c7c7c7" "#bcbd22" "#dbdb8d" "#17becf" "#9edae5")}{p_end}

{p 4 4 4} This returns the RGB values for the colors listed under d3.scale.category20b(). {p_end}
{p 8 8 12}{stata hextorgb, hex("#393b79" "#5254a3" "#6b6ecf" "#9c9ede" "#637939" "#8ca252" "#b5cf6b" "#cedb9c" "#8c6d31" "#bd9e39" "#e7ba52" "#e7cb94" "#843c39" "#ad494a" "#d6616b" "#e7969c" "#7b4173" "#a55194" "#ce6dbd" "#de9ed6")}{p_end}

{p 4 4 4} This returns the RGB values for the colors listed under d3.scale.category20c(). {p_end}
{p 8 8 12}{stata hextorgb, hex("#3182bd" "#6baed6" "#9ecae1" "#c6dbef" "#e6550d" "#fd8d3c" "#fdae6b" "#fdd0a2" "#31a354" "#74c476" "#a1d99b" "#c7e9c0" "#756bb1" "#9e9ac8" "#bcbddc" "#dadaeb" "#636363" "#969696" "#bdbdbd" "#d9d9d9")}{p_end}


{title: Author}{break}
{p 1 1 1} William R. Buchanan, Ph.D. {break}
Data Scientist {break}
{browse "http://mpls.k12.mn.us":Minneapolis Public Schools} {break}
William.Buchanan at mpls [dot] k12 [dot] mn [dot] us

