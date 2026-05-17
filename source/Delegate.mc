using Toybox.WatchUi;

import Toybox.Lang;


class Delegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        var id = item.getId();

        if (id.equals(COLOR_SCHEME_PROPERTY) && item instanceof WatchUi.MenuItem) {
            var view = new SettingsView();
            var delegate = new SettingsDelegate(view, item);
            WatchUi.pushView(view, delegate, WatchUi.SLIDE_LEFT);
        }
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

}
