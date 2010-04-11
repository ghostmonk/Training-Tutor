package ca.georgebrown.trainingtutor.components 
{	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	
	import header.HeaderAsset;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public final class Header extends HeaderAsset 
	{	
		public function Header() 
		{	
			alpha = 0;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );					
		}
		
		public function set title( value:String ) : void 
		{	
			titleField.text = value;	
		}
		
		public function buildIn() : void 
		{	
			Tweener.addTween( this, { alpha:1, time:0.3, delay:0.4, transition:Equations.easeNone } );
			Tweener.addTween( this, { y:0, delay:0.4, time:0.3} );	
		}
		
		public function buildOut() : void 
		{	
			Tweener.addTween( this, { alpha:0, time:0.3, transition:Equations.easeNone } );
			Tweener.addTween( this, { y:-height, time:0.3, onComplete:onBuildOutComplete } );	
		}
		
		private function onAddedToStage( e:Event ) : void 
		{		
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			y = -height;	
		}
		
		private function onBuildOutComplete() : void 
		{	
			if( parent ) {
				parent.removeChild( this );
			}	
		}	
	}
}