package com.ghostmonk.events {
	
	import flash.events.Event;

	/**
	 * This event is useful for broadasting a percentage
	 *  
	 * @author ghostmonk 22/11/2008
	 * 
	 */
	public class PercentageEvent extends Event {
		
		
		
		public static const CHANGE:String = "change";
		public static const LOAD_CHANGE:String = "loadChange";
		
		private var _percent:Number;
		
		
		
		/**
		 * retrieve percentage value 
		 * 
		 * @return 
		 * 
		 */
		public function get percent():Number {
			
			return _percent;
			
		}
		
		
		
		/**
		 * 
		 * @param type use static constants in PercentageEvent
		 * @param value the percentage value desired to be dispatched
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function PercentageEvent(type:String, value:Number, bubbles:Boolean = false, cancelable:Boolean = false) {
			
			_percent = value;
			super(type, bubbles, cancelable);
			
		}
		
		
		
		override public function clone():Event {
			
			return new PercentageEvent( type, percent, bubbles, cancelable );
			
		}
		
		
		
	}
}