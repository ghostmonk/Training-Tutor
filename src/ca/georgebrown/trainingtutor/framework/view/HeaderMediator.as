package ca.georgebrown.trainingtutor.framework.view 
{	
	import ca.georgebrown.trainingtutor.components.Header;
	import ca.georgebrown.trainingtutor.events.landingPage.LandingPageStateEvent;
	import ca.georgebrown.trainingtutor.framework.model.ConfigProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class HeaderMediator extends Mediator 
	{
		public static const NAME:String = "headerMediator";
		
		private var _stageMediator:StageMediator;
		private var _configProxy:ConfigProxy;
	
		public function HeaderMediator( viewComponent:Header, configProxy:ConfigProxy ) 
		{		
			super( NAME, viewComponent );
			_configProxy = configProxy;	
		}
		
		override public function onRegister() : void 
		{	
			_stageMediator = facade.retrieveMediator( StageMediator.NAME )  as StageMediator;	
		}
		
		public function get header() : Header 
		{	
			return viewComponent as Header;	
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
			_stageMediator.stage.addChild( header );
			header.buildIn();	
		}
	}
}