---
layout: page
title: brewtheme
permalink: /help/brewtheme/
---

<hr>
Command used to generate .theme files used by brewscheme
<hr>
<br>
<br>
<a name="top"></a>

__brewtheme__ -- a program to generate theme files containing scheme file entries for graph independent aesthetics.

## Syntax

__brewtheme__ <em>themeName</em> [, <u>abo</u>vebelow(string) <u>anglesty</u>le(string) <u>areasty</u>le(string) <u>arrowsty</u>le(string) <u>axissty</u>le(string) <u>barlabelp</u>os(string) <u>barlabelsty</u>le(string) <u>barsty</u>le(string) <u>bygraphsty</u>le(string) <u>clegendsty</u>le(string) <u>clock</u>dir(string) <u>col</u>or(string) <u>compass2</u>dir(string) <u>compass3</u>dir(string) <u>connectsty</u>le(string) <u>dottypesty</u>le(string) <u>graphsi</u>ze(string) <u>graphsty</u>le(string) <u>gridlinesty</u>le(string) <u>gridringsty</u>le(string) <u>gridsty</u>le(string) gsize(string) <u>horiz</u>ontal(string) <u>labelsty</u>le(string) <u>legendsty</u>le(string) <u>linepat</u>tern(string) <u>linesty</u>le(string) <u>linew</u>idth(string) <u>marg</u>in(string) <u>medtypesty</u>le(string) <u>numsty</u>le(string) numticks(string) <u>piegraphsty</u>le(string) <u>pielabelsty</u>le(string) <u>plotregionsty</u>le(string) <u>relativep</u>os(string) <u>relsi</u>ze(string) <u>spec</u>ial(string) <u>starsty</u>le(string) <u>sunflowersty</u>le(string) <u>symb</u>ol(string) <u>symbolsi</u>ze(string) <u>orientsty</u>le(string) <u>textboxsty</u>le(string) <u>tickp</u>osition(string) <u>ticksty</u>le(string) <u>ticksetsty</u>le(string) <u>verticalt</u>ext(string) <u>yesn</u>o(string) <u>zyx2r</u>ule(string) <u>zyx2sty</u>le(string) ]

## Description

__brewtheme__ is used to create a file with scheme entries that are primarily used to control/define graph independent/global aesthetic properties for Stata graphs (with a few exceptions related to bar graphs and/or pie graphs).  Given the number of potential arguments for some of these options, they are each described below briefly and in greater detail in their respective helpfiles.

Additionally, when developing new schemes/themes, it is important to follow the guidance provided in the scheme files help documentation.  Notably:

It is critical that you issue the discard command each time before you reissue your graph command.  discard reinitializes the graphics system, and that includes clearing the graphics scheme.  If you do not type discard, <strong>graph</strong> will note that you are using the same scheme each time and will use the already loaded scheme - ignoring the changes you made in the scheme file.

For additional information about the different options and entries that are used in scheme files, see scheme entries.  If you try a value that does not work when creating a <strong>.theme</strong> file, submit an issue to the project's repository or you can modify the corresponding help file for that option noting that the value didn't work and submit a pull request to merge your changes with the project's repository.  The entries on the topic specific help files below are my best guesses regarding the set of possible values.  

Lastly, if you want to see any working examples, there are <a href="#examples">examples available</a> at the bottom of this page.

## Options

The links below point to topic specific help files.  These are still a work in progress, but will contain information about specific entries and as much information as possible about how their values effect the appearance of graphs.

The options below are listed with the 'bt' prefix to differentiate them from cases where there may be official Stata help files with the same namespace.

<table>
<tr><td><a href="#abovebelow">btabovebelow</a></td><td><a href="#anglestyle">btanglestyle</a></td></tr>
<tr><td><a href="#areastyle">btareastyle</a></td><td><a href="#arrowstyle">btarrowstyle</a></td></tr>
<tr><td><a href="#axisstyle">btaxisstyle</a></td><td><a href="#barlabelpos">btbarlabelpos</a></td></tr>
<tr><td><a href="#barlabelstyle">btbarlabelstyle</a></td><td><a href="#barstyle">btbarstyle</a></td></tr>
<tr><td><a href="#bygraphstyle">btbygraphstyle</a></td><td><a href="#clegendstyle">btclegendstyle</a></td></tr>
<tr><td><a href="#clockdir">btclockdir</a></td><td><a href="#color">btcolor</a></td></tr>
<tr><td><a href="#compass2dir">btcompass2dir</a></td><td><a href="#compass3dir">btcompass3dir</a></td></tr>
<tr><td><a href="#connectstyle">btconnectstyle</a></td><td><a href="#dottypestyle">btdottypestyle</a></td></tr>
<tr><td><a href="#graphsize">btgraphsize</a></td><td><a href="#graphstyle">btgraphstyle</a></td></tr>
<tr><td><a href="#gridlinestyle">btgridlinestyle</a></td><td><a href="#gridringstyle">btgridringstyle</a></td></tr>
<tr><td><a href="#gridstyle">btgridstyle</a></td><td><a href="#gsize">btgsize</a></td></tr>
<tr><td><a href="#horizontal">bthorizontal</a></td><td><a href="#labelstyle">btlabelstyle</a></td></tr>
<tr><td><a href="#legendstyle">btlegendstyle</a></td><td><a href="#linepattern">btlinepattern</a></td></tr>
<tr><td><a href="#linestyle">btlinestyle</a></td><td><a href="#linewidth">btlinewidth</a></td></tr>
<tr><td><a href="#margin">btmargin</a></td><td><a href="#medtypestyle">btmedtypestyle</a></td></tr>
<tr><td><a href="#numstyle">btnumstyle</a></td><td><a href="#numticks">btnumticks</a></td></tr>
<tr><td><a href="#piegraphstyle">btpiegraphstyle</a></td><td><a href="#pielabelstyle">btpielabelstyle</a></td></tr>
<tr><td><a href="#plotregionstyle">btplotregionstyle</a></td><td><a href="#relativepos">btrelativepos</a></td></tr>
<tr><td><a href="#relsize">btrelsize</a></td><td><a href="#special">btspecial</a></td></tr>
<tr><td><a href="#starstyle">btstarstyle</a></td><td><a href="#sunflowerstyle">btsunflowerstyle</a></td></tr>
<tr><td><a href="#symbol">btsymbol</a></td><td><a href="#symbolsize">btsymbolsize</a></td></tr>
<tr><td><a href="#textboxstyle">bttextboxstyle</a></td><td><a href="#tickposition">bttickposition</a></td></tr>
<tr><td><a href="#tickstyle">bttickstyle</a></td><td><a href="#ticksetstyle">btticksetstyle</a></td></tr>
<tr><td><a href="#verticaltext">btverticaltext</a></td><td><a href="#yesno">btyesno</a></td></tr>
<tr><td><a href="#zyx2rule">btzyx2rule</a></td><td><a href="#zyx2style">btzyx2style</a></td></tr>
</table>

<hr>
<br>
<a name="abovebelow"></a>

<u>abo</u>vebelow -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>star (line 1756)*</td><td>above | below</td><td>below</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.

<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="anglestyle"></a>

<u>anglesty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>clegend (line 1504)*</td><td>angle styles</td><td>horizontal</td></tr>
<tr><td>horizontal_tick</td><td>angle styles</td><td>horizontal</td></tr>
<tr><td>p (line 1505)*</td><td>angle styles</td><td>stdarrow</td></tr>
<tr><td>parrow (line 1506)*</td><td>angle styles</td><td>stdarrow</td></tr>
<tr><td>parrowbarb (line 1507)*</td><td>angle styles</td><td>zero</td></tr>
<tr><td>vertical_tick</td><td>angle styles</td><td>horizontal</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.

<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="areastyle"></a>

<u>areasty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>background</td><td>area styles</td><td>background</td></tr>
<tr><td>bar_iplotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>bar_plotregion</td><td>area styles</td><td>plotregion</td></tr>
<tr><td>box_iplotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>box_plotregion</td><td>area styles</td><td>plotregion</td></tr>
<tr><td>bygraph</td><td>area styles</td><td>background</td></tr>
<tr><td>bygraph_iplotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>bygraph_plotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>ci</td><td>area styles</td><td>ci</td></tr>
<tr><td>ci2</td><td>area styles</td><td>ci2</td></tr>
<tr><td>clegend (line 1200)*</td><td>area styles</td><td>clegend_preg</td></tr>
<tr><td>clegend_inner (line 1204)*</td><td>area styles</td><td>clegend_inner</td></tr>
<tr><td>clegend_inpreg (line 1202)*</td><td>area styles</td><td>none</td></tr>
<tr><td>clegend_outer (line 1203)*</td><td>area styles</td><td>clegend_outer</td></tr>
<tr><td>clegend_preg (line 1201)*</td><td>area styles</td><td>none</td></tr>
<tr><td>combine_iplotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>combine_plotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>combinegraph</td><td>area styles</td><td>background</td></tr>
<tr><td>combinegraph_inner</td><td>area styles</td><td>none</td></tr>
<tr><td>dendrogram (line 1223)*</td><td>area styles</td><td>dendrogram</td></tr>
<tr><td>dot_iplotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>dot_plotregion</td><td>area styles</td><td>plotregion</td></tr>
<tr><td>dotchart</td><td>area styles</td><td>dotchart</td></tr>
<tr><td>foreground</td><td>area styles</td><td>foreground</td></tr>
<tr><td>graph</td><td>area styles</td><td>background</td></tr>
<tr><td>hbar_iplotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>hbar_plotregion</td><td>area styles</td><td>plotregion</td></tr>
<tr><td>hbox_iplotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>hbox_plotregion</td><td>area styles</td><td>plotregion</td></tr>
<tr><td>histogram</td><td>area styles</td><td>histogram</td></tr>
<tr><td>inner_bygraph</td><td>area styles</td><td>none</td></tr>
<tr><td>inner_graph</td><td>area styles</td><td>none</td></tr>
<tr><td>inner_legend</td><td>area styles</td><td>none</td></tr>
<tr><td>inner_piegraph</td><td>area styles</td><td>none</td></tr>
<tr><td>inner_pieregion</td><td>area styles</td><td>none</td></tr>
<tr><td>inner_plotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>legend</td><td>area styles</td><td>legend</td></tr>
<tr><td>legend_inkey_region</td><td>area styles</td><td>none</td></tr>
<tr><td>legend_key_region</td><td>area styles</td><td>none</td></tr>
<tr><td>matrix_ilabel (line 1218)*</td><td>area styles</td><td>none</td></tr>
<tr><td>matrix_iplotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>matrix_label (line 1217)*</td><td>area styles</td><td>background</td></tr>
<tr><td>matrix_plotregion</td><td>area styles</td><td>matrix_plotregion</td></tr>
<tr><td>matrixgraph_iplotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>matrixgraph_plotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>piegraph</td><td>area styles</td><td>background</td></tr>
<tr><td>piegraph_region</td><td>area styles</td><td>plotregion</td></tr>
<tr><td>plotregion</td><td>area styles</td><td>plotregion</td></tr>
<tr><td>sunflower (line 1226)*</td><td>area styles</td><td>sunflower</td></tr>
<tr><td>sunflowerdb</td><td>area styles</td><td>sunflowerdb</td></tr>
<tr><td>sunflowerlb</td><td>area styles</td><td>sunflowerlb</td></tr>
<tr><td>twoway_iplotregion</td><td>area styles</td><td>none</td></tr>
<tr><td>twoway_plotregion</td><td>area styles</td><td>plotregion</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="arrowstyle"></a>

