package ca.georgebrown.trainingtutor.components
{
	import G3D4Y6f4t0l2UycswkI.MainStage;
	
	import ca.georgebrown.trainingtutor.components.sections.CustomSection;
	import ca.georgebrown.trainingtutor.components.sections.CustomSectionFactory;
	import ca.georgebrown.trainingtutor.events.CustomSectionEvent;
	import ca.georgebrown.trainingtutor.events.SequenceEvent;
	import ca.georgebrown.trainingtutor.valueObjects.SectionContentData;
	
	import flash.events.EventDispatcher;
	
	[Event (name="replay", type="ca.georgebrown.trainingtutor.events.CustomSectionEvent")]
	[Event (name="nextSection", type="ca.georgebrown.trainingtutor.events.CustomSectionEvent")]
	[Event (name="goHome", type="ca.georgebrown.trainingtutor.events.CustomSectionEvent")]
	[Event (name="sequenceComplete", type="ca.georgebrown.trainingtutor.events.SequenceEvent")]
	[Event (name="newSubSequence", type="ca.georgebrown.trainingtutor.events.SequenceEvent")]
	
	public class CustomSectionManager extends EventDispatcher
	{
		private var _customView:CustomSection;
		private var _sequenceManager:SequenceManager;
		private var _sectionComponent:SectionComponent;
		private var _isSequential:Boolean;
		private var _currentSequenceCodes:Array;
		private var _currentSequenceIndex:int;
		
		public function CustomSectionManager( comp:SectionComponent ) : void
		{
			_isSequential = false;
			_sectionComponent = comp; 
			createSequenceManager();
		}
		
		public function addSectionData( data:SectionContentData ) : void
		{
			destroyView();
			_isSequential = data.isSequential;
			_currentSequenceCodes = [];
			_currentSequenceIndex = 0;
			if( _isSequential ) 
			{
				_currentSequenceCodes = data.sequenceCodes;
				_sequenceManager.addSequenceData( data.sequenceData );
				onNextSection();
				return;
			}
			if( data.isBasic ) throw new Error( "Basic Data is not allowing in CustomSectionManager" );
			
			createView( data.contentType );
		}
		
		public function playSectionTimeline() : void
		{
			_customView.view.play();
		}
		
		public function clean() : void
		{
			if( _customView ) _customView.buildOut();
			_customView = null;
		}
		
		public function showActionButtons() : void
		{
			_customView.showActionButtons();
		}
		
		public function onNextSection( e:CustomSectionEvent = null ) : void
		{
			destroyView();
			if( !_isSequential ) 
			{
				onSequenceComplete( new SequenceEvent( SequenceEvent.SEQUENCE_COMPLETE ) );
				return;
			}
			
			var data:SectionContentData = _sequenceManager.nextSection;
			if( !data ) return;
			_sectionComponent.configureBaseView( data );
			if( !data.isBasic ) createView( data.contentType );
		}	
		
		private function createView( type:String ) : void
		{
			_customView = CustomSectionFactory.getView( type );
			_customView.addEventListener(CustomSectionEvent.REPLAY, onReDispatch);
			_customView.addEventListener(CustomSectionEvent.NEXT_SECTION, onNextSection);
			_customView.addEventListener(CustomSectionEvent.GO_HOME, onReDispatch);
			MainStage.instance.addChild( _customView.view );
		}
		
		private function destroyView() : void
		{
			if( !_customView ) return;
			_customView.removeEventListener(CustomSectionEvent.REPLAY, onReDispatch);
			_customView.removeEventListener(CustomSectionEvent.NEXT_SECTION, onNextSection);
			_customView.removeEventListener(CustomSectionEvent.GO_HOME, onReDispatch);
			clean();
		}
		
		private function destroySequenceManager() : void
		{
			_sequenceManager.removeEventListener(SequenceEvent.SEQUENCE_COMPLETE, onSequenceComplete);
			_sequenceManager.removeEventListener(SequenceEvent.NEW_SUB_SEQUENCE, onNewSubSequence);
			_sequenceManager = null;
		}
		
		private function createSequenceManager() : void
		{
			_sequenceManager = new SequenceManager();
			_sequenceManager.addEventListener(SequenceEvent.SEQUENCE_COMPLETE, onSequenceComplete);
			_sequenceManager.addEventListener(SequenceEvent.NEW_SUB_SEQUENCE, onNewSubSequence);
		}
		
		private function onReDispatch( e:CustomSectionEvent ) : void
		{
			dispatchEvent( e );
		}
		
		private function onSequenceComplete( e:SequenceEvent ) : void
		{
			destroySequenceManager();
			createSequenceManager();
			dispatchEvent( e );
		}
		
		private function onNewSubSequence( e:SequenceEvent ) : void
		{
			dispatchEvent( new SequenceEvent( SequenceEvent.NEW_SUB_SEQUENCE, _currentSequenceCodes[ _currentSequenceIndex ] ) );
			_currentSequenceIndex++;
		}
	}
}