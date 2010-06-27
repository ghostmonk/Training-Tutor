package com.ghostmonk.media.video
{
	import com.ghostmonk.media.video.data.CuePoint;
	import com.ghostmonk.media.video.events.CuePointEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.net.NetStream;
	import flash.utils.Timer;
	
	[Event(type="com.ghostmonk.media.video.events.CuePointEvent", name="onCuePoint")]
	
	public class CuePointManager extends EventDispatcher
	{
		private var _stream:NetStream;
		private var _cuePoints:Array;
		private var _timer:Timer;
		
		public function CuePointManager()
		{
			_cuePoints = [];
			_timer = new Timer(500);
		}
		
		public function set stream( value:NetStream ) : void
		{
			_stream = value;
		}
		
		public function set cuePointList( list:Array ) : void
		{
			_cuePoints = list;
		}
		
		public function addCuePoint( cuepoint:CuePoint ) : void
		{
			_cuePoints.push( cuepoint );
		}
		
		public function clearCuePoints() : void
		{
			_cuePoints = [];
		}
		
		public function start() : void
		{
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
		}
		
		public function stop() : void
		{
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			_timer.stop();	
		}
		
		private function onTimer( e:TimerEvent ) : void
		{
			for each( var cueData:CuePoint in _cuePoints )
			{
				if( _stream == null ) continue;
				if( cueData.time == Math.floor(_stream.time) && !cueData.isDispatched )
				{
					dispatchCuePoint( cueData );
					cueData.isDispatched = true;
				}
			}
		}
		
		private function dispatchCuePoint( cueData:CuePoint ) : void
		{
			dispatchEvent( new CuePointEvent( CuePointEvent.ON_CUE_POINT, cueData ) );
		}
	}
}