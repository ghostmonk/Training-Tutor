package ca.georgebrown.trainingtutor.events 
{	
	import flash.events.Event;

	/**
	 * 
	 * @author ghostmonk
	 * 
	 */
	public class NavigationEvent extends Event 
	{
		public static const SECTION_NAVIGATION:String = "sectionNavigation";
		public static const INIT_SECTION:String = "initSection";
		public static const REPLAY_VIDEO:String = "replayVideo";
		public static const NEXT_SECTION:String = "nextSection";
		
		private var _index:int;
		
		public function NavigationEvent( type:String, index:int, bubbles:Boolean = false, cancelable:Boolean = false ) 
		{	
			_index = index;
			super( type, bubbles, cancelable );	
		}
		
		public function get index() : int 
		{	
			return _index;	
		}
		
		override public function clone() : Event 
		{	
			return new NavigationEvent( type, index, bubbles, cancelable );	
		}
	}
}