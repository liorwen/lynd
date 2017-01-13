/**
 * Created by zear19st on 2017/1/4.
 */
package lynd.components.base
{
    public interface IComponentState
    {
        function get state():String;
        function set state(value:String):void;
        function get prevState():String;
        function registState(state:String, fun:Function):void;
        function hasState(state:String):Boolean;
        function removeState(state:String):void;
    }
}
