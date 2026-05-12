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

    function getSettingsView() {
        return [ new Menu(), new Delegate() ];
    }

    function getWatchFaceDelegate() {
        return new WatchFaceTapDelegate(_view);
    }

    function reloadColors() as Void {
        if (_view != null) { _view.reloadColors(); }
    }

    function onSettingsChanged() as Void {
        reloadColors();
        WatchUi.requestUpdate();
    }

}
