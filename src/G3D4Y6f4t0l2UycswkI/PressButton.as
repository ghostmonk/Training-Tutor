package G3D4Y6f4t0l2UycswkI {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class PressButton extends FrameButton {
		
		
		
		private var _callBack:Function;
		public var _isOver:Boolean;
		
		
		public var _isMouseDown:Boolean;
		
		public function PressButton( view:MovieClip ) {
			
			super( view );
			enable();
			_isOver = false;
			_isMouseDown = false;
			
		}
		
		override public function addCallback( callback:Function ):void {
			
			_callBack = callback;
			
		}
		
		override public function disable( showAlpha:Boolean = false, showGrey:Boolean = false ):void {
			
			super.disable();
			view.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			
		}
		
		override public function enable():void {
			
			super.enable();
			view.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			
		}
		
		override protected function onRollOut( e:MouseEvent ):void {
			
			_isOver = false;
			super.onRollOut( e );
			view.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			
			if( _isMouseDown ) {
				view.removeEventListener( MouseEvent.ROLL_OVER, onRollOver );
			}
			
		}
		
		override protected function onRollOver( e:MouseEvent ):void {
			
			_isOver = true;
			view.gotoAndStop( 2 );
			super.onRollOver( e );
			
		}
		
		
		
		private function onEnterFrame( e:Event ):void {
			
			_callBack( e );
			
		}
		
		
		private function onMouseDown( e:MouseEvent ):void {
			
			_isMouseDown = true;
			_isOver = true;
			view.gotoAndStop( 3 );
			view.stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			view.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
		}
		
		
		
		private function onMouseUp( e:MouseEvent ):void {
			
			_isMouseDown = false;
			view.addEventListener( MouseEvent.ROLL_OVER, onRollOver );
			
			if( _isOver ) {
				view.gotoAndStop(2);
			}
			
			view.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			view.stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			
		}
		
		
		
	}
}