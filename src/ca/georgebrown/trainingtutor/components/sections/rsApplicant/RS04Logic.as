package ca.georgebrown.trainingtutor.components.sections.rsApplicant
{
	import sectionContent.RSApplicant.RS04;

	public class RS04Logic extends IntervalTimelineAdvancer
	{
		public function RS04Logic()
		{
			super( new RS04(), TOUCHPOINT_PAUSE_LENGTH );
		}
	}
}