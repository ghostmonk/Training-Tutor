package ca.georgebrown.trainingtutor.framework.controller 
{	
	import assets.videoPlayer.VideoPlayerAsset;
	
	import ca.georgebrown.trainingtutor.components.Footer;
	import ca.georgebrown.trainingtutor.components.Header;
	import ca.georgebrown.trainingtutor.components.NavigationBar;
	import ca.georgebrown.trainingtutor.components.SectionNavigation;
	import ca.georgebrown.trainingtutor.components.SectionText;
	import ca.georgebrown.trainingtutor.components.TextScroller;
	import ca.georgebrown.trainingtutor.components.image.ImageViewer;
	import ca.georgebrown.trainingtutor.components.landingPage.ImageCarousel;
	import ca.georgebrown.trainingtutor.components.landingPage.LandingPage;
	import ca.georgebrown.trainingtutor.components.video.VideoPlayer;
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	import ca.georgebrown.trainingtutor.framework.model.ConfigProxy;
	import ca.georgebrown.trainingtutor.framework.model.ImageProxy;
	import ca.georgebrown.trainingtutor.framework.model.LocalDataProxy;
	import ca.georgebrown.trainingtutor.framework.view.LandingPageMediator;
	import ca.georgebrown.trainingtutor.framework.view.NavigationMediator;
	import ca.georgebrown.trainingtutor.framework.view.SectionMediator;
	import ca.georgebrown.trainingtutor.framework.view.StageMediator;
	
	import com.ghostmonk.media.video.CoreVideo;
	
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
						
			createNavigationMediator( localData.currentSection, config.sectionNames );
			createSectionMediator( config );
			createLandingPageMediator( config.configData.landingPageImages, config.configData.imgRotationDelay, config.configData.transitionTime );
			
			sendNotification( NavigationEvent.INIT_SECTION, localData.currentSection );
		}
		
		private function createNavigationMediator( currentSection:int, sections:Array ) : void
		{
			var stageMediator:StageMediator = facade.retrieveMediator( StageMediator.NAME ) as StageMediator;
			var footer:Footer = new Footer();
			stageMediator.footer = footer;
			stageMediator.header = new Header();
			
			var navigationMediator:NavigationMediator = new NavigationMediator( new NavigationBar( footer.navigationBar ) );
			navigationMediator.navBar.sectionIndex = currentSection;
			navigationMediator.navBar.sectionAccess( currentSection );
			navigationMediator.navBar.sectionLabels = sections;
			
			facade.registerMediator( navigationMediator );
		}
		
		private function createSectionMediator( config:ConfigProxy ) : void
		{
			var sectionText:SectionText = new SectionText();
			var scroller:TextScroller = new TextScroller();
			scroller.asset = sectionText.scrollerView;
			sectionText.scroller = scroller;
			sectionText.init();
			
			var sectionMediator:SectionMediator = new SectionMediator( config );
			sectionMediator.videoPlayer = new VideoPlayer( new CoreVideo(), new VideoPlayerAsset() );
			sectionMediator.imageViewer = new ImageViewer( ImageProxy( facade.retrieveProxy( ImageProxy.NAME ) ).cueLoader );
			sectionMediator.sectionText = sectionText;
			sectionMediator.sectionNav = new SectionNavigation();
			
			facade.registerMediator( sectionMediator );
		}
		
		private function createLandingPageMediator( images:Dictionary, rotationDelay:Number, transitionTime:Number ) : void
		{
			var carousel:ImageCarousel = new ImageCarousel( images, rotationDelay, transitionTime );
			facade.registerMediator( new LandingPageMediator( new LandingPage( carousel ) ) );
		}
	}
}