package ca.georgebrown.trainingtutor.components.sections.reEmployee
{
	import ca.georgebrown.trainingtutor.components.sections.CustomSection;
	import ca.georgebrown.trainingtutor.valueObjects.ConfigData;
	
	import sectionContent.RSEmployee.RSE03;
	
	public class RSE03Logic extends CustomSection
	{
		public function RSE03Logic()
		{
			super( new RSE03() );
			createDownloadButton( view.personalStyleBtn, ConfigData.LINKS[ "testYourself" ] );
		}
	}
}