package ca.georgebrown.trainingtutor.components.stage 
{	
	import bottomBar.FooterAsset;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.events.Event;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class Footer extends FooterAsset 
	{
		public function Footer() 
		{	
			alpha = 0;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );	
		}
		
		public function buildIn() : void 
		{	
			Tweener.addTween( this, { alpha:1, delay:0.4, time:0.3, transition:Equations.easeNone } );
			Tweener.addTween( this, { y:stage.stageHeight - this.height, delay:0.4, time:0.3} );	
		}
		
		public function buildOut() : void 
		{	
			Tweener.addTween( this, { alpha:0, time:0.3, transition:Equations.easeNone } );
			Tweener.addTween( this, { y:stage.stageHeight, time:0.3, onComplete:onBuildOutComplete } );	
		}
		
		private function onBuildOutComplete() : void 
		{	
			if( parent ) 
			{
				parent.removeChild( this );
			}
		}
		
		private function onAddedToStage( e:Event ) : void 
		{	
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			y = stage.stageHeight;	
		}
	}
}