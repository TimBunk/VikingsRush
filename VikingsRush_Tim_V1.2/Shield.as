package  {
	
	import flash.display.MovieClip;
	
	
	public class Shield extends Viking {
		
		public var blocked:Blocked = new Blocked();
		public function Shield() {
			// constructor code
			this.height/=4;
			this.width/=4;
			speedLimitOld = 2.5;
			speedLimit = 2.5;
			damage = 3;
			lives = 12;
			gold = 12;
			description = "Shield: His shield is what makes him a strong opponent also he is able to block arrows with his shield."
			blocked.y = -40;
			blocked.alpha = 0;
			addChild(blocked);
		}
		
		public function Arrow(damage:Number) {
			var random:Number = Math.random();
			if (random >= 0.75)
				lives -= damage;
			else
				blocked.alpha = 1;
		}
		
		public override function NewUpdate() {
			if (blocked.alpha > 0)
				blocked.alpha -= 0.01;
		}
	}
}
