package ca.georgebrown.trainingtutor.components.sections
{
	import ca.georgebrown.trainingtutor.events.CustomSectionEvent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	
	[Event (name="replay", type="ca.georgebrown.trainingtutor.events.CustomSectionEvent")]
	[Event (name="nextSection", type="ca.georgebrown.trainingtutor.events.CustomSectionEvent")]
	[Event (name="goHome", type="ca.georgebrown.trainingtutor.events.CustomSectionEvent")]
	
	public class CustomSection extends EventDispatcher
	{
		protected static const ANIM_COMPLETE:String = "animComplete";
		private var _actionBtn:SimpleMovieClipButton;
		private var _replayBtn:SimpleMovieClipButton;
		private var _view:MovieClip;
		
		public function CustomSection( view:MovieClip )
		{
			_view = view;
			_view.addEventListener( ANIM_COMPLETE, onAnimComplete );
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
		
		public function showActionButtons() : void
		{
			buildInButton( _actionBtn );
			buildInButton( _replayBtn );
		}
		
		protected function onAnimComplete( e:Event ) : void
		{
			showActionButtons();	
		}
		
		protected function onAction( e:MouseEvent ) : void
		{
			dispatchEvent( new CustomSectionEvent( CustomSectionEvent.NEXT_SECTION ) );
		}
		
		private function onVideoReplay( e:MouseEvent ) : void
		{
			dispatchEvent( new CustomSectionEvent( CustomSectionEvent.REPLAY ) );
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