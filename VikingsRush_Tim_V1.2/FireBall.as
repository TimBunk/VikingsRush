package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class FireBall extends Bullet {
		
		public var particles:Array = new Array();
		public var bonusDamage = 2.5;
		public var fireChange:Number = 0.15;
		
		public function FireBall() {
			// constructor code
			includesParticles = true;
		}
		
		public function BonusDamage() {
			var random:Number = Math.random();
			if (random <= fireChange) {
				damage += bonusDamage;
			}
		}
	}
}
