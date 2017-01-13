/**
 * Created by zear19st on 2017/1/4.
 */
package lynd.components.base
{
    import lynd.components.*;
    import flash.utils.Dictionary;

    public class ComponentState implements IComponentState
    {
        private var _prevState:String;
        private var _state:String;
        private var _stateDict:Dictionary;


        public function ComponentState()
        {
            _stateDict = new Dictionary();
        }

        public function registState(state:String, fun:Function):void
        {
            if (_stateDict[state] != null)
                return;
            _stateDict[state] = fun;
        }

        public function hasState(state:String):Boolean
        {
            if (_stateDict[state] == null)
                return false;
            return true;
        }

        public function removeState(state:String):void
        {
            if (_stateDict[state] == null)
                return;
            _stateDict[state] = null
            delete _stateDict[state];
        }

        public function get state():String
        {
            return _state;
        }

        public function set state(value:String):void
        {
            if (_stateDict[value] == null)
                return;
            _prevState = _state;
            _state = value;
            _stateDict[state].apply();
        }

        public function get prevState():String
        {
            return _prevState;
        }
    }
}
