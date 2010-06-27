package ca.georgebrown.trainingtutor.valueObjects 
{
	
	import G3D4Y6f4t0l2UycswkI.HY7e4G6eMkslOye7GdBy;
	
	import flash.geom.Point;
		
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
		private var _sequenceCodes:Array = [];
		
		public function SectionContentData( data:XML ) 
		{	
			_data = data;
			
			//This is a terrible weird method of getting a code to decifer which sequence is being accessed
			//There are two main sequences, with 2 and 3 sub sequences respectfully. These numbers are used 
			// to update the SubNavBarElements found in the NavigationBar under components coreParts.
			// 0:0, 0:1, 1:0, 1:1, 1:2 
			var sequenceNodes:XMLList = _data.sequence;
			
			for each( var node:XML in sequenceNodes ) 
			{
				var codeString:String  = node.@code.toString();
				var stringArray:Array = codeString.split( ":" );
				var xPos:int = parseInt( stringArray[ 0 ] );
				var yPos:int = parseInt( stringArray[ 1 ] );
				if( !isNaN( xPos ) && !isNaN( yPos ) )
				{
					var newSeqPoint:Point = new Point( xPos, yPos );
					_sequenceCodes.push( newSeqPoint );	
				}
			}
			
			createCuePoints();
			createSequenceData();
			createImageIDs();
		}
		
		public function get imageSwapRate() : int
		{
			var rate:int = _data.images ? parseInt( _data.images.@imageSwapRate ) : 2000;
			return isNaN( rate ) ? 0 : rate;
		}
		
		public function get useImageTimer() : Boolean
		{
			return _data.images ? _data.images.@useImageTimer == "true" : false;
		}
		
		public function get sequenceCodes() : Array
		{
			return _sequenceCodes;
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
				_cuePoints.push( new HY7e4G6eMkslOye7GdBy( node.@name.toString(), Number( node.@time ), {} ) );
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