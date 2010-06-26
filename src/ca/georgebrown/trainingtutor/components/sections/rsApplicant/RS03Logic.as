package ca.georgebrown.trainingtutor.components.sections.rsApplicant
{
	import ca.georgebrown.trainingtutor.components.sections.CustomSection;
	
	import sectionContent.RSApplicant.RS03;

	public class RS03Logic extends IntervalTimelineAdvancer
	{
		public function RS03Logic()
		{
			super( new RS03(), TOUCHPOINT_PAUSE_LENGTH );
		}
	}
}