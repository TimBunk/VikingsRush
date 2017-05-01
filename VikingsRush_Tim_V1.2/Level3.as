package  {
	
	import flash.display.MovieClip;
	
	
	public class Level3 extends Level {
		
		
		public function Level3() {
			// constructor code
			CreatePoint(200,450);
			CreatePoint(500,450);
			CreatePoint(675,150);
			CreatePoint(850,150);
			CreatePoint(950,400);
			CreatePoint(1100,500);
			CreatePoint(1350,500);
			spawnX = 200;
			spawnY = -50;
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
			gold = 80;
			
			vikings = new Array();
			vikings[0] = [];
			CreateViking(new Thief(),0,1000);
			CreateViking(new Thief(),0,1000);
			CreateViking(new Thief(),0,1000);
			CreateViking(new Warrior(),0,1200);
			CreateViking(new Scout(),0,1000);
			CreateViking(new Warrior(),0,1000);
			CreateViking(new Warrior(),0,1000);
			vikings[1] = [];
			CreateViking(new Warrior(),1,2000);
			CreateViking(new Warrior(),1,2000);
			CreateViking(new Warrior(),1,2000);
			CreateViking(new Thief(),1,1100);
			CreateViking(new Shield(),1,2000);
			CreateViking(new Warrior(),1,3000);
			CreateViking(new Scout(),1,1000);
			vikings[2] = [];
			CreateViking(new Shield(),2,1000);
			CreateViking(new Thief(),2,2000);
			CreateViking(new Shield(),2,500);
			vikings[3] = [];
			CreateViking(new GiantWarrior(),3,1000);
			timerArray.push(0);
			
			BuildLocation(35,500);
			BuildLocation(325,150);
			BuildLocation(700,325);
			BuildLocation(1100,200);
			totalWaves = vikings.length;
		}
	}
}
