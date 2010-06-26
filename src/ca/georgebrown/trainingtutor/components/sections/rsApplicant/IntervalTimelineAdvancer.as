package ca.georgebrown.trainingtutor.components.sections.rsApplicant
{
	import ca.georgebrown.trainingtutor.components.sections.CustomSection;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class IntervalTimelineAdvancer extends CustomSection
	{
		private var _timer:Timer;
		
		public function IntervalTimelineAdvancer( mcView:MovieClip, interval:Number )
		{
			super( mcView );
			_timer = new Timer( interval );
			_timer.addEventListener(TimerEvent.TIMER, onTimer );
			_timer.start();
		}
		
		override protected function onAnimComplete(e:Event):void
		{
			super.onAnimComplete( e );
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onTimer );
		}
		
		private function onTimer( e:TimerEvent ) : void
		{
			view.play();
		}
	}
}