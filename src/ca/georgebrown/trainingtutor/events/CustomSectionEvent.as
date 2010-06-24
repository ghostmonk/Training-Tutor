package ca.georgebrown.trainingtutor.events
{
	import flash.events.Event;

	public class CustomSectionEvent extends Event
	{
		public static const REPLAY:String = "CustomSectionReplayVideo";
		public static const NEXT_SECTION:String = "CustomSectionNextSection"; 
		public static const GO_HOME:String = "goHome";
		
		public function CustomSectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}