<u>arrowsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>default (line 1750)*</td><td>graph query arrowstyle</td><td>editor</td></tr>
<tr><td>editor (line 1751)*</td><td>graph query arrowstyle</td><td>editor</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="axisstyle"></a>

<u>axissty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>bar_group</td><td>axis styles</td><td>horizontal_notick</td></tr>
<tr><td>bar_scale_horiz</td><td>axis styles</td><td>horizontal_nogrid</td></tr>
<tr><td>bar_scale_vert</td><td>axis styles</td><td>vertical_nogrid</td></tr>
<tr><td>bar_super</td><td>axis styles</td><td>horizontal_nogrid</td></tr>
<tr><td>bar_var</td><td>axis styles</td><td>horizontal_notick</td></tr>
<tr><td>box_scale_horiz</td><td>axis styles</td><td>horizontal_nogrid</td></tr>
<tr><td>box_scale_vert</td><td>axis styles</td><td>vertical_nogrid</td></tr>
<tr><td>clegend (line 1394)*</td><td>axis styles</td><td>clegend</td></tr>
<tr><td>dot_group</td><td>axis styles</td><td>horizontal_notick</td></tr>
<tr><td>dot_scale_horiz</td><td>axis styles</td><td>horizontal_nogrid</td></tr>
<tr><td>dot_scale_vert</td><td>axis styles</td><td>vertical_nogrid</td></tr>
<tr><td>dot_super</td><td>axis styles</td><td>horizontal_nogrid</td></tr>
<tr><td>dot_var</td><td>axis styles</td><td>horizontal_notick</td></tr>
<tr><td>horizontal_default</td><td>axis styles</td><td>horizontal_default</td></tr>
<tr><td>horizontal_nogrid</td><td>axis styles</td><td>horizontal_nogrid</td></tr>
<tr><td>matrix_horiz</td><td>axis styles</td><td>horizontal_nogrid</td></tr>
<tr><td>matrix_vert</td><td>axis styles</td><td>vertical_nogrid</td></tr>
<tr><td>sts_risktable (line 1393)*</td><td>axis styles</td><td>sts_risktable</td></tr>
<tr><td>vertical_default</td><td>axis styles</td><td>vertical_default</td></tr>
<tr><td>vertical_nogrid</td><td>axis styles</td><td>vertical_nogrid</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="barlabelpos"></a>

<u>barlabelp</u>os -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>bar</td><td>graph query barlabelpos</td><td>outside</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="barlabelstyle"></a>

<u>barlabelsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>bar</td><td>graph query barlabelstyle</td><td>bar</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="barstyle"></a>

<u>barsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>box</td><td>graph query barstyle</td><td>boxdefault</td></tr>
<tr><td>default</td><td>graph query barstyle</td><td>default</td></tr>
<tr><td>dot</td><td>graph query barstyle</td><td>dotdefault</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="bygraphstyle"></a>

<u>bygraphsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>bygraph</td><td>bygraph styles</td><td>default</td></tr>
<tr><td>combine</td><td>bygraph styles</td><td>combine</td></tr>
<tr><td>default</td><td>bygraph styles</td><td>default</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="clegendstyle"></a>

<u>clegendsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>default (line 1552)*</td><td>clegend styles</td><td>default</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>    
<br>
<br>
<a name="clockdir"></a>

<u>clock</u>dir -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>by_legend_position</td><td>clock position styles</td><td>12</td></tr>
<tr><td>caption_position</td><td>clock position styles</td><td>5</td></tr>
<tr><td>clegend_title_position (line 1478)*</td><td>clock position styles</td><td>12</td></tr>
<tr><td>ilabel (line 1467)*</td><td>clock position styles</td><td>3</td></tr>
<tr><td>legend_caption_position</td><td>clock position styles</td><td>5</td></tr>
<tr><td>legend_note_position</td><td>clock position styles</td><td>7</td></tr>
<tr><td>legend_position</td><td>clock position styles</td><td>12</td></tr>
<tr><td>legend_subtitle_position</td><td>clock position styles</td><td>12</td></tr>
<tr><td>legend_title_position</td><td>clock position styles</td><td>12</td></tr>
<tr><td>matrix_marklbl</td><td>clock position styles</td><td>12</td></tr>
<tr><td>note_position</td><td>clock position styles</td><td>7</td></tr>
<tr><td>p</td><td>clock position styles</td><td>0</td></tr>
<tr><td>subtitle_position</td><td>clock position styles</td><td>12</td></tr>
<tr><td>title_position</td><td>clock position styles</td><td>12</td></tr>
<tr><td>zyx2legend_position (line 1465)*</td><td>clock position styles</td><td>3</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<a name="color"></a>

<u>col</u>or -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>axis_title</td><td>color styles</td><td>black</td></tr>
<tr><td>axisline</td><td>color styles</td><td>black</td></tr>
<tr><td>background</td><td>color styles</td><td>white</td></tr>
<tr><td>backsymbol (line 211)*</td><td>color styles</td><td>none</td></tr>
<tr><td>body</td><td>color styles</td><td>black</td></tr>
<tr><td>box</td><td>color styles</td><td>none</td></tr>
<tr><td>bylabel_outline (line 238)*</td><td>color styles</td><td>white</td></tr>
<tr><td>clegend (line 285)*</td><td>color styles</td><td>none</td></tr>
<tr><td>clegend_inner (line 287)*</td><td>color styles</td><td>none</td></tr>
<tr><td>clegend_line (line 288)*</td><td>color styles</td><td>none</td></tr>
<tr><td>clegend_outer (line 286)*</td><td>color styles</td><td>none</td></tr>
<tr><td>filled</td><td>color styles</td><td>white</td></tr>
<tr><td>filled_text</td><td>color styles</td><td>black</td></tr>
<tr><td>foreground</td><td>color styles</td><td>white</td></tr>
<tr><td>grid (line 244)*</td><td>color styles</td><td>white</td></tr>
<tr><td>heading</td><td>color styles</td><td>black</td></tr>
<tr><td>histback (line 268)*</td><td>color styles</td><td>white</td></tr>
<tr><td>key_label</td><td>color styles</td><td>black</td></tr>
<tr><td>label</td><td>color styles</td><td>black</td></tr>
<tr><td>legend</td><td>color styles</td><td>white</td></tr>
<tr><td>legend_line</td><td>color styles</td><td>white</td></tr>
<tr><td>major_grid</td><td>color styles</td><td>white</td></tr>
<tr><td>mat_label_box</td><td>color styles</td><td>white</td></tr>
<tr><td>matplotregion_line</td><td>color styles</td><td>black</td></tr>
<tr><td>matrix</td><td>color styles</td><td>white</td></tr>
<tr><td>matrix_label</td><td>color styles</td><td>black</td></tr>
<tr><td>matrix_marklbl</td><td>color styles</td><td>black</td></tr>
<tr><td>matrix_plotregion</td><td>color styles</td><td>white</td></tr>
<tr><td>matrixmarkline</td><td>color styles</td><td>black</td></tr>
<tr><td>minor_grid (line 246)*</td><td>color styles</td><td>white</td></tr>
<tr><td>minortick</td><td>color styles</td><td>black</td></tr>
<tr><td>pboxlabelfill (line 317)*</td><td>color styles</td><td>white</td></tr>
<tr><td>plabelfill (line 318)*</td><td>color styles</td><td>white</td></tr>
<tr><td>plotregion</td><td>color styles</td><td>white</td></tr>
<tr><td>plotregion_line</td><td>color styles</td><td>white</td></tr>
<tr><td>pmarkback (line 320)*</td><td>color styles</td><td>white</td></tr>
<tr><td>pmarkbkfill (line 321)*</td><td>color styles</td><td>white</td></tr>
<tr><td>reverse_big (line 240)*</td><td>color styles</td><td>none</td></tr>
<tr><td>reverse_big_line (line 241)*</td><td>color styles</td><td>black</td></tr>
<tr><td>reverse_big_text (line 242)*</td><td>color styles</td><td>white</td></tr>
<tr><td>small_body</td><td>color styles</td><td>black</td></tr>
<tr><td>sts_risk_label (line 225)*</td><td>color styles</td><td>black</td></tr>
<tr><td>sts_risk_title (line 226)*</td><td>color styles</td><td>black</td></tr>
<tr><td>subheading</td><td>color styles</td><td>black</td></tr>
<tr><td>symbol (line 210)*</td><td>color styles</td><td>black</td></tr>
<tr><td>text (line 213)*</td><td>color styles</td><td>black</td></tr>
<tr><td>text_option</td><td>color styles</td><td>black</td></tr>
<tr><td>text_option_fill</td><td>color styles</td><td>white</td></tr>
<tr><td>text_option_line</td><td>color styles</td><td>white</td></tr>
<tr><td>textbox</td><td>color styles</td><td>white</td></tr>
<tr><td>tick</td><td>color styles</td><td>black</td></tr>
<tr><td>tick_biglabel (line 223)*</td><td>color styles</td><td>black</td></tr>
<tr><td>tick_label</td><td>color styles</td><td>black</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<a href="compass2dir"></a>

