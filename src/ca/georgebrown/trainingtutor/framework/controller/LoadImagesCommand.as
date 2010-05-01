package ca.georgebrown.trainingtutor.framework.controller
{
	import ca.georgebrown.trainingtutor.components.image.ImageCueLoader;
	import ca.georgebrown.trainingtutor.events.ImageCueLoadEvent;
	import ca.georgebrown.trainingtutor.framework.model.ImageProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class LoadImagesCommand extends SimpleCommand
	{
		private var _imageCueLoader:ImageCueLoader;
		
		override public function execute( note:INotification ) : void
		{
			_imageCueLoader = new ImageCueLoader();
			_imageCueLoader.addEventListener( ImageCueLoadEvent.IMAGE_CUE_COMPLETE, onCueLoaded );
			_imageCueLoader.addEventListener( ImageCueLoadEvent.IMAGE_LOADED, onImageLoaded );
			
			var imageProxy:ImageProxy = facade.retrieveProxy( ImageProxy.NAME ) as ImageProxy;
			imageProxy.setData( _imageCueLoader );
			
			var list:Array = note.getBody() as Array;
			for each( var item:Object in list )
			{
				_imageCueLoader.addListItem( item.id, item.url );
			}
			
			_imageCueLoader.startLoadCue();
		}
		
		private function onImageLoaded( e:ImageCueLoadEvent ) : void
		{
			sendNotification( e.type, e.id );
		}
		
		private function onCueLoaded( e:ImageCueLoadEvent ) : void
		{
			sendNotification( e.type, _imageCueLoader );
		}
	}
}