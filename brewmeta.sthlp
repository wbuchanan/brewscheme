{smcl}
{* *! version 0.0.2  04AUG2015}{...}
{cmd:help brewmeta}
{hline}

{title:Title}

{hi:brewmeta {hline 2}} A Stata interface to color property palettes developed 
by Cynthia Brewer ({browse "http://colorbrewer.org/": Color Brewer}).  

{title:Syntax}

{p 4 4 4}{cmd:brewmeta} {it:palette name}, {cmd:colorid(}{it:integer}{opt )} 
[ {cmd:colors(}{it:integer}{opt )}{cmdab:prop:erties[(}
{it:"", "all", "colorblind", "lcd", "print", "photocopy", "meta"}{cmd:)]} 
 {cmdab:ref:resh} ] {break}

{title:Description}

{p 4 4 4}{cmd:brewmeta} is used to build a look-up table of RGB values for 
palettes as part of the {browse "http://www.ColorBrewer2.org":Color Brewer} 
research.  Additionally, the program also parses the available meta data on the 
"friendliness" properties of the various color palettes and includes an option 
to look up those meta data on the fly.  Additionally, the program will 
automatically call the {help brewextra} program to add the other available 
research-based color palettes to the file when constructed. {p_end}

{title:Options}
{p 4 4 8}{cmd:colors} is a required argument indicating the number of the colors  
within the palette for which you would like to know about the meta data 
properties. For additional control, users may specify a specific number of colors 
within a palette to look up these values.{break}

{p 4 4 8}{cmd:colors} is an optional argument indicating the maximum number of 
colors from the specified palette from which to look up the properties of the 
color identified by {cmd:colorid}. If no value is passed to this argument, the 
maximum number of colors available in the palette are assumed. {it:Note: this is particularly important for divergent color palettes where colors may be added/subtracted from the palette in order to preserve balance across the palette.}  {break}
 
{p 4 4 8}{cmdab:prop:erties[(}{it:"", "all", "colorblind", "lcd", "print", "photocopy", "meta"}{cmd:)]} is an optional arguement used to look up a specific property for the 
color palette.  If nothing is specified, the program will assume you would like 
to see the results for all of the properties. The table below illustrates the 
types of results that can be expected to be retrieved from this functionality: {break}{p_end}

{col 10}{hline 70}
{col 10}{hi:Argument} {col 35}{hi: Result}
{col 10}{hline 70}
{col 10}{hi:all}{col 35}{Will display all of the characteristics below.}
{col 10}{hi:colorblind}{col 35}{Displays indicator of colorblind friendliness - if available}
{col 10}{hi:lcd}{col 35}{Displays indicator of LCD friendliness - if available}
{col 10}{hi:print}{col 35}{Displays indicator of Printed friendliness - if available}
{col 10}{hi:photocopy}{col 35}{Displays indicator of Photocopying friendliness - if available}
{col 10}{hi:meta}{col 35}{Provides information about the scale type for the palette (e.g., qualitative, sequential, divergent) or provides labelling/other miscellaneous data from the published research}
{col 10}{hline 70}{break}


{p 4 4 8}{cmdab:ref:resh} is an optional argument used to override the default 
behavior of the program once the lookup file is built.  This will force the 
program to download a fresh copy of the color palettes from the 
{browse "http://www.ColorBrewer2.org":Color Brewer} website, parse the javascript 
file, and rebuild the brewmeta.dta dataset. {p_end}


{marker examples}{title:Examples}{break}

{p 4 4 4} Determine if a color palette with 9 colors (of a potential 12 total) 
from the paired ColorBrewer palette is colorblind, lcd, print, or photocopy 
friendly and also identify the type of scale the palette is used for: {p_end}

{p 8 8 12}brewmeta "paired", colorid(9) colors(12) {p_end}

{p 4 4 4}Using a 15" early 2013 MacBook Pro w/Retina with a 2.8 GHz Intel Core 
i7 chipset, 16 GB 1600 MHz DDR3, and Intel HD Graphics 4000 1024 MB graphics 
card running Stata MP8, the command will typically take < 5 seconds with a 
decent Wi-Fi connection.  The first time the look up table is built and when the 
refresh option are used, you should expect to see the performance dip slightly.  
Look ups take < 1 second on my system and will likely take a similar amount of 
time on others as well. {p_end}

{title:References}{break}
{p 1 1 1} Colors from {browse "http://www.ColorBrewer2.org":Color Brewer} by 
Cynthia A. Brewer, Geography, Pennsylvania State University{p_end}

{title:License}
{p 4 4 4}Please view {browse "http://www.personal.psu.edu/cab38/ColorBrewer/ColorBrewer_updates.html": section 4} of the ColorBrewer copyright notice for additional information 
pertaining to the licensing and redistribution of ColorBrew intellectual property.{p_end}

{title: Author}{break}
{p 1 1 1} William R. Buchanan, Ph.D. {break}
Data Scientist {break}
{browse "http://mpls.k12.mn.us":Minneapolis Public Schools} {break}
William.Buchanan at mpls [dot] k12 [dot] mn [dot] us
