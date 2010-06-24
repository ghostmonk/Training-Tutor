package ca.georgebrown.trainingtutor.components
{
	import ca.georgebrown.trainingtutor.components.media.ImageViewer;
	import ca.georgebrown.trainingtutor.components.media.VideoPlayer;
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	
	import com.ghostmonk.media.video.events.CuePointEvent;
	import com.ghostmonk.utils.MainStage;
	
	import flash.events.EventDispatcher;
	
	[Event (name="onCuePoint", type="com.ghostmonk.media.video.events.CuePointEvent")]
	
	public class MediaManager extends EventDispatcher
	{
		private var _videoPlayer:VideoPlayer;
		private var _imageView:ImageViewer;
		private var _useImageSwap:Boolean;
		
		public function set videoPlayer( value:VideoPlayer ) : void
		{
			_videoPlayer = value;
			_videoPlayer.addEventListener( CuePointEvent.ON_CUE_POINT, onCuePoint );
			MainStage.instance.addChild( _videoPlayer );
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
		
		public function enableImageView( imageIDs:Array ) : void
		{
			_imageView.buildIn();
			_imageView.imageIDs = imageIDs;	
			MainStage.instance.addChild( _imageView );
		}
		
		public function diableImageView() : void
		{
			_imageView.buildOut();
		}
		
		public function enableVideo( srcUrl:String, cuePoints:Array ) : void
		{
			_videoPlayer.buildIn();
			_imageView.buildOut();
			MainStage.instance.addChild( _videoPlayer );
			setCuePoints( cuePoints );
			_videoPlayer.loadAsset( srcUrl );
		}
		
		public function disableVideo() : void
		{
			_videoPlayer.buildOut();
		}
		
		private function setCuePoints( value:Array ) : void
		{
			_videoPlayer.cuePointManager.clearCuePoints();
			if( value.length > 0 )
				_videoPlayer.cuePoints = value;
		}
		
		public function positionAssets() : void
		{
			_videoPlayer.x = _imageView.x = 34; 
			_videoPlayer.y = ( MainStage.instance.stageHeight - _videoPlayer.height ) * 0.5;
			_imageView.y = ( MainStage.instance.stageHeight - _imageView.height ) * 0.5;
		}
		
		private function onVideoReplay( e:NavigationEvent ) : void 
		{
			_videoPlayer.replay();
		}
		
		private function onCuePoint( e:CuePointEvent ) : void
		{
			dispatchEvent( e );
		}
	}
}