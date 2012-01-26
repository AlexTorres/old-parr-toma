package co.oldparr.toma.utils
{
	import flash.display.MovieClip;
	import org.casalib.display.CasaMovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class ScaleAnimation extends CasaMovieClip
	{
		private var velocidad:Number = 0;
		private var peso:Number = .01;
		private var _mc:MovieClip;
		private var _maxScale:Number;
		private var _minScale:Number;
		
		public function ScaleAnimation(mc:MovieClip, maxScale:Number,minScale:Number)
		{
			_mc = mc;
			this.maxScale = maxScale;
			this.minScale = minScale;
			addEventListener(Event.ENTER_FRAME, mover)
		
		}
		
		private function mover(m:Event):void
		{
			velocidad += peso;
			//Traduce la fórmula anterior a la rotación del objeto  
			_mc.scaleX += velocidad;
			_mc.scaleY +=velocidad;
			//Este condicional es verdadero al bajar de derecha a izquierda 
			
			if (_mc.scaleX >this.maxScale)
			{
				//_mc.scale =0.1;
				
				peso *= 0.0001;
				velocidad = -velocidad;
			}
			
			
			//Este condicional es verdadero al bajar de izquierda a derecha  
			if (_mc.scaleX < this.minScale)
			{
				//_mc.scaleX = 0.1;
				
				peso *= -0.0001;
				velocidad = -velocidad;
			}
		
		}
		
		public function get maxScale():Number 
		{
			return _maxScale;
		}
		
		public function set maxScale(value:Number):void 
		{
			_maxScale = value;
		}
		
		public function get minScale():Number 
		{
			return _minScale;
		}
		
		public function set minScale(value:Number):void 
		{
			_minScale = value;
		}
	
	}

}

