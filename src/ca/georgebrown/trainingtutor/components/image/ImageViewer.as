package ca.georgebrown.trainingtutor.components.image
{
	import ca.georgebrown.trainingtutor.components.sectionView.MediaComponent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;

	public class ImageViewer extends MediaComponent
	{
		private var _loader:ImageCueLoader;
		private var _currentImage:Bitmap;
		private var _isActive:Boolean;
		private var _currentImages:Array;
		private var _currentIndex:int;
		
		public function ImageViewer( loader:ImageCueLoader )
		{
			_loader = loader;
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
		
		override public function buildIn() : void
		{
			_isActive = true;
			Tweener.addTween( this, { alpha:1, time:0.3, transition:Equations.easeNone } );
		}
		
		override public function buildOut() : void
		{
			_isActive = false;
			_currentImages = null;
			_currentIndex = 0;
			Tweener.addTween( this, { alpha:0, time:0.3, transition:Equations.easeNone, onComplete:cleanView } );
		}
		
		override public function loadAsset( id:String ) : void
		{
			if( _currentImage )
				Tweener.addTween( _currentImage, 
					{ alpha:0, time:0.3, transition:Equations.easeNone, onComplete:removeChild, onCompleteParams:[_currentImage] } );
			_currentImage = _loader.getImageByID( id );
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