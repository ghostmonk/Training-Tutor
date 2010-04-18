package ca.georgebrown.trainingtutor.events 
{	
	import flash.events.Event;
		
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class ImageTransitionEvent extends Event 
	{	
		public static const IMAGE_CHANGE:String = "imageChange";
		public static const FIRST_IMAGE:String = "firstImage";
		
		private var _color:uint;
			
		public function ImageTransitionEvent( type:String, color:uint, bubbles:Boolean = false, cancelable:Boolean = false ) 
		{	
			_color = color;
			super(type, bubbles, cancelable);	
		}
		
		public function get color() : uint 
		{	
			return _color;	
		}
		
		override public function clone() : Event 
		{	
			return new ImageTransitionEvent( type, color, bubbles, cancelable );	
		}
	}
}