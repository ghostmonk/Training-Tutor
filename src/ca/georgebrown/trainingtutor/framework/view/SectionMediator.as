package ca.georgebrown.trainingtutor.framework.view 
{	
	import ca.georgebrown.trainingtutor.components.SectionComponent;
	import ca.georgebrown.trainingtutor.events.CustomSectionEvent;
	import ca.georgebrown.trainingtutor.events.LandingPageStateEvent;
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	import ca.georgebrown.trainingtutor.events.SequenceEvent;
	import ca.georgebrown.trainingtutor.framework.model.ConfigProxy;
	import ca.georgebrown.trainingtutor.valueObjects.SectionContentData;
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	/**
	 * 
	 * @author ghostmonk 21/08/2009
	 * 
	 */
	public class SectionMediator extends Mediator 
	{	
		public const NAME:String = "SectionTextMediator";
		
		private var _sectionComponent:SectionComponent;
		
		private var _configProxy:ConfigProxy;
		private var _currentSection:int;
		private var _sectionsLength:int;
		private var _isFirstSection:Boolean;
		
		public function SectionMediator( configProxy:ConfigProxy, viewManager:SectionComponent ) 
		{
			_isFirstSection = true;
			super( NAME, viewManager );
			_configProxy = configProxy;
			_sectionComponent = viewManager;
			_sectionComponent.addEventListener(NavigationEvent.NEXT_SECTION, onNextSection );
			_sectionComponent.addEventListener(SequenceEvent.NEW_SUB_SEQUENCE, onSubSequence );
			_sectionComponent.addEventListener(CustomSectionEvent.GO_HOME, onGoHome);
			_sectionsLength = _configProxy.configData.sectionIDs.length();
		}
		
		public function get sectionComponent() : SectionComponent
		{
			return viewComponent as SectionComponent;
		}

		override public function listNotificationInterests() : Array 
		{		
			return [
				NavigationEvent.SECTION_NAVIGATION,
				LandingPageStateEvent.BUILD_OUT_COMPLETE,
				NavigationEvent.INIT_SECTION
			];
		}
		
		override public function handleNotification( note:INotification ) : void 
		{	
			switch( note.getName() ) 
			{		
				case NavigationEvent.SECTION_NAVIGATION:
					setView( note.getBody() as int );
					break;
				
				case LandingPageStateEvent.BUILD_OUT_COMPLETE:
					onLandingComplete();
					break;
					
				case NavigationEvent.INIT_SECTION:
					_currentSection = note.getBody() as int;
					break;
			}
		}

		private var _interval:uint;
		private function onLandingComplete() : void 
		{
			_interval = setInterval( setView, 1000, _currentSection );
		}
		
		private function setView( index:int ) : void 
		{	
			clearInterval( _interval );
			_currentSection = index;
			var sectionData:SectionContentData = _configProxy.getSectionData( _currentSection );	
			_sectionComponent.analyzeSectionContent( sectionData );
		}
		
		private function onNextSection( e:NavigationEvent ) : void
		{
			if( _currentSection == _sectionsLength - 1 ) return;
			_currentSection++; 
			sendNotification( e.type, _currentSection );
			setView( _currentSection );
		}
		
		private function onSubSequence( e:SequenceEvent ) : void
		{
			sendNotification( e.type, e.sequenceCode );
		}
		
		private function onGoHome( e:CustomSectionEvent ) : void
		{
			sendNotification( NavigationEvent.SECTION_NAVIGATION, 0 );
		}
	}
}