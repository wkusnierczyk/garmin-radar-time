using Toybox.Application.Properties;
using Toybox.WatchUi;

import Toybox.Lang;


class WatchFaceTapDelegate extends WatchUi.WatchFaceDelegate {

    private var _view as View;

    function initialize(view as View) {
        WatchFaceDelegate.initialize();
        _view = view;
    }

    function onPress(clickEvent) as Boolean {
        var tapEnabled = PropertyUtils.getPropertyElseDefault(TAP_TO_CYCLE_PROPERTY, TAP_TO_CYCLE_DEFAULT);
        if (!tapEnabled) {
            return false;
        }

        if (clickEvent.getType() != WatchUi.CLICK_TYPE_TAP) {
            return false;
        }

        var current = PropertyUtils.getPropertyElseDefault(COLOR_SCHEME_PROPERTY, COLOR_SCHEME_DEFAULT);
        var next = (current + 1) % Palette.size();
        Properties.setValue(COLOR_SCHEME_PROPERTY, next);
        _view.reloadColors();
        WatchUi.requestUpdate();
        return true;
    }

}
