package com.ghostmonk.media.video.events {
    
    import flash.events.Event;
    
    
    public class TextDataEvent extends Event {
        
        
       	
        public static const ON_TEXT_DATA:String = "onTextData";
        
        private var _textData:Object;
        
        
        
        public function TextDataEvent( type:String, textData:Object, bubbles:Boolean = false, cancelable:Boolean = false ) {
            
            _textData = textData;
            super( type, bubbles, cancelable );
            
        }
        
        
        
        public function get textData() : Object {
            
            return _textData;
            
        }
        
        
        
        override public function clone() : Event {
            
            return new TextDataEvent( type, bubbles, cancelable ); 
            
        }
        
        
        
    }
}