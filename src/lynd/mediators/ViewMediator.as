/**
 * Created by zear19st on 2016/12/16.
 */
package lynd.mediators
{
    import flash.utils.getQualifiedClassName;

    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import lynd.core.IAppCore;
    import lynd.services.extra.modules.IExtraModule;
    import lynd.utils.util;

    public class ViewMediator implements IViewMediator, IEventDispatcher
    {
        private var _app:IAppCore;
        private var _screen:DisplayObjectContainer;
        protected var _view:*;
        private var _eventDispatch:EventDispatcher;
        private var _onAddScreenAtFn:Function;
        private var _isAddedToScreen:Boolean;
        private var _viewAddState:String;

        public function ViewMediator(app:IAppCore, screen:DisplayObjectContainer)
        {
            _app = app;
            _screen = screen;
            _viewAddState = ViewAddState.NO_ADD;
            _isAddedToScreen = false;
            _eventDispatch = new EventDispatcher();
        }

        public final function load(type:String, path:String, config:Object, container:*, callback:Function):void
        {
            return _app.loader.load(type, path, config, container, callback);
        }

        public final function get root():DisplayObjectContainer
        {
            return _app.root;
        }

        public final function get view():*
        {
            return _view;
        }

        public final function addToScreen():void
        {
            if (_viewAddState != ViewAddState.NO_ADD)
                return;
            _viewAddState = ViewAddState.WILL_ADD;
            addEventListener("addToScreenReady", onAddToScreenReady);
            addToScreenBefore();

        }

        public final function addToScreenAt(index:int):void
        {
            if (_viewAddState != ViewAddState.NO_ADD)
                return;
            _viewAddState = ViewAddState.WILL_ADD;
            _onAddScreenAtFn = getOnAddToScreenAtReady(index);
            addEventListener("addToScreenReady", _onAddScreenAtFn);
            addToScreenBefore();

        }

        protected function addToScreenBefore():void
        {
            addToScreenReady();
        }

        protected final function addToScreenReady():void
        {
            dispatchEvent(new Event("addToScreenReady"));
        }

        private function onAddToScreenReady(event:Event):void
        {
            removeEventListener("addToScreenReady", onAddToScreenReady);
            view.addEventListener(Event.ADDED, onAdded);
            _viewAddState = ViewAddState.ADDING;
            _screen.addChild(view);
        }

        private function getOnAddToScreenAtReady(index:int):Function
        {
            var fn:Function = function (event:Event):void
            {
                removeEventListener("addToScreenReady", _onAddScreenAtFn);
                _onAddScreenAtFn = null;
                view.addEventListener(Event.ADDED, onAdded);
                _viewAddState = ViewAddState.ADDING;
                _screen.addChildAt(view, index);
            }
            return fn;
        }

        private function onAdded(e:Event):void
        {
            view.removeEventListener(Event.ADDED, onAdded);
            _viewAddState = ViewAddState.ADDED;
            _isAddedToScreen = true;
            added();
        }

        protected function added():void
        {

        }

        public final function removeFromScreen():void
        {
            if (_viewAddState != ViewAddState.ADDED)
                return;
            addEventListener("removeFromScreenReady", onRemoveFromScreenReady);
            removeFromScreenBefore();
        }

        private function onRemoveFromScreenReady(event:Event):void
        {
            removeEventListener("removeFromScreenReady", onRemoveFromScreenReady);
            view.addEventListener(Event.REMOVED, onRemoved);
            _screen.removeChild(view);
        }

        protected function removeFromScreenBefore():void
        {
            removeFromScreenReady();
        }

        protected final function removeFromScreenReady():void
        {
            dispatchEvent(new Event("removeFromScreenReady"));
        }

        private function onRemoved(e:Event):void
        {
            view.removeEventListener(Event.REMOVED, onRemoved);
            _viewAddState = ViewAddState.NO_ADD;
            _isAddedToScreen = false;
            removed();
        }

        protected function removed():void
        {

        }

        public final function getState(index:String):*
        {
            return _app.state.getState(index);
        }

        public final function get appPath():String
        {
            return _app.extra.getPath();
        }

        final public function get extra():IExtraModule
        {
            return _app.extra;
        }

        final protected function injectApp():void
        {
            injectChild(_app);
        }

        protected function injectChild(app:IAppCore):void
        {

        }

        final public function realPath(path:String):String
        {
            return _app.extra.getPath() + path;
        }

        public final function listenState(index:String, callBack:Function):void
        {
            _app.state.listen(index, callBack);
        }

        public final function removelistenState(index:String, callBack:Function):void
        {
            _app.state.removeListen(index, callBack);
        }

        public final function haslistenState(index:String, callBack:Function):Boolean
        {
            return _app.state.hasListen(index, callBack);
        }

        protected function onScreenChange(value:*):void
        {
            if (getQualifiedClassName(value) == getQualifiedClassName(this))
                this.addToScreenAt(0);
            else
            {
                this.removeFromScreen();
                root.stage.focus = null;
            }

        }

        public final function commit(type:String, ...args):void
        {
            args.unshift(type);
            _app.commit.apply(null, args);
        }

        public final function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            _eventDispatch.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        public final function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        {
            _eventDispatch.removeEventListener(type, listener, useCapture);
        }

        public final function dispatchEvent(event:Event):Boolean
        {
            return _eventDispatch.dispatchEvent(event);
        }

        public final function hasEventListener(type:String):Boolean
        {
            return _eventDispatch.hasEventListener(type);
        }

        public final function willTrigger(type:String):Boolean
        {
            return _eventDispatch.willTrigger(type);
        }


        public function get isAddedToScreen():Boolean
        {
            return _isAddedToScreen;
        }

        public function get viewAddState():String
        {
            return _viewAddState;
        }

        protected function compConfig(infoClass:Class):Object
        {
            return util.compConfig(infoClass);
        }
    }
}
