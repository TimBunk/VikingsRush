package  {
	
	import flash.display.MovieClip;
	
	
	public class HeavyTower extends Tower {
		
		public static var radius = 400;
		
		public var wwidth:Number;
		public var hheight:Number;
		
		public function HeavyTower() {
			// constructor code
			this.height /= 2;
			this.width /= 2;
			
			wwidth = this.width;
			hheight = this.height;
			
			damage = 2.5;
			reloadSpeedMSec = 2000;
			reloadSpeedSec = 2;
			timer.delay = reloadSpeedMSec;
			speed = 10;
			radius = 400;
			special = "On hit the rocks will split in tiny pieces doing 0.25 damage each";
			
			upgradeAmount1 = 1;
			upgradeCost1 = 20;
			upgrade1text = "Increase radius to 550<br>" + "Cost: $20";
			upgradeAmount2 = 0;
			upgradeCost2 = 0;
			upgrade2text = "No more upgrades";
			upgradeCost3 = 0;
			upgradeAmount3 = 0;
			upgrade3text = "No more upgrades";
			upgradeCost4 = 0;
			upgradeAmount4 = 0;
			upgrade4text = "No more upgrades";
		}
		
		public override function Upgrade1() {
			if (upgradeCost1 <= LevelUI.gold) {
				LevelUI.gold -= upgradeCost1;
				radius = 550;
				HeavyTower.radius = 550;
				upgradeNum1++;
			}
		}
	}
}
