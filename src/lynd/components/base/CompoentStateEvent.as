/**
 * Created by zear19st on 2017/1/4.
 */
package lynd.components.base
{
    import flash.events.Event;

    public class CompoentStateEvent extends Event
    {
        static public var CHANGE:String = "change";

        private var _state:String;

        public function CompoentStateEvent(type:String, state:String)
        {
            super(type, false, false);
            _state = state;
        }

        override public function clone():Event
        {
            return new CompoentStateEvent(type, state);
        }

        public function get state():String
        {
            return _state;
        }
    }
}
