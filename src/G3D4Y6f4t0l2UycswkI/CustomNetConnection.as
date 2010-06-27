package G3D4Y6f4t0l2UycswkI {
    
    
    import flash.events.NetStatusEvent;
    import flash.net.NetConnection;
    
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