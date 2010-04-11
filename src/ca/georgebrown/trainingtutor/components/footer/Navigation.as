package ca.georgebrown.trainingtutor.components.footer 
{	
	import assets.footer.timeline.SectionLabel;
	
	import bottomBar.timeline.NavigationAsset;
	
	import ca.georgebrown.trainingtutor.events.footer.NavigationEvent;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getQualifiedClassName;
	
	[Event (name="navigationClick", type="ca.georgebrown.trainingtutor.events.footer.NavigationEvent")]
	
	public class Navigation extends EventDispatcher 
	{	
		private const INACTIVE_LABEL_ALPHA:Number = 0.5;
		
		private var _view:NavigationAsset;
		private var _sectionsLabels:Array;
		private var _sectionNodes:Array;
		
		private var _openSections:int;
		private var _sectionLabelEffect:Array;
		
		public function Navigation( view:NavigationAsset ) 
		{	
			_view = view;
			
			_sectionsLabels = new Array();
			_sectionNodes = new Array();
			
			fillSectionArrays();	
		}
		
		public function get view() : NavigationAsset 
		{	
			return _view;	
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
			
			var nodeTarget:SimpleMovieClipButton = _sectionNodes[ index ] as SimpleMovieClipButton;
			nodeTarget.disable();
			Tweener.addTween( _view.progressMask, { width:nodeTarget.view.x, time:0.3 } );
			
			var labelTarget:SectionLabel = _sectionsLabels[ index ] as SectionLabel;
			Tweener.addTween( labelTarget, { alpha:1, time:0.3, transition:Equations.easeNone } );
			labelTarget.label.filters = _sectionLabelEffect;
			
		}
		
		public function sectionAccess( index:int ) : void 
		{	
			_openSections = index;
			
			for( var i:int = index + 1; i < _sectionNodes.length; i++ ) 
			{
				( _sectionNodes[ i ] as SimpleMovieClipButton ).disable();	
			}
		}
		
		private function resetSectionAssets() : void 
		{	
			for( var i:int; i < _sectionNodes.length; i++ ) 
			{
				( _sectionsLabels[ i ] as SectionLabel ).alpha = INACTIVE_LABEL_ALPHA;
				( _sectionsLabels[ i ] as SectionLabel ).label.filters = [];
				( _sectionNodes[ i ] as SimpleMovieClipButton ).enable();
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
			_sectionNodes.push( new SimpleMovieClipButton( node, onSectionClick ) );
		}
		
		private function onSectionClick( e:MouseEvent ) : void 
		{	
			for each( var btn:SimpleMovieClipButton in _sectionNodes ) 
			{
				if( e.target == btn.view ) 
				{
					var index:int = _sectionNodes.indexOf( btn ); 
					sectionIndex = index;
					dispatchEvent( new NavigationEvent( NavigationEvent.SECTION_NAVIGATION, index ) );
				}
			}
			
			sectionAccess( _openSections );
		}
	}
}