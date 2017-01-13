/**
 * Created by zear19st on 2017/1/4.
 */
package lynd.components
{
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.NetStatusEvent;
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;

    import lynd.components.base.Component;
    import lynd.components.base.ComponentState;
    import lynd.components.base.IComponentState;

    public class VideoComponent extends Component
    {
        static public const STREAM_NOT_FOUND:String = "NetStream.Play.StreamNotFound";
        static public const STOP:String = "NetStream.Play.Stop";
        static public const START:String = "NetStream.Play.Start";
        static public const PAUSE:String = "NetStream.Pause.Notify";
        static public const RESUME:String = "NetStream.Unpause.Notify";

        private var _netConnect:NetConnection;
        private var _netStream:NetStream;

        public var onMetaData:Function;

        public function VideoComponent(onMetaData:Function, screen:DisplayObjectContainer, root:DisplayObjectContainer)
        {
            this.onMetaData = onMetaData;
            super(new Video(), screen, root);
        }

        public function get video():Video
        {
            return _view;
        }


        override protected function init():void
        {
            video.smoothing = true;
            _netConnect = new NetConnection();
            _netConnect.connect(null);
            _netStream = new NetStream(_netConnect);
            _netStream.client = this;
            video.attachNetStream(_netStream);
        }

        override protected function addState(state:IComponentState):void
        {
            state.registState(STREAM_NOT_FOUND, streamNotFoundState);
            state.registState(STOP, stopState);
            state.registState(START, startState);
            state.registState(PAUSE, pauseState);
            state.registState(RESUME, resumeState);
        }

        private function resumeState():void
        {
            dispatchEvent(new Event(RESUME));
        }

        private function pauseState():void
        {
            dispatchEvent(new Event(PAUSE));
        }

        private function startState():void
        {
            dispatchEvent(new Event(START));
        }


        private function stopState():void
        {
            dispatchEvent(new Event(STOP));
        }

        private function streamNotFoundState():void
        {
            dispatchEvent(new Event(STREAM_NOT_FOUND));
        }

        override protected function added():void
        {

        }

        override protected function addEvent():void
        {
            _netStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
        }

        private function onNetStatus(event:NetStatusEvent):void
        {
//            trace("onNetStatus", event.info.code);
//            _root.root["debug"].pushMsg("onNetStatus:" + event.info.code);

            var ns:NetStream = event.currentTarget as NetStream;
            state = event.info.code;
        }

        override protected function removeState(state:IComponentState):void
        {
            super.removeState(state);
        }

        override protected function removed():void
        {

        }

        override protected function removeEvent():void
        {
            _netStream.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
        }

        public function netStatus(item:Object):void
        {

        }


        public function onPlayStatus(item:Object):void
        {

        }

        public function play(url:String):void
        {
            video.clear();
            _netStream.play(url);
        }

        public function close():void
        {
            video.clear();
            _netStream.close();
            state = STOP;
        }

        public function togglePause():void
        {
            _netStream.togglePause();
        }

        public function pause():void
        {
            _netStream.pause();
        }

        public function resume():void
        {
            _netStream.resume();
        }

    }
}
