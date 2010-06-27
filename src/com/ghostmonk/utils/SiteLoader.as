package com.ghostmonk.utils 
{	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * Based on Kieth Peter's AS3 preloader.
	 * 
	 * @author ghostmonk 2009-09-21
	 * 
	 */
	public class SiteLoader extends MovieClip 
	{	
		private var _mainClassRef:String;
		private var _main:DisplayObjectContainer;
		
		public function SiteLoader( mainClassRef:String = "Main" ) 
		{	
			stop();
			_mainClassRef = mainClassRef;
			root.loaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress ); 
			root.loaderInfo.addEventListener( Event.COMPLETE, onComplete ); 	
		}
		
		protected function updateLoader( percent:Number ) : void 
		{	
			throw new Error( "Must override updateLoader in " + getQualifiedClassName( this ) );	
		}
		
		protected function cleanUp() : void {}
		
		protected function testLoader( updateRate:Number = 500 ) : void
		{
			root.loaderInfo.removeEventListener( ProgressEvent.PROGRESS, onProgress ); 
			root.loaderInfo.removeEventListener( Event.COMPLETE, onComplete ); 
			var timer:Timer = new Timer( updateRate );
			timer.addEventListener( TimerEvent.TIMER, function( e:TimerEvent ) : void { updateLoader( Math.random() ) } );
			timer.start();
		}
		
		private function onProgress( e:ProgressEvent ) : void 
		{	
			var percent:Number = root.loaderInfo.bytesTotal ? root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal : 0;
			updateLoader( percent );	
		}
		
		private function onComplete( e:Event ) : void 
		{	
			cleanUp();
			
			nextFrame();
			var mainClass:Class = getDefinitionByName( _mainClassRef ) as Class;
			_main = new mainClass();
			addChild( _main );
			
			root.loaderInfo.removeEventListener( ProgressEvent.PROGRESS, onProgress ); 
			root.loaderInfo.removeEventListener( Event.COMPLETE, onComplete ); 	
		}
	}
}