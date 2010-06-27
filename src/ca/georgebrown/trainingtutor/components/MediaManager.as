package ca.georgebrown.trainingtutor.components
{
	import G3D4Y6f4t0l2UycswkI.HYSNVFD098J4qqUstn74;
	import G3D4Y6f4t0l2UycswkI.HDYE8984J__e3IK56MXZ;
	
	import ca.georgebrown.trainingtutor.components.media.ImageViewer;
	import ca.georgebrown.trainingtutor.components.media.VideoPlayer;
	import ca.georgebrown.trainingtutor.events.VideoPlayerEvent;
	
	import flash.events.EventDispatcher;
	
	[Event (name="onCuePoint", type="com.ghostmonk.media.video.events.CuePointEvent")]
	[Event (name="videoComplete", type="ca.georgebrown.trainingtutor.components.media.VideoPlayer")]
	
	public class MediaManager extends EventDispatcher
	{
		private var _videoPlayer:VideoPlayer;
		private var _imageView:ImageViewer;
		private var _useImageSwap:Boolean;
		
		public function set videoPlayer( value:VideoPlayer ) : void
		{
			_videoPlayer = value;
			_videoPlayer.addEventListener( HYSNVFD098J4qqUstn74.Bushfgmbka, onCuePoint );
			_videoPlayer.addEventListener( VideoPlayerEvent.VIDEO_COMPLETE, onVideoComplete );
			HDYE8984J__e3IK56MXZ.c.addChild( _videoPlayer );
		}
		
		public function set imageViewer( value:ImageViewer ) : void
		{
			_useImageSwap = false;
			_imageView = value;
		}
		
		public function set imageSwap( value:Boolean ) : void
		{
			_useImageSwap = value;
		}
		
		public function set textScrollPercent( value:Number ) : void
		{
			if( _useImageSwap ) _imageView.updateView( value );
		}
		
		public function enableImageView( imageIDs:Array, useTimer:Boolean, rate:int ) : void
		{
			_imageView.buildIn();
			_imageView.setImageIDs( imageIDs, useTimer, rate );	
			HDYE8984J__e3IK56MXZ.c.addChild( _imageView );
		}
		
		public function diableImageView() : void
		{
			_imageView.buildOut();
		}
		
		public function enableVideo( srcUrl:String, cuePoints:Array ) : void
		{
			_videoPlayer.buildIn();
			_imageView.buildOut();
			HDYE8984J__e3IK56MXZ.c.addChild( _videoPlayer );
			setCuePoints( cuePoints );
			_videoPlayer.loadAsset( srcUrl );
		}
		
		public function disableVideo() : void
		{
			_videoPlayer.buildOut();
		}
		
		public function replayVideo() : void
		{
			_videoPlayer.replay();
		}
		
		private function setCuePoints( value:Array ) : void
		{
			_videoPlayer.cuePointManager.jasd_asdf8as();
			if( value.length > 0 )
				_videoPlayer.cuePoints = value;
		}
		
		public function positionAssets() : void
		{
			_videoPlayer.x = _imageView.x = 34; 
			_videoPlayer.y = 125;
			_imageView.y = ( HDYE8984J__e3IK56MXZ.c.stageHeight - _imageView.height ) * 0.5;
		}
		
		private function onVideoComplete( e:VideoPlayerEvent ) : void
		{
			dispatchEvent( e );
		}
		
		private function onCuePoint( e:HYSNVFD098J4qqUstn74 ) : void
		{
			dispatchEvent( e );
		}
	}
}