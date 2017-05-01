package  {
	
	import flash.display.MovieClip;
	
	
	public class IceBall extends Bullet {
		
		public var particles:Array = new Array();
		
		public var slow:Boolean = false;
		public var slowDuration = 2;
		public var slowPercentage:Number = 40;
		public var slowChange:Number;
		
		public function IceBall() {
			// constructor code
			includesParticles = true;
		}
		
		public function ApplySlow() {
			var random:Number = Math.random();
			if (random <= slowChange) {
				slow = true;
			}
		}
	}
}
