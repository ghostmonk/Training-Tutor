package com.ghostmonk.ui.graveyard.buttons 
{	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/** 
	 * @author ghostmonk
	 */
	public class DragButton extends FrameButton 
	{
		private var _callBack:Function;
		private var _mouseDown:Function;
		private var _mouseUp:Function;
		private var _isOver:Boolean;
		
		public function DragButton( view:MovieClip ) 
		{	
			super( view );
			_isOver = false;
			enable();
		}
		
		override public function enable():void 
		{	
			super.enable();
			view.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			view.addEventListener( MouseEvent.MOUSE_OVER, overTracker );
			view.addEventListener( MouseEvent.MOUSE_OUT, overTracker );	
		}
		
		override public function disable( showAlpha:Boolean = false, showGrey:Boolean = false ) : void 
		{	
			super.disable();
			view.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			view.removeEventListener( MouseEvent.MOUSE_OVER, overTracker );
			view.removeEventListener( MouseEvent.MOUSE_OUT, overTracker );
		}
		
		override public function addCallback( callback:Function ) : void 
		{		
			_callBack = callback;	
		}
		
		public function mouseDownCall( callBack:Function ) : void 
		{	
			_mouseDown = callBack;
		}
		
		public function mouseUpCall( callBack:Function ) : void
		{
			_mouseUp = callBack;
		}
		
		public function onMouseDown( e:MouseEvent ) : void 
		{
			if( _mouseDown != null ) _mouseDown();
			super.disable();
			view.buttonMode = true;
			view.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			view.stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );	
		}
		
		private function onMouseUp( e:MouseEvent ) : void 
		{			
			super.enable();
			
			if( !_isOver ) view.gotoAndStop( 1 );
			if( _mouseUp != null ) _mouseUp();
			 
			view.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			view.stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		}
		
		private function onMouseMove( e:MouseEvent ) : void 
		{	
			_callBack( e );
		}
		
		private function overTracker( e:MouseEvent ) : void 
		{	
			_isOver = e.type == MouseEvent.MOUSE_OVER ? true : false;	
		}
	}
}