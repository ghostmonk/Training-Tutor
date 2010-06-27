package com.ghostmonk.media.video.events {
	
	import flash.events.Event;

	/**
 	 * Class of Constants used for videoControl 
 	 *  
	 * @author ghostmonk 20/11/2008
	 * 
	 */
	public class VideoControlEvent extends Event {
		
		
		
		public static const PAUSE:String = "pause";
		public static const PLAY:String = "play";
		
		
		
		/**
		 * 
		 * @param type use static variables in VideoControlEvent
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function VideoControlEvent( type:String, bubbles:Boolean=false, cancelable:Boolean=false ) {
			
			super(type, bubbles, cancelable);
			
		}
		
		
		
		override public function clone():Event {
			
			return new VideoControlEvent( type, bubbles, cancelable );
			
		}
		
		
		
	}
}