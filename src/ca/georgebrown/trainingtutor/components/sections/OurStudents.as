package ca.georgebrown.trainingtutor.components.sections
{
	import sectionContent.OurStudents.OurStudentsView;
	
	public class OurStudents extends CustomSection
	{
		public function OurStudents()
		{
			super( new OurStudentsView() );
		}

	}
}