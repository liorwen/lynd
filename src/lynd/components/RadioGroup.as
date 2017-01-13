/**
 * Created by zear19st on 2017/1/5.
 */
package lynd.components
{
    import flash.events.Event;
    import flash.utils.Dictionary;

    import lynd.components.base.GroupManager;

    public class RadioGroup extends GroupManager
    {
        static private var _instances:Dictionary;

        public function RadioGroup(name:String, noCreate:NoCreate)
        {
            super(name);
            instances[name] = this;
        }

        static private function get instances():Dictionary
        {
            if (_instances == null)
                _instances = new Dictionary();
            return _instances;
        }

        static public function getGroup(name:String):RadioGroup
        {
            var result:RadioGroup;
            if (!hasGroup(name))
            {
                result = new RadioGroup(name, new NoCreate());
            }
            else
            {
                result = instances[name];
            }
            return result;
        }

        static public function hasGroup(name:String):Boolean
        {
            if (instances[name] == null)
                return false;
            return true;
        }

        static public function removeGroup(name:String):void
        {
            if (instances[name] == null)
                return;
            instances[name] = null;
            delete instances[name];
        }

        public function select(itme:*, data:*):void
        {
            for (var item:* in _itemDict)
            {
                _itemDict[item] = null;
                delete _itemDict[item];
            }
            _itemDict[itme] = data;
            dispatchEvent(new Event(Event.CHANGE));
        }

        final public function get selectedItemData():Object
        {
            var result:Array = [];
            for (var item:* in _itemDict)
            {
                result.push({item: item, data: _itemDict[item]});
            }
            if (result.length > 0)
                return result[0];
            return {}
        }

        final public function get selectedItem():*
        {
            var result:Array = [];
            for  (var item:* in _itemDict)
            {
                result.push(item);
            }
            if (result.length > 0)
                return result[0];
            return null;
        }

        final public function get selectedData():*
        {
            var result:Array = [];
            for  (var item:* in _itemDict)
            {
                result.push(_itemDict[item]);
            }
            if (result.length > 0)
                return result[0];
            return null;
        }
    }
}
class NoCreate
{
}
