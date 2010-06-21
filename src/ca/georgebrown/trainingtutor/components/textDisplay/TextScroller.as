package ca.georgebrown.trainingtutor.components.textDisplay
{
	import assets.ui.scrollbar.ScrollBarAsset;
	
	import com.ghostmonk.ui.graveyard.IScrollerAsset;
	import com.ghostmonk.ui.graveyard.Scroller;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class TextScroller extends Scroller implements IScrollerAsset
	{
		private var _asset:ScrollBarAsset;
		
		public function set asset( asset:ScrollBarAsset ) : void
		{
			_asset = asset;
			init( this );
		}
		
		public function get container():Sprite
		{
			return _asset;
		}
		
		public function get track():Sprite
		{
			return _asset.trackView;
		}
		
		public function get handle():MovieClip
		{
			return _asset.handleView;
		}
		
		public function get grip():Sprite
		{
			return null;
		}
		
		public function get upBtn():MovieClip { return null; }
		public function get downBtn():MovieClip { return null; }
		public function size( value:Number ) : void {}
	}
}