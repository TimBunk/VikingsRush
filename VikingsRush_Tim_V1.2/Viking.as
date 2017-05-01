package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class Viking extends MovieClip {
		
		public var position:Vector2 = new Vector2(0,0);
		public var velocity:Vector2 = new Vector2(0,0);
		public var acceleration:Vector2 = new Vector2(0,0);
		
		public var boss:Boolean = false;
		public var activated:Boolean = false;
		public var distance:Number = 10000;
		
		public var speedLimitOld:Number;
		
		public var speedLimit:Number;
		public var damage:Number;
		public var lives:Number;
		public var gold:Number;
		public var description:String;
		
		public var checkNum:Number = 0;
		public var hitPoint:Boolean = false;
		
		public var left:Boolean = true;
		public var _active:Boolean = false;
		
		public var uniqueNumber:Number;
		
		public var slowTimer:Timer = new Timer(0,0);
		public var slowActive:Boolean = false;

		public function Viking() {
			// constructor code
			slowTimer.stop();
			slowTimer.addEventListener(TimerEvent.TIMER, RemoveSlow);
		}
		
		public function Update():void {
			
			this.x = position.x;
			this.y = position.y;
			
			velocity.add(acceleration);
			velocity.limit(speedLimit);
			position.add(velocity);
			NewUpdate();
			
			if (velocity.x > 0) {
				this.rotationY = 0;
			}
			else {
				this.rotationY = 180;
			}
		}
		
		public function NewUpdate() {
			
		}
		
		public function ApplySlow(duration:Number,slowPercentage:Number) {
			duration *= 1000;
			slowTimer.stop();
			slowTimer.delay = duration;
			slowTimer.start();
			if (slowActive == false) {
				slowPercentage = 100 - slowPercentage;
				
				speedLimit /= 100;
				speedLimit *= slowPercentage;

				slowActive = true;
			}
			
		}
		
		public function RemoveSlow(e:TimerEvent) {
			speedLimit = speedLimitOld;
			slowTimer.stop();
			slowActive = false;
		}
	}
}
