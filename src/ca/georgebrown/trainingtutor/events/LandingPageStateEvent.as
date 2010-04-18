package ca.georgebrown.trainingtutor.events 
{	
	import flash.events.Event;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class LandingPageStateEvent extends Event 
	{	
		public static const BUILD_OUT_COMPLETE:String = "buildOutComplete";
		
		public function LandingPageStateEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
		{	
			super( type, bubbles, cancelable );	
		}
		
		override public function clone() : Event 
		{	
			return new LandingPageStateEvent( type, bubbles, cancelable );	
		}
	}
}