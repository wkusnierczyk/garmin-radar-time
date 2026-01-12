using Toybox.Graphics;
using Toybox.Math;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System;

import Toybox.Lang;


class Radar {

    private static const 
        RADAR_WIDTH = 100,
        RADAR_GRID_LINES = 10,
        RADAR_BEAM_SHADES = 40,
        RADAR_GRID_COLOR = 0x550000,
        RADAR_BEAM_COLOR = 0x990000;
        // RADAR_GRID_COLOR = 0x355E3B,
        // RADAR_BEAM_COLOR = 0x4CBB17;

    private static const
        HOURS_SHIP_WIDTH_FACTOR = 0.05,
        MINUTES_SHIP_WIDTH_FACTOR = 0.05,
        HOURS_SHIP_LENGTH_FACTOR = 0.3,
        MINUTES_SHIP_LENGTH_FACTOR = 0.5,
        HOURS_SHIP_RADIUS_FACTOR = 0.4,
        MINUTES_SHIP_RADIUS_FACTOR = 0.6;

    private static const
        SHIP_DIM_COLOR = Graphics.COLOR_DK_GRAY,
        HOURS_SHIP_LIT_COLOR = 0xFF0000,
        MINUTES_SHIP_LIT_COLOR = 0xDD0000;
        // HOURS_SHIP_LIT_COLOR = Graphics.COLOR_GREEN,
        // MINUTES_SHIP_LIT_COLOR = Graphics.COLOR_GREEN;

    private static const
        RED_SHIFT = 16,
        GREEN_SHIFT = 8,
        BLUE_SHIFT = 0,
        MASK = 0xFF;


    private var 
        _time as Gregorian.Info,
        _dc as Graphics.Dc or Null;

    private var 
        _width as Number,
        _height as Number,
        _centerX as Number,
        _centerY as Number,
        _radius as Number;

    private var 
        _radarWidth = RADAR_WIDTH,
        _radarGridLines = RADAR_GRID_LINES,
        _radarBeamShades = RADAR_BEAM_SHADES,
        _radarGridColor = RADAR_GRID_COLOR,
        _radarBeamColor = RADAR_BEAM_COLOR;

    private var
        _hoursShipWidth as Number,
        _hoursShipLength as Number,
        _hoursShipRadius as Number,
        _hoursShipWidthFactor = HOURS_SHIP_WIDTH_FACTOR,
        _hoursShipLengthFactor = HOURS_SHIP_LENGTH_FACTOR,
        _hoursShipRadiusFactor = HOURS_SHIP_RADIUS_FACTOR,
        _minutesShipWidth as Number,
        _minutesShipLength as Number,
        _minutesShipRadius as Number,
        _minutesShipWidthFactor = MINUTES_SHIP_WIDTH_FACTOR,
        _minutesShipLengthFactor = MINUTES_SHIP_LENGTH_FACTOR,
        _minutesShipRadiusFactor = MINUTES_SHIP_RADIUS_FACTOR;

    private var
        _shipDimColor = SHIP_DIM_COLOR,
        _hoursShipLitColor = HOURS_SHIP_LIT_COLOR,
        _minutesShipLitColor = MINUTES_SHIP_LIT_COLOR;


    function initialize() {
        var settings = System.getDeviceSettings();
        _width = settings.screenWidth;
        _height = settings.screenHeight;
        _centerX = _width / 2;
        _centerY = _height / 2;
        _radius = ((_width < _height)  ? _width : _height) / 2;
        _hoursShipWidth = (_radius * _hoursShipWidthFactor).toNumber();
        _hoursShipLength = (_radius * _hoursShipLengthFactor).toNumber();
        _hoursShipRadius = (_radius * _hoursShipRadiusFactor).toNumber();
        _minutesShipWidth = (_radius * _minutesShipWidthFactor).toNumber();
        _minutesShipLength = (_radius * _minutesShipLengthFactor).toNumber();
        _minutesShipRadius = (_radius * _minutesShipRadiusFactor).toNumber();
        _time = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    }


    function forTime(time as Time.Moment or Gregorian.Info) as Radar {
        _time = (time instanceof Gregorian.Info) ? time : Gregorian.info(time, Time.FORMAT_SHORT);
        return self;
    }


    function draw(dc as Graphics.Dc) as Radar {

        _dc = dc;
        _drawBeam();
        _drawGrid();
        _drawTime();

        return self;

    }


    private function _drawBeam() as Radar {

        if (SCREEN_IS_AMOLED) {
            return _drawBeamColors();
        } else if (SCREEN_IS_MIP) {
            return _drawBeamLines();
        }
        return self; // can't happen

    }

    private function _drawBeamLines() as Radar {

        var color = _radarBeamColor;
        
        var seconds = _time.sec,
            angle = _correctAngle((seconds / 60.0) * 360);

        // TODO move constants upfront
        var steps = 15;
        var waves = 5;
        var factor = 1.2;
        
        _dc.setPenWidth(1);
        _dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        for (var i = 0; i < steps; ++i) {
            var width = (steps - i) * _radarWidth / steps;
            for (var j = 0; j < waves.toNumber(); ++j) {
                var radius = ((j + 1.0) * _radius / waves).toNumber();
                _dc.drawArc(_centerX, _centerY, radius, Graphics.ARC_CLOCKWISE, angle + width, angle);
            }
            waves = waves * factor;
        }  
        
        return self;

    }


