package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Particle extends MovieClip {
		
		public var position:Vector2 = new Vector2(0,0);
		public var velocity:Vector2 = new Vector2(0,0);
		public var acceleration:Vector2 = new Vector2(0,0);
		public var speedLimit:Number = 5;
		
		public function Particle() {
			// constructor code
		}
		
		public function Update() {
			this.x = position.x;
			this.y = position.y;
			
			velocity.add(acceleration);
			velocity.limit(speedLimit);
			position.add(velocity);
		}
	}
}
