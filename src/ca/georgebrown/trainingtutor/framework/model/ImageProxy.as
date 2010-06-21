package ca.georgebrown.trainingtutor.framework.model
{
	import ca.georgebrown.trainingtutor.components.media.ImageCueLoader;
	
	import flash.display.Bitmap;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ImageProxy extends Proxy
	{
		public static const NAME:String = "ImageProxy";
		
		public function ImageProxy()
		{
			super( NAME );
		}
		
		public function get cueLoader() : ImageCueLoader
		{
			return data as ImageCueLoader;
		}
		
		public function getImage( id:String ) : Bitmap
		{
			return cueLoader.getImageByID( id );
		}
	}
}