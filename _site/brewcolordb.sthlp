{smcl}
{* *! version 0.0.1  25NOV2015}{...}
{cmd:help brewcolordb}
{hline}

{title:Title}

{p 4 4 4}{hi:brewcolordb {hline 2}} is a program to build a database of locally 
installed colors defined by StataCorp.  It includes the RGB values for each color 
as well as transformed RGB values that simulate varying forms of color sight impairments.{p_end}

{title:Syntax}

{p 4 4 4}{cmd:brewcolordb} [, {cmdab:dis:play} ] {break}

{title:Description}

{p 4 4 4}{cmd:brewcolordb} builds a local database of named RGB colors on the 
user's system.  It also includes transformed RGB values for different forms of 
color sight impairments.{p_end}

{marker examples}{title:Examples}{break}
{p 4 4 4}Build the database and display the results{p_end}

{p 8 8 12}brewcolordb, dis{p_end}{break}

{title: Author}{break}
{p 1 1 1} William R. Buchanan, Ph.D. {break}
Data Scientist {break}
{browse "http://mpls.k12.mn.us":Minneapolis Public Schools} {break}
William.Buchanan at mpls [dot] k12 [dot] mn [dot] us
