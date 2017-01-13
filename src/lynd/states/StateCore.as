/**
 * Created by zear19st on 2016/12/20.
 */
package lynd.states
{
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;

    import lynd.utils.util;


    import lynd.utils.util;

    public class StateCore extends EventDispatcher implements IStateCore
    {
        private var _stateTree:Dictionary;
        private var _stateIndex:Dictionary;
        private var _listenIndex:Dictionary;

        public function StateCore()
        {
            super(null);
            _stateTree = new Dictionary();
            _listenIndex = new Dictionary();
        }

        public function register(root:String, states:Object):void
        {
            _stateTree[root] = new Dictionary();
            var registerState:IState;
            for (var key:String in states)
            {
                if(util.hasInterface(states[key], IState))
                {
                    registerState = new states[key]();
                    _stateTree[root][key] = util.createStateDict(registerState.state);
                }

            }
            _stateIndex = util.createStateIndex(_stateTree);
        }

        public function setState(index:String, value:*):void
        {
            if (_stateIndex[index] == null)
                return;
            if (!_stateIndex[index].hasOwnProperty("stateValue"))
                return;
//            if (getQualifiedClassName(_stateIndex[index]["stateValue"]) != getQualifiedClassName(value))
//                return;
            _stateIndex[index]["stateValue"] = value;
            dispatchTree(index);
        }

        public function getState(index:String):*
        {
            if (_stateIndex[index] == null)
                return null;
            if (_stateIndex[index].hasOwnProperty("stateValue"))
                return _stateIndex[index]["stateValue"];
            return _stateIndex[index];
        }

        public function listen(index:String, callBack:Function):void
        {
            if (hasListen(index, callBack))
                return;
            if (_stateIndex[index] == null)
                return;
            if (_listenIndex[index] == null)
                _listenIndex[index] = new Dictionary();
            _listenIndex[index][callBack] = onListen(callBack);
            addEventListener(index, _listenIndex[index][callBack]);
        }

        private function onListen(callBack:Function):Function
        {
            var fn:Function = function (e:StateEvent):void
            {
                callBack.apply(null, [e.value]);
            }
            return fn;
        }

        public function removeListen(index:String, callBack:Function):void
        {
            if (!hasListen(index, callBack))
                return;
            removeEventListener(index, _listenIndex[index][callBack]);
            delete _listenIndex[index][callBack]
        }

        public function hasListen(index:String, callBack:Function):Boolean
        {
            if (!_listenIndex[index])
                return false;
            if (!_listenIndex[index][callBack])
                return false;
            return true;
        }

        private function dispatchTree(index:String):void
        {
            var indexArray:Array = index.split(".");
            var newIndex:String = "";
            for each(var key:String in indexArray)
            {
                if(newIndex == "")
                    newIndex = key;
                else
                    newIndex = newIndex + "." + key;
                dispatch(newIndex);
            }
        }

        private function dispatch(index:String):void
        {
            var value:*;
            if (!_stateIndex[index])
                return;
            if (_stateIndex[index].hasOwnProperty("stateValue"))
                value = _stateIndex[index]["stateValue"];
            else
                value = _stateIndex[index];
            dispatchEvent(new StateEvent(index, value));
        }


    }
}
