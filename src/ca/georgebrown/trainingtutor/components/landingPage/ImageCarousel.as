package ca.georgebrown.trainingtutor.components.landingPage 
{	
	import ca.georgebrown.trainingtutor.events.landingPage.ImageTransitionEvent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.net.IndexLoader;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	[Event (name="imageChange", type="ca.georgebrown.trainingtutor.events.landingPage.ImageTransitionEvent")]
	[Event (name="firstImage", type="ca.georgebrown.trainingtutor.events.landingPage.ImageTransitionEvent")]
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class ImageCarousel extends EventDispatcher 
	{	
		private var _timer:Timer;
		private var _view:DisplayObjectContainer;
		
		private var _loaders:Array;
		
		private var _associativeData:Array;
		private var _rearrangedData:Array;
		private var _images:Array;
		
		private var _isEmpty:Boolean;
		private var _currentNode:int;
		
		private var _transitionTime:Number;
		
		public function ImageCarousel( imgs:Dictionary, delay:Number, transitionTime:Number ) 
		{	
			_timer = new Timer( delay );
			_transitionTime = transitionTime;
			_timer.addEventListener( TimerEvent.TIMER, onTimer );
			_images = new Array();
			_associativeData = new Array();
			_rearrangedData = new Array();
			_isEmpty = true;
			loadImages( imgs );
			
			_currentNode = 0;		
		}
		
		public function set display( view:DisplayObjectContainer ) : void 
		{	
			_view = view;	
		}
		
		public function buildOut( time:Number ) : void 
		{	
			Tweener.addTween( _view, { alpha:0, time:time, transition:Equations.easeNone } );		
		}
		
		public function buildIn( time:Number ) : void 
		{	
			Tweener.addTween( _view, { alpha:1, time:time, transition:Equations.easeNone } );	
		}
		
		private function loadImages( imgs:Dictionary ) : void 
		{		
			_loaders = new Array();
			
			var index:int = 0;
			
			for( var url:String in imgs ) {
				_loaders.push( new IndexLoader( url, index, onImageLoaded, null, null, new LoaderContext( true ) ) );
				_associativeData.push( imgs[ url ] );
				index++;
			}	
		}
		
		private function onImageLoaded( bitmap:Bitmap, index:int ) : void 
		{	
			bitmap.alpha = 0;
			_images.push( bitmap );
			_rearrangedData.push( _associativeData[ index ] );
			
			if( _isEmpty ) {
				_isEmpty = false;
				dispatchEvent( new ImageTransitionEvent( ImageTransitionEvent.FIRST_IMAGE, 0 ) );
				swapPicture();
				_timer.start();
			}
		}
		
		private function swapPicture() : void 
		{
			Tweener.addTween( _images[ _currentNode ], { alpha:0, time:_transitionTime, transition:Equations.easeNone, onComplete:_view.removeChild, onCompleteParams:[ _images[ _currentNode ] ] } );	
			
			if( _currentNode == _images.length -1 ) 
			{
				_currentNode = 0;
			}
			else 
			{
				_currentNode++;
			}
			
			dispatchEvent( new ImageTransitionEvent( ImageTransitionEvent.IMAGE_CHANGE, _rearrangedData[ _currentNode ] ) );
			_view.addChild( _images[ _currentNode ] );
			Tweener.addTween( _images[ _currentNode ], { alpha:1, time:_transitionTime, transition:Equations.easeNone } );
		}
		
		private function onTimer( e:TimerEvent ) : void 
		{	
			swapPicture();
		}
	}
}