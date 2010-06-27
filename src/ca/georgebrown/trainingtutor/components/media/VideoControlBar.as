package ca.georgebrown.trainingtutor.components.media 
{	
	import G3D4Y6f4t0l2UycswkI.CoreVideo;
	import G3D4Y6f4t0l2UycswkI.CustomNetStreamEvent;
	import G3D4Y6f4t0l2UycswkI.PercentageEvent;
	import G3D4Y6f4t0l2UycswkI.SimpleMovieClipButton;
	import G3D4Y6f4t0l2UycswkI.VideoControlEvent;
	import G3D4Y6f4t0l2UycswkI.VideoScrubBar;
	
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
		private var _scrubBar:VideoScrubBar;
		private var _playBtn:SimpleMovieClipButton;
		private var _pauseBtn:SimpleMovieClipButton;
		
		private var _rrwd:SimpleMovieClipButton;
		
		private var _video:CoreVideo;
		private var _view:VideoControlBarAsset;
		
		public function VideoControlBar( video:CoreVideo, asset:VideoControlBarAsset ) 
		{	
			_view = asset;
			
			_video = video;
			_video.addEventListener( CustomNetStreamEvent.STATUS, onStatus );
			
			_scrubBar = new VideoScrubBar( _view.scrubber.handle, _view.scrubber.progressBar, _view.scrubber.scrubGroove );
			if( !TrainingTutor.IS_DEBUG ) _scrubBar.disable();
			
			_playBtn = new SimpleMovieClipButton( _view.playBtn, play );
			_pauseBtn = new SimpleMovieClipButton( _view.pauseBtn, pause );
			_rrwd = new SimpleMovieClipButton( _view.rrwdBtn, onRRWD );
			disable();
		}
		
		public function enable() : void 
		{	
			_scrubBar.addEventListener( PercentageEvent.CHANGE, onChange );
			_scrubBar.addEventListener( VideoControlEvent.PAUSE, onScrub );
			_scrubBar.addEventListener( VideoControlEvent.PLAY, onScrub );
			
			togglePlayPause( _playBtn, _pauseBtn );
			_rrwd.enable();
		}
		
		public function disable() : void 
		{
			_scrubBar.removeEventListener( PercentageEvent.CHANGE, onChange );
			_scrubBar.removeEventListener( VideoControlEvent.PAUSE, onScrub );
			_scrubBar.removeEventListener( VideoControlEvent.PLAY, onScrub );
			_view.removeEventListener( Event.ENTER_FRAME, scrubHeadPosition );
			
			_playBtn.disable();
			_rrwd.disable();
		}
		
		public function setPlayHead( percent:Number ) : void 
		{	
			_scrubBar.setPlayhead( percent );
		}
		
		public function play( e:MouseEvent = null ) : void 
		{
			togglePlayPause( _pauseBtn, _playBtn );
			_view.addEventListener( Event.ENTER_FRAME, scrubHeadPosition );
			_video.play();
		}
		
		public function pause( e:MouseEvent = null ) : void 
		{
			togglePlayPause( _playBtn, _pauseBtn );
			_view.removeEventListener( Event.ENTER_FRAME, scrubHeadPosition );
			_video.pause();
		}
		
		public function updateLoad( percent:Number ) : void 
		{
			_scrubBar.onLoadProgress( percent );
		}
		
		private function togglePlayPause( addBtn:SimpleMovieClipButton, removeBtn:SimpleMovieClipButton ) : void 
		{
			removeBtn.disable();
			removeBtn.view.gotoAndStop( 1 );
			
			if( removeBtn.view.parent ) 
			{
				_view.removeChild( removeBtn.view );
			}
			
			addBtn.enable();
			_view.addChild( addBtn.view );
		}
		
		private function onChange( e:PercentageEvent ) : void 
		{		
			_video.timeAsPercent = e.percent;	
		}
		
		private function scrubHeadPosition( e:Event ) : void 
		{	
			_scrubBar.setPlayhead( _video.timeAsPercent );
		}
		
		private function onRRWD( e:MouseEvent ) : void 
		{
			_video.seek( 0 );
		}
		
		private function onScrub( e:VideoControlEvent ) : void 
		{		
			if( e.type == VideoControlEvent.PLAY ) play();
			else pause();
		}
		
		private function onStatus( e:CustomNetStreamEvent ) : void 
		{	
			_video.customNetStream.addEventListener( CustomNetStreamEvent.PLAY_STOP, onVideoComplete );
		}
		
		private function onVideoComplete( e:CustomNetStreamEvent ) : void 
		{	
			_video.dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.VIDEO_COMPLETE ) );
			_video.seek( 0 );
			_scrubBar.setPlayhead( 0 );
			_video.pause();
			togglePlayPause( _playBtn, _pauseBtn );
		}
		
	}
}