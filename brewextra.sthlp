




{hline 100}
{col 10} 			 {col 25}storage {col 35} display {col 46} value {col 57}
{col 10}variable name{col 25} type 	 {col 35} format  {col 46} label {col 57} variable label 
{hline 100}
{col 10}palette 	{col 25} str11	{col 35} {col 46} {col 57}
{col 10}colorblind 	{col 25} byte	{col 35} {col 46} {col 57}
{col 10} 			{col 25} 		{col 35} {col 46} {col 57}
{col 10}print 		{col 25} byte	{col 35} {col 46} {col 57}
{col 10}photocopy 	{col 25} byte	{col 35} {col 46} {col 57}
{col 10} 			{col 25} 		{col 35} {col 46} {col 57}
{col 10}lcd 		{col 25} byte	{col 35} {col 46} {col 57}
{col 10}colorid 	{col 25} {col 35} {col 46} {col 57}
{col 10}pcolor 		{col 25} {col 35} {col 46} {col 57}
{col 10}rgb 		{col 25} {col 35} {col 46} {col 57}
{col 10}maxcolors 	{col 25} {col 35} {col 46} {col 57}
{col 10}seqid 		{col 25} {col 35} {col 46} {col 57}
{col 10}meta 		{col 25} {col 35} {col 46} {col 57}
{hline 100}
-----------------------------------------------------------------------------------------------------------------------------------------------
              storage   display    value
variable name   type    format     label      variable label
-----------------------------------------------------------------------------------------------------------------------------------------------
palette         str11   %11s                  Name of Color Palette
colorblind      byte    %39.0g     colorblind
                                              Colorblind Indicator
print           byte    %34.0g     print      Print Indicator
photocopy       byte    %40.0g     photocopy
                                              Photocopy Indicator
lcd             byte    %32.0g     lcd        LCD/Laptop Indicator
colorid         double  %9.0g                 Within pcolor ID for individual color look ups
pcolor          double  %9.0g                 Palette by Colors Selected ID
rgb             str32   %32s                  Red-Green-Blue Values to Build Scheme Files
maxcolors       double  %10.0g                Maximum number of colors allowed for the palette
seqid           str13   %13s                  Sequential ID for property lookups
meta            str13   %13s                  Meta-Data Palette Characteristics (see char _meta[*] for more info)
-----------------------------------------------------------------------------------------------------------------------------------------------
