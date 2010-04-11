package ca.georgebrown.trainingtutor.events.footer 
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