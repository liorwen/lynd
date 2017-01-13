/**
 * Created by zear19st on 2017/1/6.
 */
package lynd.components
{
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    import lynd.components.base.Component;
    import lynd.components.base.IComponentState;
    import lynd.utils.util;

    public class SliderComponent extends Component
    {
        private var _btn:MovieClip;
        private var _minimum:Number;
        private var _maxmum:Number;
        private var _offsetX:Number;
        private var _value:Number;

        public function SliderComponent(view:*, screen:DisplayObjectContainer, root:DisplayObjectContainer)
        {
            super(view, screen, root);
        }

        override protected function init():void
        {
            _btn = _view.btn;
            _btn.buttonMode = true;
            _view.gotoAndStop(1);
            _minimum = _btn.x;
            _view.gotoAndStop(100);
            _maxmum = _btn.x;
            value = 0;
        }

        override protected function addState(state:IComponentState):void
        {
            super.addState(state);
        }

        override protected function added():void
        {
            super.added();
        }

        override protected function addEvent():void
        {
            _root.stage.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
            _root.stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
        }

        override protected function removeState(state:IComponentState):void
        {
            super.removeState(state);
        }

        override protected function removed():void
        {
            super.removed();
        }

        override protected function removeEvent():void
        {
            _root.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
            _root.stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
        }

        private function onDown(event:MouseEvent):void
        {
            if (!checkFocus(_btn))
                return;
            var localPt:Point = util.getMouseLocalPosition(_root, _view);
            _offsetX = _btn.x - localPt.x;
            _root.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);

        }

        private function onUp(event:MouseEvent):void
        {
            if (!checkFocusWithNull(_btn))
                return;
            _offsetX = 0;
            _root.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
        }

        private function onMove(event:MouseEvent):void
        {
            var localPt:Point = util.getMouseLocalPosition(_root, _view);
            var localX:Number = localPt.x + _offsetX;
            if (localX < _minimum)
                localX = _minimum;
            if (localX > _maxmum)
                localX = _maxmum;
            value = localX / _maxmum;
        }

        public function get value():Number
        {
            return _value;
        }

        public function set value(value:Number):void
        {
            if (value < 0)
                value = 0;
            if (value > 1)
                value = 1;

            _value = value;
            var frame:int = int(String(_value * 100).split(".")[0]);
            _view.gotoAndStop(frame);
            dispatchEvent(new Event(Event.CHANGE));
        }
    }
}
