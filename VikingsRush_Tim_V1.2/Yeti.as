package  {
	
	import flash.display.MovieClip;
	
	
	public class Yeti extends VikingBoss {
		
		
		public function Yeti() {
			// constructor code
			this.height /= 4;
			this.width /= 4;
			bossName = "Yeti";
			
			speedLimitOld = 3;
			speedLimit = 3;
			damage = 9001;
			lives = 40;
			oldLives = 40;
			gold = 0;
			description = "Yeti: though opponent with many lives.";
		}
	}
}
