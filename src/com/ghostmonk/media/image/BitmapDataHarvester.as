package com.ghostmonk.media.image {
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.media.*;
	import flash.net.*;
	import flash.text.*;
	
	/** 
	 * @author ghostmonk
	 * 
	 */
	public class BitmapDataHarvester extends Loader {
	
	
	
		/**
		 * 
		 * @param imageURL
		 * 
		 */
		public function BitmapDataHarvester( imageURL:String ) {
			
			load( new URLRequest( imageURL ) );
			contentLoaderInfo.addEventListener( Event.OPEN, onOpen );
			contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress ); 
			contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
			
		}
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get bitmapData():BitmapData {
			
			return BitmapData( Bitmap( contentLoaderInfo.content ).bitmapData );
			
		}
		
		
		
		private function onOpen( e:Event ):void {
			
			contentLoaderInfo.removeEventListener( Event.OPEN, onOpen );
			dispatchEvent( e );
			
		}
		
		
		
		private function onProgress( e:ProgressEvent ):void {
			 
			var percent:Number = int( e.bytesLoaded / e.bytesTotal * 100 );
			dispatchEvent( e );
			
		}
		
		
		
		private function onComplete( e:Event ):void {
			
			contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, onProgress ); 
			contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
			dispatchEvent( e );
			
		}
		
		
	}
}