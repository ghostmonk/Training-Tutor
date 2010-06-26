package ca.georgebrown.trainingtutor.events
{
	import flash.events.Event;
	import flash.geom.Point;

	public class SequenceEvent extends Event
	{
		public static const SEQUENCE_COMPLETE:String = "sequenceComplete";
		public static const NEW_SUB_SEQUENCE:String = "newSubSequence";
		
		private var _sequenceCode:Point;
		
		public function SequenceEvent(type:String, sequenceCode:Point = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_sequenceCode = sequenceCode;
			super(type, bubbles, cancelable);
		}
		
		public function get sequenceCode() : Point
		{
			return _sequenceCode;
		}
		
		override public function clone():Event
		{
			return new SequenceEvent( type, _sequenceCode, bubbles, cancelable );
		}
	}
}