package ca.georgebrown.trainingtutor.components.sections.rsApplicant
{
	import ca.georgebrown.trainingtutor.components.sections.CustomSection;
	
	import flash.events.Event;
	
	import sectionContent.RSApplicant.RS01;
	
	public class RS01Logic extends CustomSection
	{
		public function RS01Logic()
		{
			super( new RS01() );
			view.graph.stop();
			view.bodyText.stop();
			startGraph();
		}
		
		private function startGraph() : void
		{
			view.graph.addEventListener( ANIM_COMPLETE, onGraphComplete );
			view.graph.play();
		}
		
		private function onGraphComplete( e:Event ) : void
		{
			view.bodyText.addEventListener( ANIM_COMPLETE, onBodyComplete );
			view.graph.removeEventListener( ANIM_COMPLETE, onGraphComplete );
			view.bodyText.play();
		}
		
		private function onBodyComplete( e:Event ) : void
		{
			view.bodyText.removeEventListener( ANIM_COMPLETE, onBodyComplete );
			showActionButtons();
		}
	}
}