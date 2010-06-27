package G3D4Y6f4t0l2UycswkI {
	
	import flash.events.Event;

	public class PercentageEvent extends Event {
		
		
		
		public static const CHANGE:String = "change";
		public static const LOAD_CHANGE:String = "loadChange";
		
		private var _percent:Number;
		
		public function get percent():Number {
			
			return _percent;
			
		}
		
		public function PercentageEvent(type:String, value:Number, bubbles:Boolean = false, cancelable:Boolean = false) {
			
			_percent = value;
			super(type, bubbles, cancelable);
			
		}
		
		
		
		override public function clone():Event {
			
			return new PercentageEvent( type, percent, bubbles, cancelable );
			
		}
		
		
		
	}
}