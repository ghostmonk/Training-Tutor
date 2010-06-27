package G3D4Y6f4t0l2UycswkI 
{	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Video;
	
	public class CoreVideo extends EventDispatcher 
	{	
		private var _currentURL:String;
		private var _duration:Number;
		private var _bufferTime:Number;
		
		private var _video:Video;
		private var _stream:CustomNetStream;
		private var _connection:CustomNetConnection;
		
		private var _client:StreamClient;
		private var _autoPlay:Boolean;
		private var _getLoadUpdates:Boolean;
		
		private var _cuePointManager:CuePointManager;
		
		public function CoreVideo( ) 
		{	
			_client = new StreamClient();
			setClient();
			
			_duration = 0;
			_bufferTime = 0.1;
			_getLoadUpdates = false;
			_currentURL = "";	
		}
		
		public function set cuePointManager( value:CuePointManager ) : void
		{
			_cuePointManager = value;
		}
        
        public function get customNetStream() : CustomNetStream 
        {	
        	return _stream;	
        }
        
        public function get customNetConnection() : CustomNetConnection 
        {	
        	return _connection;	
        }
		
		public function set bufferTime( value:Number ) : void 
		{   
            _bufferTime = value;
               
            if( _stream ) 
            {
                _stream.bufferTime = _bufferTime;
            }
            
        }
        
        public function get bufferTime() : Number 
        {    
            return _bufferTime;   
        }
		
		public function get time() : Number 
		{
			if( !_stream ) return 0;
			return _stream.time;	
		}
		
		public function get timeAsPercent() : Number 
		{
			if( !_stream ) return 0;
			return _stream.time / _duration;			 
		}
		
		public function set timeAsPercent( percent:Number ) : void 
		{	
			seek( percent*_duration );	
		} 
		
		public function get duration() : Number 
		{	
			return _duration;	
		}
		
		public function get percentLoaded() : Number 
		{	
			if( !_stream ) return 0;
			return Math.max( 0, _stream.bytesLoaded / _stream.bytesTotal );	
		}
		
		public function setSize( width:Number, height:Number ) : void 
		{	
			if( !_video ) return;
			_video.width = width;
			_video.height = height;	
		}
        
        public function setClient() : void 
        {    
            _client.addEventListener( ClientDataEvent.CLIENT_RESPONSE, onClientData );
            _client.addEventListener( ImageDataEvent.ON_IMAGE_DATA, onClientData );
            _client.addEventListener( MetaInfoEvent.META_INFO_READY, onClientData );
            _client.addEventListener( TextDataEvent.ON_TEXT_DATA, onClientData );
            _client.addEventListener( XMPDataEvent.ON_XMP_DATA, onClientData );
            _client.addEventListener( CuePointEvent.ON_CUE_POINT, onClientData );
            _client.addEventListener( PlayStatusEvent.ON_PLAY_STATUS, onClientData );   
        }
        
        public function destroyCurrentStream() : void 
        {    
            if ( _stream ) 
            {
                _stream.close();
                _stream = null;
            }
            
            if ( _connection ) 
            {
                _connection.close();
                _connection = null;
            }
        }
		
		public function load( url:String, video:Video, autoPlay:Boolean = true, getLoadUpdates:Boolean = false ) : void 
		{	
			_currentURL = url;
			
			if( _video ) 
			{
				_video.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				_video = null;			
			}
			
			_video = video;
			destroyCurrentStream();
			
			 _autoPlay = autoPlay;
            
            _connection = new CustomNetConnection();
            _connection.addEventListener( CustomNetConnectionEvent.STATUS, onNetConnectionStatus );
            _connection.addEventListener( CustomNetConnectionEvent.SUCCESS, onConnection );
            _connection.connect( null );
            
            _getLoadUpdates = getLoadUpdates;
            
            if( _getLoadUpdates ) 
            {
                onEnterFrame( null );
                _video.addEventListener( Event.ENTER_FRAME, onEnterFrame );
            }	
		}
		
		public function close() : void 
		{	
			_video.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			_stream.close();	
		}
		
		public function play() : void 
		{	
			_stream.resume();	
		}
		
		public function pause() : void 
		{	
			_stream.pause();	
		}
		
		public function togglePlayback() : void 
		{	
			_stream.togglePause();		
		}
		
		public function seek( time:Number ) : void 
		{	
			_stream.seek( time );	
		}
		
        public function fullStageMode( stage:Stage ) : void 
        {    
            scaleAndCenterCalc( stage.stageWidth, stage.stageHeight );   
        }
        
        public function scaleAndCenter( container:DisplayObjectContainer ) : void 		{
            scaleAndCenterCalc( container.width, container.height );
        }
        
        private function onConnection( e:CustomNetConnectionEvent ) : void 		{   
            _stream = new CustomNetStream( _connection );
            
            if( _cuePointManager ) _cuePointManager.stream = _stream;
            
            _stream.bufferTime = _bufferTime;
            _stream.addEventListener( CustomNetStreamEvent.STATUS, onNetStatus );
            
            _stream.client = _client;
            _stream.play( _currentURL );  
            
            _video.attachNetStream( _stream );         
                     
            if( !_autoPlay ) 
            {
                _stream.seek( 0 );
                _stream.pause();    
            }   
        }
        
        private function scaleAndCenterCalc( contWidth:Number, contHeight:Number ) : void 
        {    
            if( !_video ) return;
            
            var ratio:Number = Math.min( contWidth / _video.width, contHeight / _video.height );
            
            _video.width = _video.width * ratio;
            _video.height = _video.height * ratio;
             
            _video.x = Math.abs( ( _video.width - contWidth ) ) * 0.5;
            _video.y = Math.abs( ( _video.height - contHeight ) ) * 0.5;   
        }
		
		private function onNetStatus( e:CustomNetStreamEvent ) : void 
		{	
            dispatchEvent( e );            
		}
		
		private function onNetConnectionStatus( e:CustomNetConnectionEvent ) : void 
		{	
			dispatchEvent( e );	
		}
        
        private function onClientData( e:Event ) : void 
        {
            if( e.type == MetaInfoEvent.META_INFO_READY ) 
                _duration = ( e as MetaInfoEvent ).metaData.duration;
            
            dispatchEvent( e );
        }
		
		private function onEnterFrame( e:Event ) : void 
		{
			if( percentLoaded >= 1 )
				_video.removeEventListener( Event.ENTER_FRAME, onEnterFrame ); 
			
			dispatchEvent( new PercentageEvent( PercentageEvent.LOAD_CHANGE, percentLoaded ) );
		}
	}
}