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
	import org.flintparticles.common.initializers.ImageClass;
	import org.flintparticles.common.initializers.ImageClasses;
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
	import org.flintparticles.twoD.zones.LineZone;
	import org.flintparticles.twoD.zones.RectangleZone;
	
	
	
	
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
		
		public function onCreateEmition(angle1:Number,angle2:Number,theX:Number,theY:Number,disc:Boolean=true):void
		{
			arrayClassesItems = new Array();
		
				arrayClassesItems.push(ExplodePar0);
				arrayClassesItems.push(ExplodePar1);
				arrayClassesItems.push(ExplodePar2);
				arrayClassesItems.push(ExplodePar3);
				arrayClassesItems.push(ExplodePar4);
				arrayClassesItems.push(ExplodePar5);
				arrayClassesItems.push(ExplodePar6);
				arrayClassesItems.push(ExplodePar7);
				arrayClassesItems.push(ExplodePar8);
				arrayClassesItems.push(ExplodePar9);
				arrayClassesItems.push(ExplodePar10);
				arrayClassesItems.push(ExplodePar11);
				arrayClassesItems.push(ExplodePar12);
				arrayClassesItems.push(ExplodePar13);
				arrayClassesItems.push(ExplodePar14);
				arrayClassesItems.push(ExplodePar15);
				arrayClassesItems.push(ExplodePar16);
				arrayClassesItems.push(ExplodePar17);
				arrayClassesItems.push(ExplodePar18);
				arrayClassesItems.push(ExplodePar19);
				arrayClassesItems.push(ExplodePar20);
				arrayClassesItems.push(ExplodePar21);
				arrayClassesItems.push(ExplodePar22);
			trace("rata");
			emitter = new Emitter2D();
			emitter.counter = new TimePeriod(300, 20);
			emitter.addInitializer( new ImageClasses(arrayClassesItems));
			var renderer:BitmapRenderer;
			if (disc)
			{
				emitter.addInitializer( new Lifetime( 1.5 ) );
				emitter.addInitializer( new Velocity( new DiscSectorZone( new Point( 0, 0 ), 900, 900, angle1, angle2) ) );
				emitter.addAction( new LinearDrag(0.3) );
				emitter.addAction( new Accelerate(10, -100 ));
				renderer = new BitmapRenderer( new Rectangle( 0, -100, 500, 800 ) );
			}
			else
			{
				emitter.addInitializer( new Lifetime( 3 ) );
				emitter.addInitializer( new Velocity(new RectangleZone( -500, 0, 500, 500)));
				renderer = new BitmapRenderer( new Rectangle( 0, 0, 1000, 1000 ) );
			}
			
			emitter.addAction( new Age(  ) );
			emitter.addAction( new Move() );
			emitter.addAction( new Fade() );
			
			
			
			//emitter.addAction(new Friction(50));
			emitter.addAction(new SpeedLimit(500));
			//emitter.addAction(new GravityWell(10000,0,50,1));
			//emitter.addEventListener( EmitterEvent.EMITTER_EMPTY, restart, false, 0, true );

			
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