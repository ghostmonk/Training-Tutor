package com.ghostmonk.ui.graveyard.idecomposed {
	
	import com.ghostmonk.events.PercentageEvent;
	import com.ghostmonk.media.video.events.VideoControlEvent;
	
	import flash.display.*;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	[Event(name="change", type="com.ghostmonk.events.PercentageEvent")]
	[Event(name="play", type="com.ghostmonk.events.video.VideoControlEvent")]
	[Event(name="pause", type="com.ghostmonk.events.video.VideoControlEvent")]
	
	/**
	 * 
	 * A playback control scrubber meant for video.
	 * <p>Three constructor parameters are self explanitory.</p>
	 * <p>The playhead travels along the loadProgressTrack, constrainded by loadProgressTrack's scaleX, which should
	 * be set by the video loadprogess. </p>
	 * 
	 * <p>The playhead is also draggable along the x axis, and will not render outside of the x value of loadProgressTrack 
	 * and the length of loadProgressTrack.</p>
	 * 
	 * <p>The fullTrack is clickable and should be composed beneath (i.e. covered) the loadprogress track in the IDE, or in another matter.</p>
	 * <p>The fullTrack is meant to be an indicator of video length before load.</p>
	 * <p>MouseEvents have been disabled on loadProgressTrack, so the click event will register through loadProgressTrack to fullTrack.</p>
	 * <p>loadProgressTrack and fullTrack should register visually (stack on top of each other) exactly.</p> 
 	 *  
	 * @author ghostmonk 05/03/2009
	 * 
	 */
	public class VideoScrubBar extends EventDispatcher {
		
		
		
		private var _minX:Number;				//The minumum X value of playhead 
		private var _maxX:Number;				//The maximum X value of playhead
			
		private var _playHead:Sprite;
		private var _loadProgressTrack:Sprite;
		private var _fullTrack:Sprite;			
		
		private var _durationAsWidth:Number;	//The full length of the _fulltrack, to represent 100 percent length of video
		private var _mouseOffset:Number; 		//Used to offset the playhead my mouseX on click and drag
		
		
		
		/**
		 * 
		 * @param playhead
		 * @param loadProgressTrack
		 * @param fullTrack
		 * 
		 */
		public function VideoScrubBar( playhead:Sprite, loadProgressTrack:Sprite, fullTrack:Sprite ) {
			
			_playHead = playhead;
			_loadProgressTrack = loadProgressTrack;
			_fullTrack = fullTrack;
			_loadProgressTrack.mouseEnabled = false;
			_durationAsWidth = _fullTrack.width - _playHead.width;
			
			enable();
			
			_minX = _loadProgressTrack.x;
			_maxX = _loadProgressTrack.x + _loadProgressTrack.width - _playHead.width; 
			
		}
		
		
		
		/**
		 * Enables mouseActions on instance of VideoScrubBar
		 * 
		 */
		public function enable():void {
			
			_fullTrack.addEventListener( MouseEvent.CLICK, onTrackClick );
			_playHead.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			_playHead.buttonMode = true;
			
		}
		
		
		
		/**
		 * Disables mouseActions on instance of VideoScrubBar
		 * 
		 */
		public function disable():void {
			
			_fullTrack.removeEventListener( MouseEvent.CLICK, onTrackClick );
			_playHead.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			_playHead.buttonMode = false;
			
		}
		
		
		
		/**
		 * 
		 * @param percent: sets the length of loadProgressTrack. Represents percentage of video downloaded
		 * 
		 */
		public function onLoadProgress( percent:Number ):void {
			
			_loadProgressTrack.scaleX = percent;
			_maxX = _loadProgressTrack.x + _loadProgressTrack.width - _playHead.width;
			
		}
		
		
		
		/**
		 * 
		 * @param percent: 	sets playhead along loadProgressTrack based on percentage of current video,
		 * 					playhead position is constrained by position and length of loadProgressTrack
		 * 
		 */
		public function setPlayhead( percent:Number ):void {
			
			var setX:Number = _durationAsWidth*percent + _loadProgressTrack.x;
			_playHead.x = Math.max( _minX, Math.min( _maxX, setX ) );
			
		}
		
		
		
		private function onMouseDown( e:MouseEvent ):void {
			
			_mouseOffset = _playHead.mouseX;
			
			dispatchEvent( new VideoControlEvent( VideoControlEvent.PAUSE ) );
			
			_playHead.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			_playHead.stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			
		}
		
		
		
		private function onMouseUp( e:MouseEvent ):void {
			
			dispatchEvent( new VideoControlEvent( VideoControlEvent.PLAY ) );
			
			_playHead.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			_playHead.stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			
		}
		
		
		
		private function onMouseMove( e:MouseEvent ):void {
			
			movePlayheadByX( _fullTrack.mouseX + _fullTrack.x - _mouseOffset );
			
		}
		
		
		
		private function onTrackClick( e:MouseEvent ):void {
			
			movePlayheadByX( _fullTrack.mouseX + _fullTrack.x );
			
		}
		
		
		
		private function movePlayheadByX( value:Number ):void {
			
			_playHead.x = Math.max( _minX, Math.min( _maxX, value ) );
			
			var percent:Number = ( _playHead.x - _loadProgressTrack.x )/_durationAsWidth;
			
			dispatchEvent( new PercentageEvent( PercentageEvent.CHANGE, percent ) );
			
		}



	}
}