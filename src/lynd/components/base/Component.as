/**
 * Created by zear19st on 2017/1/4.
 */
package lynd.components.base
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.EventDispatcher;

    public class Component implements IComponent
    {
        protected var _view:*;
        protected var _screen:DisplayObjectContainer;
        protected var _root:DisplayObjectContainer;
        private var _isAdded:Boolean;
        private var _eventDispatcher:EventDispatcher;
        private var _state:ComponentState;


        public function Component(view:*, screen:DisplayObjectContainer, root:DisplayObjectContainer)
        {
            _view = view;
            _screen = screen;
            _root = root;
            _eventDispatcher = new EventDispatcher();
            _state = new ComponentState();
            if (_view.parent == _screen)
            {
                _isAdded = true;
            }

            init();

        }

        protected function init():void
        {

        }

        final protected function addToScreen():void
        {
            if (_isAdded)
                return;
            _view.addEventListener(Event.ADDED, onAdded);
            _screen.addChild(_view);
        }

        final protected function addToScreenAt(index:int):void
        {
            if (_isAdded)
                return;
            _view.addEventListener(Event.ADDED, onAdded);
            _screen.addChildAt(_view, index);

        }

        final protected function checkFocusWithNull(target:*):Boolean
        {
            if (_root.stage.focus == null || _root.stage.focus == target)
                return true;
            return false;
        }

        final public function set visible(value:Boolean):void
        {
            _view.visible = value;
        }

        final public function get visible():Boolean
        {
            return _view.visible;
        }

        final protected function checkFocus(target:*):Boolean
        {
            if (_root.stage.focus == target)
                return true;
            return false;
        }

        private function onAdded(event:Event):void
        {
            _view.removeEventListener(Event.ADDED, onAdded);
            _isAdded = true;
            ready();
        }

        final public function startup():void
        {
            if (!_isAdded)
            {
                addToScreen();
            }
            else
            {
                ready();
            }

        }

        final public function startupAt(index:int):void
        {
            if (!_isAdded)
            {
                addToScreenAt(index);
            }
            else
            {
                ready();
            }
        }

        private function ready():void
        {
            addState(_state);
            addEvent();
            added();
        }

        protected function addState(state:IComponentState):void
        {

        }

        protected function added():void
        {

        }

        protected function addEvent():void
        {

        }

        final protected function removeFromScreen():void
        {
            if (!_isAdded)
                return;
            _view.addEventListener(Event.REMOVED, onRemoved);
            _screen.removeChild(_view);

        }

        private function onRemoved(event:Event):void
        {
            _view.removeEventListener(Event.REMOVED, onRemoved);
            _isAdded = false;

        }

        final public function stopup(isRemove:Boolean):void
        {
            if (isRemove)
                removeFromScreen();
            removeState(_state);
            removeEvent();
            removed();
        }

        protected function removeState(state:IComponentState):void
        {

        }

        protected function removed():void
        {

        }

        protected function removeEvent():void
        {

        }

        final public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            _eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        final public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        {
            _eventDispatcher.removeEventListener(type, listener, useCapture);
        }

        final public function dispatchEvent(event:Event):Boolean
        {
            return _eventDispatcher.dispatchEvent(event);
        }

        final public function hasEventListener(type:String):Boolean
        {
            return _eventDispatcher.hasEventListener(type);
        }

        final public function willTrigger(type:String):Boolean
        {
            return _eventDispatcher.willTrigger(type);
        }

        final public function set state(state:String):void
        {
            _state.state = state;
            dispatchEvent(new CompoentStateEvent(CompoentStateEvent.CHANGE, _state.state));

        }

        final public function get state():String
        {
            return _state.state;
        }

        final public function get prevState():String
        {
            return _state.prevState;
        }

        public function set x(value:Number):void
        {
            _view.x = value;
        }

        public function get x():Number
        {
            return _view.x;
        }

        public function set y(value:Number):void
        {
            _view.y = value;
        }

        public function get y():Number
        {
            return _view.y;
        }

        public function set width(value:Number):void
        {
            _view.width = value;
        }

        public function get width():Number
        {
            return _view.width;
        }

        public function set height(value:Number):void
        {
            _view.height = value;
        }

        public function get height():Number
        {
            return _view.height;
        }

        final public function get isAdded():Boolean
        {
            return _isAdded;
        }

        final public function set mouseEnabled(value:Boolean):void
        {
            _view.mouseEnabled = value;
        }

        final public function get mouseEnabled():Boolean
        {
            return _view.mouseEnabled;
        }

        final public function startDrag():void
        {
            _view.startDrag();
        }

        final public function stopDrag():void
        {
            _view.stopDrag();
        }

        public function get view():DisplayObject
        {
            return _view;
        }
    }
}
