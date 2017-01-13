/**
 * Created by zear19st on 2016/12/20.
 */
package lynd.states
{
    public interface IStateCore
    {
        function setState(index:String, value:*):void;
        function getState(index:String):*;
        function listen(index:String, callBack:Function):void;
        function removeListen(index:String, callBack:Function):void;
        function hasListen(index:String, callBack:Function):Boolean;
    }
}
