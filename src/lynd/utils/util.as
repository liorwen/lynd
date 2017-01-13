/**
 * Created by zear19st on 2016/12/16.
 */
package lynd.utils
{


    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import flash.utils.describeType;
    import flash.utils.getQualifiedClassName;

    import lynd.utils.ObjectToDict.ArrayTransfer;
    import lynd.utils.ObjectToDict.ITransferModule;
    import lynd.utils.ObjectToDict.ObjectTransfer;
    import lynd.utils.ObjectToDict.ValueTransfer;

    public class util
    {
        public function util()
        {
        }

        public static function hasInterface(value:*, checkInterface:*):Boolean
        {
            var checkInterfaceLink:String = getQualifiedClassName(checkInterface);
            var calssXml:XML = describeType(value);
            var interfaceLength:int = calssXml.factory.implementsInterface.(@type == checkInterfaceLink).length();
            if (interfaceLength > 0)
                return true;
            return false;
        }

        public static function hasExtendsClass(value:*, checkClass:*):Boolean
        {
            var checkClassLink:String = getQualifiedClassName(checkClass);
            var calssXml:XML = describeType(value);
            var extendsClassLength:int = calssXml.factory.extendsClass.(@type == checkClassLink).length();
            if (extendsClassLength > 0)
                return true;
            return false;
        }

        public static function createStateDict(obj:*):Dictionary
        {

            var arrayTransfer:ITransferModule = new ArrayTransfer().next(new ValueTransfer());
            var transfer:ITransferModule = new ObjectTransfer().next(arrayTransfer);


            return transfer.transfer(obj) as Dictionary;

        }

        public static function createStateIndex(stateDict:Dictionary):Dictionary
        {
            var result:Dictionary = new Dictionary();
            getFlat("", stateDict, result);
            return result;
        }

        private static function getFlat(path:String, targetDict:Dictionary, resultDict:Dictionary):void
        {
            var newKey:String;
            var dictClass:String = getQualifiedClassName(Dictionary);
            for (var key:String in targetDict)
            {
                if (key == "stateValue")
                    continue;
                if (path == "")
                    newKey = key;
                else
                    newKey = path + "." + key;
                resultDict[newKey] = targetDict[key];
                if (getQualifiedClassName(targetDict[key]) == dictClass)
                    getFlat(newKey, targetDict[key], resultDict);
            }
        }

        public static function cloneObject(source:Object):*
        {
            var byteArray:ByteArray = new ByteArray();
            byteArray.writeObject(source);
            byteArray.position = 0;
            return byteArray.readObject();
        }

        static public function compConfig(infoClass:Class):Object
        {
            var xml:XML = describeType(infoClass);
            var constant:XMLList = xml.constant;
            var result:Object = {};
            result["file"] = "";
            result["components"] = {};
            for each(var node:XML in constant)
            {
                if (node.@name == "file")
                {
                    result["file"] = infoClass['file'];
                }
                else
                {
                    result["components"][node.@name] = infoClass[node.@name];
                }
            }
            return result;
        }

        static public function copyBitmap(target:Bitmap):Bitmap
        {
            var cloneBitmapData:BitmapData = new BitmapData(target.width, target.height);
            var rect:Rectangle = new Rectangle(0, 0, target.width, target.height);
            var point:Point = new Point(0, 0);
            cloneBitmapData.copyPixels(target.bitmapData, rect, point);
            var cloneBitmap:Bitmap = new Bitmap(cloneBitmapData);

            return cloneBitmap;
        }

        static public function copyDisplayObjectWithBitmap(target:DisplayObject):Bitmap
        {
            var cloneBitmapData:BitmapData = new BitmapData(target.width, target.height);
            cloneBitmapData.draw(target);
            var cloneBitmap:Bitmap = new Bitmap(cloneBitmapData);

            return cloneBitmap;
        }

        static public function getMouseLocalPosition(root:DisplayObjectContainer, local:DisplayObjectContainer):Point
        {
            var globalPt:Point = new Point(root.stage.mouseX, root.stage.mouseY);
            var localPt:Point = local.globalToLocal(globalPt);
            return localPt;
        }

        static public function getGlobalToLocalPosition(globalPt:Point, local:DisplayObjectContainer):Point
        {
            var localPt:Point = local.globalToLocal(globalPt);
            return localPt;
        }

        static public function getLocalToGlobalPosition(localPt:Point, local:DisplayObjectContainer):Point
        {
            var globalPt:Point = local.localToGlobal(localPt);
            return globalPt;
        }
    }
}
