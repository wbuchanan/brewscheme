********************************************************************************
* Description of the Program -												   *
* This program is used to set theme values for things like backgrounds, point  *
* sizes, font sizes, etc...   The purpose is to allow the end user greater	   *
* flexibility in developing graph themes (e.g., create a ggplot2 theme with   *
* a given set of palettes and also create a theme with a more Tufte inspired  *
* set of background/size parameters). 										   *
*                                                                              *
* Data Requirements -														   *
*     Reads a file containing properties/parameters 	                       *
*						  OR												   *
*	  Allows users to build the property file interactively					   *
*																			   *
* System Requirements -														   *
*     none                                                                     *
*                                                                              *
* Program Output -                                                             *
*     none																	   *
*                                                                              *
* Lines -                                                                      *
*     585                                                                      *
*                                                                              *
********************************************************************************
		
*! brewtheme
*! v 0.0.1
*! 08SEP2015

// Drop the program from memory if loaded
cap prog drop brewtheme

// Define program
prog def brewtheme

	// Set version to interpret under
	version 13.1
	
	// Set syntax tree
	syntax anything(name=themefile id="Theme File Name") [,					 ///   
						GRSize(numlist min=2 max=2 int)						 ///   
						LEGTab(numlist min=0 max=2 int)  ASPectratio(real 0) ///   
						GAPSizes(string asis) RELGAPSizes(string asis)		 /// 
						SYMSizes(string asis) AXTicks(string asis)			 ///   
						GRColors(string asis) TXTColors(string asis)		 ///   
						PRColors(string asis) LEGColors(string asis)		 ///   
						LINEPatterns(string asis) MARGins(string asis)		 ///   
						LINEWidths(string asis) GRIDLines(string asis)		 /// 
						TICKStyles(string asis) TICKSETStyles(string asis)	 ///   
						BARLPos(string asis) GRIDRing(string asis)			 ///   
						Yesno(string asis) AUXStyles(string asis) ]
	
	// Check for directory and if not build it	
	dirfile, p(`"`c(sysdir_personal)'b/theme"') rebuild

	// Write the scheme file to a location on the path
	qui: file open theme using ///
		`"`c(sysdir_personal)'b/theme/theme-`themefile'.theme"', w replace

	// Check for user specified graph size parameters
	if `"`grsize'"' == "" {
		
		// Default Image size parameters
		file write theme `"graphsize x           9"' _n
		file write theme `"graphsize y           6"' _n

	} // END IF Block for graph size
	
	// If argument passed
	else {
	
		// User specified image size parameters
		file write theme `"graphsize x           `:word 1 of `grsize''"' _n
		file write theme `"graphsize y           `:word 2 of `grsize''"' _n
	
	} // End ELSE Block for image size
	
	// Check for number of rows/columns in legends
	if `"`legtab'"' == "" {

		// Legend rows/cols
		file write theme `"numstyle legend_rows      0"' _n
		file write theme `"numstyle legend_cols      5"' _n

	} // End IF Block for number of legend rows and columns
	
	// If user specifies values
	else {

		// Legend rows/cols
		file write theme `"numstyle legend_rows      `: word 1 of `legtab''"' _n
		file write theme `"numstyle legend_cols      `: word 2 of `legtab''"' _n
	
	} // End ELSE Block for user specified values
	
	// Aspect ratio
	file write theme `"numstyle graph_aspect     `aspectratio'"' _n
	
	// Check for gap size arguments
	if `"`gapsizes'"' == "" {

		// Write default values to theme file
		file write theme `"gsize gap             tiny"' _n
		file write theme `"gsize text            medsmall"' _n
		file write theme `"gsize body            small"' _n
		file write theme `"gsize small_body      vsmall"' _n
		file write theme `"gsize heading         medlarge"' _n
		file write theme `"gsize subheading      medium"' _n
		file write theme `"gsize axis_title      small"' _n
		file write theme `"gsize matrix_label    medium"' _n
		file write theme `"gsize label           medsmall"' _n
		file write theme `"gsize small_label     small"' _n
		file write theme `"gsize matrix_marklbl  medsmall"' _n
		file write theme `"gsize key_label       small"' _n
		file write theme `"gsize note            vsmall"' _n
		file write theme `"gsize star            small"' _n
		file write theme `"gsize text_option     small"' _n
		file write theme `"gsize dot_rectangle   third_tiny"' _n
		file write theme `"gsize axis_space      half_tiny"' _n
		file write theme `"gsize axis_title_gap  minuscule"' _n
		file write theme `"gsize tick            tiny"' _n
		file write theme `"gsize minortick       third_tiny"' _n
		file write theme `"* gsize minortick       .55"' _n
		file write theme `"gsize tickgap         half_tiny"' _n
		file write theme `"gsize notickgap       tiny"' _n
		file write theme `"gsize tick_label      small"' _n
		file write theme `"gsize tick_biglabel   small"' _n
		file write theme `"gsize minortick_label vsmall"' _n
		file write theme `"gsize filled_text     medsmall"' _n
		file write theme `"gsize reverse_big     large"' _n
		file write theme `"gsize alternate_gap   zero"' _n
		file write theme `"gsize title_gap       small"' _n
		file write theme `"gsize key_gap         small"' _n
		file write theme `"gsize key_linespace   small"' _n
		file write theme `"gsize star_gap        minuscule"' _n
		file write theme `"gsize legend_colgap   medium"' _n
		file write theme `"gsize label_gap       half_tiny"' _n
		file write theme `"gsize matrix_mlblgap  half_tiny"' _n
		file write theme `"gsize barlabel_gap    tiny"' _n
		file write theme `"gsize legend_row_gap    tiny"' _n
		file write theme `"gsize legend_col_gap    large"' _n
		file write theme `"gsize legend_key_gap    vsmall"' _n
		file write theme `"gsize legend_key_xsize  small"' _n
		file write theme `"gsize legend_key_ysize  small"' _n
		file write theme `"gsize zyx2legend_key_gap    tiny"' _n
		file write theme `"gsize zyx2legend_key_xsize  vhuge"' _n
		file write theme `"gsize zyx2legend_key_ysize  medium"' _n
		file write theme `"gsize zyx2rowgap            zero"' _n
		file write theme `"gsize zyx2colgap            large"' _n
		file write theme `"gsize clegend_width     medsmall"' _n
		file write theme `"gsize clegend_height    zero"' _n
		file write theme `"gsize pie_explode       medsmall"' _n
		file write theme `"gsize pielabel_gap      medsmall"' _n
		file write theme `"gsize plabel            vsmall"' _n
		file write theme `"gsize pboxlabel         vsmall"' _n
		file write theme `"* gsize p#label           small"' _n
		file write theme `"* gsize p#boxlabel        small"' _n
		file write theme `"gsize sts_risktable_space tiny"' _n
		file write theme `"gsize sts_risktable_tgap  tiny"' _n
		file write theme `"gsize sts_risktable_lgap  tiny"' _n
		file write theme `"gsize sts_risk_label      medsmall"' _n
		file write theme `"gsize sts_risk_title      medsmall"' _n
		file write theme `"gsize sts_risk_tick       zero"' _n

	} // End IF Block for gap size parameters
	
	// Create a local macro with allowable values for gapsizes argument
	loc gaps gap text body small_body heading subheading axis_title 		 ///   
	matrix_label label small_label matrix_marklbl key_label note star 		 ///   
	text_option dot_rectangle axis_space axis_title_gap tick minortick 		 ///   
	tickgap notickgap tick_label tick_biglabel minortick_label filled_text 	 ///   
	reverse_big alternate_gap title_gap key_gap key_linespace star_gap 		 ///   
	legend_colgap label_gap matrix_mlblgap barlabel_gap legend_row_gap 		 ///   
	legend_col_gap legend_key_gap legend_key_xsize legend_key_ysize 		 ///   
	zyx2legend_key_gap zyx2legend_key_xsize zyx2legend_key_ysize zyx2rowgap  ///   
	zyx2colgap clegend_width clegend_height pie_explode pielabel_gap plabel  ///   
	pboxlabel sts_risktable_space sts_risktable_tgap sts_risktable_lgap 	 ///   
	sts_risk_label sts_risk_title sts_risk_tick
	
	// If user passes values for gap size parameters
	else {
	
		// Loop over arguments
		forv i = 1/`: word count `gapsizes'' {

		// Write default values to theme file
		file write theme `"gsize gap             tiny"' _n
		file write theme `"gsize text            medsmall"' _n
		file write theme `"gsize body            small"' _n
		file write theme `"gsize small_body      vsmall"' _n
		file write theme `"gsize heading         medlarge"' _n
		file write theme `"gsize subheading      medium"' _n
		file write theme `"gsize axis_title      small"' _n
		file write theme `"gsize matrix_label    medium"' _n
		file write theme `"gsize label           medsmall"' _n
		file write theme `"gsize small_label     small"' _n
		file write theme `"gsize matrix_marklbl  medsmall"' _n
		file write theme `"gsize key_label       small"' _n
		file write theme `"gsize note            vsmall"' _n
		file write theme `"gsize star            small"' _n
		file write theme `"gsize text_option     small"' _n
		file write theme `"gsize dot_rectangle   third_tiny"' _n
		file write theme `"gsize axis_space      half_tiny"' _n
		file write theme `"gsize axis_title_gap  minuscule"' _n
		file write theme `"gsize tick            tiny"' _n
		file write theme `"gsize minortick       third_tiny"' _n
		file write theme `"* gsize minortick       .55"' _n
		file write theme `"gsize tickgap         half_tiny"' _n
		file write theme `"gsize notickgap       tiny"' _n
		file write theme `"gsize tick_label      small"' _n
		file write theme `"gsize tick_biglabel   small"' _n
		file write theme `"gsize minortick_label vsmall"' _n
		file write theme `"gsize filled_text     medsmall"' _n
		file write theme `"gsize reverse_big     large"' _n
		file write theme `"gsize alternate_gap   zero"' _n
		file write theme `"gsize title_gap       small"' _n
		file write theme `"gsize key_gap         small"' _n
		file write theme `"gsize key_linespace   small"' _n
		file write theme `"gsize star_gap        minuscule"' _n
		file write theme `"gsize legend_colgap   medium"' _n
		file write theme `"gsize label_gap       half_tiny"' _n
		file write theme `"gsize matrix_mlblgap  half_tiny"' _n
		file write theme `"gsize barlabel_gap    tiny"' _n
		file write theme `"gsize legend_row_gap    tiny"' _n
		file write theme `"gsize legend_col_gap    large"' _n
		file write theme `"gsize legend_key_gap    vsmall"' _n
		file write theme `"gsize legend_key_xsize  small"' _n
		file write theme `"gsize legend_key_ysize  small"' _n
		file write theme `"gsize zyx2legend_key_gap    tiny"' _n
		file write theme `"gsize zyx2legend_key_xsize  vhuge"' _n
		file write theme `"gsize zyx2legend_key_ysize  medium"' _n
		file write theme `"gsize zyx2rowgap            zero"' _n
		file write theme `"gsize zyx2colgap            large"' _n
		file write theme `"gsize clegend_width     medsmall"' _n
		file write theme `"gsize clegend_height    zero"' _n
		file write theme `"gsize pie_explode       medsmall"' _n
		file write theme `"gsize pielabel_gap      medsmall"' _n
		file write theme `"gsize plabel            vsmall"' _n
		file write theme `"gsize pboxlabel         vsmall"' _n
		file write theme `"* gsize p#label           small"' _n
		file write theme `"* gsize p#boxlabel        small"' _n
		file write theme `"gsize sts_risktable_space tiny"' _n
		file write theme `"gsize sts_risktable_tgap  tiny"' _n
		file write theme `"gsize sts_risktable_lgap  tiny"' _n
		file write theme `"gsize sts_risk_label      medsmall"' _n
		file write theme `"gsize sts_risk_title      medsmall"' _n
		file write theme `"gsize sts_risk_tick       zero"' _n	
	
	} // End ELSE Block for gap size parameters
	
	// Relative gap sizes
	if `"`relgapsizes'"' == "" {

		file write theme `"relsize bar_gap            0pct"' _n
		file write theme `"relsize bar_groupgap      80pct"' _n
		file write theme `"relsize bar_supgroupgap  200pct"' _n
		file write theme `"relsize bar_outergap      20pct"' _n
		file write theme `"relsize dot_gap       neg100pct"' _n
		file write theme `"relsize dot_groupgap       0pct"' _n
		file write theme `"relsize dot_supgroupgap   75pct"' _n
		file write theme `"relsize dot_outergap       0pct"' _n
		file write theme `"relsize box_gap           50pct"' _n
		file write theme `"relsize box_groupgap     100pct"' _n
		file write theme `"relsize box_supgroupgap  150pct"' _n
		file write theme `"relsize box_outergap      25pct"' _n
		file write theme `"relsize box_fence         75pct"' _n
		file write theme `"relsize box_fencecap       0pct"' _n
	
	} // End IF Block for relative gap sizes
	
	// Symbol sizes
	if `"`symsizes'"' == "" {
	
		file write theme `"symbolsize              medium"' _n
		file write theme `"symbolsize symbol       medium"' _n
		file write theme `"symbolsize smallsymbol  medsmall"' _n
		file write theme `"symbolsize star         vlarge"' _n
		file write theme `"symbolsize histogram    medium"' _n
		file write theme `"symbolsize histback     vlarge"' _n
		file write theme `"symbolsize dots         vtiny"' _n
		file write theme `"symbolsize ci           medlarge"' _n
		file write theme `"symbolsize ci2          medlarge"' _n
		file write theme `"symbolsize matrix       medsmall"' _n
		file write theme `"symbolsize refmarker    medium"' _n
		file write theme `"symbolsize sunflower    medium"' _n
		file write theme `"symbolsize backsymbol   large"' _n
		file write theme `"symbolsize backsymspace large"' _n
		file write theme `"symbolsize p            medium"' _n
		file write theme `"symbolsize pback        zero"' _n
		file write theme `"symbolsize parrow       medium"' _n
		file write theme `"symbolsize parrowbarb   medsmall"' _n
		
	} // End IF Block for symbol size arguments
	
	// Number of axis ticks
	if `"`axticks'"' == "" {
	
		file write theme `"numticks_g 0"' _n
		file write theme `"numticks_g major 5"' _n
		file write theme `"numticks_g horizontal_major 5"' _n
		file write theme `"numticks_g vertical_major 5"' _n
		file write theme `"numticks_g horizontal_minor 0"' _n
		file write theme `"numticks_g vertical_minor 0"' _n
		file write theme `"numticks_g horizontal_tmajor 0"' _n
		file write theme `"numticks_g vertical_tmajor 0"' _n
		file write theme `"numticks_g horizontal_tminor 0"' _n
		file write theme `"numticks_g vertical_tminor 0"' _n
		
	} // End IF Block for axis ticks 
	

	// Check for user supplied graph background/foreground color arguments
	if `"`grcolors'"' == "" {

		// Load defaults
		file write theme `"color background     white"' _n
		file write theme `"color foreground     white"' _n

	} // End IF Block for default background/foreground colors
	
	// If user provided values
	else {
	
		// Check for number of arguments
		if `: word count `grcolors'' == 2 {
		
			// User specified values for background and foreground
			file write theme `"color background     `: word 1 of `grcolors''"' _n
			file write theme `"color foreground     `: word 2 of `grcolors''"' _n

		} // End IF Block for individual colors for each parameter
		
		// If a single color value is passed
		else if `: word count `grcolors'' == 1 {
		
			// Single color value specified for background and foreground
			file write theme `"color background     `grcolors'"' _n
			file write theme `"color foreground     `grcolors'"' _n

		} // End ELSEIF Block for single color for both parameters
		
		// If illegal number of arguments
		else {
		
			// Close file connection and erase file
			qui: file close theme
			
			// Erase file
			erase "`c(sysdir_personal)'b/theme/theme-`themefile'.theme"
			
			// Print error message to screen
			di as err "The option {hi: grcolors} accepts a maximum of 2 "	 ///   
			"arguments.  The first is used for color background and second " ///  
			"for color foreground in the scheme file.  Please try again "	 ///   
			"using a maximum of two values for this parameter."
			
			// Error out
			err 198
		
		} // End ELSE Block for illegal number of arguments
	
	} // End ELSE Block for user supplied values
	
	// Text/tick colors
	if `"`txtcolors'"' == "" {
	
		file write theme `"color text           black"' _n
		file write theme `"color body           black"' _n
		file write theme `"color small_body     black"' _n
		file write theme `"color heading        black"' _n
		file write theme `"color subheading     black"' _n
		file write theme `"color axis_title     black"' _n
		file write theme `"color matrix_label   black"' _n
		file write theme `"color label          black"' _n
		file write theme `"color key_label      black"' _n
		file write theme `"color tick_label     black"' _n
		file write theme `"color tick_biglabel  black"' _n
		file write theme `"color matrix_marklbl black"' _n
		file write theme `"color sts_risk_label black"' _n
		file write theme `"color sts_risk_title black"' _n
		file write theme `"color box              none"' _n
		file write theme `"color textbox          white"' _n
		file write theme `"color mat_label_box    white"' _n
		file write theme `"color text_option      black"' _n
		file write theme `"color text_option_line white"' _n
		file write theme `"color text_option_fill white"' _n
		file write theme `"color filled_text    black"' _n
		file write theme `"color filled          white"' _n
		file write theme `"color bylabel_outline white"' _n
		file write theme `"color grid           white"' _n
		file write theme `"color major_grid     white"' _n
		file write theme `"color minor_grid     white"' _n
		file write theme `"color axisline       black"' _n
		file write theme `"color tick           black"' _n
		file write theme `"color minortick      black"' _n
		
	} // End IF Block for text/tick color arguments
	
	// Plot region color
	file write theme `"color plotregion         white"' _n
	file write theme `"color plotregion_line    white"' _n
	file write theme `"color matrix_plotregion  white"' _n
	file write theme `"color matplotregion_line black"' _n

	// Legend color
	file write theme `"color legend             white"' _n
	file write theme `"color legend_line        white"' _n
	file write theme `"color clegend            none"' _n
	file write theme `"color clegend_outer      none"' _n
	file write theme `"color clegend_inner      none"' _n
	file write theme `"color clegend_line       none"' _n
	
	// Linepatterns
	if `"`linepatterns'"' == "" {
	
		file write theme `"linepattern solid"' _n
		file write theme `"linepattern foreground blank"' _n
		file write theme `"linepattern background blank"' _n
		file write theme `"linepattern ci solid"' _n
		file write theme `"linepattern ci_area solid"' _n
		file write theme `"linepattern histogram solid"' _n
		file write theme `"linepattern dendrogram solid"' _n
		file write theme `"linepattern grid blank"' _n
		file write theme `"linepattern major_grid blank"' _n
		file write theme `"linepattern minor_grid blank"' _n
		file write theme `"linepattern axisline solid"' _n
		file write theme `"linepattern tick solid"' _n
		file write theme `"linepattern minortick solid"' _n
		file write theme `"linepattern xyline solid"' _n
		file write theme `"linepattern refline solid"' _n
		file write theme `"linepattern refmarker solid"' _n
		file write theme `"linepattern matrixmark solid"' _n
		file write theme `"linepattern dots solid"' _n
		file write theme `"linepattern dot solid"' _n
		file write theme `"linepattern dot_area solid"' _n
		file write theme `"linepattern dotmark solid"' _n
		file write theme `"linepattern pie solid"' _n
		file write theme `"linepattern legend solid"' _n
		file write theme `"linepattern clegend solid"' _n
		file write theme `"linepattern plotregion solid"' _n
		file write theme `"linepattern sunflower solid"' _n
		file write theme `"linepattern matrix_plotregion solid"' _n
		file write theme `"linepattern text_option blank"' _n
		file write theme `"linepattern zyx2 solid"' _n
		file write theme `"linepattern p solid"' _n
		file write theme `"linepattern pmark solid"' _n
	
	}
	
	// Margins
	if `"`margins'"' == "" {
	
		file write theme `"margin zero"' _n
		file write theme `"margin graph medium"' _n
		file write theme `"margin twoway medsmall"' _n
		file write theme `"margin bygraph zero"' _n
		file write theme `"margin combinegraph medsmall"' _n
		file write theme `"margin combine_region zero"' _n
		file write theme `"margin matrixgraph zero"' _n
		file write theme `"margin piegraph small"' _n
		file write theme `"margin piegraph_region medsmall"' _n
		file write theme `"margin matrix_plotreg small"' _n
		file write theme `"margin matrix_label zero"' _n
		file write theme `"margin mat_label_box zero"' _n
		file write theme `"margin by_indiv small"' _n
		file write theme `"margin text vsmall"' _n
		file write theme `"margin textbox zero"' _n
		file write theme `"margin body vsmall"' _n
		file write theme `"margin small_body vsmall"' _n
		file write theme `"margin heading vsmall"' _n
		file write theme `"* margin heading ".6 .6 .6 .6""' _n
		file write theme `"margin subheading vsmall"' _n
		file write theme `"margin axis_title zero"' _n
		file write theme `"margin label zero"' _n
		file write theme `"margin key_label zero"' _n
		file write theme `"margin text_option zero"' _n
		file write theme `"margin plotregion medsmall"' _n
		file write theme `"margin star tiny"' _n
		file write theme `"margin bargraph bargraph"' _n
		file write theme `"margin boxgraph bargraph"' _n
		file write theme `"margin dotgraph bargraph"' _n
		file write theme `"margin hbargraph bargraph"' _n
		file write theme `"margin hboxgraph bargraph"' _n
		file write theme `"margin hdotgraph bargraph"' _n
		file write theme `"margin legend small"' _n
		file write theme `"margin legend_key_region tiny"' _n
		file write theme `"margin legend_boxmargin small"' _n
		file write theme `"margin clegend medium"' _n
		file write theme `"margin cleg_title medsmall"' _n
		file write theme `"margin clegend_boxmargin small"' _n
		file write theme `"margin key_label zero"' _n
		file write theme `"margin filled_textbox small"' _n
		file write theme `"margin filled_box zero"' _n
		file write theme `"margin editor zero"' _n
		file write theme `"margin plabel zero"' _n
		file write theme `"margin plabelbox zero"' _n
		file write theme `"margin pboxlabel zero"' _n
		file write theme `"margin pboxlabelbox zero"' _n
	
	}
	
	// Line widths
	if `"`linewidths'"' == "" {
	
		file write theme `"linewidth thin thin"' _n
		file write theme `"linewidth medium medium"' _n
		file write theme `"linewidth p vthin"' _n
		file write theme `"linewidth foreground none"' _n
		file write theme `"linewidth background none"' _n
		file write theme `"linewidth grid none"' _n
		file write theme `"linewidth major_grid none"' _n
		file write theme `"linewidth minor_grid none"' _n
		file write theme `"linewidth axisline thin"' _n
		file write theme `"linewidth tick vthin"' _n
		file write theme `"linewidth tickline vthin"' _n
		file write theme `"linewidth minortick vvthin"' _n
		file write theme `"linewidth ci medium"' _n
		file write theme `"linewidth ci_area medthin"' _n
		file write theme `"linewidth ci2 medium"' _n
		file write theme `"linewidth ci2_area medthin"' _n
		file write theme `"linewidth histogram vthin"' _n
		file write theme `"linewidth dendrogram medium"' _n
		file write theme `"linewidth xyline medthin"' _n
		file write theme `"linewidth refline medium"' _n
		file write theme `"linewidth refmarker medthin"' _n
		file write theme `"linewidth matrixmark vvthin"' _n
		file write theme `"linewidth dots vthin"' _n
		file write theme `"linewidth dot_line medthick"' _n
		file write theme `"linewidth dot_area medthin"' _n
		file write theme `"linewidth dotmark vthin"' _n
		file write theme `"linewidth plotregion vthin"' _n
		file write theme `"linewidth legend none"' _n
		file write theme `"linewidth clegend none"' _n
		file write theme `"linewidth pie vthin"' _n
		file write theme `"linewidth reverse_big thin"' _n
		file write theme `"linewidth sunflower thin"' _n
		file write theme `"linewidth matrix_plotregion thin"' _n
		file write theme `"linewidth text_option none"' _n
		file write theme `"linewidth zyx2 medium"' _n
		file write theme `"linewidth pbar vthin"' _n
	
	}
	
	// Grid styles
	file write theme `"gridstyle default"' _n
	file write theme `"gridstyle major major"' _n
	file write theme `"gridstyle minor major"' _n
	file write theme `"gridlinestyle default"' _n
	file write theme `"gridlinestyle default default"' _n
	
	// Tick styles
	if `"`tickstyles'"' == "" {
	
		file write theme `"tickstyle default"' _n
		file write theme `"tickstyle default default"' _n
		file write theme `"tickstyle major major"' _n
		file write theme `"tickstyle minor minor"' _n
		file write theme `"tickstyle major_nolabel major_nolabel"' _n
		file write theme `"tickstyle minor_nolabel minor_nolabel"' _n
		file write theme `"tickstyle major_notick major_notick"' _n
		file write theme `"tickstyle minor_notick minor_notick"' _n
		file write theme `"tickstyle major_notickbig major_notickbig"' _n
		file write theme `"tickstyle minor_notickbig minor_notickbig"' _n
		file write theme `"tickstyle sts_risktable sts_risktable"' _n
	
	}
	
	// Tickset styles
	if `"`ticksetstyles'"' == "" {
	
		file write theme `"ticksetstyle major_horiz_default"' _n
		file write theme `"ticksetstyle major_horiz_default major_horiz_default"' _n
		file write theme `"ticksetstyle major_vert_default major_vert_default"' _n
		file write theme `"ticksetstyle minor_horiz_default minor_horiz_default"' _n
		file write theme `"ticksetstyle minor_vert_default minor_vert_default"' _n
		file write theme `"ticksetstyle major_horiz_withgrid major_horiz_default"' _n
		file write theme `"ticksetstyle major_vert_withgrid major_vert_withgrid"' _n
		file write theme `"ticksetstyle major_horiz_nolabel major_horiz_nolabel"' _n
		file write theme `"ticksetstyle major_vert_nolabel major_vert_nolabel"' _n
		file write theme `"ticksetstyle minor_horiz_nolabel minor_horiz_nolabel"' _n
		file write theme `"ticksetstyle minor_vert_nolabel minor_vert_nolabel"' _n
		file write theme `"ticksetstyle major_horiz_notick major_horiz_notick"' _n
		file write theme `"ticksetstyle major_vert_notick major_vert_notick"' _n
		file write theme `"ticksetstyle minor_horiz_notick minor_horiz_notick"' _n
		file write theme `"ticksetstyle minor_vert_notick minor_vert_notick"' _n
		file write theme `"ticksetstyle major_horiz_notickbig major_horiz_notickbig"' _n
		file write theme `"ticksetstyle major_vert_notickbig major_vert_notickbig"' _n
		file write theme `"ticksetstyle sts_risktable sts_risktable"' _n
		file write theme `"ticksetstyle major_clegend major_clegend"' _n
		file write theme `"tickposition axis_tick outside"' _n
		
	}
	

	// Check for user supplied bar label position argument
	if `"`barlpos'"' == "" {
	
		// Bar label positions
		file write theme `"barlabelpos bar outside"' _n

	} // End IF Block for barlabel position

	// If user supplies argument
	else {
	
		// Use user supplied argument
		file write theme `"barlabelpos bar `barlpos'"' _n
		
	} // End ELSE Block for user supplied bar label position argument
	
	// Grid Ring Options
	if `"`gridring'"' == "" {
		
		file write theme `"gridringstyle spacers_ring 11"' _n
		file write theme `"gridringstyle title_ring 7"' _n
		file write theme `"gridringstyle subtitle_ring 6"' _n
		file write theme `"gridringstyle caption_ring 4"' _n
		file write theme `"gridringstyle note_ring 4"' _n
		file write theme `"gridringstyle legend_ring 3"' _n
		file write theme `"gridringstyle zyx2legend_ring 4"' _n
		file write theme `"gridringstyle clegend_ring 3"' _n
		file write theme `"gridringstyle by_legend_ring 3"' _n
		file write theme `"gridringstyle legend_title_ring 7"' _n
		file write theme `"gridringstyle legend_subtitle_ring 6"' _n
		file write theme `"gridringstyle legend_caption_ring 3"' _n
		file write theme `"gridringstyle legend_note_ring 3"' _n
		file write theme `"gridringstyle clegend_title_ring 7"' _n
	
	} // End IF Block for grid ring options
	
	// YES/NO Options 
	if `"`yesno'"' == "" {
	
		file write theme `"yesno textbox no"' _n
		file write theme `"yesno text_option no"' _n
		file write theme `"yesno connect_missings yes"' _n
		file write theme `"yesno cmissings yes"' _n
		file write theme `"yesno pcmissings yes"' _n
		file write theme `"* yesno p#cmissings       no"' _n	
		file write theme `"yesno extend_axes_low yes"' _n
		file write theme `"yesno extend_axes_high yes"' _n
		file write theme `"yesno extend_axes_full_low yes"' _n
		file write theme `"yesno extend_axes_full_high yes"' _n
		file write theme `"yesno draw_major_grid no"' _n
		file write theme `"yesno draw_minor_grid no"' _n
		file write theme `"yesno draw_majornl_grid no"' _n
		file write theme `"yesno draw_minornl_grid no"' _n
		file write theme `"yesno draw_major_hgrid no"' _n
		file write theme `"yesno draw_minor_hgrid no"' _n
		file write theme `"yesno draw_majornl_hgrid no"' _n
		file write theme `"yesno draw_minornl_hgrid no"' _n
		file write theme `"yesno draw_major_vgrid yes"' _n
		file write theme `"yesno draw_minor_vgrid no"' _n
		file write theme `"yesno draw_majornl_vgrid no"' _n
		file write theme `"yesno draw_minornl_vgrid no"' _n
		file write theme `"yesno draw_major_nl_vgrid no"' _n
		file write theme `"yesno draw_minor_nl_vgrid no"' _n
		file write theme `"yesno draw_majornl_nl_vgrid no"' _n
		file write theme `"yesno draw_minornl_nl_vgrid no"' _n
		file write theme `"yesno draw_major_nl_hgrid no"' _n
		file write theme `"yesno draw_minor_nl_hgrid no"' _n
		file write theme `"yesno draw_majornl_nl_hgrid no"' _n
		file write theme `"yesno draw_minornl_nl_hgrid no"' _n
		file write theme `"yesno draw_major_nt_vgrid no"' _n
		file write theme `"yesno draw_minor_nt_vgrid no"' _n
		file write theme `"yesno draw_majornl_nt_vgrid no"' _n
		file write theme `"yesno draw_minornl_nt_vgrid no"' _n
		file write theme `"yesno draw_major_nt_hgrid no"' _n
		file write theme `"yesno draw_minor_nt_hgrid no"' _n
		file write theme `"yesno draw_majornl_nt_hgrid no"' _n
		file write theme `"yesno draw_minornl_nt_hgrid no"' _n
		file write theme `"yesno draw_major_nlt_vgrid no"' _n
		file write theme `"yesno draw_minor_nlt_vgrid no"' _n
		file write theme `"yesno draw_majornl_nlt_vgrid no"' _n
		file write theme `"yesno draw_minornl_nlt_vgrid no"' _n
		file write theme `"yesno draw_major_nlt_hgrid no"' _n
		file write theme `"yesno draw_minor_nlt_hgrid no"' _n
		file write theme `"yesno draw_majornl_nlt_hgrid no"' _n
		file write theme `"yesno draw_minornl_nlt_hgrid no"' _n
		file write theme `"yesno extend_grid_low yes"' _n
		file write theme `"yesno extend_grid_high yes"' _n
		file write theme `"yesno extend_minorgrid_low yes"' _n
		file write theme `"yesno extend_minorgrid_high yes"' _n
		file write theme `"yesno extend_majorgrid_low yes"' _n
		file write theme `"yesno extend_majorgrid_high yes"' _n
		file write theme `"yesno grid_draw_min no"' _n
		file write theme `"yesno grid_draw_max no"' _n
		file write theme `"yesno grid_force_nomin no"' _n
		file write theme `"yesno grid_force_nomax no"' _n
		file write theme `"yesno xyline_extend_low yes"' _n
		file write theme `"yesno xyline_extend_high yes"' _n
		file write theme `"yesno alt_xaxes no"' _n
		file write theme `"yesno alt_yaxes no"' _n
		file write theme `"yesno x2axis_ontop yes"' _n
		file write theme `"yesno y2axis_onright yes"' _n
		file write theme `"yesno use_labels_on_ticks no"' _n
		file write theme `"yesno alternate_labels no"' _n
		file write theme `"yesno swap_bar_scaleaxis no"' _n
		file write theme `"yesno swap_bar_groupaxis no"' _n
		file write theme `"yesno swap_dot_scaleaxis no"' _n
		file write theme `"yesno swap_dot_groupaxis no"' _n
		file write theme `"yesno swap_box_scaleaxis no"' _n
		file write theme `"yesno swap_box_groupaxis no"' _n
		file write theme `"yesno extend_dots yes"' _n
		file write theme `"yesno bar_reverse_scale no"' _n
		file write theme `"yesno dot_reverse_scale no"' _n
		file write theme `"yesno box_reverse_scale no"' _n
		file write theme `"yesno box_hollow no"' _n
		file write theme `"yesno box_custom_whiskers no"' _n		
		file write theme `"yesno pie_clockwise yes"' _n		
		file write theme `"yesno by_edgelabel yes"' _n
		file write theme `"yesno by_alternate_xaxes no"' _n
		file write theme `"yesno by_alternate_yaxes no"' _n
		file write theme `"yesno by_skip_xalternate no"' _n
		file write theme `"yesno by_skip_yalternate no"' _n
		file write theme `"yesno by_outer_xtitles yes"' _n
		file write theme `"yesno by_outer_ytitles yes"' _n
		file write theme `"yesno by_outer_xaxes yes"' _n
		file write theme `"yesno by_outer_yaxes yes"' _n
		file write theme `"yesno by_indiv_xaxes no"' _n
		file write theme `"yesno by_indiv_yaxes no"' _n
		file write theme `"yesno by_indiv_xtitles no"' _n
		file write theme `"yesno by_indiv_ytitles no"' _n
		file write theme `"yesno by_indiv_xlabels yes"' _n
		file write theme `"yesno by_indiv_ylabels yes"' _n
		file write theme `"yesno by_indiv_xticks yes"' _n
		file write theme `"yesno by_indiv_yticks yes"' _n
		file write theme `"yesno by_indiv_xrescale no"' _n
		file write theme `"yesno by_indiv_yrescale no"' _n
		file write theme `"yesno by_indiv_as_whole no"' _n
		file write theme `"yesno by_shrink_plotregion no"' _n
		file write theme `"yesno by_shrink_indiv no"' _n		
		file write theme `"yesno mat_label_box yes"' _n
		file write theme `"yesno mat_label_as_textbox yes"' _n		
		file write theme `"yesno legend_col_first no"' _n
		file write theme `"yesno legend_text_first no"' _n
		file write theme `"yesno legend_stacked no"' _n
		file write theme `"yesno legend_force_keysz no"' _n
		file write theme `"yesno legend_force_draw no"' _n
		file write theme `"yesno legend_force_nodraw no"' _n		
		file write theme `"yesno title_span yes"' _n
		file write theme `"yesno subtitle_span yes"' _n
		file write theme `"yesno caption_span yes"' _n
		file write theme `"yesno note_span yes"' _n
		file write theme `"yesno legend_span yes"' _n
		file write theme `"yesno zyx2legend_span no"' _n
		file write theme `"yesno clegend_title_span yes"' _n		
		file write theme `"yesno adj_xmargins no"' _n
		file write theme `"yesno adj_ymargins no"' _n		
		file write theme `"yesno plabelboxed no"' _n
		file write theme `"yesno pboxlabelboxed no"' _n		
		file write theme `"yesno contours_outline no"' _n
		file write theme `"yesno contours_reversekey no"' _n
		file write theme `"yesno contours_colorlines no"' _n		
		file write theme `"* yesno p#labelboxed           no"' _n
		file write theme `"* yesno p#boxlabelboxed        no"' _n
		
	} // End IF Block for YES/NO Arguments
	
	// Additional styles
	if `"`auxstyles'"' == "" {
	
		file write theme `"barstyle default"' _n
		file write theme `"barstyle default default"' _n
		file write theme `"barstyle dot dotdefault"' _n
		file write theme `"barstyle box boxdefault"' _n		
		file write theme `"barlabelstyle      none"' _n
		file write theme `"barlabelstyle bar bar"' _n		
		file write theme `"dottypestyle dot dot"' _n		
		file write theme `"medtypestyle boxplot line"' _n		
		file write theme `"pielabelstyle default none"' _n		
		file write theme `"arrowstyle default editor"' _n
		file write theme `"arrowstyle editor editor"' _n		
		file write theme `"starstyle default"' _n
		file write theme `"starstyle default default"' _n		
		file write theme `"above_below star below"' _n
		file write theme `"zyx2rule contour intensity"' _n
		file write theme `"zyx2rule contour hue"' _n		
		file write theme `"zyx2style default"' _n
		file write theme `"zyx2style default default"' _n
		
	} // End IF Block for auxilary style arugments
	
	// Close the open file connection
	file close theme
	
// End Program Definition	
end

	
