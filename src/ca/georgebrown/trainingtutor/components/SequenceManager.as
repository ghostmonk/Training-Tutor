package ca.georgebrown.trainingtutor.components
{
	public class SequenceManager
	{
		private var _sequences:Array;
		private var _currentSequence:Array;
		private var _sectionViewManager:SectionComponent;
		
		public function SequenceManager( sectionManager:SectionComponent )
		{
			_sectionViewManager = sectionManager; 
		}
		
		public function startNewSequence( data:Array ) : void
		{
			_sequences = data;
			_sectionViewManager.analyzeSectionContent( _sequences[0][0] );
		}
		
		public function clear() : void
		{
			_sequences = null;
			_currentSequence = null;
		}
	}
}