<u>compass2</u>dir -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>editor (line 1450)*</td><td>compass direction styles</td><td>east</td></tr>
<tr><td>graph_aspect</td><td>compass direction styles</td><td>center</td></tr>
<tr><td>key_label</td><td>compass direction styles</td><td>west</td></tr>
<tr><td>legend_fillpos (line 1446)*</td><td>compass direction styles</td><td>center</td></tr>
<tr><td>legend_key (line 1447)*</td><td>compass direction styles</td><td>default</td></tr>
<tr><td>p (line 1444)*</td><td>compass direction styles</td><td>east</td></tr>
<tr><td>text_option</td><td>compass direction styles</td><td>center</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<a name="compass3dir"></a>

<u>compass3</u>dir -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>p (line 1455)*</td><td>compass3 direction styles</td><td>east</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="connectstyle"></a>

<u>connectsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>p</td><td>connection styles</td><td>direct</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="dottypestyle"></a>

<u>dottypesty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>dot</td><td>graph query dottypestyle</td><td>dot</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="graphsize"></a>

<u>graphsi</u>ze -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>x</td><td>Real #</td><td>9</td></tr>
<tr><td>y</td><td>Real #</td><td>6</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="graphstyle"></a>

<u>graphsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>default (line 1533)*</td><td>graph styles</td><td>default</td></tr>
<tr><td>graph (line 1534)*</td><td>graph styles</td><td>default</td></tr>
<tr><td>matrixgraph (line 1535)*</td><td>graph styles</td><td>matrixgraph</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="gridlinestyle"></a>

<u>gridlinesty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>default (line 1403)*</td><td>grid line styles</td><td>default</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="gridringstyle"></a>

<u>gridringsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>by_legend_ring</td><td>ring position styles</td><td>3</td></tr>
<tr><td>caption_ring</td><td>ring position styles</td><td>4</td></tr>
<tr><td>clegend_ring (line 1491)*</td><td>ring position styles</td><td>3</td></tr>
<tr><td>clegend_title_ring (line 1498)*</td><td>ring position styles</td><td>7</td></tr>
<tr><td>legend_caption_ring</td><td>ring position styles</td><td>3</td></tr>
<tr><td>legend_note_ring</td><td>ring position styles</td><td>3</td></tr>
<tr><td>legend_ring</td><td>ring position styles</td><td>3</td></tr>
<tr><td>legend_subtitle_ring</td><td>ring position styles</td><td>6</td></tr>
<tr><td>legend_title_ring</td><td>ring position styles</td><td>7</td></tr>
<tr><td>note_ring</td><td>ring position styles</td><td>4</td></tr>
<tr><td>spacers_ring (line 1484)*</td><td>ring position styles</td><td>11</td></tr>
<tr><td>subtitle_ring</td><td>ring position styles</td><td>6</td></tr>
<tr><td>title_ring</td><td>ring position styles</td><td>7</td></tr>
<tr><td>zyx2legend_ring (line 1490)*</td><td>ring position styles</td><td>4</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="gridstyle"></a>

<u>gridsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>major</td><td>graph query gridstyle</td><td>major</td></tr>
<tr><td>minor</td><td>graph query gridstyle</td><td>major</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="gsize"></a>

gsize -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>alternate_gap</td><td>text size styles</td><td>zero</td></tr>
<tr><td>axis_space</td><td>text size styles</td><td>half_tiny</td></tr>
<tr><td>axis_title</td><td>text size styles</td><td>small</td></tr>
<tr><td>axis_title_gap</td><td>text size styles</td><td>minuscule</td></tr>
<tr><td>barlabel_gap</td><td>text size styles</td><td>tiny</td></tr>
<tr><td>body</td><td>text size styles</td><td>small</td></tr>
<tr><td>clegend_height (line 128)*</td><td>text size styles</td><td>zero</td></tr>
<tr><td>clegend_width (line 127)*</td><td>text size styles</td><td>medsmall</td></tr>
<tr><td>dot_rectangle</td><td>text size styles</td><td>third_tiny</td></tr>
<tr><td>filled_text</td><td>text size styles</td><td>medsmall</td></tr>
<tr><td>gap</td><td>text size styles</td><td>tiny</td></tr>
<tr><td>heading</td><td>text size styles</td><td>medlarge</td></tr>
<tr><td>key_gap</td><td>text size styles</td><td>small</td></tr>
<tr><td>key_label</td><td>text size styles</td><td>small</td></tr>
<tr><td>key_linespace (line 108)*</td><td>text size styles</td><td>small</td></tr>
<tr><td>label</td><td>text size styles</td><td>small</td></tr>
<tr><td>label_gap</td><td>text size styles</td><td>half_tiny</td></tr>
<tr><td>legend_col_gap</td><td>text size styles</td><td>large</td></tr>
<tr><td>legend_colgap (line 110)*</td><td>text size styles</td><td>medium</td></tr>
<tr><td>legend_key_gap</td><td>text size styles</td><td>vsmall</td></tr>
<tr><td>legend_key_xsize</td><td>text size styles</td><td>small</td></tr>
<tr><td>legend_key_ysize</td><td>text size styles</td><td>small</td></tr>
<tr><td>legend_row_gap</td><td>text size styles</td><td>tiny</td></tr>
<tr><td>matrix_label</td><td>text size styles</td><td>medium</td></tr>
<tr><td>matrix_marklbl</td><td>text size styles</td><td>small</td></tr>
<tr><td>matrix_mlblgap</td><td>text size styles</td><td>half_tiny</td></tr>
<tr><td>minortick</td><td>text size styles</td><td>third_tiny</td></tr>
<tr><td>minortick_label</td><td>text size styles</td><td>vsmall</td></tr>
<tr><td>note (line 89)*</td><td>text size styles</td><td>vsmall</td></tr>
<tr><td>notickgap</td><td>text size styles</td><td>tiny</td></tr>
<tr><td>pboxlabel</td><td>text size styles</td><td>vsmall</td></tr>
<tr><td>pie_explode</td><td>text size styles</td><td>medsmall</td></tr>
<tr><td>pielabel_gap</td><td>text size styles</td><td>medsmall</td></tr>
<tr><td>plabel (line 133)*</td><td>text size styles</td><td>vsmall</td></tr>
<tr><td>reverse_big (line 104)*</td><td>text size styles</td><td>large</td></tr>
<tr><td>small_body</td><td>text size styles</td><td>vsmall</td></tr>
<tr><td>small_label</td><td>text size styles</td><td>vsmall</td></tr>
<tr><td>star (line 90)*</td><td>text size styles</td><td>small</td></tr>
<tr><td>star_gap (line 109)*</td><td>text size styles</td><td>minuscule</td></tr>
<tr><td>sts_risk_label (line 142)*</td><td>text size styles</td><td>medsmall</td></tr>
<tr><td>sts_risk_tick (line 144)*</td><td>text size styles</td><td>zero</td></tr>
<tr><td>sts_risk_title (line 143)*</td><td>text size styles</td><td>medsmall</td></tr>
<tr><td>sts_risktable_lgap (line 141)*</td><td>text size styles</td><td>tiny</td></tr>
<tr><td>sts_risktable_space (line 139)*</td><td>text size styles</td><td>tiny</td></tr>
<tr><td>sts_risktable_tgap (line 140)*</td><td>text size styles</td><td>tiny</td></tr>
<tr><td>subheading</td><td>text size styles</td><td>medium</td></tr>
<tr><td>text</td><td>text size styles</td><td>medsmall</td></tr>
<tr><td>text_option</td><td>text size styles</td><td>small</td></tr>
<tr><td>tick</td><td>text size styles</td><td>tiny</td></tr>
<tr><td>tick_biglabel</td><td>text size styles</td><td>small</td></tr>
<tr><td>tick_label</td><td>text size styles</td><td>small</td></tr>
<tr><td>tickgap</td><td>text size styles</td><td>half_tiny</td></tr>
<tr><td>title_gap</td><td>text size styles</td><td>small</td></tr>
<tr><td>zyx2colgap (line 125)*</td><td>text size styles</td><td>large</td></tr>
<tr><td>zyx2legend_key_gap (line 121)*</td><td>text size styles</td><td>tiny</td></tr>
<tr><td>zyx2legend_key_xsize (line 122)*</td><td>text size styles</td><td>vhuge</td></tr>
<tr><td>zyx2legend_key_ysize (line 123)*</td><td>text size styles</td><td>medium</td></tr>
<tr><td>zyx2rowgap (line 124)*</td><td>text size styles</td><td>zero</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="horizontal"></a>

