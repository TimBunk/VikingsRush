package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	
	
	public class LevelUI extends MovieClip{
		
		public var statistics:Statistics = new Statistics();
		
		public var menu:InGameMenu = new InGameMenu();
		public var menuPanel:MenuPanel = new MenuPanel();
		public var restart:Restart = new Restart();
		public var mute:MuteButton = new MuteButton();
		public var exit:ExitButton = new ExitButton();
		
		public var muted:Boolean = false;
		public var menuBool:Boolean = false;
		public var start:Boolean = false;
		public var exited:Boolean = true;
		public var defeated:Boolean = false;
		
		public static var gold:Number = 0;
		public var totalWaves:Number = 0;
		public var wave:Number = 0;
		public var lives:Number = 20;
		
		public var vikingProperties:VikingProperties = new VikingProperties();
		public var showViking:Viking;
		public var boolShowViking:Boolean = false;
		public var propertiesSwitchViking:Boolean = false;
		
		public var towerProperties:TowerUpgrades = new TowerUpgrades();
		public var showTower:Tower;
		public var boolShowTower:Boolean = false;
		public var propertiesSwitchTower:Boolean = false;
		
		public function LevelUI() {
			// constructor code
			
			statistics.alpha = 0.75;
			addChild(statistics);
			menu.addEventListener(MouseEvent.CLICK, OpenMenu);
			menu.x = 1180;
			addChild(menu);
			
			menuPanel.x = 640 - menuPanel.width/2;
			menuPanel.y = 360 - menuPanel.height/2;
			
			restart.addEventListener(MouseEvent.CLICK, RestartLevel);
			restart.x = 25;
			restart.y = 25;
			menuPanel.addChild(restart);
			
			mute.addEventListener(MouseEvent.CLICK, Mute);
			mute.x = 150;
			mute.y = 25;
			mute.gotoAndStop(1);
			menuPanel.addChild(mute);
			
			exit.addEventListener(MouseEvent.CLICK, ExitLevel);
			exit.x = 275;
			exit.y = 25;
			menuPanel.addChild(exit);
			
			vikingProperties.y = 620;
			vikingProperties.alpha = 0.75;
			towerProperties.y = 620;
			towerProperties.alpha = 0.75;
		}
		
		public function UpdateUI():void {
			this.setChildIndex(statistics,numChildren-1);
			if (exited == false) {
				statistics.gold.text = "Gold: " + gold.toString();
				var newWave:Number = wave+1;
				statistics.wave.text = "Wave: " + newWave.toString() + "/" + totalWaves.toString();
				statistics.lives.text = "Lives: " + lives.toString();
				if (lives <= 0) {
					defeated = true;
					exited = true;
					(parent as MovieClip).removeChild(this);
					if (menuBool == true)
						OpenMenu(null);
				}
				if (Main.muted ==  false) {
					mute.gotoAndStop(2);
				}
				if (Main.muted == true) {
					mute.gotoAndStop(1);
				}
			}
		}
		
		public function OpenMenu(e:MouseEvent) {
			if (menuBool == false) {
				addChild(menuPanel);
				this.setChildIndex(menuPanel,numChildren-1);
				menuBool = true;
				return;
			}
			if (menuBool == true) {
				removeChild(menuPanel);
				menuBool = false;
				return;
			}
		}
		
		public function RestartLevel(e:MouseEvent):void {
			start = true;
			OpenMenu(null);
		}
		
		public function Mute(e:MouseEvent):void {
			if (Main.muted ==  false) {
				Main.muted = true;
				OpenMenu(null);
				return;
			}
			if (Main.muted == true) {
				Main.muted = false;
				OpenMenu(null);
				return;
			}
		}
		
		public function ExitLevel(e:MouseEvent):void {
			exited = true;
			OpenMenu(null);
			(parent as MovieClip).removeChild(this);
		}
	}
}
