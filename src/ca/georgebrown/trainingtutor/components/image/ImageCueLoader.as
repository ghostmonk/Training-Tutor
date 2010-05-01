package ca.georgebrown.trainingtutor.components.image
{
	import ca.georgebrown.trainingtutor.events.ImageCueLoadEvent;
	
	import com.ghostmonk.errorEvents.LoadingError;
	import com.ghostmonk.net.IDLoader;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.IOErrorEvent;
	
	[Event(name="imageCueComplete", type="ca.georgebrown.trainingtutor.events.ImageCueLoadEvent")]
	[Event(name="imageLoaded", type="ca.georgebrown.trainingtutor.events.ImageCueLoadEvent")]
	[Event(name="imageLoadFailed", type="ca.georgebrown.trainingtutor.events.ImageCueLoadEvent")]
	
	public class ImageCueLoader extends Sprite
	{
		private var _isLoading:Boolean;
		private var _currentLoader:IDLoader;
		private var _currentIndex:int;
		private var _list:Array;
		
		public function ImageCueLoader()
		{
			_list = [];
			_isLoading = false;
			_currentIndex = 0;
		}
		
		public function addListItem( id:String, url:String ) : void
		{
			if( _isLoading ) 
			{
				dispatchEvent( new LoadingError( LoadingError.LOADING_IN_PROGRESS, "Loading is in progress, image " + id + " will not be loaded" ) );
				return; 
			}
			_list.push( { id:id, url:url, image:null } );
		}
		
		public function startLoadCue() : void
		{
			_isLoading = true;
			loadImage( 0 );
		}
		
		public function getImageByID( id:String ) : Bitmap
		{
			var info:Object = getInfoByID( id );
			return info == null ? null : info.image;
		}
		
		public function getURLByID( id:String ) : String
		{
			var info:Object = getInfoByID( id );
			return info == null ? null : info.url;
		}
		
		private function loadImage( index:int ) : void
		{	
			if( _currentIndex == _list.length )
			{
				_isLoading = false;
				dispatchEvent( new ImageCueLoadEvent( ImageCueLoadEvent.IMAGE_CUE_COMPLETE ) );
				return;
			}	
			var info:Object = _list[ index ];	
			_currentLoader = new IDLoader( info.url, info.id, onImageLoaded, onError );		
		}
		
		private function onImageLoaded( content:Bitmap, id:String ) : void
		{
			insertImage( id, content );
			dispatchEvent( new ImageCueLoadEvent( ImageCueLoadEvent.IMAGE_LOADED, id ) );
			loadImage( ++_currentIndex );
		}
		
		private function onError( e:IOErrorEvent, id:String ) : void
		{
			dispatchEvent( new ImageCueLoadEvent( ImageCueLoadEvent.IMAGE_LOAD_FAILED, id ) );
			loadImage( ++_currentIndex );
		}
		
		private function insertImage( id:String, content:Bitmap ) : void
		{
			var info:Object = getInfoByID( id );
			if( info ) info.image = content;
		}
		
		private function getInfoByID( id:String ) : Object
		{
			for each( var info:Object in _list )
			{
				if( info.id == id ) return info;
			}
			return null;
		}
	}
}