<u>horiz</u>ontal -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>axis_title</td><td>horizontal justification styles</td><td>center</td></tr>
<tr><td>body</td><td>horizontal justification styles</td><td>center</td></tr>
<tr><td>editor (line 1353)*</td><td>horizontal justification styles</td><td>left</td></tr>
<tr><td>filled (line 1351)*</td><td>horizontal justification styles</td><td>center</td></tr>
<tr><td>heading</td><td>horizontal justification styles</td><td>center</td></tr>
<tr><td>key_label</td><td>horizontal justification styles</td><td>left</td></tr>
<tr><td>label</td><td>horizontal justification styles</td><td>center</td></tr>
<tr><td>matrix_label</td><td>horizontal justification styles</td><td>center</td></tr>
<tr><td>small_body (line 1348)*</td><td>horizontal justification styles</td><td>center</td></tr>
<tr><td>sts_risk_label (line 1354)*</td><td>horizontal justification styles</td><td>default</td></tr>
<tr><td>sts_risk_title (line 1355)*</td><td>horizontal justification styles</td><td>right</td></tr>
<tr><td>subheading</td><td>horizontal justification styles</td><td>center</td></tr>
<tr><td>text_option</td><td>horizontal justification styles</td><td>center</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="labelstyle"></a>

<u>labelsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>editor (line 1558)*</td><td>label styles</td><td>editor</td></tr>
<tr><td>ilabel (line 1556)*</td><td>label styles</td><td>ilabel</td></tr>
<tr><td>matrix</td><td>label styles</td><td>matrix</td></tr>
<tr><td>sunflower (line 1559)*</td><td>label styles</td><td>default</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="legendstyle"></a>

<u>legendsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>default (line 1548)*</td><td>legend styles</td><td>default</td></tr>
<tr><td>zyx2 (line 1549)*</td><td>legend styles</td><td>zyx2</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="linepattern"></a>

<u>linepat</u>tern -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>axisline</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>background</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>ci</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>ci_area</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>clegend (line 438)*</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>dendrogram (line 421)*</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>dot (line 433)*</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>dot_area</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>dotmark (line 435)*</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>dots (line 432)*</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>foreground</td><td>line pattern styles</td><td>blank</td></tr>
<tr><td>grid (line 422)*</td><td>line pattern styles</td><td>blank</td></tr>
<tr><td>histogram</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>legend</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>major_grid</td><td>line pattern styles</td><td>blank</td></tr>
<tr><td>matrix_plotregion</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>matrixmark (line 431)*</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>minor_grid (line 424)*</td><td>line pattern styles</td><td>blank</td></tr>
<tr><td>minortick</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>p</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>pie (line 436)*</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>plotregion</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>pmark (line 446)*</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>refline</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>refmarker</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>sunflower (line 440)*</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>text_option</td><td>line pattern styles</td><td>blank</td></tr>
<tr><td>tick</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>xyline</td><td>line pattern styles</td><td>solid</td></tr>
<tr><td>zyx2 (line 443)*</td><td>line pattern styles</td><td>solid</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="linestyle"></a>

<u>linesty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>axis</td><td>line style options</td><td>axisline</td></tr>
<tr><td>axis_withgrid</td><td>line style options</td><td>foreground</td></tr>
<tr><td>background</td><td>line style options</td><td>background</td></tr>
<tr><td>box_median</td><td>line style options</td><td>refline</td></tr>
<tr><td>box_whiskers</td><td>line style options</td><td>ci</td></tr>
<tr><td>boxline (line 716)*</td><td>line style options</td><td>foreground</td></tr>
<tr><td>ci</td><td>line style options</td><td>ci</td></tr>
<tr><td>ci2</td><td>line style options</td><td>ci2</td></tr>
<tr><td>ci2_area</td><td>line style options</td><td>ci2_area</td></tr>
<tr><td>ci_area</td><td>line style options</td><td>ci_area</td></tr>
<tr><td>clegend (line 746)*</td><td>line style options</td><td>clegend</td></tr>
<tr><td>clegend_inner (line 748)*</td><td>line style options</td><td>none</td></tr>
<tr><td>clegend_outer (line 747)*</td><td>line style options</td><td>none</td></tr>
<tr><td>clegend_preg (line 749)*</td><td>line style options</td><td>foreground</td></tr>
<tr><td>dendrogram (line 730)*</td><td>line style options</td><td>dendrogram</td></tr>
<tr><td>dotchart</td><td>line style options</td><td>dotchart</td></tr>
<tr><td>dotchart_area</td><td>line style options</td><td>dotchart_area</td></tr>
<tr><td>dotmark</td><td>line style options</td><td>dotmark</td></tr>
<tr><td>dots (line 754)*</td><td>line style options</td><td>dot</td></tr>
<tr><td>editor (line 755)*</td><td>line style options</td><td>editor</td></tr>
<tr><td>foreground</td><td>line style options</td><td>foreground</td></tr>
<tr><td>grid (line 731)*</td><td>line style options</td><td>none</td></tr>
<tr><td>histback (line 729)*</td><td>line style options</td><td>histogram</td></tr>
<tr><td>histogram</td><td>line style options</td><td>histogram</td></tr>
<tr><td>legend</td><td>line style options</td><td>none</td></tr>
<tr><td>major_grid</td><td>line style options</td><td>none</td></tr>
<tr><td>mat_label_box</td><td>line style options</td><td>foreground</td></tr>
<tr><td>matrix (line 733)*</td><td>line style options</td><td>p1solid</td></tr>
<tr><td>matrix_plotregion</td><td>line style options</td><td>matrix_plotregion</td></tr>
<tr><td>matrixmark</td><td>line style options</td><td>matrixmark</td></tr>
<tr><td>minor_grid (line 733)*</td><td>line style options</td><td>none</td></tr>
<tr><td>minortick</td><td>line style options</td><td>minortick</td></tr>
<tr><td>pboxlabel (line 977)*</td><td>line style options</td><td>foreground</td></tr>
<tr><td>pboxmarkback (line 974)*</td><td>line style options</td><td>background</td></tr>
<tr><td>pie_lines</td><td>line style options</td><td>pie</td></tr>
<tr><td>plabel (line 976)*</td><td>line style options</td><td>foreground</td></tr>
<tr><td>plotregion</td><td>line style options</td><td>plotregion</td></tr>
<tr><td>pmarkback (line 973)*</td><td>line style options</td><td>background</td></tr>
<tr><td>refline</td><td>line style options</td><td>refline</td></tr>
<tr><td>refmarker</td><td>line style options</td><td>refmarker</td></tr>
<tr><td>reverse_big (line 751)*</td><td>line style options</td><td>reverse_big</td></tr>
<tr><td>star (line 723)*</td><td>line style options</td><td>p1</td></tr>
<tr><td>sts_risktable (line 762)*</td><td>line style options</td><td>none</td></tr>
<tr><td>sunflower</td><td>line style options</td><td>sunflower</td></tr>
<tr><td>sunflowerdb</td><td>line style options</td><td>sunflowerdb</td></tr>
<tr><td>sunflowerdf</td><td>line style options</td><td>sunflowerdf</td></tr>
<tr><td>sunflowerlb</td><td>line style options</td><td>sunflowerlb</td></tr>
<tr><td>sunflowerlf</td><td>line style options</td><td>sunflowerlf</td></tr>
<tr><td>symbol (line 715)*</td><td>line style options</td><td>symbol</td></tr>
<tr><td>text_option</td><td>line style options</td><td>text_option</td></tr>
<tr><td>textbox</td><td>line style options</td><td>none</td></tr>
<tr><td>tick</td><td>line style options</td><td>tick</td></tr>
<tr><td>xyline</td><td>line style options</td><td>xyline</td></tr>
<tr><td>zero_line (line 720)*</td><td>line style options</td><td>foreground</td></tr>
<tr><td>zyx2 (line 763)*</td><td>line style options</td><td>zyx2</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="linewidth"></a>

<u>linew</u>idth -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>axisline</td><td>line width styles</td><td>thin</td></tr>
<tr><td>background</td><td>line width styles</td><td>none</td></tr>
<tr><td>ci</td><td>line width styles</td><td>medium</td></tr>
<tr><td>ci2</td><td>line width styles</td><td>medium</td></tr>
<tr><td>ci2_area</td><td>line width styles</td><td>medthin</td></tr>
<tr><td>ci_area</td><td>line width styles</td><td>medthin</td></tr>
<tr><td>clegend (line 1014)*</td><td>line width styles</td><td>none</td></tr>
<tr><td>dendrogram (line 1003)*</td><td>line width styles</td><td>medium</td></tr>
<tr><td>dot_area</td><td>line width styles</td><td>medthin</td></tr>
<tr><td>dot_line</td><td>line width styles</td><td>medthick</td></tr>
<tr><td>dotmark</td><td>line width styles</td><td>vthin</td></tr>
<tr><td>dots (line 1008)*</td><td>line width styles</td><td>vthin</td></tr>
<tr><td>foreground</td><td>line width styles</td><td>none</td></tr>
<tr><td>grid (line 992)*</td><td>line width styles</td><td>none</td></tr>
<tr><td>histogram</td><td>line width styles</td><td>vthin</td></tr>
<tr><td>legend</td><td>line width styles</td><td>none</td></tr>
<tr><td>major_grid</td><td>line width styles</td><td>none</td></tr>
<tr><td>matrix_plotregion</td><td>line width styles</td><td>thin</td></tr>
<tr><td>matrixmark</td><td>line width styles</td><td>vvthin</td></tr>
<tr><td>medium (line 988)*</td><td>line width styles</td><td>medium</td></tr>
<tr><td>minor_grid (line 994)*</td><td>line width styles</td><td>none</td></tr>
<tr><td>minortick</td><td>line width styles</td><td>vvthin</td></tr>
<tr><td>p (line 989)*</td><td>line width styles</td><td>vthin</td></tr>
<tr><td>pbar (line 1022)*</td><td>line width styles</td><td>vthin</td></tr>
<tr><td>pie</td><td>line width styles</td><td>vthin</td></tr>
<tr><td>plotregion</td><td>line width styles</td><td>vthin</td></tr>
<tr><td>refline</td><td>line width styles</td><td>medium</td></tr>
<tr><td>refmarker</td><td>line width styles</td><td>medthin</td></tr>
<tr><td>reverse_big (line 1016)*</td><td>line width styles</td><td>thin</td></tr>
<tr><td>sunflower</td><td>line width styles</td><td>thin</td></tr>
<tr><td>text_option</td><td>line width styles</td><td>none</td></tr>
<tr><td>thin (line 987)*</td><td>line width styles</td><td>thin</td></tr>
<tr><td>tick</td><td>line width styles</td><td>vthin</td></tr>
<tr><td>xyline</td><td>line width styles</td><td>medthin</td></tr>
<tr><td>zyx2 (line 1020)*</td><td>line width styles</td><td>medium</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="margin"></a>

