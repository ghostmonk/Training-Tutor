package ca.georgebrown.trainingtutor.components.sections.serviceExcellence
{
	import ca.georgebrown.trainingtutor.components.sections.CustomSection;
	import ca.georgebrown.trainingtutor.valueObjects.ConfigData;
	
	import sectionContent.ServiceExcellence.SE19;
	
	public class SE19Logic extends CustomSection
	{
		public function SE19Logic()
		{
			super( new SE19() );
			createDownloadButton( view.one, ConfigData.LINKS[ "missionStatement" ] );
			createDownloadButton( view.two, ConfigData.LINKS[ "scoreCards" ] );
			createDownloadButton( view.three, ConfigData.LINKS[ "coachingCheckList" ] );
		}
	}
}