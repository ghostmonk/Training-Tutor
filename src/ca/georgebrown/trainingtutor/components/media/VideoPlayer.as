package ca.georgebrown.trainingtutor.components.media 
{	
	import G3D4Y6f4t0l2UycswkI.CoreVideo;
	import G3D4Y6f4t0l2UycswkI.CuePointEvent;
	import G3D4Y6f4t0l2UycswkI.CuePointManager;
	import G3D4Y6f4t0l2UycswkI.CustomNetStreamEvent;
	import G3D4Y6f4t0l2UycswkI.PercentageEvent;
	
	import assets.videoPlayer.VideoPlayerAsset;
	
	import ca.georgebrown.trainingtutor.events.VideoPlayerEvent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.display.Sprite;
	import flash.media.Video;
	
	[Event(name="onCuePoint", type="com.ghostmonk.media.video.events.CuePointEvent")]
	[Event(name="videoComplete", type="ca.georgebrown.trainingtutor.events.VideoPlayerEvent")]

	/**
	 * 
	 * @author ghostmonk 21/08/2009
	 * 
	 */
	public class VideoPlayer extends Sprite 
	{	
		private var _controls:VideoControlBar;
		private var _core:CoreVideo;
		private var _video:Video;
		private var _mainView:VideoPlayerAsset;
		private var _cuePointManager:CuePointManager;
		
		public function VideoPlayer( core:CoreVideo, mainView:VideoPlayerAsset ) 
		{	
			_mainView = mainView;
			addChild( _mainView );
			alpha = 0;
			
			_cuePointManager = new CuePointManager();
			_cuePointManager.addEventListener(CuePointEvent.ON_CUE_POINT, onCuePoint);
			
			_core = core;
			_core.cuePointManager = _cuePointManager;
			_core.addEventListener( PercentageEvent.LOAD_CHANGE, onLoadProgress );
			_core.addEventListener( CustomNetStreamEvent.STATUS, onStreamStatus );		
			
			createVideo();
			
			_controls = new VideoControlBar( _core, _mainView.controlBar );
		}
		
		public function get cuePointManager() : CuePointManager
		{
			return _cuePointManager;
		}
		
		public function set cuePoints( value:Array ) : void
		{
			_cuePointManager.cuePointList = value;
			_cuePointManager.start();
		}
		
		public function buildIn() : void 
		{	
			_video.alpha = 0;
			Tweener.addTween( this, { alpha:1, time:0.3, delay:0.3, transition:Equations.easeNone } );
			Tweener.addTween( _video, { alpha:1, time:0.3, delay:0.5, transition:Equations.easeNone } );	
		}
		
		public function buildOut() : void 
		{	
			_cuePointManager.clearCuePoints();
			_cuePointManager.stop();
			_controls.disable();
			_core.destroyCurrentStream();
			Tweener.addTween( this, { alpha:0, time:0.3, transition:Equations.easeNone, onComplete:onBuildOutComplete } );
			Tweener.addTween( _video, { alpha:0, time:0.1, transition:Equations.easeNone } );	
		}
		
		public function loadAsset( url:String ) : void
		{
			_controls.setPlayHead( 0 );
			_core.load( url, createVideo(), true, true );
			_controls.enable();	
			_controls.play();
		}
		
		public function replay() : void
		{
			_controls.setPlayHead( 0 );
			_controls.enable();	
			_core.pause();
			_core.seek( 0 );
			_core.play();
		}
		
		public function play() : void 
		{	
			_core.play();
			_cuePointManager.start();
		}
		
		public function pause() : void 
		{	
			_core.pause();
			_cuePointManager.stop();	
		}
		
		public function disableContols() : void 
		{	
			_controls.disable();	
		}
		
		public function enableControls() : void  
		{		
			_controls.enable();		
		}
		
		private function createVideo() : Video 
		{
			if( _video && _video.parent ) _video.parent.removeChild( _video );
			_video = null;
			_video = new Video;
			_video.smoothing = true;
			_mainView.holder.addChild( _video );
			_video.width = _mainView.holder.width;
			_video.height = _mainView.holder.height;
			return _video;
		}
		
		private function onLoadProgress( e:PercentageEvent ) : void 
		{	
			_controls.updateLoad( e.percent );	
		}
		
		private function onBuildOutComplete() : void 
		{	
			if( parent ) parent.removeChild( this );
		}
		
		private function onCuePoint( e:CuePointEvent ) : void
		{
			dispatchEvent( e );
		}
		
		private function onStreamStatus( e:CustomNetStreamEvent ) : void
		{
			if( e.info.code == "NetStream.Play.Stop" )
				dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.VIDEO_COMPLETE ) );
		}
	}
}