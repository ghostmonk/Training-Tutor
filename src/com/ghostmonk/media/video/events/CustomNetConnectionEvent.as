package com.ghostmonk.media.video.events {
    
    import flash.events.Event;

    public class CustomNetConnectionEvent extends Event {
        
        
        
        public static const STATUS:String = "netConnectionStatus";
        public static const INVALID_APP:String = "NetConnection.Connect.InvalidApp";
        public static const APP_SHUTDOWN:String = "NetConnection.Connect.AppShutdown"
        public static const REJECTED:String = "NetConnection.Connect.Rejected"
        public static const SUCCESS:String = "NetConnection.Connect.Success"
        public static const FAILED:String = "NetConnection.Connect.Failed"
        public static const CLOSED:String = "NetConnection.Connect.Closed"
        
        private var _info:Object;
        
        
        
        public function CustomNetConnectionEvent( type:String, info:Object, bubbles:Boolean=false, cancelable:Boolean=false ) {
            
            _info = info;
            super(type, bubbles, cancelable);
            
        }
        
        
        
        public function get info() : Object {
            
            return _info;
            
        }
        
        
        
        override public function clone() : Event {
            
            return new CustomNetConnectionEvent( type, info, bubbles, cancelable );
            
        } 
        
        
        
    }
}