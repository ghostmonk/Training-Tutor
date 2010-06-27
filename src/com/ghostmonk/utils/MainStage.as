package com.ghostmonk.utils
{
	import flash.display.Stage;
	
	public class MainStage
	{
		private static var STAGE:Stage;
		
		public static function set instance( stage:Stage ) : void
		{
			if( STAGE == null ) STAGE = stage;	
		}
		
		public static function get instance() : Stage
		{
			return STAGE;
		}
	}
}