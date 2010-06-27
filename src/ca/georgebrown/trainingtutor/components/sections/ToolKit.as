package ca.georgebrown.trainingtutor.components.sections
{
	import G3D4Y6f4t0l2UycswkI.SimpleMovieClipButton;
	
	import ca.georgebrown.trainingtutor.valueObjects.ConfigData;
	
	import flash.events.MouseEvent;
	
	import sectionContent.ToolKit.TK;

	public class ToolKit extends CustomSection
	{
		private var _collegeResourcesLink:SimpleMovieClipButton;
		private var _contactCentreLink:SimpleMovieClipButton;
		
		public function ToolKit()
		{
			super( new TK() );
			_collegeResourcesLink = new SimpleMovieClipButton( view.button1, goToCollegeResources );
			_contactCentreLink = new SimpleMovieClipButton( view.button2, goToContactCentre );
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