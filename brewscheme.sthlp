{smcl}
{* *! version 0.0.2  13APR2015}{...}
{cmd:help brewscheme}
{hline}

{title:Title}

{hi:brewscheme {hline 2}} A program for easy generation of customized graph 
scheme files.  This product includes color schemes developed by 
Cynthia Brewer ({browse "http://colorbrewer.org/": Color Brewer}).

{title:Syntax}

{p 4 4 4}{cmd:brewscheme} , {cmdab:scheme:name(}{it:scheme name}{opt )} 
[ {cmdab:refr:esh} {break} {cmdab:allst:yle(}{it:string}{cmd:)} {cmdab:allc:olors(}{it:real 3}{cmd:)} 
{cmdab:allsat:uration(}{it:real 100}{cmd:)} {break} {cmdab:somest:yle(}{it:string}{cmd:)} 
{cmdab:somec:olors(}{it:real 3}{cmd:)} {cmdab:somesat:uration(}{it:real 100}{cmd:)} {break} 
{cmdab:barst:yle(}{it:string}{cmd:)} {cmdab:barc:olors(}{it:real 3}{cmd:)} 
{cmdab:barsat:uration(}{it:real 100}{cmd:)} {break} {cmdab:scatst:yle(}{it:string}{cmd:)} 
{cmdab:scatc:olors(}{it:real 3}{cmd:)} {cmdab:scatsat:uration(}{it:real 100}{cmd:)} {break} 
{cmdab:areast:yle(}{it:string}{cmd:)} {cmdab:areac:olors(}{it:real 3}{cmd:)} 
{cmdab:areasat:uration(}{it:real 100}{cmd:)} {break} {cmdab:linest:yle(}{it:string}{cmd:)} 
{cmdab:linec:olors(}{it:real 3}{cmd:)} {cmdab:linesat:uration(}{it:real 100}{cmd:)} {break} 
{cmdab:boxst:yle(}{it:string}{cmd:)} {cmdab:boxc:olors(}{it:real 3}{cmd:)} 
{cmdab:boxsat:uration(}{it:real 100}{cmd:)} {break} {cmdab:dotst:yle(}{it:string}{cmd:)} 
{cmdab:dotc:olors(}{it:real 3}{cmd:)} {cmdab:dotsat:uration(}{it:real 100}{cmd:)}  {break} 
{cmdab:piest:yle(}{it:string}{cmd:)} {cmdab:piec:olors(}{it:real 3}{cmd:)} 
{cmdab:piesat:uration(}{it:real 100}{cmd:)} {break} {cmdab:sunst:yle(}{it:string}{cmd:)} 
{cmdab:sunc:olors(}{it:real 4}{cmd:)} {cmdab:sunsat:uration(}{it:real 100}{cmd:)}  {break} 
{cmdab:histst:yle(}{it:string}{cmd:)} {cmdab:histc:olors(}{it:real 3}{cmd:)} 
{cmdab:histsat:uration(}{it:real 100}{cmd:)} {break} {cmdab:cist:yle(}{it:string}{cmd:)} 
{cmdab:cic:olors(}{it:real 3}{cmd:)} {cmdab:cisat:uration(}{it:real 100}{cmd:)}  {break} 
{cmdab:matst:yle(}{it:string}{cmd:)} {cmdab:matc:olors(}{it:real 3}{cmd:)} 
{cmdab:matsat:uration(}{it:real 100}{cmd:)} {break} {cmdab:reflst:yle(}{it:string}{cmd:)} 
{cmdab:reflc:olors(}{it:real 3}{cmd:)} {cmdab:reflsat:uration(}{it:real 100}{cmd:)}  {break} 
{cmdab:refmst:yle(}{it:string}{cmd:)} {cmdab:refmc:olors(}{it:real 3}{cmd:)} 
{cmdab:refmsat:uration(}{it:real 100}{cmd:)} {break} {cmdab:const:art(}{it:string}{cmd:)} 
{cmdab:cone:nd(}{it:string}{cmd:)} {cmdab:consat:uration(}{it:real 100}{cmd:)} ] {p_end}{break}

{title:Description}

