package ca.georgebrown.trainingtutor.components.media
{
	import assets.BrokenImage;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.ui.RotatingBufferIcon;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class ImageViewer extends Sprite
	{
		private var _bulkLoader:BulkAssetIDLoader;
		private var _currentImage:Bitmap;
		private var _isActive:Boolean;
		private var _currentImages:Array;
		private var _currentIndex:int;
		private var	_loadingBuffer:RotatingBufferIcon;
		
		public function ImageViewer()
		{
			_bulkLoader = new BulkAssetIDLoader( new Bitmap( new BrokenImage( 0, 0 ) ) );
			_loadingBuffer = new RotatingBufferIcon();
			_isActive = false;
		}
		
		public function set currentImages( value:Array ) : void
		{
			_currentImages = value;
		}
		
		public function updateView( percent:Number ) : void
		{
			if( !_isActive || _currentImages == null ) return;
			
			var index:int = Math.min( _currentImages.length - 1, ( _currentImages.length * percent ) );
			
			if( index == _currentIndex ) return;
			
			_currentIndex = index;
			loadAsset( _currentImages[ index ] );
		}
		
		public function buildIn() : void
		{
			_isActive = true;
			Tweener.addTween( this, { alpha:1, time:0.3, transition:Equations.easeNone } );
		}
		
		public function buildOut() : void
		{
			_isActive = false;
			_currentImages = null;
			_currentIndex = 0;
			Tweener.addTween( this, { alpha:0, time:0.3, transition:Equations.easeNone, onComplete:cleanView } );
		}
		
		public function loadAsset( id:String ) : void
		{
			if( _currentImage )
				Tweener.addTween( _currentImage, 
					{ alpha:0, time:0.3, transition:Equations.easeNone, onComplete:removeChild, onCompleteParams:[_currentImage] } );
			_currentImage.alpha = 0;
			addChild( _currentImage );
			Tweener.addTween( _currentImage, { alpha:1, time:0.3, transition:Equations.easeNone } );
		}
		
		private function cleanView() : void
		{
			if( _currentImage && _currentImage.parent == this ) removeChild( _currentImage );	
			_currentImage = null;
			if( parent ) parent.removeChild( this );
		}
	}
}