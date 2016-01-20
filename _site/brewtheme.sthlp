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

{title:Options}{break}
{marker abovebelow}{title: {help btabovebelow}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker anglestyle}{title: {help btanglestyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker areastyle}{title: {help btareastyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker arrowstyle}{title: {help btarrowstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker axisstyle}{title: {help btaxisstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker barlabelpos}{title: {help btbarlabelpos}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker barlabelstyle}{title: {help btbarlabelstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker barstyle}{title: {help btbarstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker bygraphstyle}{title: {help btbygraphstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker clegendstyle}{title: {help btclegendstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker clockdir}{title: {help btclockdir}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker color}{title: {help btcolor}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker compass2dir}{title: {help btcompass2dir}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker compass3dir}{title: {help btcompass3dir}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker connectstyle}{title: {help btconnectstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker dottypestyle}{title: {help btdottypestyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker graphsize}{title: {help btgraphsize}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker graphstyle}{title: {help btgraphstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker gridlinestyle}{title: {help btgridlinestyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker gridringstyle}{title: {help btgridringstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker gridstyle}{title: {help btgridstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker gsize}{title: {help btgsize}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker horizontal}{title: {help bthorizontal}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker labelstyle}{title: {help btlabelstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker legendstyle}{title: {help btlegendstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker linepattern}{title: {help btlinepattern}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker linestyle}{title: {help btlinestyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker linewidth}{title: {help btlinewidth}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker btmargin}{title: {help btmargin:margin}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker medtypestyle}{title: {help btmedtypestyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker numstyle}{title: {help btnumstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker numticks}{title: {help btnumticks}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker piegraphstyle}{title: {help btpiegraphstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker pielabelstyle}{title: {help btpielabelstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker plotregionstyle}{title: {help btplotregionstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker relativepos}{title: {help btrelativepos}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker relsize}{title: {help btrelsize}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker special}{title: {help btspecial}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker starstyle}{title: {help btstarstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker sunflowerstyle}{title: {help btsunflowerstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker symbol}{title: {help btsymbol}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker symbolsize}{title: {help btsymbolsize}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker textboxstyle}{title: {help bttextboxstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker tickposition}{title: {help bttickposition}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker tickstyle}{title: {help bttickstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker ticksetstyle}{title: {help btticksetstyle}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker verticaltext}{title: {help btverticaltext}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker yesno}{title: {help btyesno}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker zyx2rule}{title: {help btzyx2rule}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}

{marker zyx2style}{title: {help btzyx2style}}{break}
{p 4 4 8}{p_end}
{p 4 4 8}{help brewtheme##bttop:Back to the Top}{p_end}


{title: Author}{break}
{p 1 1 1} William R. Buchanan, Ph.D. {break}
Data Scientist {break}
{browse "http://mpls.k12.mn.us":Minneapolis Public Schools} {break}
William.Buchanan at mpls [dot] k12 [dot] mn [dot] us
