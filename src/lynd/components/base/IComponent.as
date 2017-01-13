/**
 * Created by zear19st on 2017/1/4.
 */
package lynd.components.base
{
    import flash.display.DisplayObject;
    import flash.events.IEventDispatcher;

    public interface IComponent extends IEventDispatcher
    {
        function get view():DisplayObject;
        function get isAdded():Boolean;
        function get state():String;
        function set state(value:String):void;
        function get prevState():String;
        function set x(value:Number):void;
        function get x():Number;
        function set y(value:Number):void;
        function get y():Number;
        function set width(value:Number):void;
        function get width():Number;
        function set height(value:Number):void;
        function get height():Number;
        function set mouseEnabled(value:Boolean):void;
        function get mouseEnabled():Boolean;
        function set visible(value:Boolean):void;
        function get visible():Boolean;
        function startup():void;
        function startupAt(index:int):void;
        function stopup(isRemove:Boolean):void;
        function startDrag():void;
        function stopDrag():void;

    }
}
