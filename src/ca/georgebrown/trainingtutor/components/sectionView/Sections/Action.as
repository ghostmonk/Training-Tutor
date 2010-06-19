package ca.georgebrown.trainingtutor.components.sectionView.Sections
{
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	
	import flash.events.MouseEvent;
	
	import sectionContent.Action.ActionView;

	public class Action extends ActionView
	{
		private var _homeButton:SimpleMovieClipButton;
		private var _testButton:SimpleMovieClipButton;
		
		public function Action()
		{
			_homeButton = new SimpleMovieClipButton( homeBtn, onHomeClick );
			_testButton = new SimpleMovieClipButton( testYourselfBtn, onTestYourselfClick );
		}
		
		private function onHomeClick( e:MouseEvent ) : void
		{
			trace( "going home" );
		}
		
		private function onTestYourselfClick( e:MouseEvent ) : void
		{
			trace( "test yourself" );
		}
	}
}