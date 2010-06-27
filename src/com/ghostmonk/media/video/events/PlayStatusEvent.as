package com.ghostmonk.media.video.events {
    
    import flash.events.Event;

    
    public class PlayStatusEvent extends Event {
        
        
        
        public static const ON_PLAY_STATUS:String = "onPlayStatus";
        
        private var _playStatusData:Object;
        
        
        
        public function PlayStatusEvent( type:String, playStatusData:Object, bubbles:Boolean = false, cancelable:Boolean = false ) {
            
            _playStatusData = playStatusData;
            super( type, bubbles, cancelable );
            
        }
        
        
        
        public function get playStatusData() : Object {
            
            return _playStatusData;
            
        }
        
        
        
        override public function clone() : Event {
            
            return new PlayStatusEvent( type, playStatusData, bubbles, cancelable ); 
            
        }
        
        
        
    }
}