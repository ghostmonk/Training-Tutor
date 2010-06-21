package ca.georgebrown.trainingtutor.components.sections
{
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	
	import flash.events.MouseEvent;
	
	import sectionContent.ToolKit.TK;

	public class ToolKit extends CustomSection
	{
		private var _select01:SimpleMovieClipButton;
		private var _select02:SimpleMovieClipButton;
		
		public function ToolKit()
		{
			super( new TK() );
			_select01 = new SimpleMovieClipButton( view.button1, onButtonClick01 );
			_select02 = new SimpleMovieClipButton( view.button2, onButtonClick02 );
		}
		
		private function onButtonClick01( e:MouseEvent ) : void
		{
			trace( "one" );
		}
		
		private function onButtonClick02( e:MouseEvent ) : void
		{
			trace( "two" );
		}
	}
}