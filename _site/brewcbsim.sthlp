{smcl}
{* *! version 0.0.1  25NOV2015}{...}
{cmd:help brewcbsim}
{hline}

{title:Title}

{p 4 4 4}{hi:brewcbsim {hline 2}} a program to simulate how a given color would 
be perceived by individuals with achromatopsia, protanopia, deuteranopia, or 
tritanopia.{p_end}

{title:Syntax}

{p 4 4 4}{cmd:brewcbsim} {it:red green blue} {break}

{title:Description}

{p 4 4 4}{cmd:brewcbsim} is used to simulate how a given color (specified as an RGB tuple in [0, 255]) would be perceived by individuals with color sight impairments.{p_end}

{marker examples}{title:Examples}{break}
{p 4 4 4} Green channel dominant color. {p_end}

{p 8 8 12}brewcbsim 63 210 142{p_end}

{p 4 4 4}Blue channel dominant color.{p_end}

{p 8 8 12}brewcbsim 8 151 233{p_end}

{p 4 4 4}Red channel dominant color{p_end}

{p 8 8 12}brewcbsim 182 33 43{p_end}

{p 4 4 4}These examples can be viewed {browse "http://wbuchanan.github.io/brewscheme/brewcbsim/":here}.{p_end}{break}

{marker refs}{title:{ul:References}}{break}
{marker wickline}{p 4 8 8}Wickline, M. (2014). {it:Color.Vision.Simulate, Version 0.1}.  Retrieved from: 
{browse "http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js"}. 
Retrieved on: 24nov2015.{p_end} 
{marker mg}{p 4 8 8}Meyer, G. W., & Greenberg, D. P. (1988). Color-Defective Vision and Computer Graphics Displays. 
{it:Computer Graphics and Applications, IEEE 8(5)}, pp. 28-40.{p_end}

{marker sp}{p 4 8 8}Smith, V. C., & Pokorny, J. (2005).  Spectral sensitivity of the foveal cone photopigments between 400 and 500nm.  
{it:Journal of the Optical Society of America A, 22(10),} pp. 2060-2071.{p_end}

{marker lindbloom}{p 4 8 8}Lindbloom, B. (2001).  RGB working space information. Retrieved from: {browse "http://www.brucelindbloom.com/WorkingSpaceInfo.html"}.  Retrieved on 24nov2015.{p_end}

{title: Author}{break}
{p 1 1 1} William R. Buchanan, Ph.D. {break}
Data Scientist {break}
{browse "http://mpls.k12.mn.us":Minneapolis Public Schools} {break}
William.Buchanan at mpls [dot] k12 [dot] mn [dot] us
