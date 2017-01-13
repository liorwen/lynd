/**
 * Created by zear19st on 2016/12/19.
 */
package lynd.states
{
    import flash.events.Event;

    public class StateEvent extends Event
    {
        private var _value:*;

        public function StateEvent(type:String, value:*)
        {
            super(type, false, false);
            _value = value;
        }

        public function get value():*
        {
            return _value;
        }

        public override function clone():Event
        {
            return new StateEvent(type, value);
        }
    }
}
