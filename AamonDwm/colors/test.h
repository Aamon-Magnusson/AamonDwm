// test
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#ff0000";
static const char col_gray2[]       = "#00ff00";
static const char col_gray3[]       = "#0000ff";
static const char col_gray4[]       = "#000000"; //"#eeeeee";
static const char col_cyan[]        = "#ff00ff"; //"#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};
