/**
 * Created by zear19st on 2017/1/5.
 */
package lynd.components.base
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;

    public class GroupManager implements IEventDispatcher
    {
        private var _eventDispatcher:EventDispatcher;
        private var _nmae:String;
        protected var _itemDict:Dictionary;

        public function GroupManager(name:String)
        {
            _nmae = name;
            _eventDispatcher = new EventDispatcher();
            _itemDict = new Dictionary();
        }

        final public function addSelected(item:*, data:*):void
        {
            _itemDict[item] = data;
            dispatchEvent(new Event(Event.CHANGE));
        }

        final public function hasSelected(item:*):Boolean
        {
            if (_itemDict[item] == null)
                return false;
            return true;
        }

        final public function removeSelected(item:*):void
        {
            if (_itemDict[item] == null)
                return;
            _itemDict[item] = null;
            delete  _itemDict[item];
            dispatchEvent(new Event(Event.CHANGE));
        }

        final public function clearSelected():void
        {
            for (var item:* in _itemDict)
            {
                _itemDict[item] = null;
                delete _itemDict[item];
            }
            dispatchEvent(new Event(Event.CHANGE));
        }




        final public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            _eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        final public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        {
            _eventDispatcher.removeEventListener(type, listener, useCapture)
        }

        final public function dispatchEvent(event:Event):Boolean
        {
            return _eventDispatcher.dispatchEvent(event);
        }

        final public function hasEventListener(type:String):Boolean
        {
            return _eventDispatcher.hasEventListener(type);
        }

        final public function willTrigger(type:String):Boolean
        {
            return _eventDispatcher.willTrigger(type);
        }

        final public function get nmae():String
        {
            return _nmae;
        }
    }
}
