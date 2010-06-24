package ca.georgebrown.trainingtutor.components
{
	import ca.georgebrown.trainingtutor.components.textDisplay.SectionText;
	import ca.georgebrown.trainingtutor.valueObjects.SectionContentData;
	
	import com.ghostmonk.events.PercentageEvent;
	import com.ghostmonk.media.video.events.CuePointEvent;
	import com.ghostmonk.utils.MainStage;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class SectionComponent extends Sprite
	{
		private var _sectionText:SectionText;
		
		private var _stage:Stage;
		private var _mediaManager:MediaManager;
		private var _customManager:CustomSectionManager;
		
		public function SectionComponent()
		{
			_customManager = new CustomSectionManager( this );
			_stage = MainStage.instance;
			_stage.addChild( this );
		}
		
		public function set mediaManager( value:MediaManager ) : void
		{
			_mediaManager = value;
			_mediaManager.addEventListener( CuePointEvent.ON_CUE_POINT, onCuePoint );
		}
		
		public function set sectionText( value:SectionText ) : void
		{
			_sectionText = value;
			_sectionText.addEventListener( PercentageEvent.CHANGE, onTextChange );
			_sectionText.viewParent = this;
		}
		
		public function analyzeSectionContent( content:SectionContentData ) : void
		{
			_customManager.clean();
			configureBaseView( content );
			if( !content.isBasic ) 
				_customManager.addSectionData( content );
		}
		
		public function configureBaseView( content:SectionContentData ) : void
		{
			_mediaManager.imageSwap = content.useChangeOnTextScroll;
			
			setVideo( content.hasVideo, content.videoURL, content.cuePoints );
			setImageViewer( content.hasImages, content.imageIDs );
			
			if( content.isBasic ) 
				createBasicView( content );
			else 
				_sectionText.buildOut();
			
			positionAssets();
		}
		
		private function setImageViewer( hasImages:Boolean, ids:Array ) : void
		{
			if( hasImages )
				_mediaManager.enableImageView( ids );
			else
				_mediaManager.diableImageView();
		}
		
		private function setVideo( hasVideo:Boolean, url:String, cuePoints:Array ) : void
		{
			if( hasVideo )
				_mediaManager.enableVideo( url, cuePoints );
			else
				_mediaManager.disableVideo();
		}
		
		private function createBasicView( content:SectionContentData ) : void
		{
			_sectionText.buildIn();
			addChild( _sectionText );
			
			_sectionText.title = content.title;
			_sectionText.bodyText = content.bodyText;
		}
		
		private function onTextChange( e:PercentageEvent ) : void
		{
			_mediaManager.textScrollPercent = e.percent;
		}
		
		private function positionAssets() : void
		{
			_mediaManager.positionAssets();
			_sectionText.x = _stage.stageWidth - _sectionText.width - 40;
			_sectionText.y = ( _stage.stageHeight - _sectionText.height ) * 0.5;
		}
		
		private function onCuePoint( e:CuePointEvent ) : void
		{
			_customManager.advanceSection();
		}
	}
}