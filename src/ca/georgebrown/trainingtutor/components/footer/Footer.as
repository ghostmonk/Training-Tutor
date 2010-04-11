package ca.georgebrown.trainingtutor.components.footer 
{	
	import bottomBar.FooterAsset;
	
	import ca.georgebrown.trainingtutor.events.footer.NavigationEvent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.events.Event;

	[Event (name="navigationClick", type="ca.georgebrown.trainingtutor.events.footer.NavigationEvent")]
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class Footer extends FooterAsset 
	{
		private var _navigation:Navigation;
		
		public function Footer() 
		{	
			_navigation = new Navigation( sectionNavigation );
			_navigation.addEventListener( NavigationEvent.SECTION_NAVIGATION, onNavigation );
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
		
		public function set sectionLabels( value:Array ) : void 
		{		
			_navigation.sectionLabels = value;	
		}
		
		public function set sectionIndex( index:int ) : void 
		{	
			_navigation.sectionIndex = index;
			_navigation.sectionAccess( index );	
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
		
		private function onNavigation( e:NavigationEvent ) : void 
		{	
			dispatchEvent( e );	
		}
		
	}
}