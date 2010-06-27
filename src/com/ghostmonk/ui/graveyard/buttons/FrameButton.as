package com.ghostmonk.ui.graveyard.buttons {
	
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * 
	 * Moves the playhead on a MovieClip from frame 1 to frame 2 on rollOver 
	 * and back to frame 1 on rollout, 
	 * 
	 * <p>Uses a callback function on MouseClick that was passed in on creation
	 * Button can be both enabled and diabled</p>
	 *  
	 * @author ghostmonk 01/15/2009
	 * 
	 */
	public class FrameButton {
		
		
		
		private var _view:MovieClip;
		private var _callBack:Function;
		private var _disableState:Bitmap;
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get view():MovieClip { 
		
			return _view;
			 
		}
		
		
		
		/**
		 * 
		 * @param view
		 * 
		 */
		public function FrameButton( view:MovieClip ) {
			
			_view = view;
			_view.stop();
			_view.mouseChildren = false;
			enable();
			
			_disableState = new Bitmap( new BitmapData( _view.width, _view.height, true, 0 ) );
			_disableState.bitmapData.draw( _view );
			_disableState.alpha = 0.7;
			Tweener.addTween( _disableState, { _color:0x676767, time:0 } );
			
		}
		
		
		
		/**
		 * 
		 * @param callback
		 * 
		 */
		public function addCallback( callback:Function ):void {
			
			_callBack = callback;
			
		}
		
		
		
		/**
		 * 
		 * 
		 */
		public function enable():void {
			
			_view.alpha = 1;
			
			try {
				_view.removeChild( _disableState )
			}
			catch(e:Error){
				//trace(e.message);
			}
			
			_view.buttonMode = true;
			_view.addEventListener( MouseEvent.ROLL_OVER, onRollOver );
			_view.addEventListener( MouseEvent.ROLL_OUT, onRollOut );
			_view.addEventListener( MouseEvent.CLICK, onClick );
			
		}
		
		
		
		/**
		 * 
		 * @param showAlpha
		 * @param showGrey
		 * 
		 */
		public function disable( showAlpha:Boolean = false, showGrey:Boolean = false ):void {
			
			if( showAlpha ) {
				_view.alpha = 0.5;
			} 
			
			if( showGrey ) {
				_view.addChild( _disableState );
			}
			
			_view.buttonMode = false;
			_view.removeEventListener( MouseEvent.ROLL_OVER, onRollOver );
			_view.removeEventListener( MouseEvent.ROLL_OUT, onRollOut );
			_view.removeEventListener( MouseEvent.CLICK, onClick );
			
		}
		
		
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function onRollOver( e:MouseEvent ):void {
			
			_view.gotoAndStop( 2 );
			
		}
		
		
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function onRollOut( e:MouseEvent ):void {
			
			_view.gotoAndStop( 1 );
			
		}
		
		
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function onClick( e:MouseEvent ):void {
			
			if( _callBack != null ) {
				_callBack( e );
			}
			
		}



	}
}