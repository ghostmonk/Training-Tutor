package ca.georgebrown.trainingtutor.framework.view 
{	
	import ca.georgebrown.trainingtutor.components.landingPage.LandingPage;
	import ca.georgebrown.trainingtutor.events.landingPage.LandingPageStateEvent;
	
	import flash.display.Stage;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class StageMediator extends Mediator {
		
		public static const NAME:String = "stageMediator";
		
		public function StageMediator( viewComponent:Stage ) 
		{		
			super( NAME, viewComponent );
			stage.stageFocusRect = false;	
		}
		
		public function get stage() : Stage 
		{	
			return viewComponent as Stage;	
		}
		
		override public function listNotificationInterests() : Array 
		{	
			return [ LandingPageStateEvent.BUILD_OUT_COMPLETE ];	
		}
		
		override public function handleNotification( note:INotification ) : void 
		{	
			switch( note.getName() ) 
			{			
				case LandingPageStateEvent.BUILD_OUT_COMPLETE:
					onLandingComplete( note.getBody() as LandingPage );
					break;	
			}
		}
		
		private function onLandingComplete( landing:LandingPage ) : void 
		{		
			stage.removeChild( landing );	
		}	
	}
}