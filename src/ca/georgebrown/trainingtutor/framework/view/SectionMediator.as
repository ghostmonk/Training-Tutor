package ca.georgebrown.trainingtutor.framework.view 
{	
	import ca.georgebrown.trainingtutor.components.SectionNavigation;
	import ca.georgebrown.trainingtutor.components.SectionText;
	import ca.georgebrown.trainingtutor.components.video.VideoPlayer;
	import ca.georgebrown.trainingtutor.events.LandingPageStateEvent;
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	import ca.georgebrown.trainingtutor.framework.model.ConfigProxy;
	import ca.georgebrown.trainingtutor.valueObjects.SectionData;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
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
		private var _sectionNav:SectionNavigation;
		private var _currentSection:int;
		
		private var _configProxy:ConfigProxy;
		private var _sectionsLength:int;
		
		public function SectionMediator( videoPlayer:VideoPlayer, sectionText:SectionText, sectionNav:SectionNavigation, configProxy:ConfigProxy ) 
		{	
			_parentView = new Sprite();
			_videoPlayer = videoPlayer;
			_sectionText = sectionText;
			_sectionNav = sectionNav;
			_sectionNav.addEventListener( NavigationEvent.NEXT_SECTION, onNextSection );
			_sectionNav.addEventListener( NavigationEvent.REPLAY_VIDEO, onVideoReplay );
			
			super( NAME, _parentView );
			
			_configProxy = configProxy;
			_sectionsLength = _configProxy.configData.sectionIDs.length();
			_parentView.addChild( _videoPlayer );
			_parentView.addChild( _sectionText );
			_parentView.addChild( _sectionNav );
		}
		
		override public function onRegister() : void 
		{		
			_stageMediator = facade.retrieveMediator( StageMediator.NAME )  as StageMediator;	
			positionAssets();
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
		
		private function get stage() : Stage
		{
			return _stageMediator.stage;
		}
		
		private function setView( index:int ) : void 
		{		
			_currentSection = index;
			var sectionData:SectionData = _configProxy.getSectionData( _currentSection );
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
			
			_sectionNav.showReplay = sectionData.hasVideo;
			_sectionNav.showContinue = _currentSection < _sectionsLength - 1;
			
			positionAssets();
		}

		private function onLandingComplete() : void 
		{
			setView( _currentSection );
			_stageMediator.stage.addChild( _parentView );
			_sectionText.buildIn();
			_videoPlayer.buildIn();
			_sectionNav.buildIn();
		}
		
		private function positionAssets() : void
		{
			_videoPlayer.x = 34;
			_videoPlayer.y = ( stage.stageHeight - _videoPlayer.height ) * 0.5;
			
			var sectionHeight:Number = _sectionNav.height + _sectionText.combinedHeight;
			
			_sectionText.x = stage.stageWidth - _sectionText.width - 40;
			_sectionText.y = ( _videoPlayer.height - sectionHeight ) * 0.5 + _videoPlayer.y;
			
			_sectionNav.x = _sectionText.x;
			_sectionNav.yPos = _sectionText.y + _sectionText.height + 10;
		}
		
		private function onNextSection( e:NavigationEvent ) : void
		{
			_currentSection++;
			
			if( _currentSection == _sectionsLength )
			{ 
				_currentSection --;
			}
			else
			{ 
				sendNotification( e.type, _currentSection );
				setView( _currentSection );
			}
		}
		
		private function onVideoReplay( e:NavigationEvent ) : void 
		{
			_videoPlayer.replay();
		}
	}
}