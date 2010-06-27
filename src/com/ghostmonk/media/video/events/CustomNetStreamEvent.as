package com.ghostmonk.media.video.events {
    
    import flash.events.Event;

    public class CustomNetStreamEvent extends Event {
        
        
        
        public static const STATUS:String = "netStreamStatus";
        public static const SEEK_NOTIFY:String = "NetStream.Seek.Notify";
        public static const SEEK_FAILED:String = "NetStream.Seek.Failed";
        public static const SEEK_INVALID_TIME:String = "NetStream.Seek.InvalidTime";
        
        public static const UNPAUSE:String = "NetStream.Unpause.Notify";
        public static const PAUSE:String = "NetStream.Pause.Notify";
        
        public static const TRANSITION:String = "NetStream.Play.Transition";
        public static const FILE_STRUCTURE_INVALID:String = "NetStream.Play.FileStructureInvalid";
        public static const NO_SUPPORTED_TRACK_FOUND:String = "NetStream.Play.NoSupportedTrackFound";
        public static const INSUFFICIENT_BW:String = "NetStream.Play.InsufficientBW";
        public static const UNPUBLISH_NOTIFY:String = "NetStream.Play.UnpublishNotify";
        public static const PUBLISH_NOTIFY:String = "NetStream.Play.PublishNotify";
        public static const RESET:String = "NetStream.Play.Reset";
        public static const STREAM_NOT_FOUND:String = "NetStream.Play.StreamNotFound";
        public static const PLAY_FAILED:String = "NetStream.Play.Failed";
        public static const PLAY_STOP:String = "NetStream.Play.Stop";
        public static const PLAY_START:String = "NetStream.Play.Start";
        
        public static const FAILED:String = "NetStream.Failed"; 
        public static const BUFFER_FLUSH:String = "NetStream.Buffer.Flush";
        public static const BUFFER_FULL:String = "NetStream.Buffer.Full";
        public static const BUFFER_EMPTY:String = "NetStream.Buffer.Empty";
        
        private var _info:Object;
        
        
        
        public function CustomNetStreamEvent( type:String, info:Object, bubbles:Boolean=false, cancelable:Boolean=false ) {
            
            _info = info;
            super( type, bubbles, cancelable );
            
        }
        
        
        
        public function get info() : Object {
            
            return _info;
            
        }
        
        
        
        override public function clone() : Event {
            
            return new CustomNetStreamEvent( type, info, bubbles, cancelable );
            
        } 
        
    }
}