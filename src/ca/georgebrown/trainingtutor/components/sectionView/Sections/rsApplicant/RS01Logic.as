package ca.georgebrown.trainingtutor.components.sectionView.Sections.rsApplicant
{
	import ca.georgebrown.trainingtutor.utils.ContinueBtnWrapper;
	
	import flash.events.Event;
	
	import sectionContent.RSApplicant.RS01;
	
	public class RS01Logic extends RS01
	{
		private static const ANIM_COMPLETE:String = "animComplete";
		private var _continue:ContinueBtnWrapper;
		
		public function RS01Logic()
		{
			_continue = new ContinueBtnWrapper( continueBtn, gotoNextSection );
			graph.stop();
			bodyText.stop();	
			startGraph();
		}
		
		private function startGraph() : void
		{
			graph.addEventListener( ANIM_COMPLETE, onGraphComplete );
			graph.play();
		}
		
		private function onGraphComplete( e:Event ) : void
		{
			bodyText.addEventListener( ANIM_COMPLETE, onBodyComplete );
			graph.removeEventListener( ANIM_COMPLETE, onGraphComplete );
			bodyText.play();
		}
		
		private function onBodyComplete( e:Event ) : void
		{
			bodyText.removeEventListener( ANIM_COMPLETE, onBodyComplete );
			_continue.show();
		}
		
		private function gotoNextSection() : void
		{
			trace( "gotoNextSection" );
		}
	}
}