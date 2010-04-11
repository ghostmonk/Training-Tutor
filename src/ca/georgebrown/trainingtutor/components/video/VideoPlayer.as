package ca.georgebrown.trainingtutor.components.video {
	
	import assets.videoPlayer.VideoPlayerAsset;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.events.PercentageEvent;
	import com.ghostmonk.media.video.CoreVideo;
	
	import flash.events.Event;

	/**
	 * 
	 * @author ghostmonk 21/08/2009
	 * 
	 */
	public class VideoPlayer extends VideoPlayerAsset {
		
		
		private var _controls:VideoControlBar;
		private var _core:CoreVideo;
		
		
		public function VideoPlayer( core:CoreVideo ) {
			
			alpha = 0;
			_core = core;
			holder.addChild( _core.video );
			_core.video.smoothing = true;
			_core.scaleAndCenter( holder );
			_core.addEventListener( PercentageEvent.LOAD_CHANGE, onLoadProgress );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			_controls = new VideoControlBar( _core, controlBar );		
			
		}
		
		
		
		public function buildIn() : void {
			
			_core.video.alpha = 0;
			Tweener.addTween( this, { alpha:1, time:0.3, delay:0.5, transition:Equations.easeNone } );
			Tweener.addTween( _core.video, { alpha:1, time:0.3, delay:0.7, transition:Equations.easeNone } );
			
		}
		
		
		
		public function buildOut() : void {
			
			_controls.disable();
			_core.destroyCurrentStream();
			Tweener.addTween( this, { alpha:0, time:0.3, transition:Equations.easeNone, onComplete:onBuildOutComplete } );
			Tweener.addTween( _core.video, { alpha:0, time:0.1, transition:Equations.easeNone } );
			
		}
		
		
		
		public function loadVideo( url:String ) : void {
			
			_controls.setPlayHead( 0 );
			_core.load( url, false, true );
			_controls.enable();		
			
		}
		
		
		
		public function play() : void {
			
			_core.play();
			
		}
		
		
		
		public function pause() : void {
			
			_core.pause();
			
		}
		
		
		
		public function disableContols() : void {
			
			_controls.disable();
			
		}
		
		
		
		public function enableControls() : void  {
			
			_controls.enable();	
			
		}
		
		
		
		private function onLoadProgress( e:PercentageEvent ) : void {
			
			_controls.updateLoad( e.percent );
			
		}
		
		
		
		private function onBuildOutComplete() : void {
			
			if( parent ) {
				parent.removeChild( this );
			}
			
		}
		
		
		
		private function onAddedToStage( e:Event ) : void {
			
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			x = 34;
			y = ( stage.stageHeight - height ) * 0.5;
			
		}
		
		
		
	}
}