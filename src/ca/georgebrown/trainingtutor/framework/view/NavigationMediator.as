package ca.georgebrown.trainingtutor.framework.view
{
	import ca.georgebrown.trainingtutor.components.coreParts.NavigationBar;
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	import ca.georgebrown.trainingtutor.events.SequenceEvent;
	import ca.georgebrown.trainingtutor.framework.model.LocalDataProxy;
	
	import flash.geom.Point;
	
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
			return [ 
				NavigationEvent.NEXT_SECTION,
				SequenceEvent.NEW_SUB_SEQUENCE,
				NavigationEvent.SECTION_NAVIGATION ]
		}
		
		override public function handleNotification( note:INotification ) : void
		{
			switch( note.getName() )
			{
				case NavigationEvent.SECTION_NAVIGATION:
				case NavigationEvent.NEXT_SECTION:
					nextSection( note.getBody() as int );
					break;
				case SequenceEvent.NEW_SUB_SEQUENCE:
					view.sequenceCode = note.getBody() as Point;
					break;
			}
		}
		
		private function nextSection( value:int ) : void
		{
			view.sectionIndex = value;
			LocalDataProxy.updateSection( value );
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