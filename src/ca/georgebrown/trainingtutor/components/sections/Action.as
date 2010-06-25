package ca.georgebrown.trainingtutor.components.sections
{
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	
	import flash.events.MouseEvent;
	
	import sectionContent.Action.ActionView;

	public class Action extends CustomSection
	{
		private var _testButton:SimpleMovieClipButton;
		
		public function Action()
		{
			super( new ActionView() );
			_testButton = new SimpleMovieClipButton( view.testYourselfBtn, onTestYourselfClick );
		}
		
		override protected function onAction( e:MouseEvent ) : void
		{
			trace( "go home" );
		}
		
		private function onTestYourselfClick( e:MouseEvent ) : void
		{
			trace( "test yourself" );
		}
	}
}