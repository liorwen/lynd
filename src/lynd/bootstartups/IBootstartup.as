/**
 * Created by zear19st on 2016/12/16.
 */
package lynd.bootstartups
{
    import lynd.core.IAppCore;

    public interface IBootstartup
    {
        function startup(app:IAppCore):void;
    }
}
