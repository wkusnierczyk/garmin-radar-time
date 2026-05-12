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
            var view = new SettingsView();
            var delegate = new SettingsDelegate(view, item);
            WatchUi.pushView(view, delegate, WatchUi.SLIDE_LEFT);
            return;
        }

        if (id.equals(TAP_TO_CYCLE_PROPERTY) && item instanceof WatchUi.ToggleMenuItem) {
            Properties.setValue(TAP_TO_CYCLE_PROPERTY, item.isEnabled());
            return;
        }
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

}
