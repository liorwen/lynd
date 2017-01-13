/**
 * Created by zear19st on 2017/1/6.
 */
package lynd.components
{
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import lynd.components.base.Component;
    import lynd.components.base.IComponentState;

    public class CheckComponent extends Component
    {
        static public const UNSELECT:String = "unselect";
        static public const SELECTED:String = "selected";

        public function CheckComponent(view:*, screen:DisplayObjectContainer, root:DisplayObjectContainer)
        {
            super(view, screen, root);
        }

        override protected function init():void
        {
            _view.buttonMode = true;
        }

        override protected function addState(state:IComponentState):void
        {
            state.registState(UNSELECT, unselectState);
            state.registState(SELECTED, selectedState);
        }

        private function selectedState():void
        {
            _view.gotoAndStop(2);
        }

        private function unselectState():void
        {
            _view.gotoAndStop(1);
        }

        override protected function added():void
        {
            state = UNSELECT;
        }

        override protected function addEvent():void
        {
            _view.addEventListener(MouseEvent.CLICK, onClick);
        }

        final public function get isSelected():Boolean
        {
            if (state == SELECTED)
                return true;
            return false;
        }

        private function onClick(event:MouseEvent):void
        {
            switchSelect();
        }


        override protected function removeState(state:IComponentState):void
        {
            state.removeState(UNSELECT);
            state.removeState(SELECTED);
        }

        override protected function removed():void
        {
            super.removed();
        }

        override protected function removeEvent():void
        {
            _view.removeEventListener(MouseEvent.CLICK, onClick);
        }

        public function select(isSelect:Boolean):void
        {
            if (isSelect)
                state = SELECTED;
            else
                state = UNSELECT;
            dispatchEvent(new Event(Event.CHANGE));
        }


        public function switchSelect():void
        {
            select(!isSelected);
        }
    }
}
