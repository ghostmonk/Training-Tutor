package ca.georgebrown.trainingtutor.framework.view 
{	
	import ca.georgebrown.trainingtutor.components.coreParts.Footer;
	import ca.georgebrown.trainingtutor.components.coreParts.Header;
	import ca.georgebrown.trainingtutor.components.landingPage.LandingPage;
	import ca.georgebrown.trainingtutor.events.LandingPageStateEvent;
	
	import flash.display.Stage;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class StageMediator extends Mediator {
		
		public static const NAME:String = "stageMediator";
		
		private var _header:Header;
		private var _footer:Footer;
		
		public function StageMediator( viewComponent:Stage ) 
		{		
			super( NAME, viewComponent );
			stage.stageFocusRect = false;	
		}
		
		public function set header( value:Header ) : void
		{
			_header = value;
		}
		
		public function set footer( value:Footer ) : void
		{
			_footer = value;
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
			onLandingComplete( note.getBody() as LandingPage );
		}
		
		private function onLandingComplete( landing:LandingPage ) : void 
		{		
			stage.removeChild( landing );
			
			stage.addChild( _footer );
			_footer.buildIn();
			
			stage.addChild( _header );
			_header.buildIn();	
		}	
	}
}