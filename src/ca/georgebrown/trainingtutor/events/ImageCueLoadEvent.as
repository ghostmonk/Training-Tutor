package ca.georgebrown.trainingtutor.events
{
	import flash.events.Event;

	public class ImageCueLoadEvent extends Event
	{
		public static const IMAGE_CUE_COMPLETE:String = "imageCueComplete";
		public static const IMAGE_LOADED:String = "imageLoaded";
		public static const IMAGE_LOAD_FAILED:String = "imageLoadFailed";
		
		private var _id:String;
		
		public function ImageCueLoadEvent( type:String, id:String = null, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			_id = id;
			super( type, bubbles, cancelable );
		}
		
		public function get id() : String
		{
			return _id;
		}		
		
		override public function clone() : Event
		{
			return new ImageCueLoadEvent( type, bubbles, cancelable );
		}
	}
}