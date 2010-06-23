package ca.georgebrown.trainingtutor.components.landingPage 
{	
	import assets.LargeLabel;
	
	import ca.georgebrown.trainingtutor.events.ImageTransitionEvent;
	import ca.georgebrown.trainingtutor.events.LandingPageStateEvent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.ui.RotatingBufferIcon;
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import homePage.LandingPageAsset;
	
	[Event (name="landingComplete", type="ca.georgebrown.trainingtutor.events.landingPage.LandingPageStateEvent")]
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class LandingPage extends LandingPageAsset 
	{	
		private const Y_OFFSET:Number = 40;
		
		private var _carousel:ImageCarousel;
		private var _startButton:SimpleMovieClipButton;
		private var _failedLoginMsg:String;
		private var _rotatingBufferIcon:RotatingBufferIcon;
		private var _label:LargeLabel;
		
		private var _logoHomePos:Point;
		private var _logoHomeScale:Number;
		private var _mainTitleY:int;
		private var _subTitleY:int;
		private var _getStartedY:int;
		private var _startBtnY:int;
		
		public function LandingPage( carousel:ImageCarousel ) 
		{	
			_label = new LargeLabel();
			_rotatingBufferIcon = new RotatingBufferIcon( 0x0162a6 );
			_startButton = new SimpleMovieClipButton( startBtn, onStart );
			_startButton.disable();
			_carousel = carousel;
			_carousel.addEventListener( ImageTransitionEvent.IMAGE_CHANGE, onCarouselUpdate );
			_carousel.addEventListener( ImageTransitionEvent.FIRST_IMAGE, onFirstImage );
			_carousel.display = holder;
			positionDisplayAssets();	
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( e:Event ) : void
		{
				
			_rotatingBufferIcon.x = ( stage.stageWidth - _rotatingBufferIcon.width ) * 0.5;
			_rotatingBufferIcon.y = ( stage.stageHeight - _rotatingBufferIcon.height ) * 0.5;
			_label.x = ( stage.stageWidth - _label.width ) * 0.5;
			_label.y = _rotatingBufferIcon.y - _label.height - 10;
			
			addChild( _rotatingBufferIcon );
			addChild( _label );
			_rotatingBufferIcon.buildIn();
			_label.alpha = 0;
			Tweener.addTween( _label, {alpha:1, time:0.3, transition:Equations.easeNone} );
		}
		
		public function buildIn():void 
		{	
			tweenAsset( mainTitle, _mainTitleY, 0.8 );
			tweenAsset( subTitle, _subTitleY, 1 );
			tweenAsset( startedTextFld, _getStartedY, 1.4 );
			tweenAsset( getTextField, _getStartedY, 1.4 );
			tweenAsset( startBtn, _startBtnY, 1.6, 1, _startButton.enable );
			buildInLogo( 1.5 );
			_carousel.buildIn( 1.5 );	
		}
		
		public function buildOut() : void 
		{
			tweenAsset( mainTitle, _mainTitleY + -Y_OFFSET, 0, 0 );
			tweenAsset( subTitle, _subTitleY + Y_OFFSET, 0, 0 );
			tweenAsset( startedTextFld, _getStartedY + Y_OFFSET, 0, 0 );
			tweenAsset( getTextField, _getStartedY + Y_OFFSET, 0, 0 );
			tweenAsset( startBtn, _startBtnY + Y_OFFSET, 0, 0 );
			_carousel.buildOut( 0.3 );
			buildOutLogo();	
		}
		
		private function tweenAsset( displayObject:DisplayObject, destY:int, delay:Number, tAlpha:Number = 1, onComplete:Function = null ) : void 
		{	
			Tweener.addTween( displayObject, {  alpha:tAlpha, time:0.3, delay:delay, transition:Equations.easeNone, onComplete:onComplete } );
			Tweener.addTween( displayObject, {  y:destY, time:0.6, delay:delay } );	
		}
		
		private function buildInLogo( delay:Number ) : void 
		{		
			Tweener.addTween( logo, {  alpha:1, time:0.3, delay:delay, transition:Equations.easeNone } );
			Tweener.addTween( logo, {  x:_logoHomePos.x, y:_logoHomePos.y, scaleX:_logoHomeScale, scaleY:_logoHomeScale, time:0.3, delay:delay, transition:Equations.easeOutBack } );	
		}
		
		private function buildOutLogo( ) : void 
		{	
			Tweener.addTween( logo, {  x:logo.x += logo.width * 0.5, y:logo.y += logo.height * 0.5, scaleX:0, scaleY:0, time:0.3, onComplete:onBuildOutFinished } );		
		}
		
		private function positionDisplayAssets() : void 
		{	
			mainTitle.alpha = 
			subTitle.alpha = 
			startedTextFld.alpha = 
			getTextField.alpha = 
			logo.alpha = 
			startBtn.alpha = 0;
			
			_logoHomePos = new Point( logo.x, logo.y );
			_logoHomeScale = logo.scaleX;
			logo.x += logo.width * 0.5;
			logo.y += logo.height * 0.5;
			logo.scaleX = logo.scaleY = 0;
			
			_mainTitleY = initialYPosition( mainTitle, Y_OFFSET );
			_subTitleY = initialYPosition( subTitle, Y_OFFSET );
			_getStartedY = initialYPosition( startedTextFld, Y_OFFSET );	
			initialYPosition( getTextField, Y_OFFSET );	
			_startBtnY = initialYPosition( startBtn, Y_OFFSET );
		}
		
		private function initialYPosition( displayObject:DisplayObject, yOffset:int ) : int 
		{	
			var output:int = displayObject.y;
			displayObject.y = displayObject.y - yOffset;
			return output;	
		}
		
		private function onCarouselUpdate( e:ImageTransitionEvent ) : void 
		{	
			startedTextFld.textColor = e.color;	
		}
		
		private function onFirstImage( e:ImageTransitionEvent ) : void 
		{	
			_rotatingBufferIcon.buildOut();	
			Tweener.addTween( _label, {alpha:0, time:0.3, transition:Equations.easeNone, onComplete:removeChild, onCompleteParams:[_label]} );
			buildIn();
		}
		
		private function onBuildOutFinished() : void 
		{	
			dispatchEvent( new LandingPageStateEvent( LandingPageStateEvent.BUILD_OUT_COMPLETE ) );	
		}
		
		private function onStart( e:MouseEvent ) : void
		{
			buildOut();
		}
	}
}