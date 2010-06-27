package com.ghostmonk.media.video {
    
    import com.ghostmonk.media.video.data.VideoMetaData;
    import com.ghostmonk.media.video.events.ClientDataEvent;
    import com.ghostmonk.media.video.events.CuePointEvent;
    import com.ghostmonk.media.video.events.ImageDataEvent;
    import com.ghostmonk.media.video.events.MetaInfoEvent;
    import com.ghostmonk.media.video.events.PlayStatusEvent;
    import com.ghostmonk.media.video.events.TextDataEvent;
    import com.ghostmonk.media.video.events.XMPDataEvent;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    
    [Event (name="close", type="flash.events.Event")]
    [Event (name="clientResponse", type="com.stw.playercore.events.coreMediaPlayer.ClientDataEvent")]
    [Event (name="onCuePoint", type="com.stw.playercore.events.coreMediaPlayer.CuePointEvent")]
    [Event (name="onImageData", type="com.stw.playercore.events.coreMediaPlayer.ImageDataEvent")]
    [Event (name="onMetaData", type="com.stw.playercore.events.coreMediaPlayer.MetaDataEvent")]
    [Event (name="onTextData", type="com.stw.playercore.events.coreMediaPlayer.TextDataEvent")]
    [Event (name="onXmpData", type="com.stw.playercore.events.coreMediaPlayer.XMPDataEvent")]
    [Event (name="onPlayStatus", type="com.stw.playercore.events.coreMediaPlayer.PlayStatusEvent")]
    
    
    /**
     * 
     * @author nhillier - 2009-07-29
     * 
     */
    public class StreamClient extends EventDispatcher {
        
        
        
        public function onMetaData( data:Object ) : void {
            
            handleClientEvent( MetaInfoEvent, MetaInfoEvent.META_INFO_READY, data ); 
            
        }
        
        
        
        public function onCuePoint( data:Object ) : void {
            
            handleClientEvent( CuePointEvent, CuePointEvent.ON_CUE_POINT, data );
            
        }
        
        
        
        public function onImageData( data:Object ) : void {
            
            handleClientEvent( ImageDataEvent, ImageDataEvent.ON_IMAGE_DATA, data );
            
        }
        
        
        
        public function onTextData( data:Object ) : void {
            
            handleClientEvent( TextDataEvent, TextDataEvent.ON_TEXT_DATA, data );
            
        }
        
        
        
        public function onXMPData( data:Object ) : void {
            
            handleClientEvent( XMPDataEvent, XMPDataEvent.ON_XMP_DATA, data );
            
        }
        
        
        
        public function onPlayStatus( data:Object ) : void {
            
            handleClientEvent( PlayStatusEvent, PlayStatusEvent.ON_PLAY_STATUS, data );
            
        }
        
        
        
        public function close() : void {
            
            dispatchEvent( new Event( Event.CLOSE ) );    
          
        }
        
        
        
        public function handleClientEvent( eventClass:Class, eventType:String, data:Object ) : void {
            
            dispatchEvent( new eventClass( eventType, new VideoMetaData( data  ) ) );
            dispatchEvent( new ClientDataEvent( ClientDataEvent.CLIENT_RESPONSE, eventType, data ) );
            
        }
        


    }
}