package ca.georgebrown.trainingtutor.components.sections
{
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS01Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS02Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS03Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS04Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS06Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS07Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS08Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS09Logic;
	
	public class CustomSectionFactory
	{
		private static const VIEW_CLASS:Object = {
			"OS":OurStudents, "RS01":RS01Logic, "RS02":RS02Logic, "RS03":RS03Logic,
			"RS04":RS04Logic, "RS06":RS06Logic, "RS07":RS07Logic, "RS08":RS08Logic, "RS09":RS09Logic,
			"action":Action, "toolkit":ToolKit
		}
		
		public static function getView( id:String ) : CustomSection
		{
			return new ( VIEW_CLASS[ id ] as Class )();
		}
	}
}