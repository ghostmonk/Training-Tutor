package ca.georgebrown.trainingtutor 
{	
	import ca.georgebrown.trainingtutor.framework.controller.CreationCommand;
	import ca.georgebrown.trainingtutor.framework.controller.StartupCommand;
	import ca.georgebrown.trainingtutor.valueObjects.StartupData;
	
	import com.ghostmonk.utils.MainStage;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	/**
	 * 
	 * @author ghostmonk 15/08/2009
	 * 
	 */
	public class AppFacade extends Facade 
	{	
		public static const STARTUP_APP:String = "startupApp";
		public static const CREATE_COMPONENTS:String = "createComponents";
		
		public function AppFacade( key:String ) 
		{	
			super( key );	
		}
	
		public static function getInstance( key:String ) : AppFacade 
		{	
			if( instanceMap[ key ] == null ) 
			{
				instanceMap[ key ] = new AppFacade( key );
			}
			return instanceMap[ key ] as AppFacade;
		}
		
		override protected function initializeController() : void 
		{	
			super.initializeController();
			
			registerCommand( STARTUP_APP, StartupCommand );
			registerCommand( CREATE_COMPONENTS, CreationCommand );
		}
		
		public function startup( startupData:StartupData ) : void 
		{	
			MainStage.instance = startupData.stage;
			sendNotification( STARTUP_APP, startupData );
		}
	}
}