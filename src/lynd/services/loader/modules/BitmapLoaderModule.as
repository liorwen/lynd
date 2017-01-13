/**
 * Created by zear19st on 2016/12/16.
 */
package lynd.services.loader.modules
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.LoaderInfo;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;

    import lynd.utils.util;


    public class BitmapLoaderModule extends LoaderModule
    {
        public function BitmapLoaderModule(type:String)
        {
            super(type);
        }

        override public function isLoaded(loadedDict:Dictionary, path:String, config:Object):Boolean
        {
            if (loadedDict[getKey(path, config, "")] == null)
                return false;
            return true;
        }

        override public function getPath(path:String, config:Object):String
        {
            return path + config.file;
        }


        override public function getKey(path:String, config:Object, option:String):String
        {
            return type + "_" + getPath(path, config);
        }

        override public function loaded(loadedDict:Dictionary, path:String, config:Object, loaderInfo:LoaderInfo):*
        {
//            loadedDict[getKey(path, config, "")] = loaderInfo.content;
            var target:Bitmap = loaderInfo.content as Bitmap;
            var cloneBitmap:Bitmap = util.copyBitmap(target);

            return cloneBitmap;
//            return loadedDict[getKey(path, config, "")];
        }

        override public function getLoaded(loadedDict:Dictionary, path:String, config:Object):*
        {
            var target:Bitmap = loadedDict[getKey(path, config, "")] as Bitmap;
            var cloneBitmap:Bitmap = util.copyBitmap(target);

            return cloneBitmap;
//            return loadedDict[getKey(path, config, "")];
        }
    }
}
