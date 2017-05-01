package  {
	
	import flash.display.MovieClip;
	
	
	public class RockParticles extends Particle {
		
		public var lifeSpan:Number = 1;
		public var lifeDecrease:Number = 0.05;
		public var velocityBall:Vector2;
		public var angle:Number;
		public var damage = 0.25;
		
		public var includesParticles = false;
		public var nonTarget:Number;
		
		public function RockParticles(positionBall:Vector2,vvelocityBall:Vector2,aangle:Number) {
			// constructor code
			this.width /= 2;
			this.height /= 2;
			
			position = positionBall.copy();
			velocityBall = vvelocityBall.copy();
			angle = aangle;
			
			velocity = velocityBall.copy();
			velocity.normalize();
			velocity.multS(-25);
			
			speedLimit = 5;
			
			this.rotation = angle;
			velocity.rotate(Vector2.deg2rad(angle));
		}
		
		public function NewUpdate() {
			Update();
			this.alpha = lifeSpan;
			lifeSpan -= lifeDecrease;
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
