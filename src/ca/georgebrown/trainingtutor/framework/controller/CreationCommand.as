package ca.georgebrown.trainingtutor.framework.controller 
{	
	import ca.georgebrown.trainingtutor.components.Footer;
	import ca.georgebrown.trainingtutor.components.Header;
	import ca.georgebrown.trainingtutor.components.NavigationBar;
	import ca.georgebrown.trainingtutor.components.SectionNavigation;
	import ca.georgebrown.trainingtutor.components.SectionText;
	import ca.georgebrown.trainingtutor.components.TextScroller;
	import ca.georgebrown.trainingtutor.components.landingPage.ImageCarousel;
	import ca.georgebrown.trainingtutor.components.landingPage.LandingPage;
	import ca.georgebrown.trainingtutor.components.video.VideoPlayer;
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	import ca.georgebrown.trainingtutor.framework.model.ConfigProxy;
	import ca.georgebrown.trainingtutor.framework.model.LocalDataProxy;
	import ca.georgebrown.trainingtutor.framework.view.LandingPageMediator;
	import ca.georgebrown.trainingtutor.framework.view.NavigationMediator;
	import ca.georgebrown.trainingtutor.framework.view.SectionMediator;
	import ca.georgebrown.trainingtutor.framework.view.StageMediator;
	
	import com.ghostmonk.media.video.CoreVideo;
	
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
						
			var stageMediator:StageMediator = facade.retrieveMediator( StageMediator.NAME ) as StageMediator;
			var footer:Footer = new Footer();
			stageMediator.footer = footer;
			stageMediator.header = new Header();
			
			var navigationMediator:NavigationMediator = new NavigationMediator( new NavigationBar( footer.navigationBar ) );
			navigationMediator.navBar.sectionIndex = localData.currentSection;
			navigationMediator.navBar.sectionAccess( localData.currentSection );
			navigationMediator.navBar.sectionLabels = config.sectionNames;
			
			var sectionText:SectionText = new SectionText();
			var scroller:TextScroller = new TextScroller();
			scroller.asset = sectionText.scrollerView;
			sectionText.scroller = scroller;
			sectionText.init();
			
			var sectionMediator:SectionMediator = new SectionMediator( new VideoPlayer( new CoreVideo() ), sectionText, new SectionNavigation(), config );
			var carousel:ImageCarousel = new ImageCarousel( config.configData.imagesURLs, config.configData.imgRotationDelay, config.configData.transitionTime );
			
			facade.registerMediator( navigationMediator );
			facade.registerMediator( sectionMediator );
			facade.registerMediator( new LandingPageMediator( new LandingPage( carousel ) ) );
			
			sendNotification( NavigationEvent.INIT_SECTION, localData.currentSection );
		}
	}
}