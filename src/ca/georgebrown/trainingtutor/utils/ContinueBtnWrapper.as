package ca.georgebrown.trainingtutor.utils
{
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ContinueBtnWrapper
	{
		private var _callBack:Function;
		private var _continueBtn:SimpleMovieClipButton;
		
		public function ContinueBtnWrapper( view:MovieClip, callback:Function )
		{
			view.alpha = 0;
			view.visible = false;
			_callBack = callback;
			_continueBtn = new SimpleMovieClipButton( view, onContinue );
			_continueBtn.disable();
		}
		
		public function show() : void
		{
			_continueBtn.view.visible = true;
			Tweener.addTween( _continueBtn.view, { alpha:1, time:0.3, transition:Equations.easeNone, onComplete:_continueBtn.enable } );
		}
		
		private function onContinue( e:MouseEvent ) : void
		{
			_callBack();
		}

	}
}