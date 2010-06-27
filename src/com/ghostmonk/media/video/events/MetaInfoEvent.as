package com.ghostmonk.media.video.events {
	
	import com.ghostmonk.media.video.data.VideoMetaData;
	
	import flash.events.Event;

	/**
	 * Fire this event in the onMetaData function when loading a video
	 * 
	 * @author ghostmonk
	 * 
	 */
	public class MetaInfoEvent extends Event {
		
		
		
		public static const META_INFO_READY:String = "metaInfoReady";
		
		private var _metaData:VideoMetaData;
		
		
		
		/**
		 * Retrieve available data from loaded video
		 *  
		 * @return 
		 * 
		 */
		public function get metaData():VideoMetaData {
			
			return _metaData;
			
		}
		
		
		
		/**
		 * 
		 * @param type Use static variable MetaInfoEvent.META_INFO_READY
		 * @param metaData Data Struct with all meta data passed with a typical flv
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function MetaInfoEvent( type:String, metaData:VideoMetaData, bubbles:Boolean=false, cancelable:Boolean=false ) {
			
			super(type, bubbles, cancelable);
			_metaData = metaData;
			
		}
		
		
		
		override public function clone():Event {
			
			return new MetaInfoEvent( type, metaData, bubbles, cancelable );
			
		}
		
	}
}