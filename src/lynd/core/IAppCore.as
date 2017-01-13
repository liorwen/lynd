/**
 * Created by zear19st on 2016/12/16.
 */
package lynd.core
{
    import flash.display.DisplayObjectContainer;

    import lynd.mutations.IMutationCore;

    import lynd.services.extra.IExtraFactory;
    import lynd.services.extra.modules.IExtraModule;

    import lynd.services.loader.ILoaderFactory;
    import lynd.states.IStateCore;

    public interface IAppCore
    {
        function get loader():ILoaderFactory;
        function get extra():IExtraModule;
        function get root():DisplayObjectContainer;
        function get state():IStateCore;
        function commit(type:String, ...args):void;
        function injectViewMediator(mediator:Class):void
    }
}
