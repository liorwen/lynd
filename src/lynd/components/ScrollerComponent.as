/**
 * Created by zear19st on 2017/1/6.
 */
package lynd.components
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    import lynd.components.base.Component;
    import lynd.components.base.IComponentState;
    import lynd.utils.util;

    public class ScrollerComponent extends Component
    {
        private var _scrollDefaultY:Number;
        private var _range:Number;
        private var _targetRange:Number;
        private var _defaultH:Number;
        private var _nowH:Number;
        private var _target:DisplayObject;
        private var _value:Number;
        private var _defaultY:Number;
        private var _offsetY:Number;
        private var _position:Number;

        public function ScrollerComponent(target:DisplayObject, view:*, screen:DisplayObjectContainer, root:DisplayObjectContainer)
        {
            _target = target;
            super(view, screen, root);
        }

        override protected function init():void
        {
            _view.buttonMode = true;
            _scrollDefaultY = _view.y;
            _defaultY = _target.y;
            _defaultH = _target.height;
//            _maximum = _target.y + _defaultH;
//            _view.x = _target.x + _target.width + 2;
//            _view.y = _target.y;
            update();
            value = 0;
        }

        override protected function addState(state:IComponentState):void
        {
            super.addState(state);
        }

        override protected function added():void
        {

        }

        override protected function addEvent():void
        {
            _view.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
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
            _view.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
            _root.stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);

        }

        private function onUp(event:MouseEvent):void
        {
            _root.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
        }

        private function onDown(event:MouseEvent):void
        {
            var localPt:Point = util.getMouseLocalPosition(_root, _screen);
            _offsetY = _view.y - localPt.y;
            _root.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);

        }

        private function onMove(event:MouseEvent):void
        {
            var localPt:Point = util.getMouseLocalPosition(_root, _screen);
            var localY:Number = localPt.y + _offsetY;
            var maximum:Number = _scrollDefaultY + _range;
            if (localY < _scrollDefaultY)
                localY = _scrollDefaultY;
            if (localY > maximum)
                localY = maximum;
            value = (localY - _scrollDefaultY) / _range;
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
            _view.y = _scrollDefaultY + _range * _value;
            _position = Math.abs(_targetRange * _value);
            _target.y = _defaultY - _position;
        }

        public function update():void
        {

            _nowH = _target.height;
            var newScrollerH:Number;
            if (_nowH <= _defaultH)
            {
                _view.visible = false;
                _targetRange = 0;
                newScrollerH = _defaultH;
            }
            else
            {
                _view.visible = true;
                _targetRange = _defaultH - _nowH;
                newScrollerH = _defaultH * Math.abs(_defaultH / _targetRange);
            }
            if (newScrollerH < 20)
                newScrollerH = 20;
            _view.height = newScrollerH;
            _range = _defaultH - newScrollerH;
        }


        override public function set y(value:Number):void
        {
            super.y = value;
            _scrollDefaultY = value;
        }

        public function get position():Number
        {
            return _position;
        }

        public function set position(value:Number):void
        {
            if (value < 0)
                value = 0;
            if(value > Math.abs(_targetRange))
                value =   Math.abs(_targetRange);
            _position = value;
            _target.y = _defaultY - _position;
            _value = _position/Math.abs(_targetRange);
            _view.y = _scrollDefaultY + _range * _value;
        }
    }
}
