package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class MagicTower extends Tower {
		
		public static var radius = 400;
		
		public var wwidth:Number;
		public var hheight:Number;
		
		public var slowChange:Number = 0.15;
		public var slow:Number = 15;
		
		public var fireChange:Number = 0.15;
		public var fire:Number = 15;
		
		public function MagicTower() {
			// constructor code
			this.height /= 2;
			this.width /= 2;
			
			wwidth = this.width;
			hheight = this.height;
			
			damage = 1.25;
			reloadSpeedMSec = 1000;
			reloadSpeedSec = 1;
			timer.delay = reloadSpeedMSec;
			speed = 10;
			radius = 400;
			
			upgradeAmount1 = 2;
			upgradeCost1 = 0;
			upgrade1text = "Fire elemental, has 15% change of doing 2.5 more damage.<br>" + "Cost: 0";
			upgradeAmount2 = 1;
			upgradeCost2 = 0;
			upgrade2text = "Ice elematal, has 15% change of slowing vikings for 40%. This effect lasts for 2 seconds. Cost: 0";
			upgradeAmount3 = 0;
			upgradeCost3 = 0;
			upgrade3text = "No more upgrades";
			upgradeCost4 = 0;
			upgradeAmount4 = 0;
			upgrade4text = "No more upgrades";
		}
		
		public override function Upgrade1() {
			if (upgradeNum1 == 0) {
				if (upgradeCost1 <= LevelUI.gold) {
					LevelUI.gold -= upgradeCost1;
					this.gotoAndStop(3);
					upgradeNum1++;
					upgradeNum2++;
					
					upgradeCost1 = 30;
					upgrade1text = "15% more change of applying bonus damage<br>" + "Cost: 30";
					
					special = fire.toString() + "% change to aplly 2.5 bonus damage";
				}
				return;
			}
			if (upgradeNum1 == 1 && this.currentFrame == 2) {
				if (upgradeCost1 <= LevelUI.gold) {
					LevelUI.gold -= upgradeCost1;
					upgradeNum1++;
					
					slowChange = 0.3;
					slow = 30;
					special = slow.toString() + "% change to slow for 40%. Effect lasts for 2 seconds";
				}
			}
			if (upgradeNum1 == 1 && this.currentFrame == 3) {
				if (upgradeCost1 <= LevelUI.gold) {
					LevelUI.gold -= upgradeCost1;
					upgradeNum1++;
					
					fireChange = 0.3;
					fire = 30;
					special = fire.toString() + "% change to aplly 2.5 bonus damage";
				}
			}
		}
		
		public  override function Upgrade2() {
			if (upgradeNum2 == 0) {
				if (upgradeCost2 <= LevelUI.gold) {
					LevelUI.gold -= upgradeCost2;
					this.gotoAndStop(2);
					upgradeNum1++;
					upgradeNum2++;
					
					upgradeCost1 = 30;
					upgrade1text = "15% more change of slowing a viking<br>" + "Cost: 30";
					
					special = slow.toString() + "% change to slow for 40%. Effect lasts for 2 seconds";
				}
			}
		}
		
		public  override function Upgrade3() {
			
		}
		
		public  override function Upgrade4() {
			
		}
	}	
}
