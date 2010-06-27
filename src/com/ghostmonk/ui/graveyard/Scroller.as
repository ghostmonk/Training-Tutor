package com.ghostmonk.ui.graveyard 
{	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.events.PercentageEvent;
	import com.ghostmonk.ui.graveyard.buttons.DragButton;
	import com.ghostmonk.ui.graveyard.buttons.PressButton;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	[Event (name="change", type="com.ghostmonk.events.PercentageEvent")]
	
	/**
 	 * Self explanitory scroller, that dispatches positioning events by percentage of scroll max and min
	 * 
	 * @author ghostmonk 16/01/2009
	 * 
	 */
	public class Scroller extends EventDispatcher 
	{
		private var _view:Sprite;
		
		private var _handle:DragButton;
		private var _track:Sprite;
		private var _grip:Sprite;
		private var _up:PressButton;
		private var _down:PressButton;
		
		private var _maxY:Number;
		private var _minY:Number;
		private var _totalScrollDistance:Number;
		private var _scrollOffset:Number;
		private var _isScrolling:Boolean;
		
		public function init( scrollerAsset:IScrollerAsset ) : void
		{
			_view = scrollerAsset.container;
			
			_handle = new DragButton( scrollerAsset.handle );
			_handle.addCallback( onDrag );
			_handle.mouseDownCall( onMouseDown );
			_handle.mouseUpCall( onMouseUp );
			_track = scrollerAsset.track;
			
			_maxY = _track.y + _track.height - _handle.view.height;
			_minY = _track.y;
			_totalScrollDistance = _maxY - _minY;
			
			if( scrollerAsset.grip ) 
			{
				_grip = scrollerAsset.grip;
				_grip.mouseEnabled = false;
			}
			 
			if( scrollerAsset.upBtn ) 
			{	
				_up = new PressButton( scrollerAsset.upBtn );
				_up.addCallback( scrollUp );
			}
			
			if( scrollerAsset.downBtn ) 
			{	
				_down = new PressButton( scrollerAsset.downBtn );
				_down.addCallback( scrollDown );
			}	
			_isScrolling = false;
		}
		
		public function get view() : Sprite 
		{ 		
			return _view; 
		}
		
		public function enable() : void 
		{	
			_view.alpha = 1;
			_track.addEventListener( MouseEvent.CLICK, onTrackClick );
			_view.addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
			_handle.enable();
			view.visible = true;
			_handle.view.visible = true;
			
			if( _up ) _up.enable();
			if( _down ) _down.enable();
			
			Tweener.addTween( _view,  { alpha:1, time:0.1, transition:Equations.easeNone } );
		}
		
		public function disable( alpha:Number ) : void 
		{		
			_view.alpha = alpha;
			_track.removeEventListener( MouseEvent.CLICK, onTrackClick );
			_view.removeEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
			_handle.view.visible = false;
			
			if( _up ) _up.disable();	
			if( _down ) _down.disable();
		}
		
		public function scrollByPercent( value:Number ) : void
		{
			if( _isScrolling ) return;
			_handle.view.y = _maxY * value;
		}
		
		public function scroll( value:Number ) : void 
		{
			if( _isScrolling ) return;
			_handle.view.y += value;
			_handle.view.y = Math.max( _minY, Math.min( _maxY, _handle.view.y ) );
			dispatch();
		}

		public function setUp( targetHeight:Number, viewHeight:Number, minScale:Number = 1, maxScale:Number = 13 ) : void 
		{	
			view.height = viewHeight;
			setHandle( targetHeight, viewHeight, minScale, maxScale );	
		}
		
		private function setHandle( targetHeight:Number, viewHeight:Number, minScale:Number, maxScale:Number ) : void 
		{		
			var ratio:Number = viewHeight/targetHeight;
			var scale:Number = Math.min( maxScale, Math.max( minScale, ratio*maxScale ) );
			
			_handle.view.scaleY = scale;
			_maxY = _track.y + _track.height - _handle.view.height;  
			_totalScrollDistance = _maxY - _minY;
			_handle.view.y = _minY;
			
			if( targetHeight <= viewHeight ) disable( 0 );
			else enable();
			
			if( _grip ) _grip.y = _handle.view.y + _handle.view.height * 0.5 - _grip.height * 0.5;
		}
		
		private function scrollUp( e:Event ) : void 
		{		
			scroll( -5 );	
		}
		
		private function scrollDown( e:Event ) : void 
		{
			scroll( 5 );
		}
		
		private function onDrag( e:MouseEvent ) : void 
		{	
			_handle.view.y = Math.max( _minY, Math.min( _maxY, _view.mouseY- _scrollOffset ) );
			dispatch();
		}
		
		private function onMouseDown() : void 
		{	
			_isScrolling = true;
			_scrollOffset = _view.mouseY - _handle.view.y;
		}
		
		private function onMouseUp() : void
		{
			_isScrolling = false;
		}
		
		private function onTrackClick( e:MouseEvent ) : void
		{
			var yPos:Number = Math.max( _minY, Math.min( _maxY, _track.mouseY ) );
			Tweener.addTween( _handle.view, { y:yPos, time:0.3, onUpdate:dispatch } );
		}
		
		private function dispatch() : void 
		{		
			if( _grip ) _grip.y = _handle.view.y + _handle.view.height * 0.5 - _grip.height * 0.5;
			var percentage:Number = ( _handle.view.y - _minY ) / _totalScrollDistance;
			
			dispatchEvent( new PercentageEvent( PercentageEvent.CHANGE, percentage ) );
		}

		private function onMouseWheel( e:MouseEvent ):void 
		{	
			scroll( e.delta * -2 );	
		}
	}
}