<u>marg</u>in -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>axis_title</td><td>margin styles</td><td>zero</td></tr>
<tr><td>bargraph</td><td>margin styles</td><td>bargraph</td></tr>
<tr><td>body</td><td>margin styles</td><td>vsmall</td></tr>
<tr><td>boxgraph</td><td>margin styles</td><td>bargraph</td></tr>
<tr><td>by_indiv</td><td>margin styles</td><td>small</td></tr>
<tr><td>bygraph</td><td>margin styles</td><td>zero</td></tr>
<tr><td>cleg_title (line 586)*</td><td>margin styles</td><td>medsmall</td></tr>
<tr><td>clegend (line 587)*</td><td>margin styles</td><td>medium</td></tr>
<tr><td>clegend_boxmargin (line 588)*</td><td>margin styles</td><td>small</td></tr>
<tr><td>combine_region</td><td>margin styles</td><td>zero</td></tr>
<tr><td>combinegraph</td><td>margin styles</td><td>medsmall</td></tr>
<tr><td>dotgraph</td><td>margin styles</td><td>bargraph</td></tr>
<tr><td>editor (line 591)*</td><td>margin styles</td><td>zero</td></tr>
<tr><td>filled_box (line 590)*</td><td>margin styles</td><td>zero</td></tr>
<tr><td>filled_textbox (line 589)*</td><td>margin styles</td><td>small</td></tr>
<tr><td>graph</td><td>margin styles</td><td>medium</td></tr>
<tr><td>hbargraph</td><td>margin styles</td><td>bargraph</td></tr>
<tr><td>hboxgraph</td><td>margin styles</td><td>bargraph</td></tr>
<tr><td>hdotgraph (line 581)*</td><td>margin styles</td><td>bargraph</td></tr>
<tr><td>heading</td><td>margin styles</td><td>vsmall</td></tr>
<tr><td>key_label</td><td>margin styles</td><td>zero</td></tr>
<tr><td>key_label</td><td>margin styles</td><td>zero</td></tr>
<tr><td>label</td><td>margin styles</td><td>zero</td></tr>
<tr><td>legend</td><td>margin styles</td><td>small</td></tr>
<tr><td>legend_boxmargin</td><td>margin styles</td><td>small</td></tr>
<tr><td>legend_key_region</td><td>margin styles</td><td>tiny</td></tr>
<tr><td>mat_label_box</td><td>margin styles</td><td>zero</td></tr>
<tr><td>matrix_label</td><td>margin styles</td><td>zero</td></tr>
<tr><td>matrix_plotreg</td><td>margin styles</td><td>small</td></tr>
<tr><td>matrixgraph</td><td>margin styles</td><td>zero</td></tr>
<tr><td>pboxlabel (line 595)*</td><td>margin styles</td><td>zero</td></tr>
<tr><td>pboxlabelbox (line 596)*</td><td>margin styles</td><td>zero</td></tr>
<tr><td>piegraph</td><td>margin styles</td><td>small</td></tr>
<tr><td>piegraph_region</td><td>margin styles</td><td>medsmall</td></tr>
<tr><td>plabel (line 593)*</td><td>margin styles</td><td>zero</td></tr>
<tr><td>plabelbox (line 594)*</td><td>margin styles</td><td>zero</td></tr>
<tr><td>plotregion</td><td>margin styles</td><td>medsmall</td></tr>
<tr><td>small_body</td><td>margin styles</td><td>vsmall</td></tr>
<tr><td>star (line 575)*</td><td>margin styles</td><td>tiny</td></tr>
<tr><td>subheading</td><td>margin styles</td><td>vsmall</td></tr>
<tr><td>text</td><td>margin styles</td><td>vsmall</td></tr>
<tr><td>text_option</td><td>margin styles</td><td>zero</td></tr>
<tr><td>textbox</td><td>margin styles</td><td>zero</td></tr>
<tr><td>twoway (line 552)*</td><td>margin styles</td><td>medsmall</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="medtypestyle"></a>

<u>medtypesty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>boxplot</td><td>graph query medtypestyle</td><td>line</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="numstyle"></a>

<u>numsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>bar_num_dots (line 49)*</td><td>Integer</td><td>100</td></tr>
<tr><td>dot_extend_high</td><td>0|1</td><td>0</td></tr>
<tr><td>dot_extend_low</td><td>0|1</td><td>0</td></tr>
<tr><td>dot_num_dots</td><td>Integer</td><td>100</td></tr>
<tr><td>graph_aspect</td><td>Real #</td><td>0</td></tr>
<tr><td>grid_outer_tol</td><td>Real #</td><td>0.23</td></tr>
<tr><td>legend_cols</td><td>Integer</td><td>5</td></tr>
<tr><td>legend_rows</td><td>Integer</td><td>0</td></tr>
<tr><td>max_wted_symsize</td><td>Real # (Max Symbol Size in Bubble Plots)</td><td>10</td></tr>
<tr><td>pie_angle</td><td>Real #</td><td>90</td></tr>
<tr><td>zyx2cols (line 41)*</td><td>Integer</td><td>2</td></tr>
<tr><td>zyx2rows (line 40)*</td><td>Integer</td><td>4</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="numticks"></a>

numticks -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>horizontal_major</td><td>Integer #</td><td>5</td></tr>
<tr><td>horizontal_minor</td><td>Integer #</td><td>0</td></tr>
<tr><td>horizontal_tmajor</td><td>Integer #</td><td>0</td></tr>
<tr><td>horizontal_tminor</td><td>Integer #</td><td>0</td></tr>
<tr><td>major</td><td>Integer #</td><td>5</td></tr>
<tr><td>vertical_major</td><td>Integer #</td><td>5</td></tr>
<tr><td>vertical_minor</td><td>Integer #</td><td>0</td></tr>
<tr><td>vertical_tmajor</td><td>Integer #</td><td>0</td></tr>
<tr><td>vertical_tminor</td><td>Integer #</td><td>0</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="piegraphstyle"></a>

<u>piegraphsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>piegraph</td><td>by graph styles</td><td>default</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="pielabelstyle"></a>

<u>pielabelsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>default (line 1748)*</td><td>pie graph label styles</td><td>none</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="plotregionstyle"></a>

<u>plotregionsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>bargraph</td><td>plot region style</td><td>bargraph</td></tr>
<tr><td>boxgraph</td><td>plot region style</td><td>boxgraph</td></tr>
<tr><td>bygraph</td><td>plot region style</td><td>bygraph</td></tr>
<tr><td>clegend (line 1529)*</td><td>plot region style</td><td>clegend</td></tr>
<tr><td>combinegraph</td><td>plot region style</td><td>matrixgraph</td></tr>
<tr><td>combineregion</td><td>plot region style</td><td>combineregion</td></tr>
<tr><td>graph</td><td>plot region style</td><td>graph</td></tr>
<tr><td>hbargraph</td><td>plot region style</td><td>hbargraph</td></tr>
<tr><td>hboxgraph</td><td>plot region style</td><td>hboxgraph</td></tr>
<tr><td>legend_key_region (line 1528)*</td><td>plot region style</td><td>legend_key_region</td></tr>
<tr><td>matrix</td><td>plot region style</td><td>matrix</td></tr>
<tr><td>matrix_label</td><td>plot region style</td><td>matrix_label</td></tr>
<tr><td>matrixgraph</td><td>plot region style</td><td>matrixgraph</td></tr>
<tr><td>piegraph</td><td>plot region style</td><td>piegraph</td></tr>
<tr><td>twoway</td><td>plot region style</td><td>twoway</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="relativepos"></a>

<u>relativep</u>os -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>clegend_axispos (line 1482)*</td><td>relative position styles</td><td>right</td></tr>
<tr><td>clegend_pos (line 1481)*</td><td>relative position styles</td><td>right</td></tr>
<tr><td>zyx2legend_pos (line 1480)*</td><td>relative position styles</td><td>right</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="relsize"></a>

<u>relsi</u>ze -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>bar_gap</td><td>Real #pct</td><td>0pct</td></tr>
<tr><td>bar_groupgap</td><td>Real #pct</td><td>80pct</td></tr>
<tr><td>bar_outergap</td><td>Real #pct</td><td>20pct</td></tr>
<tr><td>bar_supgroupgap</td><td>Real #pct</td><td>200pct</td></tr>
<tr><td>box_fence (line 160)*</td><td>Real #pct</td><td>75pct</td></tr>
<tr><td>box_fencecap (line 161)*</td><td>Real #pct</td><td>0pct</td></tr>
<tr><td>box_gap</td><td>Real #pct</td><td>50pct</td></tr>
<tr><td>box_groupgap</td><td>Real #pct</td><td>100pct</td></tr>
<tr><td>box_outergap</td><td>Real #pct</td><td>25pct</td></tr>
<tr><td>box_supgroupgap</td><td>Real #pct</td><td>150pct</td></tr>
<tr><td>dot_gap</td><td>Real #pct</td><td>neg100pct</td></tr>
<tr><td>dot_groupgap</td><td>Real #pct</td><td>0pct</td></tr>
<tr><td>dot_outergap</td><td>Real #pct</td><td>0pct</td></tr>
<tr><td>dot_supgroupgap</td><td>Real #pct</td><td>75pct</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="special"></a>

