package com.ghostmonk.ui.graveyard.buttons 
{	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/** 
	 * @author ghostmonk
	 */
	public class SimpleMovieClipButton extends AbstractButton 
	{	
		public function SimpleMovieClipButton( view:MovieClip, mouseClickCall:Function ) 
		{
			view.stop();
			super( view, mouseClickCall );
		}
		
		public function get view():MovieClip 
		{ 	
			return _view as MovieClip; 
		}
		
		override protected function onRollover( e:MouseEvent ):void	
		{	
			Tweener.addTween( view, { _frame:view.totalFrames, time:0.2, transition:Equations.easeNone } );	
		}
		
		override protected function onRollout( e:MouseEvent ):void
		{
			Tweener.addTween( view, { _frame:0, time:0.2, transition:Equations.easeNone } );	
		}
	}
}