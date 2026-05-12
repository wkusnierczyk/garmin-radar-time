using Toybox.Application.Properties;
using Toybox.Graphics;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.WatchUi;

import Toybox.Lang;


class SettingsView extends WatchUi.View {

    private var _radar = new Radar();

    function initialize() {
        View.initialize();
    }

    function reloadColors() as Void {
        _radar.reloadColors();
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        var time = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        _radar.forTime(time).draw(dc);

        var index = PropertyUtils.getPropertyElseDefault(COLOR_SCHEME_PROPERTY, COLOR_SCHEME_DEFAULT);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() - dc.getFontHeight(Graphics.FONT_SMALL) - 4,
            Graphics.FONT_SMALL,
            Palette.nameFor(index),
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }

}
