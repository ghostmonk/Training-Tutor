package ca.georgebrown.trainingtutor.valueObjects {
	
	import flash.display.Stage;
	
	/**
	 * 
	 * @author ghostmonk 15/08/2009
	 * 
	 */
	public class StartupData 
	{
		private var _stage:Stage;
		private var _confURL:String;
	
		public function StartupData(  stage:Stage, confURL:String ) 
		{	
			_stage = stage;
			_confURL = confURL;	
		}
		
		public function get stage() : Stage
		{	
			return _stage;	
		}
		
		public function get confURL() : String 
		{	
			return _confURL;	
		}
	}
}