package com.ghostmonk.net {
	
	import flash.events.*;
	import flash.net.*;

	/**
	 * 
	 * @author nhillier
	 * 
	 */
	public class XMLLoader extends URLLoader {
		
		
		private var _callBack:Function;
		private var _errorCall:Function;
		
		
		/**
		 * 
		 * @param call
		 * 
		 */
		public function set errorCall( call:Function ):void {
			
			_errorCall = call;
			
		}
		
		
		
		/**
		 * 
		 * @param url
		 * @param callBack
		 * 
		 */
		public function XMLLoader(url:String, callBack:Function) {
			
			_callBack = callBack;
			addEventListener( Event.COMPLETE, onXMLLoadComplete);
			addEventListener( IOErrorEvent.IO_ERROR, onIOError);
			super(new URLRequest(url));
			
		}
		
		
		
		private function onXMLLoadComplete(e:Event):void {
			
			_callBack( XML( data ) );
			cleanUp();
			
		}
		
		
		
		private function onIOError(e:IOErrorEvent):void {
			
			if( _errorCall != null ) {
				_errorCall( e );
			}
			else {
				trace( e.text );
			}
			
			cleanUp();
			
		}
		
		
		private function cleanUp():void {
			
			removeEventListener( Event.COMPLETE, onXMLLoadComplete );
			removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			
			null;
			
		}
		
		
	}
}