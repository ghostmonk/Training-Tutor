package com.ghostmonk.media.video {
    
    import com.ghostmonk.media.video.events.CustomNetStreamEvent;
    
    import flash.events.NetStatusEvent;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    
    [Event ( name="status", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="seekNotify", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="seekFailed", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="unPause", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="pause", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="transition", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="fileStructureInvalid", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="noSupportedTrackFound", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="inSufficientBw", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    
    [Event ( name="unpublishNotify", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="publishNotify", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    
    [Event ( name="reset", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="streamNotFound", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="playFailed", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="playStop", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="playStart", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="failed", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    
    [Event ( name="bufferFlush", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="bufferFull", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    [Event ( name="bufferEmpty", type="com.ghostmonk.media.video.events.CustomNetStreamEvent" )]
    
    /**
     * 
     * @author nhillier - 2009-07-29
     * 
     */
    public class CustomNetStream extends NetStream {
        
        
        
        public function CustomNetStream( connection:NetConnection ) {
            
            super( connection );
            
            addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
            
        }
        
        
        
        private function onNetStatus( e:NetStatusEvent ) : void {
            
            switch( e.info.code ) {
                
                case CustomNetStreamEvent.SEEK_NOTIFY:
                case CustomNetStreamEvent.SEEK_FAILED:
                case CustomNetStreamEvent.UNPAUSE:
                case CustomNetStreamEvent.PAUSE:        
                case CustomNetStreamEvent.TRANSITION:
                case CustomNetStreamEvent.FILE_STRUCTURE_INVALID:
                case CustomNetStreamEvent.NO_SUPPORTED_TRACK_FOUND:
                case CustomNetStreamEvent.INSUFFICIENT_BW:
                case CustomNetStreamEvent.UNPUBLISH_NOTIFY:
                case CustomNetStreamEvent.PUBLISH_NOTIFY:
                case CustomNetStreamEvent.RESET:
                case CustomNetStreamEvent.STREAM_NOT_FOUND:
                case CustomNetStreamEvent.PLAY_FAILED:
                case CustomNetStreamEvent.PLAY_STOP:
                case CustomNetStreamEvent.PLAY_START:
                case CustomNetStreamEvent.FAILED:
                case CustomNetStreamEvent.BUFFER_FLUSH:
                case CustomNetStreamEvent.BUFFER_EMPTY:
                case CustomNetStreamEvent.BUFFER_FULL:
                case CustomNetStreamEvent.SEEK_INVALID_TIME:
                    dispatchEvent( new CustomNetStreamEvent( e.info.code, e.info ) );
                    break
                    
                default:
                   throw new Error( e.info.code + " : not supported in CustomNetStream" );     
                
            }
            
            
            dispatchEvent( new CustomNetStreamEvent( CustomNetStreamEvent.STATUS, e.info ) );
            
        }
        
        
        
    }
}