using Toybox.Application;
using Toybox.Graphics;
using Toybox.System;

import Toybox.Lang;



// Settings
const SCREEN_IS_AMOLED = System.getDeviceSettings().requiresBurnInProtection;
const SCREEN_IS_MIP = !SCREEN_IS_AMOLED;


// const CUSTOMIZE_MENU_TITLE = Application.loadResource(Rez.Strings.Customize);

// const STANDARD_TIME_LABEL = Application.loadResource(Rez.Strings.StandardTimeMenuTitle);
// const STANDARD_TIME_PROPERTY = "ShowStandardTime";
// const STANDARD_TIME_MODE_DEFAULT = true;

// const MULTI_OPTION_LABEL = Application.loadResource(Rez.Strings.MultiOptionMenuTitle);
// const MULTI_OPTION_PROPERTY = "MultiOption";
// const MULTI_OPTION_DEFAULT = 1;
// const MULTI_OPTION_NAMES = Application.loadResource(Rez.JsonData.MultiOptionValues) as Array<String>;
