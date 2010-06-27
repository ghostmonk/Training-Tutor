package com.ghostmonk.ui.graveyard {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * 
	 * Implement this interface and pass object as a parameter to a new com.ghostmonk.ui.Scroller 
	 * 
	 * @author ghostmonk 21/03/2009
	 * 
	 */
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