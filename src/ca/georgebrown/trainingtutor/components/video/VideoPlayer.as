package ca.georgebrown.trainingtutor.components.video 
{	
	import assets.videoPlayer.VideoPlayerAsset;
	
	import ca.georgebrown.trainingtutor.components.SimpleView;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.events.PercentageEvent;
	import com.ghostmonk.media.video.CoreVideo;
	
	import flash.media.Video;

	/**
	 * 
	 * @author ghostmonk 21/08/2009
	 * 
	 */
	public class VideoPlayer extends SimpleView 
	{	
		private var _controls:VideoControlBar;
		private var _core:CoreVideo;
		private var _video:Video;
		private var _mainView:VideoPlayerAsset;
		
		public function VideoPlayer( core:CoreVideo, mainView:VideoPlayerAsset ) 
		{	
			_mainView = mainView;
			addChild( _mainView );
			alpha = 0;
			_core = core;
			_core.addEventListener( PercentageEvent.LOAD_CHANGE, onLoadProgress );
			createVideo();
			_controls = new VideoControlBar( _core, _mainView.controlBar );
		}
		
		override public function buildIn() : void 
		{	
			_video.alpha = 0;
			Tweener.addTween( this, { alpha:1, time:0.3, delay:0.3, transition:Equations.easeNone } );
			Tweener.addTween( _video, { alpha:1, time:0.3, delay:0.5, transition:Equations.easeNone } );	
		}
		
		override public function buildOut() : void 
		{	
			_controls.disable();
			_core.destroyCurrentStream();
			Tweener.addTween( this, { alpha:0, time:0.3, transition:Equations.easeNone, onComplete:onBuildOutComplete } );
			Tweener.addTween( _video, { alpha:0, time:0.1, transition:Equations.easeNone } );	
		}
		
		override public function loadAsset( id:String ) : void
		{
			_controls.setPlayHead( 0 );
			_core.load( id, createVideo(), false, true );
			_controls.enable();	
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
		}
		
		public function pause() : void 
		{	
			_core.pause();	
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
	}
}