package ca.georgebrown.trainingtutor.components
{
	import ca.georgebrown.trainingtutor.components.sections.CustomSection;
	import ca.georgebrown.trainingtutor.components.sections.CustomSectionFactory;
	import ca.georgebrown.trainingtutor.events.CustomSectionEvent;
	import ca.georgebrown.trainingtutor.events.SequenceEvent;
	import ca.georgebrown.trainingtutor.valueObjects.SectionContentData;
	
	import com.ghostmonk.utils.MainStage;
	
	import flash.events.EventDispatcher;
	
	[Event (name="replay", type="ca.georgebrown.trainingtutor.events.CustomSectionEvent")]
	[Event (name="nextSection", type="ca.georgebrown.trainingtutor.events.CustomSectionEvent")]
	[Event (name="goHome", type="ca.georgebrown.trainingtutor.events.CustomSectionEvent")]
	
	public class CustomSectionManager extends EventDispatcher
	{
		private var _customView:CustomSection;
		private var _sequenceManager:SequenceManager;
		private var _sectionComponent:SectionComponent;
		
		public function CustomSectionManager( comp:SectionComponent ) : void
		{
			_sectionComponent = comp; 
			_sequenceManager = new SequenceManager();
			_sequenceManager.addEventListener(SequenceEvent.SEQUENCE_COMPLETE, onSequenceComplete);
			_sequenceManager.addEventListener(SequenceEvent.NEW_SUB_SEQUENCE, onNewSubSequence);
		}
		
		public function addSectionData( data:SectionContentData ) : void
		{
			destroyView();
			if( data.isSequential ) 
			{
				_sequenceManager.addSequenceData( data.sequenceData );
				onNextSection();
				return;
			}
			if( !data.isBasic ) createView( data.contentType );
		}
		
		public function advanceSection() : void
		{
			_customView.view.play();
		}
		
		public function clean() : void
		{
			if( _customView ) _customView.buildOut();
			_customView = null;
		}
		
		private function onNextSection( e:CustomSectionEvent = null ) : void
		{
			destroyView();
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
		
		private function onReDispatch( e:CustomSectionEvent ) : void
		{
			dispatchEvent( e );
		}
		
		private function onSequenceComplete( e:SequenceEvent ) : void
		{
			trace( "sequence complete" );
		}
		
		private function onNewSubSequence( e:SequenceEvent ) : void
		{
			trace( "new Sub sequence" );
		}
	}
}