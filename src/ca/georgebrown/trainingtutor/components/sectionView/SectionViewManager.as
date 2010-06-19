package ca.georgebrown.trainingtutor.components.sectionView
{
	import ca.georgebrown.trainingtutor.components.SectionNavigation;
	import ca.georgebrown.trainingtutor.components.image.ImageViewer;
	import ca.georgebrown.trainingtutor.components.video.VideoPlayer;
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	import ca.georgebrown.trainingtutor.valueObjects.SectionContentData;
	import ca.georgebrown.trainingtutor.valueObjects.ViewLookup;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.events.PercentageEvent;
	import com.ghostmonk.media.video.events.CuePointEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class SectionViewManager extends Sprite
	{
		private var _videoPlayer:VideoPlayer;
		private var _imageView:ImageViewer;
		private var _sectionText:SectionText;
		private var _sectionNav:SectionNavigation;
		private var _useImageSwap:Boolean;
		
		private var _customView:MovieClip;
		private var _stage:Stage;
		
		public function SectionViewManager()
		{
			_useImageSwap = false;
		}
		
		public function set mainStage( stage:Stage ) : void
		{
			_stage = stage;
			positionAssets();
		}
		
		public function set videoPlayer( value:VideoPlayer ) : void
		{
			_videoPlayer = value;
			_videoPlayer.addEventListener( CuePointEvent.ON_CUE_POINT, onCuePoint );
			addChild( _videoPlayer );
		}
		
		public function set imageViewer( value:ImageViewer ) : void
		{
			_imageView = value;
		}
		
		public function set sectionNav( value:SectionNavigation ) : void
		{
			_sectionNav = value;
			_sectionNav.addEventListener( NavigationEvent.NEXT_SECTION, onNextSection );
			_sectionNav.addEventListener( NavigationEvent.REPLAY_VIDEO, onVideoReplay );
			addChild( _sectionNav );
		}
		
		public function set sectionText( value:SectionText ) : void
		{
			_sectionText = value;
			_sectionText.addEventListener( PercentageEvent.CHANGE, onTextChange );
			_sectionText.viewParent = this;
		}
		
		public function showView( activeView:MediaComponent, assetID:String, images:Array = null ) : void
		{
			var inactiveView:MediaComponent = activeView == _videoPlayer ? _imageView : _videoPlayer;
			_stage.addChild( activeView );
			activeView.buildIn();
			activeView.loadAsset( assetID );
			inactiveView.buildOut();
			if( activeView == _imageView && images ) _imageView
		}
		
		public function analyzeSectionContent( content:SectionContentData ) : void
		{
			removeCustomView();
			
			_videoPlayer.cuePointManager.clearCuePoints();
			
			if( content.hasVideo ) 
				showView( _videoPlayer, content.videoURL );
			else 
				_videoPlayer.buildOut();
			
			if( content.isBasic ) 
				createBasicView( content );
			else if( content.isSequential ) 
				createSequentialView( content );
			else 
				createComplexView( content );
				
			if( content.hasCuePoints ) 
				_videoPlayer.cuePoints = content.cuePoints;
			
		}
		
		private function removeCustomView() : void
		{
			if( _customView == null ) return;
			var tempCustom:MovieClip = _customView;
			_customView = null;
			Tweener.addTween( tempCustom, {alpha:0, time:0.2, transition:Equations.easeNone, 
				onComplete: function() : void
				{
					if( tempCustom.parent ) tempCustom.parent.removeChild( tempCustom );
					tempCustom = null;
				} 
			} );
		}
		
		private function createComplexView( content:SectionContentData ) : void
		{
			_imageView.buildOut();
			_sectionText.buildOut();
				
			_customView = ViewLookup.getView( content.contentType );	
			_stage.addChild( this );	
			addChild( _customView );
		}
		
		private function createSequentialView( content:SectionContentData ) : void
		{
			
		}
		
		private function createBasicView( content:SectionContentData ) : void
		{
			_sectionText.buildIn();
			addChild( _sectionText );
			
			if( content.hasVideo ) 
				showView( _videoPlayer, content.videoURL );
			else 
				showView( _imageView, content.imageIDs[ 0 ] );
			
			_sectionText.title = content.title;
			_sectionText.bodyText = content.bodyText;	
			
			_imageView.currentImages = content.imageIDs;
			_useImageSwap = content.useChangeOnTextScroll;
			
			_sectionNav.showReplay = content.hasVideo;
			
			positionAssets();
		}
		
		private function onTextChange( e:PercentageEvent ) : void
		{
			if( _useImageSwap ) _imageView.updateView( e.percent );
		}
		
		private function onVideoReplay( e:NavigationEvent ) : void 
		{
			_videoPlayer.replay();
		}
		
		private function onNextSection( e:NavigationEvent ) : void
		{
		}
		
		private function positionAssets() : void
		{
			_videoPlayer.x = _imageView.x = 34; 
			_videoPlayer.y = ( _stage.stageHeight - _videoPlayer.height ) * 0.5;
			_imageView.y = ( _stage.stageHeight - _imageView.height ) * 0.5;
			
			var sectionHeight:Number = _sectionNav.height + _sectionText.combinedHeight;
			
			_sectionText.x = _stage.stageWidth - _sectionText.width - 40;
			_sectionText.y = ( _videoPlayer.height - sectionHeight ) * 0.5 + _videoPlayer.y;
			
			_sectionNav.x = _sectionText.x;
			_sectionNav.yPos = _sectionText.y + _sectionText.sectionHeight + 10;
		}
		
		private function onCuePoint( e:CuePointEvent ) : void
		{
			if( _customView ) 
				_customView.play();
		}
	}
}