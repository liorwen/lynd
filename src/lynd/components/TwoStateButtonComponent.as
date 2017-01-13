/**
 * Created by zear19st on 2017/1/9.
 */
package lynd.components
{
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;

    import lynd.components.base.Component;
    import lynd.components.base.IComponentState;

    public class TwoStateButtonComponent extends Component
    {
        static public const NORMAL:String = "normal";
        static public const OVER:String = "over";

        private var _isMouseDown:Boolean;

        public function TwoStateButtonComponent(view:*, screen:DisplayObjectContainer, root:DisplayObjectContainer)
        {
            super(view, screen, root);
        }

        override protected function init():void
        {
            _view.buttonMode = true;
        }

        override protected function addState(state:IComponentState):void
        {
            state.registState(NORMAL, normalState);
            state.registState(OVER, overState);
        }

        override protected function addEvent():void
        {
            _view.addEventListener(MouseEvent.CLICK, onClick);
            _root.stage.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
            _root.stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
            _view.addEventListener(MouseEvent.MOUSE_OVER, onOver);
            _view.addEventListener(MouseEvent.MOUSE_OUT, onOut);
        }

        private function onOut(event:MouseEvent):void
        {
            if (!checkFocusWithNull(_view) && _isMouseDown)
                return;
            dispatchEvent(event.clone());
            state = NORMAL;
        }

        private function onOver(event:MouseEvent):void
        {
            if (!checkFocusWithNull(_view) && _isMouseDown)
                return;
            dispatchEvent(event.clone());
            state = OVER;
        }

        private function onDown(event:MouseEvent):void
        {
            _isMouseDown = true;
            if (!checkFocus(_view))
                return;
            state = OVER;
            dispatchEvent(event.clone());
        }

        private function onUp(event:MouseEvent):void
        {
            _isMouseDown = false;
            if (!checkFocusWithNull(_view))
                return;
            state = NORMAL;
            dispatchEvent(event.clone());
        }

        private function onClick(event:MouseEvent):void
        {
            state = OVER;
            dispatchEvent(event.clone());
        }

        override protected function added():void
        {
            state = NORMAL;
            _isMouseDown = false;
        }

        override protected function removeState(state:IComponentState):void
        {
            state.removeState(NORMAL);
            state.removeState(OVER);
        }

        override protected function removeEvent():void
        {
            _view.removeEventListener(MouseEvent.CLICK, onClick);
            _root.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
            _root.stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
            _view.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
            _view.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
        }

        override protected function removed():void
        {

        }

        private function normalState():void
        {
            _view.gotoAndStop(1);
        }

        private function overState():void
        {
            _view.gotoAndStop(2);
        }
    }
}
