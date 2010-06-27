package G3D4Y6f4t0l2UycswkI {
	
	
	import flash.events.Event;

	public class MetaInfoEvent extends Event {
		
		
		
		public static const META_INFO_READY:String = "metaInfoReady";
		
		private var _metaData:VideoMetaData;
		
		
		public function get metaData():VideoMetaData {
			
			return _metaData;
			
		}
		
		public function MetaInfoEvent( type:String, metaData:VideoMetaData, bubbles:Boolean=false, cancelable:Boolean=false ) {
			
			super(type, bubbles, cancelable);
			_metaData = metaData;
			
		}
		
		
		
		override public function clone():Event {
			
			return new MetaInfoEvent( type, metaData, bubbles, cancelable );
			
		}
		
	}
}