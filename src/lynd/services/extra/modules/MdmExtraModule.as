/**
 * Created by zear19st on 2016/12/29.
 */
package lynd.services.extra.modules
{
    import flash.utils.setTimeout;

    import mdm.Application;
    import mdm.Dialogs;
    import mdm.Flash;
    import mdm.Forms;

    public class MdmExtraModule extends ExtraModule
    {


        public function MdmExtraModule(type:String, root:*, weight:int)
        {
            super(type, root, weight);
        }

        override protected function init(root:*):void
        {
            mdm.Application.init(root, onInit);
        }

        private function onInit():void
        {
            if (!canBeUsed())
                return;
            mdm.Flash.allowScale(true, true);
            mdm.Flash.setShowAllMode();
            var maximizeFn:Function = function (myObject:*):void
            {
                mdm.Application.onFormMaximize = null;
                fullScreen(true);
                setTimeout(function ():void
                {
                    mdm.Application.onFormMaximize = maximizeFn
                }, 100);
            };

            mdm.Application.onFormMaximize = maximizeFn;

            var restoreFn:Function = function (myObject:*):void
            {
                mdm.Application.onFormRestore = null;
                fullScreen(false);
                setTimeout(function ():void
                {
                    mdm.Application.onFormRestore = restoreFn
                }, 100);
            };

            mdm.Application.onFormRestore = restoreFn;
        }


        override public function canBeUsed():Boolean
        {
            var check:String = mdm.Application.path;
            if (check != "")
                return true;
            return false;
        }


        override public function getPath():String
        {
            return mdm.Application.path;
        }


        override public function getThisFormHeight():Number
        {
            return mdm.Forms.thisForm.height;
        }

        override public function getThisFormWidth():Number
        {
            return mdm.Forms.thisForm.width;
        }

        override public function prompt(message:String):void
        {
            mdm.Dialogs.prompt(message);
        }


        override public function fullScreen(isFullScreen:Boolean):void
        {
            if (isFullScreen)
            {
                mdm.Forms.thisForm.maximize();
            }
            else
            {
                mdm.Forms.thisForm.restore();

            }
            _isFullScreen = isFullScreen;
            executeCallback(ExtraModule.CHANGE_SCREEN, {isFullScreen: _isFullScreen});
        }
    }
}
