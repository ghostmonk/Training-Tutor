package ca.georgebrown.trainingtutor.components.sections
{
	import ca.georgebrown.trainingtutor.events.CustomSectionEvent;
	import ca.georgebrown.trainingtutor.valueObjects.ConfigData;
	
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	
	import flash.events.MouseEvent;
	
	import sectionContent.Action.ActionView;

	public class Action extends CustomSection
	{
		public function Action()
		{
			super( new ActionView() );
			createDownloadButton( view.testYourselfBtn, ConfigData.LINKS[ "personalStyle" ] );
		}
		
		override protected function onAction( e:MouseEvent ) : void
		{
			dispatchEvent( new CustomSectionEvent( CustomSectionEvent.GO_HOME ) );
		}
	}
}