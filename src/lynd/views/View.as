/**
 * Created by zear19st on 2017/1/5.
 */
package lynd.views
{
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;

    public class View extends Sprite
    {
        protected var _root:DisplayObjectContainer;
        protected var _panel:MovieClip;

        public function View(root:DisplayObjectContainer)
        {
            _root = root;
            init();
        }

        protected function init():void
        {

        }

        final public function addPanel(panel:MovieClip):void
        {
            if (_panel != null)
                return
            _panel = panel;
            addChild(_panel);
            added();
        }

        protected function added():void
        {

        }

        public function startup():void
        {

        }

        public function stopup():void
        {

        }

        final public function get panel():MovieClip
        {
            return _panel;
        }
    }
}
