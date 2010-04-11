package ca.georgebrown.trainingtutor.valueObjects 
{	
	/**
	 * 
	 * @author ghostmonk
	 * 
	 */
	public class SectionData 
	{	
		private var _data:XML;
		
		public function SectionData( data:XML ) 
		{	
			_data = data;		
		}
		
		public function get hasVideo() : Boolean 
		{		
			return _data.video[ 0 ];	
		}
		
		public function get id() : String 
		{		
			return _data.@id.toString();		
		}
		
		public function get title() : String 
		{	
			return _data.title[ 0 ].toString();	
		}
		
		public function get bodyText() : String 
		{			
			return _data.text[ 0 ].toString();	
		}
		
		public function get videoURL() : String 
		{		 
			return hasVideo ? _data.video[ 0 ].@src.toString() : "";	
		}
		
		public function get subSections() : Array
		{
			return [];
		}
	}
}