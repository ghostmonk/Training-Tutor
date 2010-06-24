package ca.georgebrown.trainingtutor.components.media
{
	import com.ghostmonk.net.IDLoader;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.IOErrorEvent;
	
	public class BulkAssetIDLoader extends Sprite
	{
		private var _defaultAsset:Object;
		private var _list:Array;
		private var _loaders:Array;
		
		public function BulkAssetIDLoader( defaultAsset:Object )
		{
			_defaultAsset = defaultAsset;
			_list = [];
			_loaders = [];
		}
		
		public function startLoad() : void
		{
			for each( var info:Object in _list )
				_loaders.push( new IDLoader( info.src, info.id, onAssetLoaded, onLoadError ) );
		}
		
		public function addItem( src:String, id:String ) : void
		{
			_list.push( { src:src, id:id, content:null } );
		}
		
		public function getAssetByID( id:String ) : Bitmap
		{
			var info:Object = getInfoByID( id );
			return info == null ? null : info.content;
		}
		
		public function getURLByID( id:String ) : String
		{
			var info:Object = getInfoByID( id ); 
			return info == null ? null : info.url;
		}
		
		private function onAssetLoaded( content:Object, id:String ) : void
		{
			insertAsset( id, content );
		}
		
		private function onLoadError( e:IOErrorEvent, id:String ) : void
		{
			insertAsset( id, _defaultAsset );
		}
		
		private function insertAsset( id:String, content:Object ) : void
		{
			var info:Object = getInfoByID( id );
			if( info ) 
				info.content = content;
		}
		
		private function getInfoByID( id:String ) : Object
		{
			for each( var info:Object in _list )
				if( info.id == id ) 
					return info;
			return null;
		}
	}
}