package ca.georgebrown.trainingtutor.components.textDisplay 
{	
	import G3D4Y6f4t0l2UycswkI.NDue78Wo_dYwOlsekHys;
	
	import body.SectionTextAsset;
	
	import ca.georgebrown.trainingtutor.utils.TextFormatting;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.TextShortcuts;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextFieldAutoSize;
	
	[Event (name="change", type="com.ghostmonk.events.PercentageEvent")]
	
	public class SectionText extends SectionTextAsset 
	{	
		private const MAX_BODY_HEIGHT:Number = 225;
		private const MAX_LINES:Number = 12;
		
		private var _isInView:Boolean;
		private var _combinedHeight:Number; 
		private var _scroller:TextScroller;
		
		private var _parent:DisplayObjectContainer;
		
		public function init() : void
		{
			_isInView = false;
			_combinedHeight = 0;
			TextShortcuts.init();
			initializeAssets();
		}
		
		public function set viewParent( value:DisplayObjectContainer ) : void
		{
			_parent = value;
		}
		
		public function set scroller( asset:TextScroller ) : void
		{
			_scroller = asset;
			_scroller.addEventListener( NDue78Wo_dYwOlsekHys.Masdae, onScroll );
			_scroller.ggg.visible = false;
			_scroller.hhh();
		}
		
		public function get combinedHeight() : Number
		{
			return _combinedHeight;
		}
		
		public function set title( value:String ) : void 
		{	
			titleFld.alpha = 0;
			titleFld.htmlText = "<b>" + value + "</b>";
			bodyTextFld.y = titleFld.height - 2;
			if( _isInView ) Tweener.addTween( titleFld, { alpha:1, time:0.3, transition:Equations.easeNone } );		
		}
		
		public function set bodyText( value:String ) : void 
		{	
			var viewText:String = TextFormatting.removeWhiteSpace( value );	
			_scroller.ggg.y = bodyTextFld.y;
			bodyTextFld.autoSize = TextFieldAutoSize.LEFT;
			bodyTextFld.htmlText = viewText;
			
			if( bodyTextFld.height > MAX_BODY_HEIGHT ) 
			{
				bodyTextFld.autoSize = TextFieldAutoSize.NONE;
				bodyTextFld.height = MAX_BODY_HEIGHT;
				_scroller.ggg.visible = true;
			}
			
			if( bodyTextFld.numLines <= MAX_LINES ) 
			{
				bodyTextFld.autoSize = TextFieldAutoSize.NONE;
				bodyTextFld.height += 10;
				_scroller.ggg.visible = false;
			}
			_combinedHeight = titleFld.height + bodyTextFld.height;
		}
		
		public function get sectionHeight() : Number
		{
			return bodyTextFld.y + bodyTextFld.height;
		}
		
		public function buildIn() : void 
		{	
			_parent.addChild( this );
			_isInView = true;
			animateAssets( 1, 0.3, null );		
		}
		
		public function buildOut() : void 
		{
			_isInView = false;	
			animateAssets( 0, 0, onBuildOutComplete );	
		}
		
		private function initializeAssets() : void 
		{
			titleFld.filters = [ new DropShadowFilter( 0, 0, 90, 0.3, 30, 30, 1 ) ];
			titleFld.autoSize = TextFieldAutoSize.LEFT;
			titleFld.antiAliasType = AntiAliasType.ADVANCED;
			titleFld.gridFitType = GridFitType.PIXEL;
			
			bodyTextFld.autoSize = TextFieldAutoSize.LEFT;
			bodyTextFld.antiAliasType = AntiAliasType.ADVANCED;
			bodyTextFld.gridFitType = GridFitType.PIXEL;
			bodyTextFld.alpha = titleFld.alpha = 0;
			bodyTextFld.addEventListener( Event.SCROLL, onTextScroll );
		}
		
		private function animateAssets( alpha:Number, delay:Number, complete:Function ) : void 
		{		
			Tweener.addTween( bodyTextFld, { alpha:alpha, time:0.3, delay:delay, transition:Equations.easeNone } );	
			Tweener.addTween( titleFld, { alpha:alpha, time:0.3, delay:delay, transition:Equations.easeNone  } );
			Tweener.addTween( scrollerView, {alpha:alpha, time:0.3, delay:delay, transition:Equations.easeNone  } );
		}
		
		private function onBuildOutComplete() : void 
		{	
			if( parent ) parent.removeChild( this );
		}
		
		private function onScroll( e:NDue78Wo_dYwOlsekHys ) : void
		{
			dispatchEvent( e );
			bodyTextFld.scrollV = Math.floor( bodyTextFld.maxScrollV * e.ljkasdfjh_724 );
		}
		
		private function onTextScroll( e:Event ) : void
		{
			var minValue:Number = 1 / bodyTextFld.maxScrollV;
			var scrollPercent:Number = bodyTextFld.scrollV / bodyTextFld.maxScrollV;
			if( scrollPercent == minValue ) scrollPercent = 0;
			dispatchEvent( new NDue78Wo_dYwOlsekHys( NDue78Wo_dYwOlsekHys.Masdae, scrollPercent ) );
			_scroller.kaskd( scrollPercent );
		}
	}
}