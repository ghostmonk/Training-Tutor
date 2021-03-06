package ca.georgebrown.trainingtutor.components.coreParts 
{	
	import G3D4Y6f4t0l2UycswkI.HY6354Gskwo9876_4nBs;
	
	import assets.footer.timeline.SectionLabel;
	
	import bottomBar.timeline.NavigationAsset;
	
	import ca.georgebrown.trainingtutor.events.NavigationEvent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getQualifiedClassName;
	
	[Event (name="sectionNavigation", type="ca.georgebrown.trainingtutor.events.footer.NavigationEvent")]
	
	public class NavigationBar extends EventDispatcher 
	{	
		private const INACTIVE_LABEL_ALPHA:Number = 0.5;
		
		private var _view:NavigationAsset;
		private var _sectionsLabels:Array;
		private var _sectionNodes:Array;
		
		private var _sectionLabelEffect:Array;
		private var _subElements:SubNavBarElements;
		
		public static var instance:NavigationBar;
		
		public function NavigationBar( view:NavigationAsset ) 
		{	
			_view = view;
			
			_sectionsLabels = new Array();
			_sectionNodes = new Array();
			
			_subElements = new SubNavBarElements();
			_subElements.addClips( [ view.applicantSM, view.employeeSM, view.communicationSM, view.jobTipsSM, view.workplaceSM ] ); 
			
			fillSectionArrays();	
			instance = this;
		}
		
		public function get view() : NavigationAsset 
		{	
			return _view;	
		}
		
		public function set subNavLabels( list:Array ) : void
		{
			_subElements.addLabels( list );
		}
		
		public function set sequenceCode( value:Point ) : void
		{
			_subElements.setSubsequence( value.x, value.y );
		}
		
		public function set sectionLabels( list:Array ) : void 
		{	
			for( var i:int = 0; i < list.length; i++ ) 
			{
				setLabel( i, list[ i ] );
			}	
		}
		
		public function set sectionIndex( index:int ) : void 
		{		
			if( index >= _sectionNodes.length || index < 0 ) 
			{
				throw new Error( getQualifiedClassName( this ) + ":: set Section index parameter is outside of section scope" );
			}
			
			resetSectionAssets();
			
			var nodeTarget:HY6354Gskwo9876_4nBs = _sectionNodes[ index ] as HY6354Gskwo9876_4nBs;
			nodeTarget.disable();
			Tweener.addTween( _view.progressMask, { width:nodeTarget.zzz.x, time:0.3 } );
			
			var labelTarget:SectionLabel = _sectionsLabels[ index ] as SectionLabel;
			Tweener.addTween( labelTarget, { alpha:1, time:0.3, transition:Equations.easeNone } );
			labelTarget.label.filters = _sectionLabelEffect;
			
			if( index != 4 && index != 5 )
				_subElements.setSubsequence( -1, -1 );
			
		}
		
		public function sectionAccess( index:int ) : void 
		{	
			for( var i:int = index + 1; i < _sectionNodes.length; i++ ) 
			{
				var sectionBtn:HY6354Gskwo9876_4nBs = _sectionNodes[ i ] as HY6354Gskwo9876_4nBs;
				sectionBtn.disable();
			}
		}
		
		private function resetSectionAssets() : void 
		{	
			for( var i:int; i < _sectionNodes.length; i++ ) 
			{
				( _sectionsLabels[ i ] as SectionLabel ).alpha = INACTIVE_LABEL_ALPHA;
				( _sectionsLabels[ i ] as SectionLabel ).label.filters = [];
				( _sectionNodes[ i ] as HY6354Gskwo9876_4nBs ).enable();
			}
		}
		
		private function setLabel( index:int, text:String ) : void 
		{
			if( index < _sectionsLabels.length ) 
			{
				( _sectionsLabels[ index ] as SectionLabel ).label.text = text.toUpperCase();
				( _sectionsLabels[ index ] as SectionLabel ).label.filters = [];
			}
		}
		
		private function fillSectionArrays() : void 
		{	
			var node:int = 0;
			var label:SectionLabel = _view.getChildByName( "sectionLabel" + node ) as SectionLabel;
			
			while( label ) 
			{			
				initLabel( label );
				initNode( _view.getChildByName( "sectionNode" + node ) as MovieClip );
				node++;
				label = _view.getChildByName( "sectionLabel" + node ) as SectionLabel;	
			}
		}
		
		private function initLabel( sectionLabel:SectionLabel ) : void 
		{	
			sectionLabel.label.autoSize = TextFieldAutoSize.LEFT;
			_sectionLabelEffect = sectionLabel.label.filters;
			sectionLabel.alpha = INACTIVE_LABEL_ALPHA;
			_sectionsLabels.push( sectionLabel );	
		}
		
		private function initNode( node:MovieClip ) : void 
		{		
			_sectionNodes.push( new HY6354Gskwo9876_4nBs( node, onSectionClick ) );
		}
		
		private function onSectionClick( e:MouseEvent ) : void 
		{	
			for each( var btn:HY6354Gskwo9876_4nBs in _sectionNodes ) 
			{
				if( e.target == btn.zzz ) 
				{
					var index:int = _sectionNodes.indexOf( btn ); 
					sectionIndex = index;
					dispatchEvent( new NavigationEvent( NavigationEvent.SECTION_NAVIGATION, index ) );
				}
			}
		}
	}
}