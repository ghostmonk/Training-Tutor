package ca.georgebrown.trainingtutor.valueObjects
{
	import ca.georgebrown.trainingtutor.components.sectionView.Sections.Action;
	import ca.georgebrown.trainingtutor.components.sectionView.Sections.ToolKit;
	
	import flash.display.MovieClip;
	
	import sectionContent.OurStudents.OurStudentsView;
	import sectionContent.RSApplicant.RS01;
	import sectionContent.RSApplicant.RS02;
	import sectionContent.RSApplicant.RS03;
	import sectionContent.RSApplicant.RS04;
	import sectionContent.RSApplicant.RS06;
	import sectionContent.RSApplicant.RS07;
	import sectionContent.RSApplicant.RS08;
	import sectionContent.RSApplicant.RS09;
	
	public class ViewLookup
	{
		private static const VIEW_CLASS:Object = {
			"OS":OurStudentsView, "RS01":RS01, "RS02":RS02, "RS03":RS03,
			"RS04":RS04, "RS06":RS06, "RS07":RS07, "RS08":RS08, "RS09":RS09,
			"action":Action, "toolkit":ToolKit
		}
		
		public static function getView( id:String ) : MovieClip
		{
			return new ( VIEW_CLASS[ id ] as Class )();
		}
	}
}