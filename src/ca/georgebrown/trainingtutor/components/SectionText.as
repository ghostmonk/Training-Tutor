package ca.georgebrown.trainingtutor.components 
{	
	import body.SectionTextAsset;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.TextShortcuts;
	
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;

	/**
	 * 
	 * @author ghostmonk 21/08/2009
	 * 
	 */
	public class SectionText extends SectionTextAsset 
	{	
		private const Y_OFFSET:Number = 20;
		
		private var _titleY:int;
		private var _bodyTextY:int;
		private var _isInView:Boolean;
		
		public function SectionText() 
		{	
			_isInView = false;
			TextShortcuts.init();
			initializeAssets();
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		public function set title( value:String ) : void 
		{	
			titleFld.alpha = 0;
			titleFld.text = value;
			_bodyTextY = titleFld.height - 2;
			titleFld.htmlText = "<b>" + value + "</b>";
			
			if( _isInView )
			{
				Tweener.addTween( titleFld, { alpha:1, time:0.3, transition:Equations.easeNone } );
			} 		
		}
		
		public function set bodyText( value:String ) : void 
		{		
			bodyTextFld.y  = _bodyTextY;
			Tweener.addTween( bodyTextFld, { _text:value, time:0.3, transition:Equations.easeNone } ); 	
		}
		
		public function buildIn() : void 
		{	
			_isInView = true;
			animateAssets( 1, 0.5, 0, null );		
		}
		
		public function buildOut() : void 
		{
			_isInView = false;	
			animateAssets( 0, 0, Y_OFFSET, onBuildOutComplete );	
		}
		
		private function initializeAssets() : void 
		{		
			titleFld.autoSize = TextFieldAutoSize.LEFT;
			_titleY = titleFld.y;
			_bodyTextY = bodyTextFld.y;
			bodyTextFld.alpha = titleFld.alpha = 0;
			bodyTextFld.y = _bodyTextY + Y_OFFSET
			titleFld.y = _titleY - Y_OFFSET;	
		}
		
		private function animateAssets( alpha:Number, delay:Number, offSet:Number, complete:Function ) : void 
		{		
			Tweener.addTween( bodyTextFld, { alpha:alpha, time:0.3, delay:delay, transition:Equations.easeNone } );
			Tweener.addTween( bodyTextFld, { y:_bodyTextY + offSet, delay:delay, time:0.5 } );	
			Tweener.addTween( titleFld, { alpha:alpha, time:0.3, delay:delay, transition:Equations.easeNone  } );
			Tweener.addTween( titleFld, { y:_titleY - offSet,  delay:delay, time:0.5, onComplete:complete } );	
		}
		
		private function onAddedToStage( e:Event ) : void 
		{		
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			x = stage.stageWidth - width - 40;
			y = 250;	
		}
		
		private function onBuildOutComplete() : void 
		{	
			if( parent ) parent.removeChild( this );
		}
	}
}