{p 4 4 4}{cmd:brewscheme} is a tool to facilitate Stata users developing 
graph schemes using research-based color palettes.  Unlike other uses of the 
color palettes developed by Brewer (see References below), this program allows 
users to specify the number of colors from any of the 35 color palettes they 
would like to use and allows users to mix/combine different palettes for the 
various graph types available in Stata.  Future releases may include color 
palettes developed by others.  {p_end}

{title:Options}
{p 4 4 8}{cmdab:scheme:name} is used to name the scheme that will be created by 
the program.  {it:Unless absolutely necessary, I highly recommend avoiding embedded spaces in these file names.}
 
{p 4 4 8}{cmdab:refr:esh} if the source dataset containing the color palettes 
is not found or the user specifies the {cmdab:refr:esh} option, {cmd: colorbrewscheme} 
will rebuild the source data set to generate the scheme files.


{dlgtab 0 0:Single Color Palettes and Default Color Palettes}{break}
{p 4 4 8}{cmdab:allst:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to be used for 
all graph types.{p_end}
{p 4 4 8}{cmdab:allc:olors} The maximum number of colors to use from the palette 
specifed by the {cmdab:allst:yle} option.{p_end}
{p 4 4 8}{cmdab:allsat:uration} Used to set the color intensity for all graph types.{p_end}
{p 4 4 8}{cmdab:somest:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to be used for 
graph types without specified color palettes.{p_end}
{p 4 4 8}{cmdab:somec:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:somest:yle} option.{p_end} 
{p 4 4 8}{cmdab:somesat:uration} Used to set the color intensity for graph 
types without specified color palettes.{p_end}

{dlgtab 4 0:Individual Graph Types}{break}
{dlgtab 8 0:Bar Graphs}{break}
{p 14 14 14}{cmdab:barst:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette that will be 
used to define colors for bar graphs.{p_end}
{p 14 14 14}{cmdab:barc:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:barst:yle} option.{p_end}
{p 14 14 14}{cmdab:barsat:uration} Used to set the color intensity for bar graphs.{p_end}

{dlgtab 8 0:Scatterplots}{break}
{p 14 14 14}{cmdab:scatst:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette that will be 
used for scatter plots.{p_end}
{p 14 14 14}{cmdab:scatc:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:scatst:yle} option.{p_end}
{p 14 14 14}{cmdab:scatsat:uration} Used to set the color intensity for scatterplots.{p_end}

{dlgtab 8 0:Area Graphs}{break}
{p 14 14 14}{cmdab:areast:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to be used for 
area graphs{p_end}
{p 14 14 14}{cmdab:areac:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:areast:yle} option.{p_end}
{p 14 14 14}{cmdab:areasat:uration} Used to set the color intensity for area graphs.{p_end}

{dlgtab 8 0:Line Graphs}{break}
{p 14 14 14}{cmdab:linest:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to be used for 
line graphs.{p_end}
{p 14 14 14}{cmdab:linec:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:linest:yle} option.{p_end}
{p 14 14 14}{cmdab:linesat:uration} Used to set the color intensity for line graphs.{p_end}

{dlgtab 8 0:Box Plots}{break}
{p 14 14 14}{cmdab:boxst:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to be used for 
box plots.{p_end}
{p 14 14 14}{cmdab:boxc:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:allst:yle} option.{p_end}
{p 14 14 14}{cmdab:boxsat:uration} Used to set the color intensity for box plots.{p_end}

{dlgtab 8 0:Dot Plots}{break}
{p 14 14 14}{cmdab:dotst:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to be used for 
dot plots.{p_end}
{p 14 14 14}{cmdab:dotc:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:dotst:yle} option.{p_end}
{p 14 14 14}{cmdab:dotsat:uration} Used to set the color intensity for dot plots.{p_end}

{dlgtab 8 0:Pie Graphs}{break}
{p 14 14 14}{cmdab:piest:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to be used for 
pie graphs.{p_end}
{p 14 14 14}{cmdab:piec:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:piest:yle} option.{p_end}
{p 14 14 14}{cmdab:piesat:uration} Used to set the color intensity for pie graphs.{p_end}

{dlgtab 8 0:Sunflower Plots}{break}
{p 14 14 14}{cmdab:sunst:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to be used for 
sunflower plots.  {it:Note, only the first four colors will be used.}{p_end}
{p 14 14 14}{cmdab:sunc:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:sunst:yle} option.{p_end}
{p 14 14 14}{cmdab:sunsat:uration} Used to set the color intensity for sunflower plots.{p_end}

{dlgtab 8 0:Histograms}{break}
{p 14 14 14}{cmdab:histst:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to be used for
histograms.{p_end}
{p 14 14 14}{cmdab:histc:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:histst:yle} option.{p_end}
{p 14 14 14}{cmdab:histsat:uration} Used to set the color intensity for histograms.{p_end}

{dlgtab 8 0:Confidence Intervals}{break}
{p 14 14 14}{cmdab:cist:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to be used for 
graphs containing confidence intervals.{p_end}
{p 14 14 14}{cmdab:cic:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:cist:yle} option.{p_end}
{p 14 14 14}{cmdab:cisat:uration} Used to set the color intensity for confidence intervals.{p_end}

{dlgtab 8 0:Scatterplot Matrices}{break}
{p 14 14 14}{cmdab:matst:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to be used for 
scatter plot matrices.{p_end}
{p 14 14 14}{cmdab:matc:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:matst:yle} option.{p_end}
{p 14 14 14}{cmdab:matsat:uration} Used to set the color intensity for scatterplot matrices.{p_end}

{dlgtab 8 0:Reference Lines}{break}
{p 14 14 14}{cmdab:reflst:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to be used for 
reference lines.{p_end}
{p 14 14 14}{cmdab:reflc:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:reflst:yle} option.{p_end}
{p 14 14 14}{cmdab:reflsat:uration} Used to set the color intensity for reference lines.{p_end}

{dlgtab 8 0:Reference Markers}{break}
{p 14 14 14}{cmdab:refmst:yle} The lower-cased name of a 
{browse "http://www.colorbrewer2.org":Color Brewer} color palette to use for 
reference markers.{p_end}
{p 14 14 14}{cmdab:refmc:olors} The maximum number of colors to use from the 
palette specifed by the {cmdab:refmst:yle} option.{p_end}
{p 14 14 14}{cmdab:refmsat:uration} Used to set the color intensity for reference markers.{p_end}

{dlgtab 8 0:Contour Plots}{break}
{p 14 14 14}{cmdab:const:art} Defines the starting color to be used for contour 
plots using standard {help colorstyle:colorstyles} from Stata.{p_end} 
{p 14 14 14}{cmdab:cone:nd} Defines the ending color to be used for contour 
plots using standard {help colorstyle:colorstyles} from Stata.{p_end}

{title:Examples}{break}
{p 8 8 8} Generate a graph scheme using the set1 color brewer palette for all 
graphs.  Use the first five colors of the palette and set the color intensity to 
80 for each of the graphs.{p_end}
{p 10 10 10}{stata brewscheme, scheme(set1) allst(set1) allc(5) allsat(80):brewscheme, scheme(set1) allst(set1) allc(5) allsat(80)}{p_end}{break}

{p 8 8 8} Generate a graph scheme using the set1 color brewer palette for 
scatterplots, pastel1 for bar graphs, and brown to blue-green for all other 
graph types.  Use the default values of colors and intensity for each.{p_end}
{p 10 10 10}{stata brewscheme, scheme(mixed1) scatst(set1) barst(pastel1) somest(brbg):brewscheme, scheme(mixed1)  scatst(set1) barst(pastel1) somest(brbg)}{p_end}{break}

{title:References}{break}
{p 1 1 1} Colors from {browse "http://www.ColorBrewer2.org":Color Brewer} by 
Cynthia A. Brewer, Geography, Pennsylvania State University{p_end}

{title:License}
{p 4 4 4}Please view {browse "http://www.personal.psu.edu/cab38/ColorBrewer/ColorBrewer_updates.html": section 4} of the ColorBrewer copyright notice for additional information 
pertaining to the licensing and redistribution of ColorBrew intellectual property.{p_end}

{title: Author}{break}
{p 1 1 1} William R. Buchanan, Ph.D. {break}
Strategic Data Fellow {break}
{browse "http://mde.k12.ms.us":Mississippi Department of Education} {break}
BBuchanan at mde [dot] k12 [dot] ms [dot] us
