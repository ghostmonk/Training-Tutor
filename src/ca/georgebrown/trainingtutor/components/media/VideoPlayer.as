package ca.georgebrown.trainingtutor.components.media 
{	
	import G3D4Y6f4t0l2UycswkI.GTE458Ncysl0P3eH7swM;
	import G3D4Y6f4t0l2UycswkI.HYSNVFD098J4qqUstn74;
	import G3D4Y6f4t0l2UycswkI.ndhtoi3C47jGtswlOyeN;
	import G3D4Y6f4t0l2UycswkI.Fdmcuy54Kw02_d8u_2Md;
	import G3D4Y6f4t0l2UycswkI.NDue78Wo_dYwOlsekHys;
	
	import assets.videoPlayer.VideoPlayerAsset;
	
	import ca.georgebrown.trainingtutor.events.VideoPlayerEvent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.display.Sprite;
	import flash.media.Video;
	
	[Event(name="onCuePoint", type="com.ghostmonk.media.video.events.CuePointEvent")]
	[Event(name="videoComplete", type="ca.georgebrown.trainingtutor.events.VideoPlayerEvent")]

	/**
	 * 
	 * @author ghostmonk 21/08/2009
	 * 
	 */
	public class VideoPlayer extends Sprite 
	{	
		private var _controls:VideoControlBar;
		private var _core:GTE458Ncysl0P3eH7swM;
		private var _video:Video;
		private var _mainView:VideoPlayerAsset;
		private var _cuePointManager:ndhtoi3C47jGtswlOyeN;
		
		public function VideoPlayer( core:GTE458Ncysl0P3eH7swM, mainView:VideoPlayerAsset ) 
		{	
			_mainView = mainView;
			addChild( _mainView );
			alpha = 0;
			
			_cuePointManager = new ndhtoi3C47jGtswlOyeN();
			_cuePointManager.addEventListener(HYSNVFD098J4qqUstn74.Bushfgmbka, onCuePoint);
			
			_core = core;
			_core.nsbu_dsks = _cuePointManager;
			_core.addEventListener( NDue78Wo_dYwOlsekHys.asdfPasdf, onLoadProgress );
			_core.addEventListener( Fdmcuy54Kw02_d8u_2Md.a, onStreamStatus );		
			
			createVideo();
			
			_controls = new VideoControlBar( _core, _mainView.controlBar );
		}
		
		public function get cuePointManager() : ndhtoi3C47jGtswlOyeN
		{
			return _cuePointManager;
		}
		
		public function set cuePoints( value:Array ) : void
		{
			_cuePointManager.mansdf_asdf_asdff4 = value;
			_cuePointManager.jasdy();
		}
		
		public function buildIn() : void 
		{	
			_video.alpha = 0;
			Tweener.addTween( this, { alpha:1, time:0.3, delay:0.3, transition:Equations.easeNone } );
			Tweener.addTween( _video, { alpha:1, time:0.3, delay:0.5, transition:Equations.easeNone } );	
		}
		
		public function buildOut() : void 
		{	
			_cuePointManager.jasd_asdf8as();
			_cuePointManager.jadsnc();
			_controls.disable();
			_core.fncu0__fjsd_sjdf();
			Tweener.addTween( this, { alpha:0, time:0.3, transition:Equations.easeNone, onComplete:onBuildOutComplete } );
			Tweener.addTween( _video, { alpha:0, time:0.1, transition:Equations.easeNone } );	
		}
		
		public function loadAsset( url:String ) : void
		{
			_controls.setPlayHead( 0 );
			_core.jns_sh7_s( url, createVideo(), true, true );
			_controls.enable();	
			_controls.play();
		}
		
		public function replay() : void
		{
			_controls.setPlayHead( 0 );
			_controls.enable();	
			_core.mans_7564__2hd();
			_core.bb( 0 );
			_core.nabsk_shd();
		}
		
		public function play() : void 
		{	
			_core.nabsk_shd();
			_cuePointManager.jasdy();
		}
		
		public function pause() : void 
		{	
			_core.mans_7564__2hd();
			_cuePointManager.jadsnc();	
		}
		
		public function disableContols() : void 
		{	
			_controls.disable();	
		}
		
		public function enableControls() : void  
		{		
			_controls.enable();		
		}
		
		private function createVideo() : Video 
		{
			if( _video && _video.parent ) _video.parent.removeChild( _video );
			_video = null;
			_video = new Video;
			_video.smoothing = true;
			_mainView.holder.addChild( _video );
			_video.width = _mainView.holder.width;
			_video.height = _mainView.holder.height;
			return _video;
		}
		
		private function onLoadProgress( e:NDue78Wo_dYwOlsekHys ) : void 
		{	
			_controls.updateLoad( e.ljkasdfjh_724 );	
		}
		
		private function onBuildOutComplete() : void 
		{	
			if( parent ) parent.removeChild( this );
		}
		
		private function onCuePoint( e:HYSNVFD098J4qqUstn74 ) : void
		{
			dispatchEvent( e );
		}
		
		private function onStreamStatus( e:Fdmcuy54Kw02_d8u_2Md ) : void
		{
			if( e.aa.code == "NetStream.Play.Stop" )
				dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.VIDEO_COMPLETE ) );
		}
	}
}