package ca.georgebrown.trainingtutor.framework.view 
{	
	import ca.georgebrown.trainingtutor.components.footer.Footer;
	import ca.georgebrown.trainingtutor.events.footer.NavigationEvent;
	import ca.georgebrown.trainingtutor.events.landingPage.LandingPageStateEvent;
	import ca.georgebrown.trainingtutor.framework.model.ConfigProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class FooterMediator extends Mediator 
	{
		public static const NAME:String = "footerMediator"
		
		private var _stageMediator:StageMediator;
		private var _configProxy:ConfigProxy;
		
		public function FooterMediator( viewComponent:Footer, configProxy:ConfigProxy ) 
		{	
			super( NAME, viewComponent);
			_configProxy = configProxy;
			footer.addEventListener( NavigationEvent.SECTION_NAVIGATION, onNavigation );	
		}
		
		override public function onRegister() : void 
		{		
			_stageMediator = facade.retrieveMediator( StageMediator.NAME )  as StageMediator;	
		}
		
		public function get footer() : Footer 
		{		
			return viewComponent as Footer;	
		}
		
		override public function listNotificationInterests() : Array 
		{		
			return [
				LandingPageStateEvent.BUILD_OUT_COMPLETE
			];	
		}
		
		override public function handleNotification( note:INotification ) : void 
		{	
			switch( note.getName() ) 
			{
				case LandingPageStateEvent.BUILD_OUT_COMPLETE:
					onLandingComplete();
					break;
			}	
		}
		
		private function onLandingComplete() : void 
		{
			_stageMediator.stage.addChild( footer );
			footer.buildIn();
		}
		
		private function onNavigation( e:NavigationEvent ) : void 
		{	
			sendNotification( e.type, e.index );	
		}
	}
}