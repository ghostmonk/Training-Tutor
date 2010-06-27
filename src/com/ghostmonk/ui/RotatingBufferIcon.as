package com.ghostmonk.ui 
{    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filters.BlurFilter;
    import flash.filters.DropShadowFilter;
    import flash.geom.Point;

    /**
     * A simple rotating circular icon representing a loading buffer.
     * 
     * @author nhillier 
     * 
     */
    public class RotatingBufferIcon extends Sprite 
    {
        private var _color:uint;
        private var _radius:int;
        private var _thickness:Number;
		private var _buffer:Sprite;
        
        public function RotatingBufferIcon( color:uint = 0x0099ff, radius:int = 20, thickness:Number = 10 ) 
        {            
            _radius = radius;
            _color = color;
            _thickness = thickness;
			_buffer =  new Sprite();
			
			alpha = 0;
			filters = [ new BlurFilter(), new DropShadowFilter( 4, 45, 0x333333, 0.5 ) ];
            drawBuffer();
			_buffer.x = _radius + ( _thickness * 0.5 );
			_buffer.y = _radius + ( _thickness * 0.5 );
			addChild( _buffer );
			_buffer.cacheAsBitmap = true;
			mouseEnabled = false;
			cacheAsBitmap = true;   
        }
        
        /**
         * Bring the icon into display. 
         * 
         */
        public function buildIn() : void 
        {    
            removeEventListener( Event.ENTER_FRAME, animateOut );
            addEventListener( Event.ENTER_FRAME, rotate );
            addEventListener( Event.ENTER_FRAME, animateIn );   
        }
        
        /**
         * Hide the icon from display 
         * 
         */
        public function buildOut() : void 
        {    
            removeEventListener( Event.ENTER_FRAME, animateIn );
            addEventListener( Event.ENTER_FRAME, animateOut );   
        }
        
        private function animateIn( e:Event ) : void 
        {    
            alpha += 0.2;
            
            if( alpha >= 1 ) 
            {
                alpha = 1;
                removeEventListener( Event.ENTER_FRAME, animateIn );
            }
        }
        
        private function animateOut( e:Event ) : void 
        {    
            alpha -= 0.2;
            
            if( alpha <= 0 ) 
            {
                alpha = 0;
                removeEventListener( Event.ENTER_FRAME, animateOut );
                removeEventListener( Event.ENTER_FRAME, rotate );
                if( parent ) parent.removeChild( this );
            }
        }
        
        private function drawBuffer() : void 
        {    
            for( var i:int = 0; i < 360; i += 8 ) 
            {
                var p:Point = getTrigPoint( i );
                drawPoint( p.x, p.y, 1 - ( i / 360 ) );
            }   
        }
        
        private function rotate( e:Event ) : void 
        {    
			_buffer.rotation += 10;   
        }
        
        private function getTrigPoint( degrees:Number ) : Point 
        {    
            var x:Number = Math.sin( ( Math.PI * degrees ) / 180 ) * _radius;
            var y:Number = Math.cos( ( Math.PI * degrees ) / 180 ) * _radius;
            return new Point( x, y );   
        }
        
        private function drawPoint( xPos:Number, yPos:Number, alpha:Number ) : void 
        {    
            _buffer.graphics.beginFill( _color, alpha );
			_buffer.graphics.drawCircle( xPos, yPos, _thickness * 0.5 );
			_buffer.graphics.endFill();   
        }
    }
}