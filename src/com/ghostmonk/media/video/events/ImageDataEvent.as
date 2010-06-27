package com.ghostmonk.media.video.events {
    
    import flash.events.Event;
    
    public class ImageDataEvent extends Event {
        
        
        
        public static const ON_IMAGE_DATA:String = "onImageData";
        
        private var _imageData:Object;
        
        
        
        public function ImageDataEvent( type:String, imageData:Object, bubbles:Boolean = false, cancelable:Boolean = false ) {
            
            _imageData = imageData;
            super(type, bubbles, cancelable);
            
        }
        
        
        
        public function get imageData() : Object {
            
            return _imageData;
            
        }
        
        
        
        override public function clone() : Event {
            
            return new ImageDataEvent( type, bubbles, cancelable ); 
            
        }
        
        
        
    }
}