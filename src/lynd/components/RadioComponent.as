/**
 * Created by zear19st on 2017/1/5.
 */
package lynd.components
{
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import lynd.components.base.Component;
    import lynd.components.base.ComponentState;
    import lynd.components.base.IComponentState;

    public class RadioComponent extends Component
    {
        static public const UNSELECT:String = "unselect";
        static public const SELECTED:String = "selected";

        private var _data:*;
        private var _groupName:String;
        private var group:RadioGroup;

        public function RadioComponent(groupName:String, data:*, view:*, screen:DisplayObjectContainer, root:DisplayObjectContainer)
        {
            _data = data;
            _groupName = groupName;
            super(view, screen, root);
        }

        override protected function init():void
        {
            group = RadioGroup.getGroup(groupName);
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
            group.addEventListener(Event.CHANGE, onGroupChange);
        }

        private function onGroupChange(event:Event):void
        {

            if (group.hasSelected(this))
            {
                state = SELECTED;
            }
            else
            {
                state = UNSELECT;
            }
        }

        final public function get isSelected():Boolean
        {
            return group.hasSelected(this);
        }

        private function onClick(event:MouseEvent):void
        {
            select();
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

        public function get groupName():String
        {
            return _groupName;
        }

        public function get data():*
        {
            return _data;
        }

        public function select():void
        {
            group.select(this, data);
        }
    }
}
