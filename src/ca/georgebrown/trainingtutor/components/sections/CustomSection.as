package ca.georgebrown.trainingtutor.components.sections
{
	import G3D4Y6f4t0l2UycswkI.HY6354Gskwo9876_4nBs;
	
	import ca.georgebrown.trainingtutor.events.CustomSectionEvent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	[Event (name="replay", type="ca.georgebrown.trainingtutor.events.CustomSectionEvent")]
	[Event (name="nextSection", type="ca.georgebrown.trainingtutor.events.CustomSectionEvent")]
	[Event (name="goHome", type="ca.georgebrown.trainingtutor.events.CustomSectionEvent")]
	
	public class CustomSection extends EventDispatcher
	{
		protected static const ANIM_COMPLETE:String = "animComplete";
		protected static const TOUCHPOINT_PAUSE_LENGTH:Number = 1000;
		private var _actionBtn:HY6354Gskwo9876_4nBs;
		private var _replayBtn:HY6354Gskwo9876_4nBs;
		
		private var _downloadButton:HY6354Gskwo9876_4nBs;
		private var _downloadSource:String;
		
		private var _view:MovieClip;
		
		public function CustomSection( view:MovieClip )
		{
			_view = view;
			_view.addEventListener( ANIM_COMPLETE, onAnimComplete );
			_actionBtn = createSimpleButton( view.actionBtn, onAction );
			_replayBtn = createSimpleButton( view.videoReplayBtn, onVideoReplay );
			if( TrainingTutor.IS_DEBUG ) showActionButtons();
		}
		
		protected function visitSite( url:String ) : void
		{
			navigateToURL( new URLRequest( url ), "_blank" );
		}
		
		public function get view() : MovieClip
		{
			return _view;
		}
		
		public function buildOut() : void
		{
			Tweener.addTween( _view, {alpha:0, time:0.2, transition:Equations.easeNone, 
				onComplete: function() : void
				{
					if( _view.parent ) _view.parent.removeChild( _view );
				} 
			} );
		}
		
		public function showActionButtons() : void
		{
			buildInButton( _actionBtn );
			buildInButton( _replayBtn );
		}
		
		protected function onAnimComplete( e:Event ) : void
		{
			showActionButtons();	
		}
		
		protected function onAction( e:MouseEvent ) : void
		{
			dispatchEvent( new CustomSectionEvent( CustomSectionEvent.NEXT_SECTION ) );
		}
		
		protected function createDownloadButton( mcBtn:MovieClip, sourceFile:String ) : void
		{
			_downloadSource = sourceFile;
			_downloadButton =  new HY6354Gskwo9876_4nBs( mcBtn, downloadFile );
		}
		
		private function downloadFile( e:MouseEvent ) : void
		{
			new FileReference().download( new URLRequest( _downloadSource ) );
		}
		
		private function onVideoReplay( e:MouseEvent ) : void
		{
			dispatchEvent( new CustomSectionEvent( CustomSectionEvent.REPLAY ) );
		}
		
		private function buildInButton( btn:HY6354Gskwo9876_4nBs ) : void
		{
			if( !btn ) return;
			btn.zzz.visible = true;
			Tweener.addTween( btn.zzz, { alpha:1, time:0.3, transition:Equations.easeNone, onComplete:btn.enable } );
		}
		
		private function createSimpleButton( view:MovieClip, callback:Function ) : HY6354Gskwo9876_4nBs
		{
			if( !view ) return null;
			var output:HY6354Gskwo9876_4nBs = new HY6354Gskwo9876_4nBs( view, callback );
			output.zzz.alpha = 0;
			output.zzz.visible = false;
			output.disable();
			return output;
		}
	}
}