package ca.georgebrown.trainingtutor.valueObjects
{
	import flash.display.MovieClip;
	
	import sectionContent.OurStudentsView;
	import sectionContent.RS01;
	import sectionContent.RS02;
	import sectionContent.RS03;
	import sectionContent.RS04;
	import sectionContent.RS06;
	import sectionContent.RS07;
	import sectionContent.RS08;
	import sectionContent.RS09;
	
	public class ClassLookup
	{
		private static const VIEW_CLASS:Object = {
			"OS":OurStudentsView, "RS01":RS01, "RS02":RS02, "RS03":RS03,
			"RS04":RS04, "RS06":RS06, "RS07":RS07, "RS08":RS08, "RS09":RS09
		}
		
		public static function getView( id:String ) : MovieClip
		{
			return new ( VIEW_CLASS[ id ] as Class )();
		}
	}
}