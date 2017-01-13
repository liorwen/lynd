/**
 * Created by zear19st on 2016/12/20.
 */
package lynd.mutations
{
    import flash.utils.Dictionary;
    import flash.utils.describeType;
    import flash.utils.getQualifiedClassName;

    import lynd.states.IStateCore;
    import lynd.utils.util;

    public class MutationCore implements IMutationCore
    {
        private var _mutations:Dictionary;
        private var _mutationIndes:Dictionary;
        private var _state:IStateCore;

        public function MutationCore(state:IStateCore)
        {
            _mutations = new Dictionary();
            _mutationIndes = new Dictionary();
            _state = state;
        }

        public function register(mutations:Object):void
        {
            for (var key:String in mutations)
            {
                _mutations[key] = new mutations[key]();
                createMutationIndex(key, _mutations[key]);
            }
        }

        private function createMutationIndex(key:String, value:*):void
        {
            var checkClass:String = getQualifiedClassName(IStateCore);
            var xml:XML = describeType(value);
            var methods:XMLList = xml.method;
            var parameter:XMLList;
            var newKey:String = key;
            var methodName:String;
            for each(var method:XML in methods)
            {
                parameter = method.parameter.(attribute("index") == "1" && attribute("type") == checkClass);
                if(parameter.length() >= 1)
                {
                    methodName = method.attribute("name");
                    newKey = key +"."+ methodName;
                    _mutationIndes[newKey] = value[methodName];
                }
            }
        }

        public function commit(type:String, ...args):void
        {
            if(!_mutationIndes[type])
                return;
            args.unshift(_state);

            _mutationIndes[type].apply(null, args);
        }


    }
}
