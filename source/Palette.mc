import Toybox.Lang;


module Palette {

    // Index -> { :grid, :beam, :hoursLit, :minutesLit }
    // Dim ship stays Graphics.COLOR_DK_GRAY for every scheme;
    // it should recede uniformly under any beam color.

    (:amoled_only)
    const TABLE = [
        { :grid => 0x550000, :beam => 0x990000, :hoursLit => 0xFF0000, :minutesLit => 0xDD0000 },
        { :grid => 0x1F3F1F, :beam => 0x4CBB17, :hoursLit => 0x17BB17, :minutesLit => 0x13A313 },
        { :grid => 0x102C4D, :beam => 0x1E6BCC, :hoursLit => 0x1E90FF, :minutesLit => 0x1A7AE0 },
        { :grid => 0x552E00, :beam => 0x995400, :hoursLit => 0xFF8C00, :minutesLit => 0xDD7A00 },
        { :grid => 0x554800, :beam => 0x998000, :hoursLit => 0xFFD700, :minutesLit => 0xDDBB00 }
    ];

    // MIP 64-color palette: each channel in {0, 0x55, 0xAA, 0xFF}.
    // hoursLit and minutesLit collapsed to FF — quantization can't preserve
    // the AMOLED two-step gradation without colliding with the beam color.
    (:mip_only)
    const TABLE = [
        { :grid => 0x550000, :beam => 0xAA0000, :hoursLit => 0xFF0000, :minutesLit => 0xFF0000 },
        { :grid => 0x005500, :beam => 0x00AA00, :hoursLit => 0x00FF00, :minutesLit => 0x00FF00 },
        { :grid => 0x000055, :beam => 0x0000AA, :hoursLit => 0x0055FF, :minutesLit => 0x0055FF },
        { :grid => 0x552A00, :beam => 0xAA5500, :hoursLit => 0xFFAA00, :minutesLit => 0xFFAA00 },
        { :grid => 0x555500, :beam => 0xAAAA00, :hoursLit => 0xFFFF00, :minutesLit => 0xFFFF00 }
    ];

    function get(index as Number) as Dictionary {
        var i = (index >= 0 and index < TABLE.size()) ? index : 0;
        return TABLE[i];
    }

    function size() as Number {
        return TABLE.size();
    }

}
