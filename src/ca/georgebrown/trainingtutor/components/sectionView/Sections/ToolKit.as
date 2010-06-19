package ca.georgebrown.trainingtutor.components.sectionView.Sections
{
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	
	import flash.events.MouseEvent;
	
	import sectionContent.ToolKit.TK;

	public class ToolKit extends TK
	{
		private var _select01:SimpleMovieClipButton;
		private var _select02:SimpleMovieClipButton;
		
		public function ToolKit()
		{
			_select01 = new SimpleMovieClipButton( button1, onButtonClick01 );
			_select02 = new SimpleMovieClipButton( button2, onButtonClick02 );
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