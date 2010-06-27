package ca.georgebrown.trainingtutor.components.media 
{	
	import G3D4Y6f4t0l2UycswkI.GTE458Ncysl0P3eH7swM;
	import G3D4Y6f4t0l2UycswkI.Fdmcuy54Kw02_d8u_2Md;
	import G3D4Y6f4t0l2UycswkI.NDue78Wo_dYwOlsekHys;
	import G3D4Y6f4t0l2UycswkI.HY6354Gskwo9876_4nBs;
	import G3D4Y6f4t0l2UycswkI.Bt567_3jUshelIwyBs_9;
	import G3D4Y6f4t0l2UycswkI.B7365H__S2Ki2wotlMwq;
	
	import assets.videoPlayer.controlBar.VideoControlBarAsset;
	
	import ca.georgebrown.trainingtutor.events.VideoPlayerEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * 
	 * @author ghostmonk 21/08/2009
	 * 
	 */
	public class VideoControlBar extends EventDispatcher
	{	
		private var _scrubBar:B7365H__S2Ki2wotlMwq;
		private var _playBtn:HY6354Gskwo9876_4nBs;
		private var _pauseBtn:HY6354Gskwo9876_4nBs;
		
		private var _rrwd:HY6354Gskwo9876_4nBs;
		
		private var _video:GTE458Ncysl0P3eH7swM;
		private var _view:VideoControlBarAsset;
		
		public function VideoControlBar( video:GTE458Ncysl0P3eH7swM, asset:VideoControlBarAsset ) 
		{	
			_view = asset;
			
			_video = video;
			_video.addEventListener( Fdmcuy54Kw02_d8u_2Md.a, onStatus );
			
			_scrubBar = new B7365H__S2Ki2wotlMwq( _view.scrubber.handle, _view.scrubber.progressBar, _view.scrubber.scrubGroove );
			if( !TrainingTutor.IS_DEBUG ) _scrubBar.i();
			
			_playBtn = new HY6354Gskwo9876_4nBs( _view.playBtn, play );
			_pauseBtn = new HY6354Gskwo9876_4nBs( _view.pauseBtn, pause );
			_rrwd = new HY6354Gskwo9876_4nBs( _view.rrwdBtn, onRRWD );
			disable();
		}
		
		public function enable() : void 
		{	
			_scrubBar.addEventListener( NDue78Wo_dYwOlsekHys.Masdae, onChange );
			_scrubBar.addEventListener( Bt567_3jUshelIwyBs_9.K5T, onScrub );
			_scrubBar.addEventListener( Bt567_3jUshelIwyBs_9.Ge3K, onScrub );
			
			togglePlayPause( _playBtn, _pauseBtn );
			_rrwd.enable();
		}
		
		public function disable() : void 
		{
			_scrubBar.removeEventListener( NDue78Wo_dYwOlsekHys.Masdae, onChange );
			_scrubBar.removeEventListener( Bt567_3jUshelIwyBs_9.K5T, onScrub );
			_scrubBar.removeEventListener( Bt567_3jUshelIwyBs_9.Ge3K, onScrub );
			_view.removeEventListener( Event.ENTER_FRAME, scrubHeadPosition );
			
			_playBtn.disable();
			_rrwd.disable();
		}
		
		public function setPlayHead( percent:Number ) : void 
		{	
			_scrubBar.k( percent );
		}
		
		public function play( e:MouseEvent = null ) : void 
		{
			togglePlayPause( _pauseBtn, _playBtn );
			_view.addEventListener( Event.ENTER_FRAME, scrubHeadPosition );
			_video.nabsk_shd();
		}
		
		public function pause( e:MouseEvent = null ) : void 
		{
			togglePlayPause( _playBtn, _pauseBtn );
			_view.removeEventListener( Event.ENTER_FRAME, scrubHeadPosition );
			_video.mans_7564__2hd();
		}
		
		public function updateLoad( percent:Number ) : void 
		{
			_scrubBar.j( percent );
		}
		
		private function togglePlayPause( addBtn:HY6354Gskwo9876_4nBs, removeBtn:HY6354Gskwo9876_4nBs ) : void 
		{
			removeBtn.disable();
			removeBtn.zzz.gotoAndStop( 1 );
			
			if( removeBtn.zzz.parent ) 
			{
				_view.removeChild( removeBtn.zzz );
			}
			
			addBtn.enable();
			_view.addChild( addBtn.zzz );
		}
		
		private function onChange( e:NDue78Wo_dYwOlsekHys ) : void 
		{		
			_video.bsu9__sjdh = e.ljkasdfjh_724;	
		}
		
		private function scrubHeadPosition( e:Event ) : void 
		{	
			_scrubBar.k( _video.bsu9__sjdh );
		}
		
		private function onRRWD( e:MouseEvent ) : void 
		{
			_video.bb( 0 );
		}
		
		private function onScrub( e:Bt567_3jUshelIwyBs_9 ) : void 
		{		
			if( e.type == Bt567_3jUshelIwyBs_9.Ge3K ) play();
			else pause();
		}
		
		private function onStatus( e:Fdmcuy54Kw02_d8u_2Md ) : void 
		{	
			_video.nsbu8__sj.addEventListener( Fdmcuy54Kw02_d8u_2Md.p, onVideoComplete );
		}
		
		private function onVideoComplete( e:Fdmcuy54Kw02_d8u_2Md ) : void 
		{	
			_video.dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.VIDEO_COMPLETE ) );
			_video.bb( 0 );
			_scrubBar.k( 0 );
			_video.mans_7564__2hd();
			togglePlayPause( _playBtn, _pauseBtn );
		}
		
	}
}