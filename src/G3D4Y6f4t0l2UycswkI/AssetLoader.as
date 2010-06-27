package G3D4Y6f4t0l2UycswkI {

	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public class AssetLoader extends Loader {
	
		private var _url:URLRequest;
		private var _readyFrame:int;
		private var _callBack:Function;
		private var _progressMeter:MovieClip;
		private var _errorCall:Function;
		
		public function AssetLoader( url:String, callback:Function, errorCall:Function = null, progressMeter:MovieClip = null, loaderContext:LoaderContext = null ) {
		    
		    _progressMeter = progressMeter;
		    
		    if(_progressMeter) {
		    	_progressMeter.stop();
		    }
		    
		    _url = new URLRequest( url );
					
			_callBack = callback;
		    _errorCall = errorCall;
		    
			contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress );
			contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
			contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onError );
			contentLoaderInfo.addEventListener( HTTPStatusEvent.HTTP_STATUS, onHttpStatus );
			
			load( _url, loaderContext );
		                        
		}
		
		public function positionToCenter( parentWidth:Number, parentHeight:Number ):void {
			
			if( _progressMeter != null ) {
				_progressMeter.x = ( parentWidth - _progressMeter.width ) * 0.5;
				_progressMeter.y = ( parentHeight - _progressMeter.height ) * 0.5;
			}
		
		}
		
		
		private function onProgress( e:ProgressEvent ):void {
		    
		    if( _progressMeter != null ) { 
		    	var percent:Number = e.bytesTotal != 0 ? e.bytesLoaded / e.bytesTotal : 0;
				var frame:int = Math.max( 1, Math.ceil( percent * _progressMeter.totalFrames ) );  
				
				_progressMeter.gotoAndStop( frame );	
		    }
		    
		}
		
		
		
		protected function onComplete( e:Event ):void {
		    
		    _callBack( content );
			
		}
		
		
		private function onHttpStatus( e:HTTPStatusEvent ):void {
			
			dispatchEvent( e );
			
		}
		
		
		protected function onError( e:IOErrorEvent ):void {
			
			if( _errorCall != null ) {
				
				_errorCall( e );
				
			}
			
		}
		
		
		public function cleanUp():void {
			
			contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
			contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onError );
			_progressMeter = null;
			null;
			
		}
	            
	}
}
