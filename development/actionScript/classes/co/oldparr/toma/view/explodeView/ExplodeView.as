package co.oldparr.toma.view.explodeView 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.casalib.display.CasaSprite;
	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.actions.Fade;
	import org.flintparticles.common.counters.Blast;
	import org.flintparticles.common.counters.TimePeriod;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.common.initializers.SharedImages;
	import org.flintparticles.twoD.actions.Accelerate;
	import org.flintparticles.twoD.actions.Friction;
	import org.flintparticles.twoD.actions.LinearDrag;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.actions.Rotate;
	import org.flintparticles.twoD.actions.SpeedLimit;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.Velocity;
	import org.flintparticles.twoD.renderers.BitmapRenderer;
	import org.flintparticles.twoD.zones.DiscSectorZone;
	import flash.utils.getDefinitionByName;
	import co.oldparr.view.explode.*;
	
	
	
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class ExplodeView extends CasaSprite 
	{
		private var emitter:Emitter2D;
	
		private var arrayClassesItems:Array;
		
		public function ExplodeView() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		public function onCreateEmition(angle1:Number,angle2:Number,theX:Number,theY:Number):void
		{
			arrayClassesItems = new Array();
		
				arrayClassesItems.push(new ExplodePar0());
				arrayClassesItems.push(new ExplodePar1());
				arrayClassesItems.push(new ExplodePar2());
				arrayClassesItems.push(new ExplodePar3());
				arrayClassesItems.push(new ExplodePar4());
				arrayClassesItems.push(new ExplodePar5());
				arrayClassesItems.push(new ExplodePar6());
				arrayClassesItems.push(new ExplodePar7());
				arrayClassesItems.push(new ExplodePar8());
				arrayClassesItems.push(new ExplodePar9());
				arrayClassesItems.push(new ExplodePar10());
				arrayClassesItems.push(new ExplodePar11());
				arrayClassesItems.push(new ExplodePar12());
				arrayClassesItems.push(new ExplodePar13());
				arrayClassesItems.push(new ExplodePar14());
				arrayClassesItems.push(new ExplodePar15());
				arrayClassesItems.push(new ExplodePar16());
				arrayClassesItems.push(new ExplodePar17());
				arrayClassesItems.push(new ExplodePar18());
				arrayClassesItems.push(new ExplodePar19());
				arrayClassesItems.push(new ExplodePar20());
				arrayClassesItems.push(new ExplodePar21());
				arrayClassesItems.push(new ExplodePar22());
			trace("rata");
			emitter = new Emitter2D();
			emitter.counter = new TimePeriod(400, 20);
			emitter.addInitializer( new SharedImages(arrayClassesItems));
			emitter.addInitializer( new Velocity( new DiscSectorZone( new Point( 0, 0 ), 700, 700, angle1, angle2) ) );
			emitter.addInitializer( new Lifetime( 2 ) );
			emitter.addAction( new Age(  ) );
			emitter.addAction( new Move() );
			//emitter.addAction( new Fade() );
			emitter.addAction(new Rotate());
			emitter.addAction( new Accelerate(10,-100 ));
			emitter.addAction( new LinearDrag(0.6) );
			emitter.addAction(new Friction(50));
			emitter.addAction(new SpeedLimit(400));
			//emitter.addAction(new GravityWell(10000,0,50,1));
			//emitter.addEventListener( EmitterEvent.EMITTER_EMPTY, restart, false, 0, true );

			var renderer:BitmapRenderer = new BitmapRenderer( new Rectangle( 0, -100, 500, 600 ) );
			//renderer.addFilter( new BlurFilter( 2, 2, 1 ) );
			//renderer.addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.95,0 ] ) );
			renderer.addEmitter( emitter );
			addChild( renderer );

			emitter.x =theX;
			emitter.y = theY;
			emitter.start();
						
		}
	}

}