package ca.georgebrown.trainingtutor.components
{
	import ca.georgebrown.trainingtutor.events.SequenceEvent;
	import ca.georgebrown.trainingtutor.valueObjects.SectionContentData;
	
	import flash.events.EventDispatcher;
	
	[Event (name="sequenceComplete", type="ca.georgebrown.trainingtutor.events.SequenceEvent")]
	[Event (name="newSubSequence", type="ca.georgebrown.trainingtutor.events.SequenceEvent")]
	
	public class SequenceManager extends EventDispatcher
	{
		private var _subSequences:Array;
		private var _currentSequence:Array;
		private var _subSequenceNode:int;
		private var _currentNode:int;
		
		public function addSequenceData( data:Array ) : void
		{
			_subSequences = null;
			_subSequences = data;
			_subSequenceNode = -1;
			
			_currentSequence = null;
			_currentSequence = nextSubSequence();
			_currentNode = -1;
		}
		
		public function get nextSection() : SectionContentData
		{
			_currentNode ++;
			if( _currentNode == _currentSequence.length ) 
				_currentSequence = nextSubSequence();
				
			if( _currentSequence == null ) return null;
			
			return _currentSequence[ _currentNode ];
		}
		
		private function nextSubSequence() : Array
		{
			_subSequenceNode++;
			if( _subSequenceNode == _subSequences.length )
			{
				dispatchEvent( new SequenceEvent( SequenceEvent.SEQUENCE_COMPLETE ) ) ;
				return null;
			}
			_currentNode = 0; 
			dispatchEvent( new SequenceEvent( SequenceEvent.NEW_SUB_SEQUENCE ) );
			return _subSequences[_subSequenceNode];
		} 
	}
}