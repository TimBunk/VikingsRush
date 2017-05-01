package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class ArcheryTower extends Tower {
		
		public var archer:Archer = new Archer();
		public var bow:Bow = new Bow();
		public var bowPosition:Vector2 = new Vector2(145,73);
		public var bowAngle:Number = 0;
		public var leftArm:Sprite = new Sprite();
		public var rightArm:Sprite = new Sprite();
		
		public static var radius = 400;
		
		public var wwidth:Number;
		public var hheight:Number;
		
		public function ArcheryTower() {
			// constructor code
			this.height /= 2;
			this.width /= 2;
			
			wwidth = this.width;
			hheight = this.height;
			
			archer.x = 125;
			archer.y = 20;
			
			addChild(archer);
			this.setChildIndex(archer,0);
			addChild(leftArm);
			addChild(rightArm);
			addChild(bow);
			
			bow.x = bowPosition.x + 30;
			bow.y = bowPosition.y;
			
			leftArm.x = archer.x;
			leftArm.y = archer.y+47;
			leftArm.graphics.beginFill(0xcebca5,1);
			leftArm.graphics.lineStyle(10,0xcebca5,1);
			leftArm.graphics.lineTo(bow.x-120,bow.y-65);
			leftArm.graphics.endFill();
			
			rightArm.x = archer.x + 32;
			rightArm.y = archer.y+ 47;
			rightArm.graphics.beginFill(0xcebca5,1);
			rightArm.graphics.lineStyle(10,0xcebca5,1);
			rightArm.graphics.lineTo(bow.x-140,bow.y-65);
			rightArm.graphics.endFill();
			
			
			damage = 1;
			reloadSpeedMSec = 1000;
			reloadSpeedSec = 1;
			timer.delay = reloadSpeedMSec;
			speed = 10;
			radius = 400;
			
			upgradeCost1 = 30;
			upgradeAmount1 = 3;
			upgrade1text = "Divide reloadSpeed by 1.15<br>" + "Cost: $30";
			upgradeCost2 = 30;
			upgradeAmount2 = 3;
			upgrade2text = "Multiply damage by 1.5<br>" + "Cost: $30";
			upgradeCost3 = 0;
			upgradeAmount3 = 0;
			upgrade3text = "No more upgrades";
			upgradeCost4 = 0;
			upgradeAmount4 = 0;
			upgrade4text = "No more upgrades";
		}
		
		public function Draw() {
			if (bowAngle < 0)
				bowAngle = bowAngle * -1;
			if (bowAngle > 90) {
				leftArm.graphics.clear();
				leftArm.graphics.beginFill(0xcebca5,1);
				leftArm.graphics.lineStyle(10,0xcebca5,1);
				leftArm.graphics.lineTo(bow.x-120,bow.y-65);
				leftArm.graphics.endFill();
				
				rightArm.graphics.clear();
				rightArm.graphics.beginFill(0xcebca5,1);
				rightArm.graphics.lineStyle(10,0xcebca5,1);
				rightArm.graphics.lineTo(bow.x-180,bow.y-65);
				rightArm.graphics.endFill();
			}
			else {
				leftArm.graphics.clear();
				leftArm.graphics.beginFill(0xcebca5,1);
				leftArm.graphics.lineStyle(10,0xcebca5,1);
				leftArm.graphics.lineTo(bow.x-120,bow.y-65);
				leftArm.graphics.endFill();
				
				rightArm.graphics.clear();
				rightArm.graphics.beginFill(0xcebca5,1);
				rightArm.graphics.lineStyle(10,0xcebca5,1);
				rightArm.graphics.lineTo(bow.x-140,bow.y-65);
				rightArm.graphics.endFill();
			}
		}
		
		public override function Upgrade1() {
			if (upgradeCost1 <= LevelUI.gold) {
				LevelUI.gold -= upgradeCost1;
				reloadSpeedMSec /= 1.15;
				reloadSpeedSec /= 1.15;
				timer.delay = reloadSpeedMSec;
				upgradeNum1++;
			}
		}
		
		public override function Upgrade2() {
			if (upgradeCost2 <= LevelUI.gold) {
				LevelUI.gold -= upgradeCost2;
				damage *= 1.5;
				upgradeNum2++;
			}
		}
	}
}
