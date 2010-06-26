package ca.georgebrown.trainingtutor.valueObjects 
{	
	import flash.utils.Dictionary;
	
	/**
	 * @author ghostmonk 16/08/2009
	 */
	public class ConfigData 
	{	
		private var _config:XML;
		public static var LINKS:Object = {};
	
		public function ConfigData( xml:XML ) 
		{				
			_config = xml;
			
			for each( var link:XML in xml.links.children() )
				LINKS[ link.localName() ] = link.@src;
		}
		
		public function get xml() : XML 
		{	
			return _config;
		} 
		
		public function get landingPageImages() : Dictionary 
		{	
			var output:Dictionary = new Dictionary();
			
			for each( var imgData:XML in xml.landingPage.rotatingImages.img ) 
				output[ imgData.@src.toString() ] = imgData.@textColor.toString();
			
			return output;	
		}
		
		public function get sectionImages() : Array 
		{
			var list:XMLList = _config.sections.section.content.images.img;
			list += _config.sections.section.content.sequence.sub.images.img;
			
			var output:Array = [];
			
			for each( var item:XML in list )
			{
				var info:Object = {id:item.@id, src:item.parent().@base + item.@src };
				output.push( info );
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
		
		public function getSection( index:int ) : SectionContentData 
		{		
			return new SectionContentData( xml.sections[ 0 ].section[ index ].content[ 0 ] );	
		}
		
		public function get sectionIDs() : XMLList 
		{	
			return xml.sections.section.@id;	
		}
	}
}