    private function _drawBeamColors() as Radar {

        var color = _radarBeamColor;

        var seconds = _time.sec,
            angle = _correctAngle((seconds / 60.0) * 360);

        var red = (color >> RED_SHIFT) & MASK,
            green = (color >> GREEN_SHIFT) & MASK,
            blue = (color >> BLUE_SHIFT) & MASK;

        var width = _radarWidth / _radarBeamShades;

        _dc.setPenWidth(_radius);
        for (var i = 0; i < _radarBeamShades; ++i) {
            _dc.setColor(color, Graphics.COLOR_TRANSPARENT);
            _dc.drawArc(_centerX, _centerY, _radius / 2, Graphics.ARC_CLOCKWISE, angle + width, angle);
            color = ((red * (_radarBeamShades - i) / _radarBeamShades) << RED_SHIFT) |
                    ((green * (_radarBeamShades - i) / _radarBeamShades) << GREEN_SHIFT) | 
                    ((blue * (_radarBeamShades - i) / _radarBeamShades) << BLUE_SHIFT);
            angle += width;
        }

        return self;

    }


    private function _drawGrid() as Radar {

        _dc.setPenWidth(1);
        _dc.setColor(_radarGridColor, Graphics.COLOR_TRANSPARENT);
        for (var i = 0; i < _radarGridLines; ++i) {
            var radius = (i + 1) * _radius / _radarGridLines;
            _dc.drawArc(_centerX, _centerY, radius, Graphics.ARC_CLOCKWISE, 0, 0);
        }

        return self;

    }


    private function _drawTime() as Radar {
    
        var hoursAngle = _correctAngle((_time.hour % 12 * 360.0 / 12) + (_time.min * 360.0 / 60 / 12));
        var secondsAngle = _correctAngle(_time.sec * 360.0 / 60 + _hoursShipWidth / 2);
        var hoursSecondsAngle = (360 + hoursAngle - secondsAngle) % 360;
        var hoursColor = (hoursSecondsAngle > 0 and hoursSecondsAngle < _radarWidth) ? _hoursShipLitColor : _shipDimColor;
        _drawShip(hoursAngle, _hoursShipRadius, _hoursShipWidth, _hoursShipLength, hoursColor);
        
        var minutesAngle = _correctAngle(_time.min * 360.0 / 60);
        secondsAngle = _correctAngle(_time.sec * 360.0 / 60 + _minutesShipWidth / 2);
        var minutesSecondsAngle = (360 + minutesAngle - secondsAngle) % 360;
        var minutesColor = (minutesSecondsAngle > 0 and minutesSecondsAngle < _radarWidth) ? _minutesShipLitColor : _shipDimColor;
        _drawShip(minutesAngle, _minutesShipRadius, _minutesShipWidth, _minutesShipLength, minutesColor);    
    
        return self;
    }

    
    private function _correctAngle(angle as Numeric) as Number {
        return (90 - angle).toNumber();
    }


    private function _drawShip(angle as Numeric, radius as Numeric, width as Numeric, length as Numeric, color as Graphics.ColorType) as Radar {

        var radians = Math.toRadians(angle.toFloat());
        var cosine = Math.cos(radians);
        var sine = Math.sin(radians);

        var directionX = cosine; 
        var directionY = -sine;

        var sidewaysX = directionY;
        var sidewaysY = -directionX;

        var centerX = _centerX + (radius * directionX);
        var centerY = _centerY + (radius * directionY);

        var halfLength = length / 2.0;
        var halfWidth = width / 2.0;

        var tipLength = width.toFloat(); 
        if (tipLength > halfLength) { 
            tipLength = halfLength; 
        }

        var bodyHalfLength = halfLength - tipLength;

        var proximalTipX = centerX - (halfLength * directionX);
        var proximalTipY = centerY - (halfLength * directionY);
        
        var distalTipX = centerX + (halfLength * directionX);
        var distalTipY = centerY + (halfLength * directionY);

        var proximalBaseX = centerX - (bodyHalfLength * directionX);
        var proximalBaseY = centerY - (bodyHalfLength * directionY);

        var distalBaseX = centerX + (bodyHalfLength * directionX);
        var distalBaseY = centerY + (bodyHalfLength * directionY);

        var baseOffsetX = sidewaysX * halfWidth;
        var baseOffsetY = sidewaysY * halfWidth;

        var points = [
            [proximalTipX, proximalTipY],                                    // Proximal Tip
            [proximalBaseX + baseOffsetX, proximalBaseY + baseOffsetY],      // Proximal Right Shoulder
            [distalBaseX + baseOffsetX, distalBaseY + baseOffsetY],          // Distal Right Shoulder
            [distalTipX, distalTipY],                                        // Distal Tip
            [distalBaseX - baseOffsetX, distalBaseY - baseOffsetY],          // Distal Left Shoulder
            [proximalBaseX - baseOffsetX, proximalBaseY - baseOffsetY]       // Proximal Left Shoulder
        ];

        _dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        _dc.fillPolygon(points);

        return self;
    
    }


    private function _toCartesian(radius as Numeric, angle as Numeric) as Array<Number> {

        var radians = Math.toRadians(angle.toFloat());
        var x = _centerX + (radius * Math.cos(radians));
        var y = _centerY - (radius * Math.sin(radians));
        
        return [x.toNumber(), y.toNumber()];

    }


}