package ca.georgebrown.trainingtutor.components
{
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	
	import flash.events.MouseEvent;
	
	import uiAssets.SectionNavigationAsset;

	public class SectionNavigation extends SectionNavigationAsset
	{
		private var _continue:SimpleMovieClipButton;
		private var _replay:SimpleMovieClipButton;
		
		public function SectionNavigation()
		{
			_continue = new SimpleMovieClipButton( continueBtn, onContinue );
			_replay = new SimpleMovieClipButton( replayBtn, onReplay );
			alpha = 0;
			disable();
		}
		
		public function enable() : void
		{
			_continue.enable();
			_replay.enable();
		}
		
		public function disable() : void
		{
			_continue.disable();
			_replay.disable();
		}
		
		public function buildIn() : void
		{
			disable();
			Tweener.addTween( this, { alpha:1, time:0.4, delay:0.3, transition:Equations.easeNone, onComplete:enable } );
		}
		
		public function buildOut() : void
		{
			disable();
			Tweener.addTween( this, { alpha:0, time:0.4, transition:Equations.easeNone } );
		}
		
		public function set showContinue( value:Boolean ) : void
		{
			if( value )
			{
				_continue.enable();
				continueBtn.visible = true;
			}
			else
			{
				_continue.disable();
				continueBtn.visible = false;
			}
		}
		
		public function set showReplay( value:Boolean ) : void
		{
			if( value )
			{
				_replay.enable();
				replayBtn.visible = true;
				continueBtn.x = replayBtn.width + 5; 
			}
			else
			{
				_replay.disable();
				replayBtn.visible = false;
				continueBtn.x = 0;
			}
		}
		
		public function set yPos( value:Number ) : void 
		{
			Tweener.addTween( this, { y:value, time:0.3 } );
		}
		
		private function onContinue( e:MouseEvent ) : void 
		{
			dispatchEvent( new NavigationEvent( NavigationEvent.NEXT_SECTION, -1 ) );
		}
		
		private function onReplay( e:MouseEvent ) : void
		{
			dispatchEvent( new NavigationEvent( NavigationEvent.REPLAY_VIDEO, -1 ) );
		}
	}
}