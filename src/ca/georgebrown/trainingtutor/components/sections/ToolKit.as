package ca.georgebrown.trainingtutor.components.sections
{
	import G3D4Y6f4t0l2UycswkI.HY6354Gskwo9876_4nBs;
	
	import ca.georgebrown.trainingtutor.valueObjects.ConfigData;
	
	import flash.events.MouseEvent;
	
	import sectionContent.ToolKit.TK;

	public class ToolKit extends CustomSection
	{
		private var _collegeResourcesLink:HY6354Gskwo9876_4nBs;
		private var _contactCentreLink:HY6354Gskwo9876_4nBs;
		
		public function ToolKit()
		{
			super( new TK() );
			_collegeResourcesLink = new HY6354Gskwo9876_4nBs( view.button1, goToCollegeResources );
			_contactCentreLink = new HY6354Gskwo9876_4nBs( view.button2, goToContactCentre );
		}
		
		private function goToCollegeResources( e:MouseEvent ) : void
		{
			visitSite( ConfigData.LINKS[ "collegeResourses" ] ); 
		}
		
		private function goToContactCentre( e:MouseEvent ) : void
		{
			visitSite( ConfigData.LINKS[ "contactCentre" ] );
		}
	}
}