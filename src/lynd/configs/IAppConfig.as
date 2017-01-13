/**
 * Created by zear19st on 2016/12/16.
 */
package lynd.configs
{
    public interface IAppConfig
    {
        function get states():Object;
        function get mutations():Object;
        function get loaderModules():Object;
        function get extraModules():Object;
    }
}
