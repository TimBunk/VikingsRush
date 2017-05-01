package  {
	
	import flash.display.MovieClip;
	
	
	public class Scout extends Viking {
		
		
		public function Scout() {
			// constructor code
			this.height/=4;
			this.width/=4;
			speedLimitOld = 4.5;
			speedLimit = 4.5;
			damage = 2;
			lives = 3.5;
			gold = 5;
			description = "Scout: This viking is well known for his high speed."
		}
		
		public override function NewUpdate() {
			
		}
	}	
}