<u>spec</u>ial -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>by_knot1</td><td>scheme by scaling</td><td>3</td></tr>
<tr><td>by_slope1</td><td>scheme by scaling</td><td>.3</td></tr>
<tr><td>by_slope2</td><td>scheme by scaling</td><td>1</td></tr>
<tr><td>combine_knot1</td><td>scheme by scaling</td><td>3</td></tr>
<tr><td>combine_slope1</td><td>scheme by scaling</td><td>.5</td></tr>
<tr><td>combine_slope2</td><td>scheme by scaling</td><td>1</td></tr>
<tr><td>default_knot1 (line 59)*</td><td>scheme by scaling</td><td>4</td></tr>
<tr><td>default_slope1 (line 58)*</td><td>scheme by scaling</td><td>.3</td></tr>
<tr><td>default_slope2 (line 60)*</td><td>scheme by scaling</td><td>1</td></tr>
<tr><td>matrix_knot1</td><td>scheme by scaling</td><td>4</td></tr>
<tr><td>matrix_slope1</td><td>scheme by scaling</td><td>.3</td></tr>
<tr><td>matrix_slope2</td><td>scheme by scaling</td><td>1</td></tr>
<tr><td>matrix_xaxis</td><td>axis options</td><td>"xlabels(#3, axis(X))"</td></tr>
<tr><td>matrix_yaxis</td><td>axis options</td><td>"ylabels(#3, angle(horizontal) axis(Y))"</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="starstyle"></a>

<u>starsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>default (line 1754)*</td><td>star styles</td><td>default</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="sunflowerstyle"></a>

<u>sunflowersty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>sunflower</td><td>sunflower plot styles</td><td>sunflower</td></tr>
</table>

<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="symbol"></a>

<u>symb</u>ol -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>ci</td><td>symbol styles</td><td>circle</td></tr>
<tr><td>ci2</td><td>symbol styles</td><td>circle</td></tr>
<tr><td>dots</td><td>symbol styles</td><td>circle</td></tr>
<tr><td>histback (line 377)*</td><td>symbol styles</td><td>none</td></tr>
<tr><td>histogram</td><td>symbol styles</td><td>circle</td></tr>
<tr><td>ilabel (line 381)*</td><td>symbol styles</td><td>none</td></tr>
<tr><td>matrix</td><td>symbol styles</td><td>circle</td></tr>
<tr><td>none</td><td>symbol styles</td><td>none</td></tr>
<tr><td>p</td><td>symbol styles</td><td>circle</td></tr>
<tr><td>pback (line 386)*</td><td>symbol styles</td><td>none</td></tr>
<tr><td>pbarback (line 387)*</td><td>symbol styles</td><td>none</td></tr>
<tr><td>pdotback (line 388)*</td><td>symbol styles</td><td>none</td></tr>
<tr><td>refmarker</td><td>symbol styles</td><td>circle</td></tr>
<tr><td>sunflower</td><td>symbol styles</td><td>circle_hollow</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="symbolsize"></a>

<u>symbolsi</u>ze -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>backsymbol (line 178)*</td><td>size options</td><td>large</td></tr>
<tr><td>backsymspace (line 179)*</td><td>size options</td><td>large</td></tr>
<tr><td>ci</td><td>size options</td><td>medlarge</td></tr>
<tr><td>ci2</td><td>size options</td><td>medlarge</td></tr>
<tr><td>dots</td><td>size options</td><td>vtiny</td></tr>
<tr><td>histback (line 170)*</td><td>size options</td><td>vlarge</td></tr>
<tr><td>histogram</td><td>size options</td><td>medium</td></tr>
<tr><td>matrix</td><td>size options</td><td>medsmall</td></tr>
<tr><td>p</td><td>size options</td><td>medium</td></tr>
<tr><td>parrow (line 182)*</td><td>size options</td><td>medium</td></tr>
<tr><td>parrowbarb (line 183)*</td><td>size options</td><td>medsmall</td></tr>
<tr><td>pback (line 181)*<tr><td>size</td><td>options</td><td>zero</td></tr>
<tr><td>refmarker</td><td>size options</td><td>medium</td></tr>
<tr><td>smallsymbol (line 166)*</td><td>size options</td><td>medsmall</td></tr>
<tr><td>star (line 168)*</td><td>size options</td><td>vlarge</td></tr>
<tr><td>sunflower</td><td>size options</td><td>medium</td></tr>
<tr><td>symbol</td><td>size options</td><td>medium</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="textboxstyle"></a>

<u>textboxsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>axis_title</td><td>text box styles</td><td>axis_title</td></tr>
<tr><td>b1title</td><td>text box styles</td><td>subheading</td></tr>
<tr><td>b2title</td><td>text box styles</td><td>body</td></tr>
<tr><td>barlabel</td><td>text box styles</td><td>small_label</td></tr>
<tr><td>bigtick (line 1119)*</td><td>text box styles</td><td>tick_biglabel</td></tr>
<tr><td>body</td><td>text box styles</td><td>body</td></tr>
<tr><td>bytitle (line 1129)*</td><td>text box styles</td><td>bytitle</td></tr>
<tr><td>caption</td><td>text box styles</td><td>body</td></tr>
<tr><td>cleg_caption (line 1095)*</td><td>text box styles</td><td>body</td></tr>
<tr><td>cleg_note (line 1096)*</td><td>text box styles</td><td>small_body</td></tr>
<tr><td>cleg_subtitle (line 1095)*</td><td>text box styles</td><td>subheading</td></tr>
<tr><td>cleg_title (line 1093)*</td><td>text box styles</td><td>clegend</td></tr>
<tr><td>editor (line 1131)*</td><td>text box styles</td><td>editor</td></tr>
<tr><td>heading</td><td>text box styles</td><td>heading</td></tr>
<tr><td>ilabel</td><td>text box styles</td><td>small_label</td></tr>
<tr><td>key_label</td><td>text box styles</td><td>key_label</td></tr>
<tr><td>l1title</td><td>text box styles</td><td>subheading</td></tr>
<tr><td>l2title</td><td>text box styles</td><td>body</td></tr>
<tr><td>label</td><td>text box styles</td><td>label</td></tr>
<tr><td>leg_caption</td><td>text box styles</td><td>small_body</td></tr>
<tr><td>leg_note</td><td>text box styles</td><td>small_body</td></tr>
<tr><td>leg_subtitle</td><td>text box styles</td><td>subheading</td></tr>
<tr><td>leg_title</td><td>text box styles</td><td>heading</td></tr>
<tr><td>legend_key</td><td>text box styles</td><td>legend_key</td></tr>
<tr><td>matrix_label</td><td>text box styles</td><td>matrix_label</td></tr>
<tr><td>matrix_marklbl</td><td>text box styles</td><td>matrix_marklbl</td></tr>
<tr><td>minortick</td><td>text box styles</td><td>minortick_label</td></tr>
<tr><td>note</td><td>text box styles</td><td>body</td></tr>
<tr><td>pielabel</td><td>text box styles</td><td>small_label</td></tr>
<tr><td>r1title</td><td>text box styles</td><td>subheading</td></tr>
<tr><td>r2title</td><td>text box styles</td><td>body</td></tr>
<tr><td>small_label</td><td>text box styles</td><td>small_label</td></tr>
<tr><td>star (line 1128)*</td><td>text box styles</td><td>star_label</td></tr>
<tr><td>sts_risktable (line 1120)*</td><td>text box styles</td><td>sts_risktable</td></tr>
<tr><td>subheading</td><td>text box styles</td><td>subheading</td></tr>
<tr><td>subtitle</td><td>text box styles</td><td>subheading</td></tr>
<tr><td>t1title</td><td>text box styles</td><td>subheading</td></tr>
<tr><td>t2title</td><td>text box styles</td><td>body</td></tr>
<tr><td>text_option</td><td>text box styles</td><td>text_option</td></tr>
<tr><td>tick</td><td>text box styles</td><td>tick_label</td></tr>
<tr><td>title</td><td>text box styles</td><td>heading</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="tickposition"></a>

<u>tickp</u>osition -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>axis_tick</td><td>inside, outside, or crossing</td><td>outside</td></tr>
</table>


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="ticksetstyle"></a>

<u>ticksetsty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>major_clegend (line 1437)*</td><td>tick set styles</td><td>major_clegend (line 1437)*</td></tr>
<tr><td>major_horiz_default</td><td>tick set styles</td><td></td></tr>
<tr><td>major_horiz_nolabel</td><td>tick set styles</td><td></td></tr>
<tr><td>major_horiz_notick</td><td>tick set styles</td><td></td></tr>
<tr><td>major_horiz_notickbig (line 1434)*</td><td>tick set styles</td><td>major_horiz_notickbig (line 1434)*</td></tr>
<tr><td>major_horiz_withgrid</td><td>tick set styles</td><td></td></tr>
<tr><td>major_vert_default</td><td>tick set styles</td><td></td></tr>
<tr><td>major_vert_nolabel</td><td>tick set styles</td><td></td></tr>
<tr><td>major_vert_notick</td><td>tick set styles</td><td></td></tr>
<tr><td>major_vert_notickbig (line 1435)*</td><td>tick set styles</td><td>major_vert_notickbig (line 1435)*</td></tr>
<tr><td>major_vert_withgrid</td><td>tick set styles</td><td></td></tr>
<tr><td>minor_horiz_default</td><td>tick set styles</td><td></td></tr>
<tr><td>minor_horiz_nolabel</td><td>tick set styles</td><td></td></tr>
<tr><td>minor_horiz_notick</td><td>tick set styles</td><td></td></tr>
<tr><td>minor_vert_default</td><td>tick set styles</td><td></td></tr>
<tr><td>minor_vert_nolabel</td><td>tick set styles</td><td></td></tr>
<tr><td>minor_vert_notick</td><td>tick set styles</td><td></td></tr>
<tr><td>sts_risktable (line 1436)*</td><td>tick set styles</td><td>sts_risktable (line 1436)*</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="tickstyle"></a>

