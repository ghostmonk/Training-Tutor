package ca.georgebrown.trainingtutor.components
{
	import G3D4Y6f4t0l2UycswkI.HY6354Gskwo9876_4nBs;
	
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	import ca.georgebrown.trainingtutor.events.VideoPlayerEvent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.events.MouseEvent;
	
	import uiAssets.SectionNavigationAsset;

	[Event(name="nextSection", type="ca.georgebrown.trainingtutor.events.NavigationEvent")]
	[Event(name="replayVideo", type="ca.georgebrown.trainingtutor.events.VideoPlayerEvent")]
	
	public class BasicSectionNav extends SectionNavigationAsset
	{
		private var _continue:HY6354Gskwo9876_4nBs;
		private var _replay:HY6354Gskwo9876_4nBs;
		
		public function BasicSectionNav()
		{
			alpha = 0;
			_continue = new HY6354Gskwo9876_4nBs( continueBtn, onContinue );
			_replay = new HY6354Gskwo9876_4nBs( replayBtn, onReplay );
		}
		
		public function show( hasVideo:Boolean ) : void
		{
			_continue.enable();
			_replay.zzz.visible = hasVideo;
			if( hasVideo ) _replay.enable();
			Tweener.addTween( this, {alpha:1, time:0.3, transition:Equations.easeNone} );
		}
		
		public function hide() : void
		{
			_continue.disable();
			_replay.disable();
			Tweener.addTween( this, {alpha:0, time:0.3, transition:Equations.easeNone, onComplete:removeMe } );
		}
		
		private function removeMe() : void
		{
			if( parent ) parent.removeChild( this );
		}
		
		private function onContinue( e:MouseEvent ) : void
		{
			dispatchEvent( new NavigationEvent( NavigationEvent.NEXT_SECTION, -1 ) );
		}
		
		private function onReplay( e:MouseEvent ) : void 
		{
			dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.REPLAY_VIDEO ) );
		}
	}
}