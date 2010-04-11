package ca.georgebrown.trainingtutor 
{	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.utils.SiteLoader;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class GBCLoader extends SiteLoader 
	{
		private var _preloader:SiteLoaderAsset;
		
		public function GBCLoader() 
		{	
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_preloader = new SiteLoaderAsset();
			
			super( "TrainingTutor" );
			addChild( _preloader );
			
			_preloader.alpha = 0;
			Tweener.addTween( _preloader, { alpha:1, time:0.3, transition:Equations.easeNone } );
			
			_preloader.x = ( stage.stageWidth - _preloader.width ) * 0.5;
			_preloader.y = ( stage.stageHeight - _preloader.height ) * 0.5;
		}
		
		override protected function updateLoader( percent:Number ) : void 
		{	
			_preloader.gotoAndStop( Math.ceil( percent * _preloader.totalFrames ) );	
		}
		
		override protected function cleanUp() : void 
		{
			Tweener.addTween( _preloader, { alpha:0, time:0.3, transition:Equations.easeNone, onComplete:removeChild, onCompleteParams:[ _preloader ] } );
		}
	}
}