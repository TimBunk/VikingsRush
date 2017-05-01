package  {
	
	import flash.display.MovieClip;
	
	
	public class Level2 extends Level {
		
		
		public function Level2() {
			// constructor code
			CreatePoint(200,125);
			CreatePoint(1050,125);
			CreatePoint(1200,350);
			CreatePoint(1200,450);
			CreatePoint(1050,550);
			CreatePoint(575,550);
			CreatePoint(550,790);
			spawnX = -50;
			spawnY = 125;
		}
		
		public function Update():void {
			if (start == true) {
				Start();
				start = false;
			}
			UpdateLevel();
		}
		
		public function Start():void {
			ClearLevel();
			LevelUI.gold = 100;
			
			vikings = new Array();
			vikings[0] = [];
			CreateViking(new Shield(),0,1000);
			CreateViking(new Scout(),0,2000);
			CreateViking(new Scout(),0,1000);
			CreateViking(new Thief(),0,1100);
			CreateViking(new Shield(),0,1000);
			CreateViking(new Warrior(),0,3000);
			CreateViking(new Shield(),0,1000);
			CreateViking(new Warrior(),0,1000);
			vikings[1] = [];
			CreateViking(new Thief(),1,1000);
			CreateViking(new Thief(),1,1000);
			CreateViking(new Shield(),1,1000);
			CreateViking(new Scout(),1,1000);
			CreateViking(new Shield(),1,1000);
			CreateViking(new Scout(),1,1000);
			vikings[2] = [];
			CreateViking(new Shield(),2,1000);
			CreateViking(new Thief(),2,500);
			CreateViking(new Shield(),2,2000);
			CreateViking(new Shield(),2,500);
			CreateViking(new Shield(),2,500);
			vikings[3] = [];
			CreateViking(new Yeti(),3,1000);
			timerArray.push(0);
			
			BuildLocation(200,225);
			BuildLocation(400,225);
			BuildLocation(600,225);
			BuildLocation(800,225);
			BuildLocation(300,500);
			totalWaves = vikings.length;
		}
	}
}
