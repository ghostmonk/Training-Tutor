package com.ghostmonk.media.video.events {
    
    import flash.events.Event;
    
    
    public class XMPDataEvent extends Event {
        
        
        
        public static const ON_XMP_DATA:String = "onXmpData";
        
        private var _xmpData:Object;
        
        
        
        public function XMPDataEvent( type:String, xmpData:Object, bubbles:Boolean = false, cancelable:Boolean = false ) {
            
            _xmpData = xmpData;
            super( type, bubbles, cancelable );
            
        }
        
        
        
        public function get xmpData() : Object {
            
            return _xmpData;
            
        }
        
        
        
        override public function clone() : Event {
            
            return new XMPDataEvent( type, xmpData, bubbles, cancelable ); 
            
        }
        
        
        
    }
}