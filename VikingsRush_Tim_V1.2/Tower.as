package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	
	
	public class Tower extends MovieClip {
		
		public var position:Vector2 = new Vector2(0,0);
		public var damage:Number;
		public var speed:Number;
		
		public var timer:Timer = new Timer(1000,0);
		public var shoot:Boolean = false;
		public var radius:Number;
		public var special:String = new String();
		
		public var reloadSpeedMSec:Number;
		public var reloadSpeedSec:Number;

		public var upgradeCost1:Number;
		public var upgradeCost2:Number;
		public var upgradeCost3:Number;
		public var upgradeCost4:Number;
		public var upgradeAmount1:Number;
		public var upgradeAmount2:Number;
		public var upgradeAmount3:Number;
		public var upgradeAmount4:Number;
		public var upgradeNum1:Number = 0;
		public var upgradeNum2:Number = 0;
		public var upgradeNum3:Number = 0;
		public var upgradeNum4:Number = 0;
		public var upgrade1text:String;
		public var upgrade2text:String;
		public var upgrade3text:String;
		public var upgrade4text:String;

		public function Tower() {
			// constructor code
			special = "";
			
			timer.addEventListener(TimerEvent.TIMER, Shoot);
			timer.start();
		}
		
		public function Update():void {
			this.x = position.x;
			this.y = position.y;
		}
		
		public function Shoot(e:TimerEvent):void {
			shoot = true;
			timer.stop();
		}
		
		public function Upgrade1() {
			
		}
		
		public function Upgrade2() {
			
		}
		
		public function Upgrade3() {
			
		}
		
		public function Upgrade4() {
			
		}
	}
}
