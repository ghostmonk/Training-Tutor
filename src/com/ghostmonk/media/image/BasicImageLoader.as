package com.ghostmonk.media.image {
	
	import caurina.transitions.Tweener;
	
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
	public class BasicImageLoader extends Sprite {
		
		
		
		public var loader:Loader;
		private var _width:Number;
		private var _height:Number;
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		override public function get width():Number {
			
			return _width;
			
		}
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		override public function get height():Number {
			
			return _height;
				
		}
		
		
		
		/**
		 * 
		 * 
		 */
		public function BasicImageLoader() {
			
			loader = new Loader();
			addChild( loader );
			loader.alpha = 0;
			
		}
		
		
		
		/**
		 * 
		 * @param imageURL
		 * 
		 */
		public function loadNewImg( imageURL:String ):void {
			
			Tweener.addTween( loader, { alpha:0, time:0.5, onComplete:loadImage, onCompleteParams:[ imageURL ] } );
			
		}
		
		
		
		private function loadImage( imageURL:String ):void {
			
			loader.unload();
			loader.load( new URLRequest( imageURL ) );
			loader.contentLoaderInfo.addEventListener( Event.OPEN, onOpen );
			loader.contentLoaderInfo.addEventListener( Event.INIT, onInit );
			loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress ); 
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
			
		}
		
		
		
		private function onOpen( e:Event ):void {
			
			loader.contentLoaderInfo.removeEventListener( Event.OPEN, onOpen );
			
		}
		
		
		
		private function onInit( e:Event ):void {
			
			loader.contentLoaderInfo.removeEventListener( Event.INIT, onInit );
			_width = loader.contentLoaderInfo.width;
			_height = loader.contentLoaderInfo.height;
			Bitmap( loader.content ).smoothing = true;
			
		}
		
		
		
		private function onProgress( e:ProgressEvent ):void {
			 
		}
		
		
		
		private function onComplete( e:Event ):void {
			
			Tweener.addTween( loader, { alpha:1, time:0.5 } );
			loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, onProgress ); 
			loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
			
		}
		
		
		
	}
}