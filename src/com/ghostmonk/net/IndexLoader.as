package com.ghostmonk.net {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.system.LoaderContext;

	public class IndexLoader extends AssetLoader {
		
		
		
		private var _completeCall:Function;
		private var _errorCall:Function;
		private var _index:Number;
		
		
		
		public function IndexLoader( url:String, index:Number, completeCall:Function, onLoadError:Function = null, progressMeter:MovieClip = null, loaderContext:LoaderContext = null ) {
			
			_completeCall = completeCall;
			_errorCall = onLoadError;
			_index = index;
			
			super( url, onComplete, onError, progressMeter, loaderContext );
			
		}
		
		
		
		override protected function onComplete( e:Event ):void {
			
			_completeCall( contentLoaderInfo.content, _index );
			
		}
		
		
		override protected function onError( e:IOErrorEvent ):void {
			
			if( _errorCall != null ) {			
				_errorCall( e, _index );
			}
			
		}
		
		
		
	}
}