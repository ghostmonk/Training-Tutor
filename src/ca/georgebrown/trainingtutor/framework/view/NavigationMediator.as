package ca.georgebrown.trainingtutor.framework.view
{
	import ca.georgebrown.trainingtutor.components.coreParts.NavigationBar;
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class NavigationMediator extends Mediator
	{
		public static const NAME:String = "NavigationMediator";
		
		public function NavigationMediator( navBar:NavigationBar )
		{
			super( NAME, navBar );
			navBar.addEventListener( NavigationEvent.SECTION_NAVIGATION, onNavigation );
		}
		
		public function get view() : NavigationBar
		{
			return viewComponent as NavigationBar;
		}
		
		override public function listNotificationInterests() : Array 
		{
			return [ NavigationEvent.NEXT_SECTION ]
		}
		
		override public function handleNotification( note:INotification ) : void
		{
			view.sectionIndex = note.getBody() as int;
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