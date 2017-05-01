package  {
	
	import flash.display.MovieClip;
	
	
	public class Thief extends Viking {
		
		
		public function Thief() {
			// constructor code
			this.height/=4;
			this.width/=4;
			speedLimitOld = 3;
			speedLimit = 3;
			damage = 4;
			lives = 3;
			gold = 8;
			description = "Thief: A sneaky viking, this viking can only be seen by a archeryTower."
		}
		
		public override function NewUpdate() {
			
		}
	}	
}
