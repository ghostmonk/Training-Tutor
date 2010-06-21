package ca.georgebrown.trainingtutor.components
{
	import ca.georgebrown.trainingtutor.components.sections.CustomSection;
	import ca.georgebrown.trainingtutor.components.sections.CustomSectionFactory;
	
	import com.ghostmonk.utils.MainStage;
	
	public class CustomSectionManager
	{
		private var _customView:CustomSection;
		
		public function CustomSectionManager()
		{
		}
		
		public function createView( type:String ) : void
		{
			_customView = CustomSectionFactory.getView( type );	
			MainStage.instance.addChild( _customView.view );
		}
		
		public function advanceSection() : void
		{
			_customView.view.play();
		}
		
		public function clean() : void
		{
			if( _customView ) _customView.buildOut();
			_customView = null;
		}	
	}
}