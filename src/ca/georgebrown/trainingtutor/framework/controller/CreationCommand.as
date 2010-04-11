package ca.georgebrown.trainingtutor.framework.controller 
{	
	import ca.georgebrown.trainingtutor.components.Header;
	import ca.georgebrown.trainingtutor.components.SectionText;
	import ca.georgebrown.trainingtutor.components.footer.Footer;
	import ca.georgebrown.trainingtutor.components.landingPage.ImageCarousel;
	import ca.georgebrown.trainingtutor.components.landingPage.LandingPage;
	import ca.georgebrown.trainingtutor.components.video.VideoPlayer;
	import ca.georgebrown.trainingtutor.events.footer.NavigationEvent;
	import ca.georgebrown.trainingtutor.framework.model.ConfigProxy;
	import ca.georgebrown.trainingtutor.framework.model.LocalDataProxy;
	import ca.georgebrown.trainingtutor.framework.view.FooterMediator;
	import ca.georgebrown.trainingtutor.framework.view.HeaderMediator;
	import ca.georgebrown.trainingtutor.framework.view.LandingPageMediator;
	import ca.georgebrown.trainingtutor.framework.view.SectionTextMediator;
	import ca.georgebrown.trainingtutor.framework.view.VideoPlayerMediator;
	
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
			
			var headerMediator:HeaderMediator = new HeaderMediator( new Header(), config );
			var footerMediator:FooterMediator = new FooterMediator( new Footer(), config );
			var videoMediator:VideoPlayerMediator = new VideoPlayerMediator( new VideoPlayer( new CoreVideo() ), config );
			var sectionTextMediator:SectionTextMediator = new SectionTextMediator( new SectionText(), config ); 
			
			facade.registerMediator( headerMediator );
			facade.registerMediator( footerMediator );
			facade.registerMediator( videoMediator );
			facade.registerMediator( sectionTextMediator );
			
			var carousel:ImageCarousel = new ImageCarousel( config.configData.imagesURLs, config.configData.imgRotationDelay, config.configData.transitionTime );
			facade.registerMediator( new LandingPageMediator( new LandingPage( carousel ) ) );
			
			footerMediator.footer.sectionIndex = localData.currentSection;
			footerMediator.footer.sectionLabels = config.sectionNames;
			sendNotification( NavigationEvent.SECTION_NAVIGATION, localData.currentSection );
		}
	}
}