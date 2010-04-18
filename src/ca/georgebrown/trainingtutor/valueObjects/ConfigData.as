package ca.georgebrown.trainingtutor.valueObjects 
{	
	import flash.utils.Dictionary;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class ConfigData 
	{	
		private var _config:XML;
	
		public function ConfigData( xml:XML ) 
		{				
			_config = xml;	
		}
		
		public function get xml() : XML 
		{	
			return _config;	
		} 
		
		public function get imagesURLs() : Dictionary 
		{	
			var output:Dictionary = new Dictionary();
			
			for each( var imgData:XML in xml.landingPage.rotatingImages.img ) 
			{
				output[ imgData.@src.toString() ] = imgData.@textColor.toString();
			}
			
			return output;	
		}
		
		public function get imgRotationDelay() : Number 
		{	
			return xml.landingPage.rotatingImages.@tranistionDelay * 1000;	
		}
		
		public function get transitionTime() : Number 
		{	
			return xml.landingPage.rotatingImages.@transitionTime;	
		}
		
		public function getSection( index:int ) : SectionData 
		{		
			return new SectionData( xml.sections[ 0 ].section[ index ] );	
		}
		
		public function get sectionIDs() : XMLList 
		{	
			return xml.sections.section.@id;	
		}
	}
}