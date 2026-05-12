using Toybox.Application;
using Toybox.Application.Properties;
using Toybox.WatchUi;

import Toybox.Lang;


class SettingsDelegate extends WatchUi.BehaviorDelegate {

    private var _view as SettingsView;
    private var _menuItem as WatchUi.MenuItem;

    function initialize(view as SettingsView, menuItem as WatchUi.MenuItem) {
        BehaviorDelegate.initialize();
        _view = view;
        _menuItem = menuItem;
    }

    function onSelect() {
        var current = PropertyUtils.getPropertyElseDefault(COLOR_SCHEME_PROPERTY, COLOR_SCHEME_DEFAULT);
        var next = (current + 1) % Palette.size();
        Properties.setValue(COLOR_SCHEME_PROPERTY, next);
        _menuItem.setSubLabel(Palette.nameFor(next));
        _view.reloadColors();
        (Application.getApp() as RadarApp).reloadColors();
        WatchUi.requestUpdate();
        return true;
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

}