<u>ticksty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>default (line 1407)*</td><td>tick styles</td><td>default</td></tr>
<tr><td>major</td><td>tick styles</td><td>major</td></tr>
<tr><td>major_nolabel</td><td>tick styles</td><td>major_nolabel</td></tr>
<tr><td>major_notick</td><td>tick styles</td><td>major_notick</td></tr>
<tr><td>major_notickbig (line 1414)*</td><td>tick styles</td><td>major_notickbig</td></tr>
<tr><td>minor</td><td>tick styles</td><td>minor</td></tr>
<tr><td>minor_nolabel</td><td>tick styles</td><td>minor_nolabel</td></tr>
<tr><td>minor_notick</td><td>tick styles</td><td>minor_notick</td></tr>
<tr><td>minor_notickbig (line 1415)*</td><td>tick styles</td><td>minor_notickbig</td></tr>
<tr><td>sts_risktable (line 1416)*</td><td>tick styles</td><td>sts_risktable</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="verticaltext"></a>

<u>verticalt</u>ext -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>axis_title</td><td>vertical justification styles</td><td>bottom</td></tr>
<tr><td>body</td><td>vertical justification styles</td><td>bottom</td></tr>
<tr><td>filled (line 1370)*</td><td>vertical justification styles</td><td>middle</td></tr>
<tr><td>heading</td><td>vertical justification styles</td><td>bottom</td></tr>
<tr><td>key_label</td><td>vertical justification styles</td><td>middle</td></tr>
<tr><td>label</td><td>vertical justification styles</td><td>middle</td></tr>
<tr><td>legend (line 1368)*</td><td>vertical justification styles</td><td>bottom</td></tr>
<tr><td>matrix_label</td><td>vertical justification styles</td><td>middle</td></tr>
<tr><td>small_body</td><td>vertical justification styles</td><td>bottom</td></tr>
<tr><td>subheading</td><td>vertical justification styles</td><td>bottom</td></tr>
<tr><td>text_option</td><td>vertical justification styles</td><td>middle</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="yesno"></a>

<u>yesn</u>o -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>adj_xmargins (line 1722)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>adj_ymargins (line 1723)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>alt_xaxes</td><td>yes | no</td><td>no</td></tr>
<tr><td>alt_yaxes</td><td>yes | no</td><td>no</td></tr>
<tr><td>alternate_labels</td><td>yes | no</td><td>no</td></tr>
<tr><td>bar_reverse_scale</td><td>yes | no</td><td>no</td></tr>
<tr><td>box_custom_whiskers</td><td>yes | no</td><td>no</td></tr>
<tr><td>box_hollow (line 1676)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>box_reverse_scale</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_alternate_xaxes (line 1682)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_alternate_yaxes (line 1683)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_edgelabel</td><td>yes | no</td><td>yes</td></tr>
<tr><td>by_indiv_as_whole</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_indiv_xaxes</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_indiv_xlabels</td><td>yes | no</td><td>yes</td></tr>
<tr><td>by_indiv_xrescale</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_indiv_xticks</td><td>yes | no</td><td>yes</td></tr>
<tr><td>by_indiv_xtitles</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_indiv_yaxes</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_indiv_ylabels</td><td>yes | no</td><td>yes</td></tr>
<tr><td>by_indiv_yrescale</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_indiv_yticks</td><td>yes | no</td><td>yes</td></tr>
<tr><td>by_indiv_ytitles</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_outer_xaxes</td><td>yes | no</td><td>yes</td></tr>
<tr><td>by_outer_xtitles</td><td>yes | no</td><td>yes</td></tr>
<tr><td>by_outer_yaxes</td><td>yes | no</td><td>yes</td></tr>
<tr><td>by_outer_ytitles</td><td>yes | no</td><td>yes</td></tr>
<tr><td>by_shrink_indiv</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_shrink_plotregion</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_skip_xalternate (line 1684)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>by_skip_yalternate (line 1685)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>caption_span</td><td>yes | no</td><td>yes</td></tr>
<tr><td>clegend_title_span (line 1720)*</td><td>yes | no</td><td>yes</td></tr>
<tr><td>cmissings (line 1598)*</td><td>yes | no</td><td>yes</td></tr>
<tr><td>connect_missings (line 1597)*</td><td>yes | no</td><td>yes</td></tr>
<tr><td>contours_colorlines (line 1730)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>contours_outline (line 1728)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>contours_reversekey (line 1729)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>dot_reverse_scale</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_major_grid (line 1607)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_major_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_major_nl_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_major_nl_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_major_nlt_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_major_nlt_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_major_nt_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_major_nt_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_major_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_majornl_grid (line 1609)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_majornl_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_majornl_nl_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_majornl_nl_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_majornl_nlt_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_majornl_nlt_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_majornl_nt_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_majornl_nt_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_majornl_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minor_grid (line 1608)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minor_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minor_nl_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minor_nl_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minor_nlt_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minor_nlt_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minor_nt_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minor_nt_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minor_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minornl_grid (line 1610)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minornl_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minornl_nl_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minornl_nl_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minornl_nlt_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minornl_nlt_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minornl_nt_hgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minornl_nt_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>draw_minornl_vgrid</td><td>yes | no</td><td>no</td></tr>
<tr><td>extend_axes_full_high</td><td>yes | no</td><td>yes</td></tr>
<tr><td>extend_axes_full_low</td><td>yes | no</td><td>yes</td></tr>
<tr><td>extend_axes_high</td><td>yes | no</td><td>yes</td></tr>
<tr><td>extend_axes_low</td><td>yes | no</td><td>yes</td></tr>
<tr><td>extend_dots</td><td>yes | no</td><td>yes</td></tr>
<tr><td>extend_grid_high (line 1644)*</td><td>yes | no</td><td>yes</td></tr>
<tr><td>extend_grid_low (line 1643)*</td><td>yes | no</td><td>yes</td></tr>
<tr><td>extend_majorgrid_high</td><td>yes | no</td><td>yes</td></tr>
<tr><td>extend_majorgrid_low</td><td>yes | no</td><td>yes</td></tr>
<tr><td>extend_minorgrid_high</td><td>yes | no</td><td>yes</td></tr>
<tr><td>extend_minorgrid_low</td><td>yes | no</td><td>yes</td></tr>
<tr><td>grid_draw_max</td><td>yes | no</td><td>no</td></tr>
<tr><td>grid_draw_min</td><td>yes | no</td><td>no</td></tr>
<tr><td>grid_force_nomax</td><td>yes | no</td><td>no</td></tr>
<tr><td>grid_force_nomin</td><td>yes | no</td><td>no</td></tr>
<tr><td>legend_col_first</td><td>yes | no</td><td>no</td></tr>
<tr><td>legend_force_draw</td><td>yes | no</td><td>no</td></tr>
<tr><td>legend_force_keysz</td><td>yes | no</td><td>no</td></tr>
<tr><td>legend_force_nodraw</td><td>yes | no</td><td>no</td></tr>
<tr><td>legend_span</td><td>yes | no</td><td>yes</td></tr>
<tr><td>legend_stacked</td><td>yes | no</td><td>no</td></tr>
<tr><td>legend_text_first</td><td>yes | no</td><td>no</td></tr>
<tr><td>mat_label_as_textbox (line 1705)*</td><td>yes | no</td><td>yes</td></tr>
<tr><td>mat_label_box (line 1704)*</td><td>yes | no</td><td>yes</td></tr>
<tr><td>note_span</td><td>yes | no</td><td>yes</td></tr>
<tr><td>pboxlabelboxed (line 1726)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>pcmissings</td><td>yes | no</td><td>yes</td></tr>
<tr><td>pie_clockwise</td><td>yes | no</td><td>yes</td></tr>
<tr><td>plabelboxed (line 1725)*</td><td>yes | no</td><td>no</td></tr>
<tr><td>subtitle_span</td><td>yes | no</td><td>yes</td></tr>
<tr><td>swap_bar_groupaxis</td><td>yes | no</td><td>no</td></tr>
<tr><td>swap_bar_scaleaxis</td><td>yes | no</td><td>no</td></tr>
<tr><td>swap_box_groupaxis</td><td>yes | no</td><td>no</td></tr>
<tr><td>swap_box_scaleaxis</td><td>yes | no</td><td>no</td></tr>
<tr><td>swap_dot_groupaxis</td><td>yes | no</td><td>no</td></tr>
<tr><td>swap_dot_scaleaxis</td><td>yes | no</td><td>no</td></tr>
<tr><td>text_option</td><td>yes | no</td><td>no</td></tr>
<tr><td>textbox</td><td>yes | no</td><td>no</td></tr>
<tr><td>title_span</td><td>yes | no</td><td>yes</td></tr>
<tr><td>use_labels_on_ticks</td><td>yes | no</td><td>yes</td></tr>
<tr><td>x2axis_ontop</td><td>yes | no</td><td>yes</td></tr>
<tr><td>xyline_extend_high</td><td>yes | no</td><td>yes</td></tr>
<tr><td>xyline_extend_low</td><td>yes | no</td><td>yes</td></tr>
<tr><td>y2axis_onright</td><td>yes | no</td><td>yes</td></tr>
<tr><td>zyx2legend_span (line 1719)*</td><td>yes | no</td><td>no</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="zyx2rule"></a>

