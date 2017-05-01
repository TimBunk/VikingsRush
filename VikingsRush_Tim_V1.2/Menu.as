package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.*;
	
	
	public class Menu extends MovieClip {
		
		private var start:Start = new Start();
		public var started:Boolean = false;
		public var mute:MuteButton = new MuteButton();
		public var active:Boolean = true;
		
		public var viking:Warrior = new Warrior();
		public var textCloud:TextCloud = new TextCloud();
		public var timer:Timer = new Timer(3000,0);
		
		public var archeryTower:ArcheryTower = new ArcheryTower();
		public var dist:Vector2;
		public var arrows:Array = new Array();
		
		public function Menu() {
			// constructor code
			this.addEventListener(MouseEvent.CLICK, ShootArrow);
			timer.stop();
			timer.addEventListener(TimerEvent.TIMER, RemoveTextCloud);
			
			start.addEventListener(MouseEvent.CLICK, StartGame);
			start.x = 160;
			start.y = 180;
			addChild(start);
			
			mute.x = 1180;
			mute.addEventListener(MouseEvent.CLICK, Mute);
			mute.gotoAndStop(1);
			addChild(mute);
			
			viking.width *= 2;
			viking.height *= 2;
			viking.position = new Vector2(640,550);
			viking.velocity = new Vector2(5,0);
			viking.speedLimit = 20;
			viking.Update();
			addChild(viking);
			
			archeryTower.width *= 1.6;
			archeryTower.height *= 1.6;
			archeryTower.position = new Vector2(900,100);
			archeryTower.Update();
			addChild(archeryTower);
		}
		
		public function Update() {
			viking.Update();
			textCloud.x = viking.x + viking.width/2;
			textCloud.y = viking.y - 50;
			dist = new Vector2(stage.mouseX - archeryTower.x - (archeryTower.width/2),stage.mouseY - archeryTower.y - (30));
			
			archeryTower.bowAngle = dist.getAngle();
			var newBowPosition:Vector2 = new Vector2(1,0);
			newBowPosition.rotate(archeryTower.bowAngle);
			newBowPosition.normalize();
			newBowPosition.multS(30);
							
			archeryTower.bowAngle = Vector2.rad2deg(archeryTower.bowAngle);
			archeryTower.bow.rotation = archeryTower.bowAngle;
			archeryTower.bow.x = archeryTower.bowPosition.x + newBowPosition.x;
			archeryTower.bow.y = archeryTower.bowPosition.y + newBowPosition.y;
			archeryTower.Draw();
			
			for (var i:Number=0;i<arrows.length;i++) {
				arrows[i].Update();
				if (arrows[i].x > 1320) {
					DestroyArrow(i);
					i--;
				}
				else if (arrows[i].x < -50) {
					DestroyArrow(i);
					i--;
				}
				else if (arrows[i].y > 770) {
					DestroyArrow(i);
					i--;
				}
				else if (arrows[i].y < -50) {
					DestroyArrow(i);
					i--;
				}
				else if (arrows[i].hitTestObject(viking)) {
					DestroyArrow(i);
					i--;
					addChild(textCloud);
					textCloud.alpha = 0.75;
					timer.delay = 3000;
					timer.start();
				}
			}
			
			
			var random:Number = Math.random();
			if (viking.position.x > 1280) {
				if (random >= 0.5)
					viking.velocity = new Vector2(-5,0);
				else
					viking.position.x = 0 - viking.width;
			}
			else if (viking.position.x < 0 - viking.width) {
				if (random >= 0.5)
					viking.velocity = new Vector2(5,0);
				else
					viking.position.x = 1280;
			}
			if (Main.muted ==  false) {
				mute.gotoAndStop(2);
			}
			if (Main.muted == true) {
				mute.gotoAndStop(1);
			}
		}
		
		public function ShootArrow(e:MouseEvent):void {
			var arrow:Arrow = new Arrow();
			arrows.push(arrow);
			arrow.position = new Vector2(archeryTower.x + archeryTower.width/2,archeryTower.y + 50);
			arrow.velocity = new Vector2(dist.x,dist.y);
			arrow.velocity.normalize();
			arrow.velocity.multS(10);
			arrow.Update();
			addChild(arrow);
		}
		
		public function RemoveTextCloud(e:TimerEvent) {
			removeChild(textCloud);
			timer.stop();
		}
		
		public function Mute(e:MouseEvent) {
			if (Main.muted ==  false) {
				Main.muted = true;
				return;
			}
			if (Main.muted == true) {
				Main.muted = false;
				return;
			}
		}
		
		public function DestroyArrow(i:Number):void {
			removeChild(arrows[i]);
			arrows.splice(i,1);
		}
		
		public function StartGame(e:MouseEvent):void {
			started = true;
		}
	}
}
