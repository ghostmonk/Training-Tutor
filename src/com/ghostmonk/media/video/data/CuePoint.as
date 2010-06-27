package com.ghostmonk.media.video.data
{
	public class CuePoint
	{
		private var _id:String;
		private var _time:Number;
		private var _info:Object;
		private var _isDispatched:Boolean;
		
		public function CuePoint( id:String, time:Number, info:Object )
		{
			_time = time;
			_info = info;
			_id = id;
		}
		
		public function get info() : Object
		{
			return _info;
		}
		
		public function get id() : String
		{
			return _id;
		}
		
		public function get time() : Number
		{
			return _time;
		}
		
		public function set isDispatched( value:Boolean ) : void
		{
			_isDispatched = value;
		}
		
		public function get isDispatched() : Boolean
		{
			return _isDispatched;
		}
	}
}