/**
 * Created by zear19st on 2016/12/16.
 */
package lynd.core
{

    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    import flash.utils.describeType;

    import lynd.bootstartups.IBootstartup;

    import lynd.configs.IAppConfig;

    import flash.display.DisplayObjectContainer;

    import lynd.mediators.IViewMediator;
    import lynd.mediators.ViewMediator;
    import lynd.mutations.IMutationCore;
    import lynd.mutations.MutationCore;
    import lynd.services.extra.ExtraFactory;
    import lynd.services.extra.ExtraManager;
    import lynd.services.extra.IExtraFactory;
    import lynd.services.extra.modules.IExtraModule;

    import lynd.services.loader.ILoaderFactory;

    import lynd.services.loader.LoaderFactory;
    import lynd.states.IStateCore;
    import lynd.states.StateCore;


    import lynd.utils.util;

    public class AppCore implements IAppCore
    {
        private var _root:DisplayObjectContainer;
        private var _appConfig:IAppConfig;
        private var _bootstartup:IBootstartup;
        private var _stateCore:StateCore;
        private var _mutationCore:MutationCore;
        private var _loaderFactory:LoaderFactory;
        private var _extraManager:ExtraManager;
        private var _mediatorDict:Dictionary;

        public function AppCore(root:DisplayObjectContainer, appConfig:Class, bootstartup:Class)
        {
            _root = root;
            _stateCore = new StateCore();
            _mutationCore = new MutationCore(_stateCore);
            _loaderFactory = new LoaderFactory();
            _extraManager = new ExtraManager();

            _mediatorDict = new Dictionary();



            setAppConfig(appConfig);
            setBootstartup(bootstartup);
        }

        public final function get root():DisplayObjectContainer
        {
            return _root;
        }

        public final function get loader():ILoaderFactory
        {
            return _loaderFactory;
        }

        private function setAppConfig(value:Class):void
        {
            if (!util.hasInterface(value, IAppConfig))
                return;
            _appConfig = new value();
            _loaderFactory.register(_appConfig.loaderModules);
            _extraManager.register(root, _appConfig.extraModules);
            _stateCore.register("state", _appConfig.states);
            _mutationCore.register(_appConfig.mutations);
        }

        private function setBootstartup(value:Class):void
        {
            if (!util.hasInterface(value, IBootstartup))
                return;
            _bootstartup = new value();
            _bootstartup.startup(this);

        }

        public final function injectViewMediator(mediator:Class):void
        {

            if (!util.hasInterface(mediator, IViewMediator))
                return;
            _mediatorDict[mediator] = new mediator(this, root);
        }

        public final function commit(type:String, ...args):void
        {
            args.unshift(type);
            _mutationCore.commit.apply(null, args);
        }

        public final function getMediator(mediator:Class):IViewMediator
        {
            if (_mediatorDict[mediator])
                return _mediatorDict[mediator];
            return null;
        }

        public final function get extra():IExtraModule
        {
            return _extraManager;
        }

        public final function get state():IStateCore
        {
            return _stateCore;
        }
    }
}
