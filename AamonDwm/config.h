/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx		= 5;		/* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { 
	"monospace:size=10",
	"JoyPixels:pixelsize=10:antialias=true:autohint=true"
};

/* color */
#include "pink.h"

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "discord",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     	= 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     	= 1;    /* number of clients in master area */
static const int resizehints 	= 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[T]",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/bash", "-c", cmd, NULL } }

/* Program name constants (For ease of access)*/
#define TERMINAL "alacritty"
#define BROWSER "google-chrome-stable"
#define FILEMANAGER "pcmanfm"
#define TERMFILEMANAGER "ranger"
#define OPTIONSLOCATION "/usr/AamonDwmScripts/dmenu-keybindings"
#define APPSWITCH "/usr/AamonDwmScripts/dmenu-switch"
#define DMENUBLUE "/usr/AamonDwmScripts/dmenu-bluetooth"
#define DMENUMENU "/usr/AamonDwmScripts/menu-dmenu"
#define SHUTDOWN "/usr/AamonDwmScripts/shutdown-dmenu"
#define RESTART "/usr/AamonDwmScripts/restart-dmenu"
#define USB "/usr/AamonDwmScripts/dmenu-usb-drives"
#define TOP "gtop"

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] 				= 		{ "dmenu_run", "-m", dmenumon, "-i", "-l", "25", "-p", "Run:", NULL };
static const char *termcmd[]  				= 		{ TERMINAL, NULL };
static const char *browsercmd[]  			= 		{ BROWSER, NULL };
static const char *qutebrowser[]			=		{ "qutebrowser", NULL};
static const char *guifilemanagercmd[]  	= 		{ FILEMANAGER, NULL };
static const char *termfilemanagercmd[]  	= 		{ TERMINAL, "-e", TERMFILEMANAGER, NULL };
static const char *printscreencmd[]  		= 		{ "flameshot", "gui", NULL };
static const char *options[]				=		{ OPTIONSLOCATION, NULL};
static const char *networkmanagerdmenu[]	=		{ "networkmanager_dmenu", "-l", "25", "-i", "-c", NULL};
static const char *bluedmenu[]				=		{ DMENUBLUE, NULL};
static const char *usbmount[]				=		{ USB, NULL};
static const char *shutdown[]				=		{ SHUTDOWN, NULL};
static const char *reboot[]					=		{ RESTART, NULL};
static const char *slock[]					=		{ "slock", NULL};
static const char *top[]					= 		{ TERMINAL, "-e", TOP, NULL };
static const char *appswitch[]				=		{ APPSWITCH, NULL};
static const char *dmenumenu[]				=		{ DMENUMENU };

/* multimedia commands */
static const char *volup[]					=		{ "pamixer", "-i", "5", NULL};
static const char *voldown[]				=		{ "pamixer", "-d", "5", NULL};
static const char *mute[]					=		{ "pamixer", "-t", NULL};

static Key keys[] = {
	/* modifier                     key        function        argument */
	/* Program spawn key bindings*/
	{ MODKEY,                       XK_r,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_c,      spawn,          {.v = browsercmd } },
	{ MODKEY|ControlMask,			XK_c,	   spawn,		   {.v = qutebrowser } },
	{ MODKEY,                       XK_f,      spawn,          {.v = termfilemanagercmd } },
	{ MODKEY|ShiftMask,             XK_f,      spawn,          {.v = guifilemanagercmd } },
	{0, 							XK_Print,  spawn,		   {.v = printscreencmd } },
	{MODKEY,						XK_o,	   spawn, 		   {.v = options} },
	{MODKEY,						XK_n,	   spawn, 		   {.v = networkmanagerdmenu} },
	{MODKEY,						XK_b,	   spawn, 		   {.v = bluedmenu} },
	{MODKEY,						XK_u,	   spawn, 		   {.v = usbmount} },
	{MODKEY,						XK_x,	   spawn,		   {.v = dmenumenu} },
	{MODKEY,						XK_a,	   spawn,		   {.v = appswitch} },
	{MODKEY,						XK_g,	   spawn,		   {.v = top} },
	/* Window and layout key bindings*/
	{ MODKEY|ShiftMask,             XK_t,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = +1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },		// This switches the current master
	{ MODKEY,                       XK_Tab,    view,           {0} },		// This jumps to the last tag
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
//	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_y,      setlayout,      {.v = &layouts[3]} },
//	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[4]} },
//	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY,             			XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_bracketleft,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_bracketright, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_bracketleft,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_bracketright, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_Right,  viewnext,       {0} },
	{ MODKEY,                       XK_Left,   viewprev,       {0} },
	{ MODKEY|ShiftMask,             XK_Right,  tagtonext,      {0} },
	{ MODKEY|ShiftMask,             XK_Left,   tagtoprev,      {0} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	/* Quit and restart DWM*/
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },	// This quits DWM
	{ MODKEY|ControlMask|ShiftMask,	XK_q,	   quit,		   {1} },	// This restarts DWM
	{ MODKEY|ShiftMask,				XK_p,	   spawn,		   {.v = shutdown} },
	{ MODKEY|ShiftMask,				XK_r,	   spawn,		   {.v = reboot} },
	{ MODKEY|ShiftMask,				XK_s,	   spawn,		   {.v = slock} },
	/* Multimedia commands */
	{ ControlMask,					XK_m,	   spawn,		   {.v = mute} },
	{ ControlMask,					XK_u,	   spawn,		   {.v = volup} },
	{ ControlMask,					XK_d,	   spawn,		   {.v = voldown} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
//	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
