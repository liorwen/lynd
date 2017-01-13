/**
 * Created by zear19st on 2017/1/4.
 */
package lynd.components
{
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.net.navigateToURL;

    import lynd.components.base.Component;
    import lynd.components.base.ComponentState;
    import lynd.components.base.IComponentState;

    public class ButtonComponent extends Component
    {
        static public const NORMAL:String = "normal";
        static public const OVER:String = "over";
        static public const DOWN:String = "down";

        private var _isMouseDown:Boolean;

        public function ButtonComponent(view:MovieClip, screen:DisplayObjectContainer, root:DisplayObjectContainer)
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
            state.registState(DOWN, downState);
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
            switch (state)
            {
                case DOWN:
                    state = OVER;
                    break;
                case OVER:
                    state = NORMAL;
                    break;
            }
        }

        private function onOver(event:MouseEvent):void
        {
            if (!checkFocusWithNull(_view) && _isMouseDown)
                return;
            dispatchEvent(event.clone());
            switch (state)
            {
                case OVER:
                    state = DOWN;
                    break;
                case NORMAL:
                    state = OVER;
                    break;
            }
        }

        private function onDown(event:MouseEvent):void
        {
            _isMouseDown = true;
            if (!checkFocus(_view))
                return;
            state = DOWN;
            dispatchEvent(event.clone());
        }

        private function onUp(event:MouseEvent):void
        {
            _isMouseDown = false;
            if (!checkFocusWithNull(_view))
                return;
            state = NORMAL;
//            switch (state)
//            {
//                case DOWN:
//                    state = OVER;
//                    break;
//                case OVER:
//                    state = NORMAL;
//                    break;
//            }
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
            state.removeState(DOWN);
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

        private function downState():void
        {
            _view.gotoAndStop(3);
        }
    }
}
