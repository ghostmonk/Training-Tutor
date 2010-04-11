package ca.georgebrown.trainingtutor.framework.view
{
	import ca.georgebrown.trainingtutor.components.footer.NavigationBar;
	import ca.georgebrown.trainingtutor.events.footer.NavigationEvent;
	
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class NavigationMediator extends Mediator
	{
		public static const NAME:String = "NavigationMediator";
		
		public function NavigationMediator( navBar:NavigationBar )
		{
			super( NAME, navBar );
			navBar.addEventListener( NavigationEvent.SECTION_NAVIGATION, onNavigation );
		}
		
		public function get navBar() : NavigationBar
		{
			return viewComponent as NavigationBar;
		}
		
		private function onNavigation( e:NavigationEvent ) : void
		{
			sendNotification( e.type, e.index );
		}
	}
}