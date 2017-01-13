/**
 * Created by zear19st on 2016/12/16.
 */
package lynd.services.extra
{
    import flash.utils.Dictionary;

    import lynd.services.extra.modules.ExtraModule;

    import lynd.services.extra.modules.IExtraModule;

    import lynd.utils.util;

    public class ExtraFactory implements IExtraFactory
    {
        protected var _moduleDict:Dictionary;

        public function ExtraFactory()
        {
            _moduleDict = new Dictionary();
        }

        public function register(root:*, modules:Object):void
        {
            for (var name:String in modules)
            {
                if (util.hasInterface(modules[name].module, IExtraModule))
                {
                    _moduleDict[name] = new modules[name].module(name, root,  modules[name].weight);
                }
            }
        }


        public function getExtra(type:String):IExtraModule
        {
            return _moduleDict[type];
        }

    }
}
