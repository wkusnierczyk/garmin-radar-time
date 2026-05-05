using Toybox.Application;
using Toybox.Application.Properties;
using Toybox.WatchUi;

import Toybox.Lang;


class Menu extends WatchUi.Menu2 {

    function initialize() {
        Menu2.initialize({:title => Application.loadResource(Rez.Strings.ColorMenuTitle)});
        var index = PropertyUtils.getPropertyElseDefault(COLOR_SCHEME_PROPERTY, COLOR_SCHEME_DEFAULT);
        addItem(new WatchUi.MenuItem(
            Application.loadResource(Rez.Strings.ColorMenuTitle),
            Palette.nameFor(index),
            COLOR_SCHEME_PROPERTY,
            null
        ));
    }

}
