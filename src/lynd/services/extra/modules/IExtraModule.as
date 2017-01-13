/**
 * Created by zear19st on 2016/12/16.
 */
package lynd.services.extra.modules
{
    import flash.display.DisplayObjectContainer;

    public interface IExtraModule
    {
        function get type():String;
        function get weight():int;
        function getPath():String;
        function canBeUsed():Boolean;
        function getThisFormWidth():Number;
        function getThisFormHeight():Number;
        function fullScreen(isFullScreen:Boolean):void;
        function setCallback(type:String, callback:Function):void;
        function hasCallback(type:String, callback:Function):Boolean;
        function removeCallback(type:String, callback:Function):void;
        function executeCallback(type:String, data:Object):void;
        function get isFullScreen():Boolean;
        function folderExists(folderPath:String):Boolean;
        function getFileList(filePath:String, fileType:String):Array;
        function prompt(message:String):void;
    }
}
