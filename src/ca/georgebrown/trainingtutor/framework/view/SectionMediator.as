package ca.georgebrown.trainingtutor.framework.view 
{	
	import ca.georgebrown.trainingtutor.components.SectionComponent;
	import ca.georgebrown.trainingtutor.events.LandingPageStateEvent;
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	import ca.georgebrown.trainingtutor.framework.model.ConfigProxy;
	import ca.georgebrown.trainingtutor.valueObjects.SectionContentData;
	
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
		
		private var _viewManager:SectionComponent;
		
		private var _configProxy:ConfigProxy;
		private var _currentSection:int;
		private var _sectionsLength:int;
		
		public function SectionMediator( configProxy:ConfigProxy, viewManager:SectionComponent ) 
		{
			super( NAME, viewManager );
			_configProxy = configProxy;
			_viewManager = viewManager;
			_sectionsLength = _configProxy.configData.sectionIDs.length();
		}
		
		public function get viewManager() : SectionComponent
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

		private function onLandingComplete() : void 
		{
			setView( _currentSection );
		}
		
		private function setView( index:int ) : void 
		{	
			_currentSection = index;
			var sectionData:SectionContentData = _configProxy.getSectionData( _currentSection );
			viewManager.analyzeSectionContent( sectionData );
		}
		
		private function onNextSection( e:NavigationEvent ) : void
		{
			if( _currentSection == _sectionsLength - 1 ) return;
			_currentSection++; 
			sendNotification( e.type, _currentSection );
			setView( _currentSection );
		}
	}
}