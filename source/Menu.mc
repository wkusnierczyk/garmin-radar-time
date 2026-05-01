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
            nameFor(index),
            COLOR_SCHEME_PROPERTY,
            null
        ));
    }

    static function nameFor(index as Number) as String {
        var ids = [Rez.Strings.ColorRed, Rez.Strings.ColorGreen, Rez.Strings.ColorBlue, Rez.Strings.ColorOrange, Rez.Strings.ColorYellow];
        var i = (index >= 0 and index < ids.size()) ? index : 0;
        return Application.loadResource(ids[i]);
    }

}
