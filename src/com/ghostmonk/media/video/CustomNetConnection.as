package com.ghostmonk.media.video {
    
    import com.ghostmonk.media.video.events.CustomNetConnectionEvent;
    
    import flash.events.NetStatusEvent;
    import flash.net.NetConnection;
    
    [Event ( name="status", type="com.ghostmonk.media.video.events.CustomNetConnectionEvent" )]
    [Event ( name="invalidApp", type="com.ghostmonk.media.video.events.CustomNetConnectionEvent" )]
    [Event ( name="appShutdown", type="com.ghostmonk.media.video.events.CustomNetConnectionEvent" )]
    [Event ( name="rejected", type="com.ghostmonk.media.video.events.CustomNetConnectionEvent" )]
    [Event ( name="success", type="com.ghostmonk.media.video.events.CustomNetConnectionEvent" )]
    [Event ( name="failed", type="com.ghostmonk.media.video.events.CustomNetConnectionEvent" )]
    [Event ( name="closed", type="com.ghostmonk.media.video.events.CustomNetConnectionEvent" )]
    
    /**
     * 
     * @author nhillier - 2009-07-29
     * 
     */
    public class CustomNetConnection extends NetConnection {
        
        public function CustomNetConnection() {
            
            addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
            
        }
        
        
        
        private function onNetStatus( e:NetStatusEvent ) : void {
            
            switch( e.info.code ) {
                
                case CustomNetConnectionEvent.APP_SHUTDOWN:
                case CustomNetConnectionEvent.CLOSED:
                case CustomNetConnectionEvent.FAILED:
                case CustomNetConnectionEvent.INVALID_APP:
                case CustomNetConnectionEvent.REJECTED:
                case CustomNetConnectionEvent.SUCCESS:
                    dispatchEvent( new CustomNetConnectionEvent( e.info.code, e.info ) );
                    break
                    
                default:
                   throw new Error( e.info.code + " : not supported in CustomNetConnection" );     
                
            }
            
            dispatchEvent( new CustomNetConnectionEvent( CustomNetConnectionEvent.STATUS, e.info ) );
            
        }
        
    }
}