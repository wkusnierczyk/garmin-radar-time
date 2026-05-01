using Toybox.Application;
using Toybox.WatchUi;


class RadarApp extends Application.AppBase {

    private var _view as View or Null;

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

    function getInitialView() {
        _view = new View();
        return [ _view ];
    }

    function onSettingsChanged() as Void {
        if (_view != null) { _view.reloadColors(); }
        WatchUi.requestUpdate();
    }

    function getSettingsView() {
        return [ new Menu(), new Delegate() ];
    }

}
