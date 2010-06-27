package com.ghostmonk.media.video 
{	
	import com.ghostmonk.events.PercentageEvent;
	import com.ghostmonk.media.video.events.ClientDataEvent;
	import com.ghostmonk.media.video.events.CuePointEvent;
	import com.ghostmonk.media.video.events.CustomNetConnectionEvent;
	import com.ghostmonk.media.video.events.CustomNetStreamEvent;
	import com.ghostmonk.media.video.events.ImageDataEvent;
	import com.ghostmonk.media.video.events.MetaInfoEvent;
	import com.ghostmonk.media.video.events.PlayStatusEvent;
	import com.ghostmonk.media.video.events.TextDataEvent;
	import com.ghostmonk.media.video.events.XMPDataEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Video;
	
	[Event (name="status", type="com.ghostmonk.media.video.events.CustomNetStreamEvent")]
    [Event (name="status", type="com.ghostmonk.media.video.events.CustomNetConnectionEvent")]
    [Event (name="clientResponse", type="com.ghostmonk.media.video.events.ClientDataEvent")]
    [Event (name="onCuePoint", type="com.ghostmonk.media.video.events.CuePointEvent")]
    [Event (name="onImageData", type="com.ghostmonk.media.video.events.ImageDataEvent")]
    [Event (name="onMetaData", type="com.ghostmonk.media.video.events.MetaInfoEvent")]
    [Event (name="onTextData", type="com.ghostmonk.media.video.events.TextDataEvent")]
    [Event (name="onXmpData", type="com.ghostmonk.media.video.events.XMPDataEvent")]
    [Event (name="onPlayStatus", type="com.ghostmonk.media.video.events.PlayStatusEvent")]
    [Event (name="loadChange", type="com.ghostmonk.events.PercentageEvent")]
	
	/**
  	 * Use this for loading and playing back video, most functionality for control and feed-back is available through public methods
  	 * <p>Handles set up for stream, connection and video objects, as well as MetaData feedback
  	 *   
	 * @author ghostmonk 18/11/2008
	 * 
	 */
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
		
		/**
		 * 
		 * @param smoothing set the smoothing property on the scalable video
		 * @param errorFunction function to call if there is an error on the stream... expects an IOErrorEvent
		 * 
		 */
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
		
		/**
		 * current playback time on the video stream
		 * 
		 * @return 
		 * 
		 */
		public function get time() : Number 
		{
			if( !_stream ) return 0;
			return _stream.time;	
		}
		
		/**
		 * current playback time as a percent
		 * 
		 * @return 
		 * 
		 */
		public function get timeAsPercent() : Number 
		{
			if( !_stream ) return 0;
			return _stream.time / _duration;			 
		}
		
		/**
		 * locates the time in the video by a percentage of the entire duration of the video
		 * 
		 * @param percent
		 * 
		 */
		public function set timeAsPercent( percent:Number ) : void 
		{	
			seek( percent*_duration );	
		} 
		
		/**
		 * the complete duration of the video in seconds 
		 * 
		 * @return 
		 * 
		 */
		public function get duration() : Number 
		{	
			return _duration;	
		}
		
		/**
		 * returns percentage of video loaded
		 * 
		 * @return 
		 * 
		 */
		public function get percentLoaded() : Number 
		{	
			if( !_stream ) return 0;
			return Math.max( 0, _stream.bytesLoaded / _stream.bytesTotal );	
		}
		
		/**
		 * set the width and height of the video object.
		 * 
		 * @param width
		 * @param height
		 * 
		 */
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
		
		/**
		 * To load in a new video asset, due to a bug in the Video.clear() method, a new video object is created each time this function is called
		 * 
		 * @param url net location of the flv
		 * @param autoPlay set it true if you want to video to automatically start playing back
		 * @param getLoadUpdates set to true if you want to listen for loading updates
		 * 
		 */
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
		
		/**
		 * close the stream and clean up the event listener
		 * 
		 */
		public function close() : void 
		{	
			_video.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			_stream.close();	
		}
		
		/**
		 * call resume on the stream
		 * 
		 */
		public function play() : void 
		{	
			_stream.resume();	
		}
		
		/**
		 * Pause the stream
		 * 
		 */
		public function pause() : void 
		{	
			_stream.pause();	
		}
		
		/**
		 * Toggles play back, pause or resume, based on what is currently happening 
		 * 
		 */
		public function togglePlayback() : void 
		{	
			_stream.togglePause();		
		}
		
		/**
		 * Jump to the location in seconds... always hit the closest keyframe
		 * 
		 * @param time
		 * 
		 */
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