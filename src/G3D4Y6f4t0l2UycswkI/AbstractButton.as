package G3D4Y6f4t0l2UycswkI 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class AbstractButton 
	{	
		protected var _view:Sprite;
		private var _mouseClickCall:Function;
		
		public function AbstractButton( view:Sprite, mouseClickCall:Function ) 
		{		
			_view = view;
			_mouseClickCall = mouseClickCall;
			enable();	
		}
		
		public function enable() : void 
		{	
			_view.buttonMode = true;
			_view.addEventListener( MouseEvent.CLICK, onClick );
			_view.addEventListener( MouseEvent.ROLL_OVER, onRollover );
			_view.addEventListener( MouseEvent.ROLL_OUT, onRollout );	
		}
		
		public function disable() : void 
		{	
			_view.buttonMode = false;
			_view.removeEventListener( MouseEvent.CLICK, onClick );
			_view.removeEventListener( MouseEvent.ROLL_OVER, onRollover );
			_view.removeEventListener( MouseEvent.ROLL_OUT, onRollout );	
		}
		
		protected function onRollover( e:MouseEvent ):void {}
		
		protected function onRollout( e:MouseEvent ):void {}
		
		private function onClick( e:MouseEvent ) : void
		{	
			_mouseClickCall( e );	
		}
	}
}