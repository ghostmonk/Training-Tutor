package ca.georgebrown.trainingtutor.events
{
	import flash.events.Event;

	public class VideoPlayerEvent extends Event
	{
		public static const VIDEO_COMPLETE:String = "videoComplete";
		public static const REPLAY_VIDEO:String = "replayVideo";
		
		public function VideoPlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new VideoPlayerEvent( type, bubbles, cancelable );
		}
	}
}