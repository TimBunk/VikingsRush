package  {
	
	import flash.display.MovieClip;
	
	
	public class Bullet extends MovieClip {
		
		public var originialPosition:Vector2;
		public var position:Vector2 = new Vector2(0,0);
		public var velocity:Vector2 = new Vector2(0,0);
		public var angle:Number = 0;
		
		public var damage:Number;
		public var speed:Number;
		public var hit:Boolean = false;
		
		public var target:Number;
		public var shootAt:Boolean = false;
		
		public var includesParticles:Boolean = false;

		public function Bullet() {
			// constructor code
		}
		
		public function Update():void {
			this.x = position.x;
			this.y = position.y;
			
			velocity.limit(speed);
			position.add(velocity);
			
			angle = velocity.getAngle();
			this.rotation =  (Vector2.rad2deg(angle) + 90);
		}
		
		public function ShootAt(_target:Number):void {
			if (shootAt == false) {
				target = _target;
				shootAt = true;
				return;
			}
			return;
		}
	}
}
