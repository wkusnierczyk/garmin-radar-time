using Toybox.Graphics;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System;

import Toybox.Lang;


class Radar {

    private static const RADAR_WIDTH = 100;
    private static const RADAR_GRID_LINES = 10;
    private static const RADAR_GRID_COLOR = 0x005500;
    private static const RADAR_BEAM_COLOR = Graphics.COLOR_DK_GREEN;

    private var _time as Gregorian.Info;

    private var _radarGridLines = RADAR_GRID_LINES;
    private var _radarGridColor = RADAR_GRID_COLOR;
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
        var startAngle = angle + RADAR_WIDTH;
        var endAngle = angle - RADAR_WIDTH;

        dc.setPenWidth(_radius);
        // dc.setColor(_radarBeamColor, Graphics.COLOR_TRANSPARENT);
        // dc.drawArc(_centerX, _centerY, _radius / 2, Graphics.ARC_CLOCKWISE, startAngle, endAngle);
        var color = 0x00FF00;
        var steps = 40;
        var width = RADAR_WIDTH / steps;
        for (var i = 0; i < steps; ++i) {
            dc.setColor(color, Graphics.COLOR_TRANSPARENT);
            dc.drawArc(_centerX, _centerY, _radius / 2, Graphics.ARC_CLOCKWISE, angle + width, angle);
            // color -= 0x001100;
            color = ((0xFF * (steps - (i + 1))) / steps) << 8;
            angle += width;
        }

        dc.setPenWidth(1);
        dc.setColor(_radarGridColor, Graphics.COLOR_TRANSPARENT);
        for (var i = 0; i < _radarGridLines; ++i) {
            var radius = (i + 1) * _radius / _radarGridLines;
            dc.drawArc(_centerX, _centerY, radius, Graphics.ARC_CLOCKWISE, 0, 0);
        }



        return self;
    }


}