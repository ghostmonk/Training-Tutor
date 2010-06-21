package ca.georgebrown.trainingtutor.components.sections
{
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	import ca.georgebrown.trainingtutor.events.VideoPlayerEvent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	[Event (name="nextSection", type="ca.georgebrown.trainingtutor.events.NavigationEvent")]
	[Event (name="replayVideo", type="ca.georgebrown.trainingtutor.events.VideoPlayerEvent")]
	
	public class CustomSection extends EventDispatcher
	{
		protected static const ANIM_COMPLETE:String = "animComplete";
		private var _actionBtn:SimpleMovieClipButton;
		private var _replayBtn:SimpleMovieClipButton;
		private var _view:MovieClip;
		
		public function CustomSection( view:MovieClip )
		{
			_view = view;
			_actionBtn = createSimpleButton( view.actionBtn, onAction );
			_replayBtn = createSimpleButton( view.videoReplayBtn, onVideoReplay );
		}
		
		public function get view() : MovieClip
		{
			return _view;
		}
		
		public function buildOut() : void
		{
			Tweener.addTween( _view, {alpha:0, time:0.2, transition:Equations.easeNone, 
				onComplete: function() : void
				{
					if( _view.parent ) _view.parent.removeChild( _view );
				} 
			} );
		}
		
		protected function contentBuildInComplete() : void
		{
			buildInButton( _actionBtn );
			buildInButton( _replayBtn );
		}
		
		protected function onAction( e:MouseEvent ) : void
		{
			dispatchEvent( new NavigationEvent( NavigationEvent.NEXT_SECTION, -1 ) );
		}
		
		private function onVideoReplay( e:MouseEvent ) : void
		{
			dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.REPLAY_VIDEO ) );
		}
		
		private function buildInButton( btn:SimpleMovieClipButton ) : void
		{
			if( !btn ) return;
			btn.view.visible = true;
			Tweener.addTween( btn.view, { alpha:1, time:0.3, transition:Equations.easeNone, onComplete:btn.enable } );
		}
		
		private function createSimpleButton( view:MovieClip, callback:Function ) : SimpleMovieClipButton
		{
			if( !view ) return null;
			var output:SimpleMovieClipButton = new SimpleMovieClipButton( view, onAction );
			output.view.alpha = 0;
			output.view.visible = false;
			output.disable();
			return output;
		}
	}
}