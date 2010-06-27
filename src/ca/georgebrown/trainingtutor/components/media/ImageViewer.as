package ca.georgebrown.trainingtutor.components.media
{
	import G3D4Y6f4t0l2UycswkI.GT5e3mUshlUe2m__8w2N;
	
	import assets.BrokenImage;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class ImageViewer extends Sprite
	{
		private var _bulkLoader:BulkAssetIDLoader;
		private var _currentImage:Bitmap;
		private var _currentIDs:Array;
		private var _isActive:Boolean;
		private var _currentID:String;
		private var	_loadingBuffer:GT5e3mUshlUe2m__8w2N;
		
		private var _rotationTimer:Timer;
		private var _rotationNode:int;
		
		public function ImageViewer( imageData:Array )
		{
			_bulkLoader = new BulkAssetIDLoader( new Bitmap( new BrokenImage( 0, 0 ) ) );
			_loadingBuffer = new GT5e3mUshlUe2m__8w2N();
			_isActive = false;
			fillBulkLoader( imageData );
		}	
		
		private function startTimer( rate:int ) : void
		{
			_rotationTimer = new Timer( rate );
			_rotationTimer.addEventListener( TimerEvent.TIMER, onTimer );
			_rotationTimer.start();
		}
		
		private function stopTimer() : void
		{
			if( _rotationTimer == null ) return;
			_rotationNode = 0;
			_rotationTimer.stop();
			_rotationTimer.removeEventListener( TimerEvent.TIMER, onTimer );
			_rotationTimer = null;			
		}
		
		public function updateView( percent:Number ) : void
		{
			if( !_isActive || _currentIDs == null ) return;
			
			var id:String = _currentIDs[ Math.min( _currentIDs.length - 1, Math.floor( _currentIDs.length * percent ) ) ];
			
			if( id == _currentID ) return;
			
			_currentID = id;
			showAsset( _currentID );
		}
		
		public function setImageIDs( value:Array, useTimer:Boolean, rate:int ) : void
		{
			stopTimer();
			_currentIDs = value;
			_rotationNode = 0;
			
			if( useTimer ) startTimer( rate );
			
			if( _currentIDs.length > 0 ) 
			{
				_currentID = _currentIDs[ _rotationNode ];
				showAsset( _currentID );
			}
		}
		
		public function buildIn() : void
		{
			stopTimer();
			_isActive = true;
			Tweener.addTween( this, { alpha:1, time:0.3, transition:Equations.easeNone } );
		}
		
		public function buildOut() : void
		{
			stopTimer();
			_isActive = false;	
			_currentID = null;
			Tweener.addTween( this, { alpha:0, time:0.3, transition:Equations.easeNone, onComplete:cleanView } );
		}
		
		public function showAsset( id:String ) : void
		{
			var outImage:Bitmap = _currentImage;
			if( outImage )
				Tweener.addTween( outImage, 
					{ alpha:0, time:0.5, transition:Equations.easeNone, onComplete:removeImage, onCompleteParams:[outImage] } );
			
			
			_currentImage = _bulkLoader.getAssetByID( id ) as Bitmap;
			_currentImage.alpha = 0;
			addChild( _currentImage );
			Tweener.addTween( _currentImage, { alpha:1, time:0.5, transition:Equations.easeNone } );
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
			stopTimer();
			if( _currentImage && _currentImage.parent == this ) removeChild( _currentImage );	
			_currentImage = null;
			if( parent ) parent.removeChild( this );
		}
		
		private function onTimer( e:TimerEvent ) : void
		{
			_rotationNode++;
			if( _rotationNode == _currentIDs.length ) _rotationNode = 0;
			_currentID = _currentIDs[ _rotationNode ];
			showAsset( _currentID );
		}
	}
}