<u>zyx2r</u>ule -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>contour (line 1758)*</td><td>zyx2 rule styles</td><td>intensity</td></tr>
<tr><td></td><td></td><td>hue</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>
<br>
<br>
<a name="zyx2style"></a>

<u>zyx2sty</u>le -- is an optional argument for brewtheme.

<table>
<th>Key(s)</th><th>Valid Values</th><th>Default Values</th>
<tr><td>default (line 1762)*</td><td>zyx2 styles</td><td>default</td></tr>
</table>

(line #)*: these entries are not directly documented, but the line numbers show you where these values appear in the s2color scheme file.


<hr>
<a href="#top">back to top</a>
<hr>


<a name="examples"></a>
## Examples 

### Ex 1.
Create a theme file that emulates the aesthetics of the [ggplot2](https://github.com/hadley/ggplot2) package for the [R language](https://cran.r-project.org).


```Stata
// Change the end of line delimiter
#d ;

// Generate the theme file used to simulate ggplot2 aesthetics
brewtheme ggtheme, numticks("major 5" "horizontal_major 5" "vertical_major 5"     
"horizontal_minor 10" "vertical_minor 10") color("plotregion gs15"          
"matrix_plotregion gs15" "background gs15" "textbox gs15" "legend gs15"       
"box gs15" "mat_label_box gs15" "text_option_fill gs15" "clegend gs15"        
"histback gs15" "pboxlabelfill gs15" "plabelfill gs15" "pmarkbkfill gs15"      
"pmarkback gs15") linew("major_grid medthick" "minor_grid thin" "legend medium"    
"clegend medium") clockdir("legend_position 3") yesno("draw_major_grid yes"     
"draw_minor_grid yes" "legend_force_draw yes" "legend_force_nodraw no"        
"draw_minor_vgrid yes" "draw_minor_hgrid yes" "extend_grid_low yes"         
"extend_grid_high yes" "extend_axes_low no" "extend_axes_high no")          
gridsty("minor minor") axissty("horizontal_default horizontal_withgrid"       
"vertical_default vertical_withgrid") linepattern("major_grid solid"        
"minor_grid solid") linesty("major_grid major_grid" "minor_grid minor_grid")     
ticksty("minor minor_notick" "minor_notick minor_notick")               
ticksetsty("major_vert_withgrid minor_vert_nolabel"                 
"major_horiz_withgrid minor_horiz_nolabel"                      
"major_horiz_nolabel major_horiz_default"                       
"major_vert_nolabel major_vert_default") gsize("minortick_label minuscule"        
"minortick tiny") numsty("legend_cols 1" "legend_rows 0" "zyx2rows 0" 
"zyx2cols 1") verticaltext("legend top");

// Change the end of line delimiter back to a carriage return
#d cr

// Create a scheme file using the theme file created with the syntax above
brewscheme, scheme(ggtest2) const(orange) cone(blue) consat(20) scatc(5)    ///  
scatst(ggplot2) piest(ggplot2) piec(6) barst(ggplot2) barc(2) linec(2)      ///   
linest(ggplot2) areast(ggplot2) areac(5) somest(ggplot2) somec(24) cic(3)   ///   
cist(ggplot2) themef(ggplot2)

// Load the auto.dta data set
sysuse auto.dta, clear

// Create a graph with the scheme file above
tw  lowess mpg weight ||                                                    ///   
    scatter mpg weight if rep78 == 1 ||                                     ///   
    scatter mpg weight if rep78 == 2 ||                                     ///   
    scatter mpg weight if rep78 == 3 ||                                     ///   
    scatter mpg weight if rep78 == 4 ||                                     ///   
    scatter mpg weight if rep78 == 5,                                       ///   
    legend(order(2 "1978 Repair Record = 1"                                 ///   
    3 "1978 Repair Record = 2" 4 "1978 Repair Record = 3"                   ///   
    5 "1978 Repair Record = 4" 6 "1978 Repair Record = 5"))                 ///   
    scheme(ggtest2) 
```


![brewthemeEx1](../../img/ggthemeTest.png)


### Ex 2.
Uses the theme above and shows how symbol types get recycled as well

```Stata
brewscheme, scheme(ggtest2) const(orange) cone(blue) consat(20)        ///  
scatst(ggplot2) scatc(5) piest(ggplot2) piec(6) barst(ggplot2) barc(2)     ///   
linest(ggplot2) linec(2) areast(ggplot2) areac(5) somest(ggplot2) somec(24)  ///   
cist(ggplot2) cic(3) themef(ggplot2) symbols(diamond triangle square)

// Create a graph with the scheme file above
tw  lowess mpg weight ||                                                    ///   
    scatter mpg weight if rep78 == 1 ||                                     ///   
    scatter mpg weight if rep78 == 2 ||                                     ///   
    scatter mpg weight if rep78 == 3 ||                                     ///   
    scatter mpg weight if rep78 == 4 ||                                     ///   
    scatter mpg weight if rep78 == 5,                                       ///   
    legend(order(2 "1978 Repair Record = 1"                                 ///   
    3 "1978 Repair Record = 2" 4 "1978 Repair Record = 3"                   ///   
    5 "1978 Repair Record = 4" 6 "1978 Repair Record = 5"))                 ///   
    scheme(ggtest2) 
```

![brewthemeEx2](../../img/ggthemeTest2.png)

### Ex 3.
Create a theme file that would emulate the original `s2color` scheme settings controlled by `brewtheme`

```Stata
// Change the end of line delimiter
#d ;

// Generates a theme in the style of s2color
brewtheme s2theme, graphsi("x 5.5" "y 4") numsty("legend_cols 2" "legend_rows 0" 
"zyx2rows 0" "zyx2cols 1") gsize("label medsmall" "small_label small"
"text medium" "body medsmall" "small_body small" "heading large" 
"axis_title medsmall" "matrix_label medlarge" "matrix_marklbl small" 
"key_label medsmall" "note small" "star medsmall" "text_option medsmall" 
"minor_tick half_tiny" "tick_label medsmall" "tick_biglabel medium" 
"title_gap vsmall" "key_gap vsmall" "key_linespace vsmall" "legend_key_xsize 13" 
"legend_key_ysize medsmall" "clegend_width huge" "pielabel_gap zero" 
"plabel small" "pboxlabel small" "sts_risktable_space third_tiny" 
"sts_risktable_tgap zero" "sts_risktable_lgap zero" "minortick half_tiny" 
"pie_explode medium") relsize("bar_groupgap 67pct" "dot_supgroupgap 67pct" 
"box_gap 33pct" "box_supgroupgap 200pct" "box_outergap 20pct" "box_fence 67pct") 
symbolsi("smallsymbol small" "histogram medlarge" "ci medium" "ci2 medium" 
"matrix medium" "refmarker medlarge" "parrowbarb zero") 
color("background ltbluishgray" "foreground black" "backsymbol gs8" 
"heading dknavy" "box bluishgray" "textbox bluishgray" 
"mat_label_box bluishgray" "text_option_line black" 
"text_option_fill bluishgray" "filled bluishgray" "bylabel_outline bluishgray" 
"reverse_big navy" "reverse_big_line navy" "grid ltbluishgray" 
"major_grid ltbluishgray" "minor_grid gs5" "matrix navy" "matrixmarkline navy" 
"histback gold" "legend_line black" "clegend white" "clegend_line black" 
"pboxlabelfill bluishgray" "plabelfill bluishgray") 
linepattern("foreground solid" "background solid" "grid solid" 
"major_grid solid" "minor_grid dot" "text_option solid") 
linesty("textbox foreground" "grid grid" "major_grid major_grid" 
"minor_grid minor_grid" "legend legend") linewidth("p medium" "foreground thin" 
"background thin" "grid medium" "major_grid medium" "minor_grid thin" 
"tick thin" "minortick thin" "ci_area medium" "ci2_area medium" 
"histogram medium" "dendrogram medium" "xyline medium" "refmarker medium" 
"matrixmark medium" "dots vvthin" "dot_area medium" "dotmark thin" 
"plotregion thin" "legend thin" "clegend thin" "pie medium" "sunflower medium" 
"text_option thin" "pbar vvvthin") textboxsty("note small_body" 
"leg_caption body") axissty("bar_super horizontal_nolinetick" 
"dot_super horizontal_nolinetick" "bar_scale_horiz horizontal_withgrid" 
"bar_scale_vert vertical_withgrid" "box_scale_horiz horizontal_withgrid" 
"box_scale_vert vertical_withgrid") clockdir("caption_position 7" 
"legend_position 6" "by_legend_position 6" "p 3" "legend_caption_position 7")  
gridringsty("caption_ring 5" "legend_caption_ring 5") 
anglesty("vertical_tick vertical") yesno("extend_axes_low no" 
"extend_axes_high no" "draw_major_vgrid yes" "use_labels_on_ticks no" 
"title_span no" "subtitle_span no" "caption_span no" 
"note_span no" "legend_span no") barlabelsty("bar none");
```

# Additional information
In addition to generating the user specified scheme, as of commit cd5cd84e83b513ef824ef61ca5e5b9124650076b, the `brewtheme` and `brewscheme` programs now automatically generate color vision impaired clones of themselves: 

```
theme-ggplot2.theme
theme-ggplot2_achromatopsia.theme
theme-ggplot2_protanopia.theme
theme-ggplot2_deuteranopia.theme
theme-ggplot2_tritanopia.theme
scheme-ggtest2.scheme
scheme-ggtest2_achromatopsia.scheme
scheme-ggtest2_protanopia.scheme
scheme-ggtest2_deuteranopia.scheme
scheme-ggtest2_tritanopia.scheme
```

<hr>
<a href="#top">back to the top</a>
<hr>