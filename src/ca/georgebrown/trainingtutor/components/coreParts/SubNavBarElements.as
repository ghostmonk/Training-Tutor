package ca.georgebrown.trainingtutor.components.coreParts
{
	import assets.footer.SequenceMarkerAsset;
	
	/**
	 * This class is UGLY...  
	 * @author ghostmonk
	 * 
	 */
	public class SubNavBarElements
	{
		private var _items:Array = [];
		private var _one:SequenceMarker;
		private var _two:SequenceMarker;
		private var _three:SequenceMarker;
		private var _four:SequenceMarker;
		private var _five:SequenceMarker;
		
		public function addLabels( items:Array ) : void
		{
			_one.name = String( items[0] ).toUpperCase();
			_two.name = String( items[1] ).toUpperCase();
			_three.name = String( items[2] ).toUpperCase();
			_four.name = String( items[3] ).toUpperCase();
			_five.name = String( items[4] ).toUpperCase();
		}
		
		public function addClips( items:Array ) : void
		{
			_one = new SequenceMarker( items[0] as SequenceMarkerAsset );
			_two = new SequenceMarker( items[1] as SequenceMarkerAsset );
			_three = new SequenceMarker( items[2] as SequenceMarkerAsset );
			_four = new SequenceMarker( items[3] as SequenceMarkerAsset );
			_five = new SequenceMarker( items[4] as SequenceMarkerAsset );
		}
		
		public function setSubsequence( code1:int, code2:int ) : void
		{
			if( code1 == -1 )
			{
				closeFirstSeq();
				closeSecondSeq();
			}
			
			if( code1 == 0 ) 
			{
				closeSecondSeq();
				openSequence1( code2 );
			}
			
			if( code1 == 1 ) 
			{
				closeFirstSeq();
				openSequence2( code2 );
			}
		}
		
		private function openSequence1( code:int ) : void
		{
			var openSeq:SequenceMarker = code == 0 ? _one : _two;
			var closeSeq:SequenceMarker = code == 0 ? _two : _one;
			openSeq.showName();
			closeSeq.hideName();
			if( code == 0 ) _two.setXPos( _one.getOpenXPosRight() );
		}
		
		private function openSequence2( code:int ) : void
		{
			switch( code )
			{
				case 0: open0close12(); break;
				case 1: open1close02(); break;
				case 2: open2close01(); break;
			}
		}
		
		private function open0close12() : void
		{
			_three.showName();
			_four.hideName();
			_four.setXPos( _three.getOpenXPosRight() );
			_five.hideName();
			_five.setXPos( _three.getOpenXPosRight() + 10 );
		}
		
		private function open1close02() : void
		{
			home( _three );
			_four.showName();
			_five.hideName();
			_five.setXPos( _four.getOpenXPosRight() );
		}
		
		private function open2close01() : void
		{
			home( _three );
			home( _four );
			_five.showName();
		}
		
		private function closeFirstSeq() : void
		{
			home( _one );
			home( _two );
		}
		
		private function closeSecondSeq() : void
		{
			home( _three );
			home( _four );
			home( _five );
		}	
		
		private function home( marker:SequenceMarker ) : void
		{
			marker.hideName();
			marker.setXHome();
		}
	}
}