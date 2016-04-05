/* brewtheme example theme files */

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
