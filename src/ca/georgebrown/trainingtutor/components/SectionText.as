package ca.georgebrown.trainingtutor.components 
{	
	import body.SectionTextAsset;
	
	import ca.georgebrown.trainingtutor.utils.TextFormatting;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.TextShortcuts;
	
	import flash.filters.DropShadowFilter;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextFieldAutoSize;

	/**
	 * 
	 * @author ghostmonk 21/08/2009
	 * 
	 */
	public class SectionText extends SectionTextAsset 
	{	
		private const Y_OFFSET:Number = 20;
		private const MAX_BODY_HEIGHT:Number = 225;
		private const MAX_LINES:Number = 12;
		
		private var _titleY:int;
		private var _bodyTextY:int;
		private var _isInView:Boolean;
		private var _combinedHeight:Number; 
		
		public function SectionText() 
		{	
			_isInView = false;
			_combinedHeight = 0;
			TextShortcuts.init();
			initializeAssets();
		}
		
		public function get combinedHeight() : Number
		{
			return _combinedHeight;
		}
		
		public function set title( value:String ) : void 
		{	
			titleFld.alpha = 0;
			titleFld.htmlText = "<b>" + value + "</b>";
			_bodyTextY = titleFld.height - 2;
			
			if( _isInView )
				Tweener.addTween( titleFld, { alpha:1, time:0.3, transition:Equations.easeNone } );		
		}
		
		public function set bodyText( value:String ) : void 
		{	
			var viewText:String = TextFormatting.removeWhiteSpace( value );	
			bodyTextFld.y = _bodyTextY;
			bodyTextFld.autoSize = TextFieldAutoSize.LEFT;
			bodyTextFld.text = viewText;
			
			if( bodyTextFld.height > MAX_BODY_HEIGHT ) 
			{
				bodyTextFld.autoSize = TextFieldAutoSize.NONE;
				bodyTextFld.height = MAX_BODY_HEIGHT;
			}
			
			if( bodyTextFld.numLines <= MAX_LINES ) 
			{
				bodyTextFld.autoSize = TextFieldAutoSize.NONE;
				bodyTextFld.height += 10;
			}
			_combinedHeight = titleFld.height + bodyTextFld.height;
			bodyTextFld.text = "";
			Tweener.addTween( bodyTextFld, { _text:viewText, time:0.3, transition:Equations.easeNone } ); 	
		}
		
		public function buildIn() : void 
		{	
			_isInView = true;
			animateAssets( 1, 0.3, 0, null );		
		}
		
		public function buildOut() : void 
		{
			_isInView = false;	
			animateAssets( 0, 0, Y_OFFSET, onBuildOutComplete );	
		}
		
		private function initializeAssets() : void 
		{
			titleFld.filters = [ new DropShadowFilter( 0, 0, 90, 0.3, 30, 30, 1 ) ];
			_titleY = titleFld.y;
			titleFld.autoSize = TextFieldAutoSize.LEFT;
			titleFld.antiAliasType = AntiAliasType.ADVANCED;
			titleFld.gridFitType = GridFitType.PIXEL;
			titleFld.y = _titleY - Y_OFFSET;	
			
			_bodyTextY = bodyTextFld.y;
			bodyTextFld.autoSize = TextFieldAutoSize.LEFT;
			bodyTextFld.antiAliasType = AntiAliasType.ADVANCED;
			bodyTextFld.gridFitType = GridFitType.PIXEL;
			bodyTextFld.alpha = titleFld.alpha = 0;
			bodyTextFld.y = _bodyTextY + Y_OFFSET;
		}
		
		private function animateAssets( alpha:Number, delay:Number, offSet:Number, complete:Function ) : void 
		{		
			Tweener.addTween( bodyTextFld, { alpha:alpha, time:0.3, delay:delay, transition:Equations.easeNone } );
			Tweener.addTween( bodyTextFld, { y:_bodyTextY + offSet, delay:delay, time:0.5 } );	
			Tweener.addTween( titleFld, { alpha:alpha, time:0.3, delay:delay, transition:Equations.easeNone  } );
			Tweener.addTween( titleFld, { y:_titleY - offSet,  delay:delay, time:0.5, onComplete:complete } );	
		}
		
		private function onBuildOutComplete() : void 
		{	
			if( parent ) parent.removeChild( this );
		}
	}
}