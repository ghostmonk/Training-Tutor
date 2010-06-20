package ca.georgebrown.trainingtutor.components.sectionView
{
	public class SequenceManager
	{
		private var _sequences:Array;
		private var _currentSequence:Array;
		private var _sectionViewManager:SectionViewManager;
		
		public function SequenceManager( sectionManager:SectionViewManager )
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