using Toybox.Application.Properties;
using Toybox.WatchUi;

import Toybox.Lang;


class Delegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        var id = item.getId();
        if (id.equals(COLOR_SCHEME_PROPERTY) && item instanceof WatchUi.MenuItem) {
            var current = PropertyUtils.getPropertyElseDefault(COLOR_SCHEME_PROPERTY, COLOR_SCHEME_DEFAULT);
            var next = (current + 1) % Palette.size();
            Properties.setValue(COLOR_SCHEME_PROPERTY, next);
            item.setSubLabel(Menu.nameFor(next));
            WatchUi.requestUpdate();
        }
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

}
