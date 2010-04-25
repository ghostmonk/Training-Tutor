package ca.georgebrown.trainingtutor.framework.model 
{	
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
		private var _configReady:Function;
		
		private var _xmlLoader:XMLLoader;
		
		/**
		 * 
		 * @param url
		 * 
		 */
		public function ConfigProxy( url:String, configReadyCallback:Function ) 
		{		
			_configReady = configReadyCallback;
			super( NAME );
			_xmlLoader = new XMLLoader( url, xmlLoaded );	
		}
		
		private function xmlLoaded( xml:XML ) : void 
		{	
			data = new ConfigData( xml );
			_configReady();
			_xmlLoader = null;
		}
		
		public function get configData() : ConfigData 
		{		
			return data as ConfigData;	
		}
		
		public function get sectionImages() : Array 
		{
			return configData.sectionImages;
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