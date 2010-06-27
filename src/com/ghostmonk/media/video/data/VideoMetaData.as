package com.ghostmonk.media.video.data {
	/** 
	 * @author ghostmonk
	 * 
	 */
	public class VideoMetaData {
		
		
		private var _canSeekToEnd:Boolean;
		private var _cuePoints:Array;
		private var _audiocodecid:Number;
		private var _audiodelay:Number;
		private var _audiodatarate:Number;
		private var _videocodecid:Number;
		private var _framerate:Number;
		private var _videodatarate:Number;
		private var _height:Number;
		private var _width:Number;
		private var _duration:Number;
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get canSeekToEnd():Boolean { 	
			return _canSeekToEnd;	
		}
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get cuePoints():Array { 	
			return _cuePoints;		
		}
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get audiodelay():Number {	
			return _audiocodecid;	
		}
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get audiocodecid():Number {	
			return _audiodelay;		
		}
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get audiodatarate():Number { 	
			return _audiodatarate;	
		}
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get videocodecid():Number {	
			return _videocodecid;	
		}
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get framerate():Number {	
			return _framerate;		
		}
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get videodatarate():Number { 	
			return _videodatarate;	
		}
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get height():Number {	
			return _height;			
		}
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get width():Number {	
			return _width;			
		}
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get duration():Number {	
			return _duration;		
		}
		
		
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function VideoMetaData( data:Object ) {
			
			_canSeekToEnd = data.canSeekToEnd;
			_cuePoints = data.cuePoints;
			_audiocodecid = data.audiocodecid;
			_audiodelay = data.audiodelay;
			_audiodatarate = data.audiodatarate;
			_videocodecid = data.videocodecid;
			_framerate = data.framerate;
			_videodatarate = data.videodatarate;
			_height = data.height;
			_width = data.width;
			_duration =	data.duration;
			
		}



	}
}