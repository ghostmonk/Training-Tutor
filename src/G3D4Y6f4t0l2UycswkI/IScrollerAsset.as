package G3D4Y6f4t0l2UycswkI {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public interface IScrollerAsset {
		
		function get container():Sprite;
		function get track():Sprite;
		function get handle():MovieClip;
		function get grip():Sprite;
		function get upBtn():MovieClip;
		function get downBtn():MovieClip;
		
		function size( value:Number ):void;
		
	}
}