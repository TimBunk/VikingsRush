package  {
	
	import flash.display.MovieClip;
	
	
	public class Warrior extends Viking {
		
		
		public function Warrior() {
			// constructor code
			this.height/=4;
			this.width/=4;
			speedLimitOld = 2.5;
			speedLimit = 2.5;
			damage = 3;
			lives = 6;
			gold = 12;
			description = "Warrior: Strong viking and a real warmonger."
		}
		
		public override function NewUpdate() {
			
		}
	}
}
