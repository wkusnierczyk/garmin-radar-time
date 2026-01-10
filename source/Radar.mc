using Toybox.Graphics;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System;

import Toybox.Lang;


class Radar {

    private static const RADAR_WIDTH = 40;
    private static const RADAR_WAVE_COLOR = Graphics.COLOR_GREEN;
    private static const RADAR_BEAM_COLOR = Graphics.COLOR_DK_GREEN;
    private static const RADAR_WAVES = 20;

    private var _time as Gregorian.Info;

    private var _radarWaveColor = RADAR_WAVE_COLOR;
    private var _radarBeamColor = RADAR_BEAM_COLOR;


    private var _width as Number;
    private var _height as Number;
    private var _centerX as Number;
    private var _centerY as Number;
    private var _radius as Number;

    function initialize() {
        var settings = System.getDeviceSettings();
        _width = settings.screenWidth;
        _height = settings.screenHeight;
        _centerX = _width / 2;
        _centerY = _height / 2;
        _radius = ((_width < _height)  ? _width : _height) / 2;
        _time = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    }

    function forTime(time as Time.Moment or Gregorian.Info) as Radar {
        _time = (time instanceof Gregorian.Info) ? time : Gregorian.info(time, Time.FORMAT_SHORT);
        return self;
    }

    function draw(dc as Graphics.Dc) as Radar {
        var seconds = _time.sec;
        var angle = 90 - ((seconds / 60.0) * 360).toNumber();
        var startAngle = angle + RADAR_WIDTH / 2;
        var endAngle = angle - RADAR_WIDTH / 2;

        dc.setPenWidth(_radius);
        dc.setColor(_radarBeamColor, Graphics.COLOR_TRANSPARENT);
        dc.drawArc(_centerX, _centerY, _radius / 2, Graphics.ARC_CLOCKWISE, startAngle, endAngle);

        dc.setPenWidth(1);
        dc.setColor(_radarWaveColor, Graphics.COLOR_TRANSPARENT);
        for (var i = 0; i < RADAR_WAVES; ++i) {
            var radius = (i + 1) * _radius / RADAR_WAVES;
            dc.drawArc(_centerX, _centerY, radius, Graphics.ARC_CLOCKWISE, startAngle, endAngle);
        }

        return self;
    }


}