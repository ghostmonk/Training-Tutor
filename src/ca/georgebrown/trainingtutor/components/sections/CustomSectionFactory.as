package ca.georgebrown.trainingtutor.components.sections
{
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE01Logic;
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE02Logic;
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE03Logic;
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE04Logic;
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE05Logic;
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE06Logic;
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE07Logic;
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE08Logic;
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE09Logic;
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE10Logic;
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE11Logic;
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE12Logic;
	import ca.georgebrown.trainingtutor.components.sections.reEmployee.RSE13Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS01Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS02Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS03Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS04Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS06Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS07Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS08Logic;
	import ca.georgebrown.trainingtutor.components.sections.rsApplicant.RS09Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE01Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE02Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE03Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE04Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE05Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE06Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE07Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE08Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE09Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE10Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE11Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE12Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE13Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE14Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE15Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE16Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE17Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE18Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE19Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE20Logic;
	import ca.georgebrown.trainingtutor.components.sections.serviceExcellence.SE21Logic;
	
	public class CustomSectionFactory
	{
		private static const VIEW_CLASS:Object = {
			"OS":OurStudents, 
			"RS01":RS01Logic, "RS02":RS02Logic, "RS03":RS03Logic, "RS04":RS04Logic, 
			"RS06":RS06Logic, "RS07":RS07Logic, "RS08":RS08Logic, "RS09":RS09Logic,
			
			"RSE01":RSE01Logic, "RSE02":RSE02Logic, "RSE03":RSE03Logic, "RSE04":RSE04Logic, "RSE05":RSE05Logic, 
			"RSE06":RSE06Logic, "RSE07":RSE07Logic, "RSE08":RSE08Logic, "RSE09":RSE09Logic, "RSE10":RSE10Logic, 
			"RSE11":RSE11Logic, "RSE12":RSE12Logic, "RSE13":RSE13Logic,
			
			"SE01":SE01Logic, "SE02":SE02Logic, "SE03":SE03Logic, "SE04":SE04Logic, "SE05":SE05Logic, 
			"SE06":SE06Logic, "SE07":SE07Logic, "SE08":SE08Logic, "SE09":SE09Logic, "SE10":SE10Logic, 
			"SE11":SE11Logic, "SE12":SE12Logic, "SE13":SE13Logic, "SE14":SE14Logic, "SE15":SE15Logic, 
			"SE16":SE16Logic, "SE17":SE17Logic, "SE18":SE18Logic, "SE19":SE19Logic, "SE20":SE20Logic, 
			"SE21":SE21Logic,
			
			"action":Action, "toolkit":ToolKit
		}
		
		public static function getView( id:String ) : CustomSection
		{
			return new ( VIEW_CLASS[ id ] as Class )();
		}
	}
}