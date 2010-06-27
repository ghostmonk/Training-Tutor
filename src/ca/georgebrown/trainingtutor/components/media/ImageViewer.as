package ca.georgebrown.trainingtutor.components.media
{
	import G3D4Y6f4t0l2UycswkI.RotatingBufferIcon;
	
	import assets.BrokenImage;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class ImageViewer extends Sprite
	{
		private var _bulkLoader:BulkAssetIDLoader;
		private var _currentImage:Bitmap;
		private var _currentIDs:Array;
		private var _isActive:Boolean;
		private var _currentID:String;
		private var	_loadingBuffer:RotatingBufferIcon;
		
		public function ImageViewer( imageData:Array )
		{
			_bulkLoader = new BulkAssetIDLoader( new Bitmap( new BrokenImage( 0, 0 ) ) );
			_loadingBuffer = new RotatingBufferIcon();
			_isActive = false;
			fillBulkLoader( imageData );
		}	
		
		public function updateView( percent:Number ) : void
		{
			if( !_isActive || _currentIDs == null ) return;
			
			var id:String = _currentIDs[ Math.min( _currentIDs.length - 1, Math.floor( _currentIDs.length * percent ) ) ];
			
			if( id == _currentID ) return;
			
			_currentID = id;
			showAsset( _currentID );
		}
		
		public function set imageIDs( value:Array ) : void
		{
			_currentIDs = value;
			
			if( _currentIDs.length > 0 ) 
			{
				_currentID = _currentIDs[0];
				showAsset( _currentID );
			}
		}
		
		public function buildIn() : void
		{
			_isActive = true;
			Tweener.addTween( this, { alpha:1, time:0.3, transition:Equations.easeNone } );
		}
		
		public function buildOut() : void
		{
			_isActive = false;	
			_currentID = null;
			Tweener.addTween( this, { alpha:0, time:0.3, transition:Equations.easeNone, onComplete:cleanView } );
		}
		
		public function showAsset( id:String ) : void
		{
			var outImage:Bitmap = _currentImage;
			if( outImage )
				Tweener.addTween( outImage, 
					{ alpha:0, time:0.3, transition:Equations.easeNone, onComplete:removeImage, onCompleteParams:[outImage] } );
			
			
			_currentImage = _bulkLoader.getAssetByID( id ) as Bitmap;
			_currentImage.alpha = 0;
			addChild( _currentImage );
			Tweener.addTween( _currentImage, { alpha:1, time:0.3, transition:Equations.easeNone } );
		}
		
		private function removeImage( img:Bitmap ) : void
		{
			if( img.parent ) img.parent.removeChild( img );
		}
		
		private function fillBulkLoader( images:Array ) : void
		{
			for each( var info:Object in images )
				_bulkLoader.addItem( info.src, info.id );
			_bulkLoader.startLoad();
		}
		
		private function cleanView() : void
		{
			if( _currentImage && _currentImage.parent == this ) removeChild( _currentImage );	
			_currentImage = null;
			if( parent ) parent.removeChild( this );
		}
	}
}