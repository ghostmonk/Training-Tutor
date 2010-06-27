package com.ghostmonk.media.video.events {
    
    import flash.events.Event;

    public class ClientDataEvent extends Event {
        
        
        
        public static var CLIENT_RESPONSE:String = "clientResponse";
        
        private var _data:Object;
        private var _statusInfo:String;
        
        
        
        public function ClientDataEvent( type:String, statusInfo:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false ) {
            
            _data = data;
            _statusInfo = statusInfo;
            super( type, bubbles, cancelable );
            
        }
        
        
        
        public function get statusInfo() : String {
            
            return _statusInfo;
            
        }
        
        
        
        public function get data() : Object {
            
            return _data;
            
        }
        
        
        
        override public function clone() : Event {
            
            return new ClientDataEvent( type, statusInfo, data, bubbles, cancelable ); 
            
        }
        
        
        
    }
}