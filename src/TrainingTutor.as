package 
{	
	import ca.georgebrown.trainingtutor.AppFacade;
	import ca.georgebrown.trainingtutor.valueObjects.ViewLookup;
	import ca.georgebrown.trainingtutor.valueObjects.StartupData;
	
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.DisplayShortcuts;
	import caurina.transitions.properties.TextShortcuts;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	[SWF ( backgroundColor=0xFFFFFF, frameRate=31, width=1024, height=588, pageTitle="GBC Training Tutor" ) ]
	[Frame ( factoryClass="ca.georgebrown.trainingtutor.GBCLoader" ) ]
	
	/**
	 * 
	 * @author ghostmonk 15/08/2009
	 * 
	 */
	public class TrainingTutor extends MovieClip 
	{	
		private var _confURL:String = "xmlData/config.xml";
		private var _appName:String = "TrainingTutor";
		
		public function TrainingTutor() 
		{	
			DisplayShortcuts.init();
			TextShortcuts.init();
			ColorShortcuts.init();
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );	
		}
		
		private function onAddedToStage(e:Event):void 
		{	
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			var data:StartupData = new StartupData( stage, _confURL );
			AppFacade.getInstance( _appName ).startup( data );
		}
	}
}
