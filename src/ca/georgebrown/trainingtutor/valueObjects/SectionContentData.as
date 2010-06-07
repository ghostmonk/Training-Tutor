package ca.georgebrown.trainingtutor.valueObjects 
{	
	/**
	 * 
	 * @author ghostmonk
	 * 
	 */
	public class SectionContentData 
	{	
		private var _data:XML;
		
		public function SectionContentData( data:XML ) 
		{	
			_data = data;		
		}
		
		public function get contentType() : String 
		{
			return _data.@type.toString();
		}
		
		public function get isSequential() : Boolean
		{
			return _data.@type.toString() == "sequential";
		}
		
		public function get hasVideo() : Boolean 
		{		
			return _data.video[ 0 ];	
		}
		
		public function get isBasic() : Boolean
		{
			return _data.@type.toString() == "basic";
		}
		
		public function get useChangeOnTextScroll() : Boolean
		{
			return _data.images ? _data.images.@changeOnTextScroll == "true" : false;
		}
		
		public function get imageIDs() : Array
		{
			var output:Array = [];
			for each( var item:String in _data.images.img.@id )
			{
				output.push( item );
			}
			return output;
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
		
		public function get videoCuePoints() : Array
		{
			var output:Array = [];
			for each( var xmlNode:XML in _data.video[ 0 ].point )
			{
				output.push( { data:xmlNode.toString(), time:parseInt( xmlNode.@time ) } );	
			}
			return output;
		}
		
		public function get sequenceData() : Array
		{
			var output:Array = [];
			
			for each( var xmlNode:XML in _data.content.sequence )
			{
				output.push( new SectionContentData( xmlNode ) );
			}
			
			return output;
		}
	}
}