package ca.georgebrown.trainingtutor.framework.controller 
{	
	import G3D4Y6f4t0l2UycswkI.CoreVideo;
	
	import assets.videoPlayer.VideoPlayerAsset;
	
	import ca.georgebrown.trainingtutor.components.MediaManager;
	import ca.georgebrown.trainingtutor.components.SectionComponent;
	import ca.georgebrown.trainingtutor.components.coreParts.Footer;
	import ca.georgebrown.trainingtutor.components.coreParts.Header;
	import ca.georgebrown.trainingtutor.components.coreParts.NavigationBar;
	import ca.georgebrown.trainingtutor.components.landingPage.ImageCarousel;
	import ca.georgebrown.trainingtutor.components.landingPage.LandingPage;
	import ca.georgebrown.trainingtutor.components.media.ImageViewer;
	import ca.georgebrown.trainingtutor.components.media.VideoPlayer;
	import ca.georgebrown.trainingtutor.components.textDisplay.SectionText;
	import ca.georgebrown.trainingtutor.components.textDisplay.TextScroller;
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	import ca.georgebrown.trainingtutor.framework.model.ConfigProxy;
	import ca.georgebrown.trainingtutor.framework.model.LocalDataProxy;
	import ca.georgebrown.trainingtutor.framework.view.LandingPageMediator;
	import ca.georgebrown.trainingtutor.framework.view.NavigationMediator;
	import ca.georgebrown.trainingtutor.framework.view.SectionMediator;
	import ca.georgebrown.trainingtutor.framework.view.StageMediator;
	
	import flash.utils.Dictionary;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class CreationCommand extends SimpleCommand 
	{	
		override public function execute( note:INotification ) : void 
		{	
			var config:ConfigProxy = note.getBody() as ConfigProxy;
			var localData:LocalDataProxy = facade.retrieveProxy( LocalDataProxy.NAME ) as LocalDataProxy;
						
			createNavigationMediator( localData.currentSection, config.sectionNames, config.subSectionNames );
			createSectionMediator( config );
			createLandingPageMediator( config.configData.landingPageImages, config.configData.imgRotationDelay, config.configData.transitionTime );
			
			sendNotification( NavigationEvent.INIT_SECTION, localData.currentSection );
		}
		
		private function createNavigationMediator( currentSection:int, sections:Array, subSections:Array ) : void
		{
			var stageMediator:StageMediator = facade.retrieveMediator( StageMediator.NAME ) as StageMediator;
			var footer:Footer = new Footer();
			stageMediator.footer = footer;
			stageMediator.header = new Header();
			
			var navigationMediator:NavigationMediator = new NavigationMediator( new NavigationBar( footer.navigationBar ) );
			navigationMediator.navBar.sectionIndex = currentSection;
			navigationMediator.navBar.sectionAccess( currentSection );
			navigationMediator.navBar.sectionLabels = sections;
			navigationMediator.navBar.subNavLabels = subSections;
			
			facade.registerMediator( navigationMediator );
		}
		
		private function createSectionMediator( config:ConfigProxy ) : void
		{
			var sectionText:SectionText = new SectionText();
			var scroller:TextScroller = new TextScroller();
			scroller.asset = sectionText.scrollerView;
			sectionText.scroller = scroller;
			sectionText.init();
			
			var mediaManager:MediaManager = new MediaManager();
			mediaManager.videoPlayer = new VideoPlayer( new CoreVideo(), new VideoPlayerAsset() );
			mediaManager.imageViewer = new ImageViewer( config.sectionImages ); 
			
			var viewManager:SectionComponent = new SectionComponent();
			viewManager.mediaManager = mediaManager;
			viewManager.sectionText = sectionText;
			
			var sectionMediator:SectionMediator = new SectionMediator( config, viewManager );
			
			facade.registerMediator( sectionMediator );
		}
		
		private function createLandingPageMediator( images:Dictionary, rotationDelay:Number, transitionTime:Number ) : void
		{
			var carousel:ImageCarousel = new ImageCarousel( images, rotationDelay, transitionTime );
			facade.registerMediator( new LandingPageMediator( new LandingPage( carousel ) ) );
		}
	}
}