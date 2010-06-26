package ca.georgebrown.trainingtutor.components.sections
{
	import ca.georgebrown.trainingtutor.valueObjects.ConfigData;
	
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
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