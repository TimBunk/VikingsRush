package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class TowerUpgrades extends MovieClip {
		
		public var towerUpgrade1:TowerUpgrade = new TowerUpgrade();
		public var towerUpgrade2:TowerUpgrade = new TowerUpgrade();
		public var towerUpgrade3:TowerUpgrade = new TowerUpgrade();
		public var towerUpgrade4:TowerUpgrade = new TowerUpgrade();
		public var upgrades:Array = new Array(towerUpgrade1,towerUpgrade2,towerUpgrade3,towerUpgrade4);
		
		public var tower:Tower;
		
		public function TowerUpgrades() {
			// constructor code
			upgrades[0].x = 140;
			upgrades[0].addEventListener(MouseEvent.CLICK, Upgrade1);
			
			upgrades[1].x = 340;
			upgrades[1].addEventListener(MouseEvent.CLICK, Upgrade2);
			
			upgrades[2].x = 140;
			upgrades[2].y = 50;
			upgrades[2].addEventListener(MouseEvent.CLICK, Upgrade3);
			
			upgrades[3].x = 340;
			upgrades[3].y = 50;
			upgrades[3].addEventListener(MouseEvent.CLICK, Upgrade4);
			for (var i:Number=0;i<upgrades.length;i++) {
				upgrades[i].gotoAndStop(1);
				addChild(upgrades[i]);
			}
		}
		
		public function Update() {
			if (tower != null && tower is Tower) {
				if (tower.upgradeCost1 <= LevelUI.gold && tower.upgradeAmount1 != tower.upgradeNum1) {
					upgrades[0].gotoAndStop(1);
					upgrades[0].upgrade.htmlText = tower.upgrade1text;
				}
				else if (tower.upgradeAmount1 != tower.upgradeNum1) {
					upgrades[0].gotoAndStop(2);
					upgrades[0].upgrade.htmlText = tower.upgrade1text;
				}
				else {
					upgrades[0].gotoAndStop(3);
				}
				
				if (tower.upgradeCost2 <= LevelUI.gold && tower.upgradeAmount2 != tower.upgradeNum2) {
					upgrades[1].gotoAndStop(1);
					upgrades[1].upgrade.htmlText = tower.upgrade2text;
				}
				else if (tower.upgradeAmount2 != tower.upgradeNum2) {
					upgrades[1].gotoAndStop(2);
					upgrades[1].upgrade.htmlText = tower.upgrade2text;
				}
				else {
					upgrades[1].gotoAndStop(3);
				}
				
				if (tower.upgradeCost3 <= LevelUI.gold && tower.upgradeAmount3 != tower.upgradeNum3) {
					upgrades[2].gotoAndStop(1);
					upgrades[2].upgrade.htmlText = tower.upgrade3text;
				}
				else if (tower.upgradeAmount3 != tower.upgradeNum3) {
					upgrades[2].gotoAndStop(2);
					upgrades[2].upgrade.htmlText = tower.upgrade3text;
				}
				else {
					upgrades[2].gotoAndStop(3);
				}
				
				if (tower.upgradeCost4 <= LevelUI.gold && tower.upgradeAmount4 != tower.upgradeNum4) {
					upgrades[3].gotoAndStop(1);
					upgrades[3].upgrade.htmlText = tower.upgrade4text;
				}
				else if (tower.upgradeAmount4 != tower.upgradeNum4) {
					upgrades[3].gotoAndStop(2);
					upgrades[3].upgrade.htmlText = tower.upgrade4text;
				}
				else {
					upgrades[3].gotoAndStop(3);
				}
			}
		}
		
		public function Upgrade1(e:MouseEvent) {
			if (tower.upgradeAmount1 != tower.upgradeNum1)
				tower.Upgrade1();
		}
		
		public function Upgrade2(e:MouseEvent) {
			if (tower.upgradeAmount2 != tower.upgradeNum2)
				tower.Upgrade2();
		}
		
		public function Upgrade3(e:MouseEvent) {
			if (tower.upgradeAmount3 != tower.upgradeNum3)
				tower.Upgrade3();
		}
		
		public function Upgrade4(e:MouseEvent) {
			if (tower.upgradeAmount4 != tower.upgradeNum4)
				tower.Upgrade4();
		}
	}
}
