package ca.georgebrown.trainingtutor.events
{
	import flash.events.Event;

	public class SequenceEvent extends Event
	{
		public static const SEQUENCE_COMPLETE:String = "sequenceComplete";
		public static const NEW_SUB_SEQUENCE:String = "newSubSequence";
		
		public function SequenceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new SequenceEvent( type, bubbles, cancelable );
		}
	}
}