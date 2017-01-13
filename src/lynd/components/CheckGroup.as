/**
 * Created by zear19st on 2017/1/5.
 */
package lynd.components
{
    import flash.utils.Dictionary;

    import lynd.components.base.GroupManager;

    public class CheckGroup extends GroupManager
    {
        static private var _instances:Dictionary;

        public function CheckGroup(name:String, noCreate:NoCreate)
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

        static public function getGroup(name:String):CheckGroup
        {
            var result:CheckGroup;
            if (!hasGroup(name))
            {
                result = new CheckGroup(name, new NoCreate());
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

        final public function switchSelected(item:*, data:*):void
        {
            if (!hasSelected(item))
            {
                addSelected(item, data);
            }
            else
            {
                removeSelected(item);
            }
        }

        final public function get selectedItemData():Array
        {
            var result:Array = [];
            for (var item:* in _itemDict)
            {
                result.push({item: item, data: _itemDict[item]});
            }
            return result;
        }

        final public function get selectedItem():Array
        {
            var result:Array = [];
            for (var item:* in _itemDict)
            {
                result.push(item);
            }
            return result;
        }

        final public function get selectedData():Array
        {
            var result:Array = [];
            for (var item:* in _itemDict)
            {
                result.push(_itemDict[item]);
            }
            return result;
        }


    }
}
class NoCreate
{
}