package ca.georgebrown.trainingtutor.framework.model 
{	
	import ca.georgebrown.trainingtutor.AppFacade;
	import ca.georgebrown.trainingtutor.valueObjects.ConfigData;
	import ca.georgebrown.trainingtutor.valueObjects.SectionData;
	
	import com.ghostmonk.net.XMLLoader;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	/**
	 * This must load and send a CONFIG_LOADED notification before the application will start.
	 * StageMediator is waiting for this to complete.
	 * 
	 * @author ghostmonk 28/12/2008
	 * 
	 */
	public class ConfigProxy extends Proxy 
	{
		public static const NAME:String = "ConfigProxy";
		
		private var _xmlLoader:XMLLoader;
		
		/**
		 * 
		 * @param url
		 * 
		 */
		public function ConfigProxy( url:String ) 
		{		
			super( NAME );
			_xmlLoader = new XMLLoader( url, xmlLoaded );	
		}
		
		private function xmlLoaded( xml:XML ) : void 
		{	
			data = new ConfigData( xml );
			sendNotification( AppFacade.CREATE_COMPONENTS, this );
			_xmlLoader = null;
		}
		
		public function get configData() : ConfigData 
		{		
			return data as ConfigData;	
		}
		
		public function getSectionData( index:int ) : SectionData 
		{		
			return configData.getSection( index );	
		}
		
		public function get sectionNames() : Array 
		{	
			var output:Array = new Array();
			var list:XMLList = configData.sectionIDs;
			
			for each( var label:String in list ) {
				output.push( label );
			} 
			
			return output;	
		}
	}
}