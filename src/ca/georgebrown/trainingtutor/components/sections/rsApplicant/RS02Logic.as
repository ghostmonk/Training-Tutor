package ca.georgebrown.trainingtutor.components.sections.rsApplicant
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import sectionContent.RSApplicant.RS02;

	public class RS02Logic extends IntervalTimelineAdvancer
	{
		public function RS02Logic()
		{
			super( new RS02(), TOUCHPOINT_PAUSE_LENGTH );
		}
	}
}