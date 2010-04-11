package ca.georgebrown.trainingtutor.framework.view 
{	
	import ca.georgebrown.trainingtutor.components.video.VideoPlayer;
	import ca.georgebrown.trainingtutor.events.footer.NavigationEvent;
	import ca.georgebrown.trainingtutor.events.landingPage.LandingPageStateEvent;
	import ca.georgebrown.trainingtutor.framework.model.ConfigProxy;
	import ca.georgebrown.trainingtutor.valueObjects.SectionData;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	/**
	 * 
	 * @author ghostmonk 21/08/2009
	 * 
	 */
	public class VideoPlayerMediator extends Mediator
	{
		public static const NAME:String = "VideoPlayerMediator";
		
		private var _stageMediator:StageMediator;
		private var _configProxy:ConfigProxy;
		
		public function VideoPlayerMediator( viewComponent:VideoPlayer, configProxy:ConfigProxy ) 
		{	
			super( NAME, viewComponent );
			_configProxy = configProxy;	
		}
		
		public function get videoPlayer() : VideoPlayer 
		{	
			return viewComponent as VideoPlayer;	
		}
		
		override public function onRegister() : void 
		{	
			_stageMediator = facade.retrieveMediator( StageMediator.NAME )  as StageMediator;	
		}
		
		override public function listNotificationInterests() : Array 
		{	
			return [
				NavigationEvent.SECTION_NAVIGATION,
				LandingPageStateEvent.BUILD_OUT_COMPLETE
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
			}
		}
		
		private function onLandingComplete() : void 
		{	
			_stageMediator.stage.addChild( videoPlayer );
			videoPlayer.buildIn();	
		}
		
		private function setView( index:int ) : void 
		{	
			var sectionData:SectionData = _configProxy.configData.getSection( index );
			videoPlayer.loadVideo( sectionData.videoURL );
		}
	}
}