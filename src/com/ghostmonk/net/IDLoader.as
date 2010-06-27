package com.ghostmonk.net
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.system.LoaderContext;

	public class IDLoader extends AssetLoader
	{
		private var _completeCall:Function;
		private var _errorCall:Function;
		private var _id:String;
		
		public function IDLoader( url:String, id:String, callback:Function, errorCall:Function=null, progressMeter:MovieClip=null, loaderContext:LoaderContext=null )
		{
			_id = id;
			_completeCall = callback;
			_errorCall = errorCall;
			
			super( url, onComplete, onError, progressMeter, loaderContext );
		}
		
		override protected function onComplete( e:Event ):void 
		{	
			_completeCall( contentLoaderInfo.content, _id );
		}
		
		override protected function onError( e:IOErrorEvent ):void 
		{
			if( _errorCall != null ) {			
				_errorCall( e, _id );
			}
			
		}
	}
}