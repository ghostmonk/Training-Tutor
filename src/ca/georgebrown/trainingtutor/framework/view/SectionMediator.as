package ca.georgebrown.trainingtutor.framework.view 
{	
	import ca.georgebrown.trainingtutor.components.SectionText;
	import ca.georgebrown.trainingtutor.components.video.VideoPlayer;
	import ca.georgebrown.trainingtutor.events.footer.NavigationEvent;
	import ca.georgebrown.trainingtutor.events.landingPage.LandingPageStateEvent;
	import ca.georgebrown.trainingtutor.framework.model.ConfigProxy;
	import ca.georgebrown.trainingtutor.valueObjects.SectionData;
	
	import flash.display.Sprite;
	
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
		
		private var _stageMediator:StageMediator;
		private var _parentView:Sprite;
		
		private var _videoPlayer:VideoPlayer;
		private var _sectionText:SectionText;
		private var _initIndex:int;
		
		private var _configProxy:ConfigProxy;
		
		public function SectionMediator( videoPlayer:VideoPlayer, sectionText:SectionText, configProxy:ConfigProxy ) 
		{	
			_parentView = new Sprite();
			_videoPlayer = videoPlayer;
			_sectionText = sectionText;
			
			super( NAME, _parentView );
			
			_configProxy = configProxy;
			_parentView.addChild( _videoPlayer );
			_parentView.addChild( _sectionText );
		}
		
		override public function onRegister() : void 
		{		
			_stageMediator = facade.retrieveMediator( StageMediator.NAME )  as StageMediator;	
		} 

		override public function listNotificationInterests() : Array 
		{		
			return [
				NavigationEvent.SECTION_NAVIGATION,
				LandingPageStateEvent.BUILD_OUT_COMPLETE,
				NavigationEvent.INIT_SECTION,
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
					_initIndex = note.getBody() as int;
					break;
			}
		}

		private function setView( index:int ) : void 
		{		
			var sectionData:SectionData = _configProxy.getSectionData( index );
			_sectionText.title = sectionData.title;
			_sectionText.bodyText = sectionData.bodyText;
			
			if( sectionData.hasVideo )
			{
				_stageMediator.stage.addChild( _videoPlayer );
				_videoPlayer.buildIn();
				_videoPlayer.loadVideo( sectionData.videoURL );
			}
			else
			{
				_videoPlayer.buildOut();
			}	
		}

		private function onLandingComplete() : void 
		{
			setView( _initIndex );
			_stageMediator.stage.addChild( _parentView );
			_sectionText.buildIn();
			_videoPlayer.buildIn();
		}	
	}
}