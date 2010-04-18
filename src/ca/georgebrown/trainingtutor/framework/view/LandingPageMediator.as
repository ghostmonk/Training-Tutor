package ca.georgebrown.trainingtutor.framework.view 
{	
	import ca.georgebrown.trainingtutor.components.landingPage.LandingPage;
	import ca.georgebrown.trainingtutor.events.LandingPageStateEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class LandingPageMediator extends Mediator 
	{	
		public static const NAME:String = "landingPageMediator";
		
		private var _stageMediator:StageMediator;
		
		public function LandingPageMediator( view:LandingPage ) 
		{		
			super( NAME, view );
			landingPage.addEventListener( LandingPageStateEvent.BUILD_OUT_COMPLETE, onBuildOutComplete );	
		}
		
		override public function onRegister() : void 
		{	
			_stageMediator = facade.retrieveMediator( StageMediator.NAME )  as StageMediator;
			_stageMediator.stage.addChild( landingPage );
		}
		
		public function get landingPage() : LandingPage 
		{	
			return viewComponent as LandingPage;
		}
		
		private function onBuildOutComplete( e:LandingPageStateEvent ) : void
		{
			sendNotification( e.type, landingPage );	
		}
	}
}