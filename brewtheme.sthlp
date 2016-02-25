{smcl}
{* *! version 0.0.1  29NOV2015}{...}
{cmd:help brewtheme}
{hline}

{title:Title}

{p 4 4 4}{hi:brewtheme {hline 2}} a program to generate theme files containing 
scheme file entries for graph independent aesthetics. {p_end}

{title:Syntax}

{p 4 4 4}{cmd:brewtheme} {it:themeName} [, {help brewtheme##abovebelow:{ul:abo}vebelow}{hi:(}{it:string}{hi:)}
{help brewtheme##anglestyle:{ul:anglesty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##areastyle:{ul:areasty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##arrowstyle:{ul:arrowsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##axisstyle:{ul:axissty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##barlabelpos:{ul:barlabelp}os}{hi:(}{it:string}{hi:)}
{help brewtheme##barlabelstyle:{ul:barlabelsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##barstyle:{ul:barsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##bygraphstyle:{ul:bygraphsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##clegendstyle:{ul:clegendsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##clockdir:{ul:clock}dir}{hi:(}{it:string}{hi:)}
{help brewtheme##color:{ul:col}or}{hi:(}{it:string}{hi:)}
{help brewtheme##compass2dir:{ul:compass2}dir}{hi:(}{it:string}{hi:)}
{help brewtheme##compass3dir:{ul:compass3}dir}{hi:(}{it:string}{hi:)}
{help brewtheme##connectstyle:{ul:connectsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##dottypestyle:{ul:dottypesty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##graphsize:{ul:graphsi}ze}{hi:(}{it:string}{hi:)}
{help brewtheme##graphstyle:{ul:graphsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##gridlinestyle:{ul:gridlinesty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##gridringstyle:{ul:gridringsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##gridstyle:{ul:gridsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##gsize:{ul:gsize}}{hi:(}{it:string}{hi:)}
{help brewtheme##horizontal:{ul:horiz}ontal}{hi:(}{it:string}{hi:)}
{help brewtheme##labelstyle:{ul:labelsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##legendstyle:{ul:legendsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##linepattern:{ul:linepat}tern}{hi:(}{it:string}{hi:)}
{help brewtheme##linestyle:{ul:linesty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##linewidth:{ul:linew}idth}{hi:(}{it:string}{hi:)}
{help brewtheme##btmargin:{ul:marg}in}{hi:(}{it:string}{hi:)}
{help brewtheme##medtypestyle:{ul:medtypesty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##numstyle:{ul:numsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##numticks:{ul:numticks}}{hi:(}{it:string}{hi:)}
{help brewtheme##piegraphstyle:{ul:piegraphsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##pielabelstyle:{ul:pielabelsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##plotregionstyle:{ul:plotregionsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##relativepos:{ul:relativep}os}{hi:(}{it:string}{hi:)}
{help brewtheme##relsize:{ul:relsi}ze}{hi:(}{it:string}{hi:)}
{help brewtheme##special:{ul:spec}ial}{hi:(}{it:string}{hi:)}
{help brewtheme##starstyle:{ul:starsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##sunflowerstyle:{ul:sunflowersty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##symbol:{ul:symb}ol}{hi:(}{it:string}{hi:)}
{help brewtheme##symbolsize:{ul:symbolsi}ze}{hi:(}{it:string}{hi:)}
{help brewtheme##orientstyle:{ul:orientsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##textboxstyle:{ul:textboxsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##tickposition:{ul:tickp}osition}{hi:(}{it:string}{hi:)}
{help brewtheme##tickstyle:{ul:ticksty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##ticksetstyle:{ul:ticksetsty}le}{hi:(}{it:string}{hi:)}
{help brewtheme##verticaltext:{ul:verticalt}ext}{hi:(}{it:string}{hi:)}
{help brewtheme##yesno:{ul:yesn}o}{hi:(}{it:string}{hi:)}
{help brewtheme##zyx2rule:{ul:zyx2r}ule}{hi:(}{it:string}{hi:)}
{help brewtheme##zyx2style:{ul:zyx2sty}le}{hi:(}{it:string}{hi:)} ]{break}

{marker bttop}{title:Description}

{p 4 4 4}{cmd:brewtheme} is used to create a file with scheme entries that are 
primarily used to control/define graph independent/global aesthetic properties 
for Stata graphs (with a few exceptions related to bar graphs and/or pie graphs).  
Given the number of potential arguments for some of these options, they are each 
described below briefly and in greater detail in their respective helpfiles.{p_end}

{p 4 4 4}Additionally, when developing new schemes/themes, it is important to 
follow the guidance provided in the {help scheme_files##remarks6:scheme files} 
help documentation.  Notably: {p_end}{break}

{p 8 8 12}It is critical that you issue the {help discard} command each time 
before you reissue your graph command.  {help discard} reinitializes the 
graphics system, and that includes clearing the graphics scheme.  If you do not 
type {help discard}, {hi graph} will note that you are using the same scheme 
each time and will use the already loaded scheme - ignoring the
changes you made in the scheme file.{p_end}

{p 4 4 4}For additional information about the different options and entries that 
are used in scheme files, see {help scheme entries}.  If you try a value that 
does not work when creating a {hi .theme} file, {browse "https://github.com/wbuchanan/brewscheme/issues":submit an issue} 
to the project's repository or you can modify the corresponding help file for 
that option noting that the value didn't work and submit a pull request to 
merge your changes with the project's repository.  The entries on the topic 
specific help files below are my best guesses regarding the set of possible 
values.  {p_end}


{title:Options}{break}
{p 4 4 4}The links below point to topic specific help files.  These are still a 
work in progress, but will contain information about specific entries and as 
much information as possible about how their values effect the appearance of 
graphs.{p_end}

{p 4 4 4}{it:The options below are listed with the 'bt' prefix to differentiate them from cases where there may be official Stata help files with the same namespace.}{p_end}

{col 15}{hline 55}
{p2colset 20 50 50 20}{p2col:{marker abovebelow}{title: {help btabovebelow}}}{marker anglestyle}{title: {help btanglestyle}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker areastyle}{title: {help btareastyle}}}{marker arrowstyle}{title: {help btarrowstyle}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker axisstyle}{title: {help btaxisstyle}}}{marker barlabelpos}{title: {help btbarlabelpos}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker barlabelstyle}{title: {help btbarlabelstyle}}}{marker barstyle}{title: {help btbarstyle}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker bygraphstyle}{title: {help btbygraphstyle}}}{marker clegendstyle}{title: {help btclegendstyle}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker clockdir}{title: {help btclockdir}}}{marker color}{title: {help btcolor}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker compass2dir}{title: {help btcompass2dir}}}{marker compass3dir}{title: {help btcompass3dir}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker connectstyle}{title: {help btconnectstyle}}}{marker dottypestyle}{title: {help btdottypestyle}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker graphsize}{title: {help btgraphsize}}}{marker graphstyle}{title: {help btgraphstyle}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker gridlinestyle}{title: {help btgridlinestyle}}}{marker gridringstyle}{title: {help btgridringstyle}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker gridstyle}{title: {help btgridstyle}}}{marker gsize}{title: {help btgsize}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker horizontal}{title: {help bthorizontal}}}{marker labelstyle}{title: {help btlabelstyle}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker legendstyle}{title: {help btlegendstyle}}}{marker linepattern}{title: {help btlinepattern}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker linestyle}{title: {help btlinestyle}}}{marker linewidth}{title: {help btlinewidth}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker btmargin}{title: {help btmargin:margin}}}{marker medtypestyle}{title: {help btmedtypestyle}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker numstyle}{title: {help btnumstyle}}}{marker numticks}{title: {help btnumticks}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker piegraphstyle}{title: {help btpiegraphstyle}}}{marker pielabelstyle}{title: {help btpielabelstyle}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker plotregionstyle}{title: {help btplotregionstyle}}}{marker relativepos}{title: {help btrelativepos}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker relsize}{title: {help btrelsize}}}{marker special}{title: {help btspecial}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker starstyle}{title: {help btstarstyle}}}{marker sunflowerstyle}{title: {help btsunflowerstyle}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker symbol}{title: {help btsymbol}}}{marker symbolsize}{title: {help btsymbolsize}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker textboxstyle}{title: {help bttextboxstyle}}}{marker tickposition}{title: {help bttickposition}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker tickstyle}{title: {help bttickstyle}}}{marker ticksetstyle}{title: {help btticksetstyle}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker verticaltext}{title: {help btverticaltext}}}{marker yesno}{title: {help btyesno}}{p_end}
{p2colset 20 50 50 20}{p2col:{marker zyx2rule}{title: {help btzyx2rule}}}{marker zyx2style}{title: {help btzyx2style}}{p_end}
{col 15}{hline 55}

{title: Author}{break}
{p 1 1 1} William R. Buchanan, Ph.D. {break}
Data Scientist {break}
{browse "http://mpls.k12.mn.us":Minneapolis Public Schools} {break}
William.Buchanan at mpls [dot] k12 [dot] mn [dot] us
