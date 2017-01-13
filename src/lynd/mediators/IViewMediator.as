/**
 * Created by zear19st on 2016/12/16.
 */
package lynd.mediators
{
    import flash.display.DisplayObjectContainer;

    public interface IViewMediator
    {
//        function addToScreen(screen:DisplayObjectContainer):void;
//        function addToScreenAt(screen:DisplayObjectContainer, index:int):void;
//        function removeFromScreen():void;
//        function listenState(index:String, callBack:Function):void;
//        function removelistenState(index:String, callBack:Function):void;
//        function haslistenState(index:String, callBack:Function):Boolean;
//        function commit(type:String, ...args):void;
        function get isAddedToScreen():Boolean;
        function get viewAddState():String;
    }
}
