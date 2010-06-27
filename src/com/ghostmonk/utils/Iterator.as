package com.ghostmonk.utils
{
	public class Iterator
	{
		private var _list:Array;
		private var _currentIter:int;
		
		public function Iterator( list:Array )
		{
			_list = list;
			_currentIter = -1;
		}
		
		public function get hasNext() : Boolean
		{
			return _currentIter < _list.length - 1;
		}
		
		public function get hasPrevious() : Boolean
		{
			return _currentIter > 0;
		}
		
		public function get previous() : Object
		{
			--_currentIter;
			if( _currentIter == -1 ) return null;
			return current;
		}
		
		public function get next() : Object
		{
			++_currentIter;
			if( _currentIter == _list.length )
			{
				_currentIter = -1;
				return null;
			}
			return current;
		}
		
		public function get current() : Object
		{
			if( _currentIter == -1 ) return null;
			return _list[ _currentIter ];
		}
		
		public function reset() :  void
		{
			_currentIter = -1;
		}
		
		public function apply( func:Function, ...rest ) : void
		{
			reset();
			while( hasNext ) 
			{
				rest.unshift( next );
				func.apply( null, rest );
				rest.shift();
			}
		}
	}
}