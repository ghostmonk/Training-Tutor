package ca.georgebrown.trainingtutor.framework.controller 
{	
	import ca.georgebrown.trainingtutor.framework.model.ConfigProxy;
	import ca.georgebrown.trainingtutor.framework.model.LocalDataProxy;
	import ca.georgebrown.trainingtutor.framework.view.StageMediator;
	import ca.georgebrown.trainingtutor.valueObjects.StartupData;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * 
	 * @author ghostmonk 15/08/2009
	 * 
	 */
	public class StartupCommand extends SimpleCommand 
	{	
		override public function execute( note:INotification ) : void 
		{	
			var startupData:StartupData = note.getBody() as StartupData;
			
			facade.registerMediator( new StageMediator( startupData.stage ) );
			facade.registerProxy( new ConfigProxy( startupData.confURL ) );
			facade.registerProxy( new LocalDataProxy() );
		}	
	}
}