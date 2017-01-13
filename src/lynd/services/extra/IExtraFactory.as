/**
 * Created by zear19st on 2016/12/16.
 */
package lynd.services.extra
{
    import lynd.services.extra.modules.ExtraModule;
    import lynd.services.extra.modules.IExtraModule;

    public interface IExtraFactory
    {
        function getExtra(type:String):IExtraModule;
    }
}
