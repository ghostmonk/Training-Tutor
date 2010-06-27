package ca.georgebrown.trainingtutor.components.textDisplay
{
	import G3D4Y6f4t0l2UycswkI.H74Be3Mso_7Yw2kI974g;
	import G3D4Y6f4t0l2UycswkI.NTE4Hs__84Kue83JSUw_;
	
	import assets.ui.scrollbar.ScrollBarAsset;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class TextScroller extends NTE4Hs__84Kue83JSUw_ implements H74Be3Mso_7Yw2kI974g
	{
		private var _asset:ScrollBarAsset;
		
		public function set asset( asset:ScrollBarAsset ) : void
		{
			_asset = asset;
			fff( this );
		}
		
		public function get b3gs__usheK():Sprite
		{
			return _asset;
		}
		
		public function get hns_hsyen856():Sprite
		{
			return _asset.trackView;
		}
		
		public function get aaa():MovieClip
		{
			return _asset.handleView;
		}
		
		public function get nnn():Sprite
		{
			return null;
		}
		
		public function get ccc():MovieClip { return null; }
		public function get qqq():MovieClip { return null; }
		public function zzz( value:Number ) : void {}
	}
}