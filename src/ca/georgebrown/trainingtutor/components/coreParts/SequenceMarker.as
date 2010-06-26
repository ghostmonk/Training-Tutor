package ca.georgebrown.trainingtutor.components.coreParts
{
	import assets.footer.SequenceMarkerAsset;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.text.TextFieldAutoSize;
	
	/**
	 * This class is a BAD IDEA 
	 * @author ghostmonk
	 * 
	 */
	public class SequenceMarker
	{
		private var _name:String;
		private var _view:SequenceMarkerAsset;
		private var _originalPosition:Number;
		private var _fullWidth:Number;
		
		public function SequenceMarker( view:SequenceMarkerAsset )
		{
			_view = view;
			_originalPosition = _view.x;
			_view.label.autoSize = TextFieldAutoSize.LEFT;
		}
		
		public function set name( value:String ) : void
		{
			_name = value;
			_view.label.text = value;
			_fullWidth = _view.width;
			_view.label.text = "";
		}
		
		public function getOpenXPosRight() : Number
		{
			return _originalPosition + _fullWidth + 5;
		}
		
		public function showName() : void
		{
			_view.marker.gotoAndStop( 2 );
			Tweener.addTween( _view, {x:_originalPosition, time:0.3, transition:Equations.easeNone} );
			Tweener.addTween( _view.label, {_text:_name, time:0.3, transition:Equations.easeNone} );
		}
		
		public function setXHome() : void
		{
			Tweener.addTween( _view, {x:_originalPosition, time:0.3, transition:Equations.easeNone} );
		}
		
		public function setXPos( value:Number ) : void
		{
			Tweener.addTween( _view, {x:value, time:0.3, transition:Equations.easeNone} );
		}
		
		public function hideName() : void
		{
			_view.marker.gotoAndStop( 1 );
			Tweener.addTween( _view.label, {_text:"", time:0.3, transition:Equations.easeNone} );
		}
	}
}