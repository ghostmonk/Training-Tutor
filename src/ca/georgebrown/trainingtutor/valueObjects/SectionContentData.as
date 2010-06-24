package ca.georgebrown.trainingtutor.valueObjects 
{
	import com.ghostmonk.media.video.data.CuePoint;
		
	/**
	 * 
	 * @author ghostmonk
	 * 
	 */
	public class SectionContentData 
	{	
		private var _data:XML;
		private var _cuePoints:Array;
		private var _imageIDs:Array;
		private var _sequenceList:Array = [];
		
		public function SectionContentData( data:XML ) 
		{	
			_data = data;	
			createCuePoints();
			createSequenceData();
			createImageIDs();
		}
		
		public function get contentType() : String 
		{
			return _data.@type.toString();
		}
		
		public function get isBasic() : Boolean
		{
			return _data.@type.toString() == "basic";
		}
		
		public function get isSequential() : Boolean
		{
			return _data.@type.toString() == "sequential";
		}
		
		public function get hasImages() : Boolean
		{
			return _imageIDs.length > 0;
		}
		
		public function get hasVideo() : Boolean 
		{		
			return _data.video[ 0 ] != null;	
		}
		
		public function get hasCuePoints() : Boolean
		{
			return _cuePoints.length > 0;
		}
		
		public function get cuePoints() : Array
		{
			return _cuePoints;
		}
		
		public function get useChangeOnTextScroll() : Boolean
		{
			return _data.images ? _data.images.@changeOnTextScroll == "true" : false;
		}
		
		public function get imageIDs() : Array
		{
			return _imageIDs;
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
			return hasVideo ? _data.video[ 0 ].@src.toString() : null;	
		}
		
		public function get videoCuePoints() : Array
		{
			return _cuePoints;
		}
		
		public function get sequenceData() : Array
		{
			return _sequenceList;
		}
		
		private function createCuePoints() : void
		{
			_cuePoints = [];
			if( !hasVideo ) return;
			for each( var node:XML in _data.video[0].cuePoint )
				_cuePoints.push( new CuePoint( node.@name.toString(), Number( node.@time ), {} ) );
		}
		
		private function createImageIDs(): void
		{
			_imageIDs = [];
			if( _data.images == null ) return;
			if( _data.images.img == null ) return;
			for each( var id:String in _data.images.img.@id )
				_imageIDs.push( id );	
		}
		
		private function createSequenceData() : void
		{
			_sequenceList = [];
			
			for each( var xmlNode:XML in _data.sequence )
			{
				var sequence:Array = [];
				for each( var subNode:XML in xmlNode.sub )
					sequence.push( new SectionContentData( subNode ) );	
				_sequenceList.push( sequence );
			}
		}
	}
}