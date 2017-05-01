package  {
	
	import flash.display.MovieClip;
	
	
	public class IceParticles extends Particle {
		
		public var lifeSpan:Number = 1;
		public var lifeDecrease:Number = 0.05;
		public var velocityBall:Vector2;
		
		public function IceParticles(positionBall:Vector2,vvelocityBall:Vector2) {
			// constructor code
			position = positionBall.copy();
			velocityBall = vvelocityBall.copy();
			
			velocity = velocityBall.copy();
			velocity.normalize();
			velocity.multS(-25);
			GetRandomAngle(30);
			
			speedLimit = 5;
		}
		
		public function NewUpdate() {
			Update();
			this.alpha = lifeSpan;
			lifeSpan -= lifeDecrease;
		}
		
		public function GetRandomAngle(maxRndmAngle:Number) {
			var random:Number = Math.random() * (maxRndmAngle - (maxRndmAngle*-1)) + maxRndmAngle*-1;
			var newAngle:int = random;
					
			this.rotation = newAngle;
			velocity.rotate(Vector2.deg2rad(newAngle));
		}
		
		public function isDead() {
			if (lifeSpan <= 0.0) {
				return true;
			}
			else {
				return false;
			}
		}
	}
}
