package com.ghostmonk.media.video.events 
{
    import com.ghostmonk.media.video.data.CuePoint;
    
    import flash.events.Event;

    public class CuePointEvent extends Event 
    {    
        public static const ON_CUE_POINT:String = "onCuePoint";
        
        private var _cuepointData:CuePoint;
     
        public function CuePointEvent( type:String, cuePointData:CuePoint, bubbles:Boolean = false, cancelable:Boolean = false ) 
        {    
            _cuepointData = cuePointData;
            super( type, bubbles, cancelable );   
        }
        
        public function get cuePointData() : CuePoint 
        {    
            return _cuepointData;   
        }
        
        override public function clone() : Event 
        {    
            return new CuePointEvent( type, cuePointData, bubbles, cancelable );    
        }
    }
}