package  {
	
	import flash.display.MovieClip;
	
	
	public class GiantWarrior extends VikingBoss {
		
		
		public function GiantWarrior() {
			// constructor code
			bossName = "GiantWarrior";
			
			speedLimitOld = 2.5;
			speedLimit = 2.5;
			damage = 20;
			lives = 30;
			oldLives = 30;
			gold = 0;
			description = "GiantWarrior: This big giant likes to crush everything that stands in his way.";
		}
	}
}
