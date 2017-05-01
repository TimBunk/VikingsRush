package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class TowerBuilder extends MovieClip {
		
		public var archerySymbol:TowerSymbol = new TowerSymbol();
		public var magicSymbol:TowerSymbol = new TowerSymbol();
		public var heavySymbol:TowerSymbol = new TowerSymbol();
		public var clicked:Boolean = false;
		
		public var allTowers:Array = new Array(new ArcheryTower(),new MagicTower(),new HeavyTower()); 
		public var towerNumber:Number;
		public var towerIsChosen:Boolean = false;

		
		public var cost:Number;
		
		public function TowerBuilder() {
			// constructor code
			this.width /= 2;
			this.height /= 2;
			archerySymbol.gotoAndStop(1);
			archerySymbol.Name.text = "ArcheryTower Cost: $35";
			archerySymbol.x = 0;
			archerySymbol.y = 50;
			magicSymbol.gotoAndStop(1);
			magicSymbol.Name.text = "MagicTower Cost: $55";
			magicSymbol.x = 200;
			magicSymbol.y = 50;
			heavySymbol.gotoAndStop(1);
			heavySymbol.Name.text = "HeavyTower Cost: $45";
			heavySymbol.x = 100;
			heavySymbol.y = -50;
			//this.addEventListener(MouseEvent.CLICK, ChoseTower);
			
			allTowers[1].gotoAndStop(1);
		}
		
		public function Update() {
			if (LevelUI.gold >= 35) {
				archerySymbol.gotoAndStop(2);
				archerySymbol.Name.text = "ArcheryTower Cost: $35";
			}
			else {
				archerySymbol.gotoAndStop(1);
				archerySymbol.Name.text = "ArcheryTower Cost: $35";
			}
			if (LevelUI.gold >= 45) {
				heavySymbol.gotoAndStop(2);
				heavySymbol.Name.text = "HeavyTower Cost: $45";
			}
			else {
				heavySymbol.gotoAndStop(1);
				heavySymbol.Name.text = "HeavyTower Cost: $45";
			}
				
			if (LevelUI.gold >= 55) {
				magicSymbol.gotoAndStop(2);
				magicSymbol.Name.text = "MagicTower Cost: $55";
			}
			else {
				magicSymbol.gotoAndStop(1);
				magicSymbol.Name.text = "MagicTower Cost: $55";
			}
		}
		
		public function ChoseTower() {
			if (towerIsChosen == false) {
				if (clicked == false) {
					clicked = true;
					addChild(archerySymbol);
					addChild(magicSymbol);
					addChild(heavySymbol);
					archerySymbol.addEventListener(MouseEvent.CLICK, ChoseArchery);
					magicSymbol.addEventListener(MouseEvent.CLICK, ChoseMagic);
					heavySymbol.addEventListener(MouseEvent.CLICK, ChoseHeavy);
					return;
				}
				if (clicked == true) {
					clicked = false;
					removeChild(archerySymbol);
					removeChild(magicSymbol);
					removeChild(heavySymbol);
					archerySymbol.removeEventListener(MouseEvent.CLICK, ChoseArchery);
					magicSymbol.removeEventListener(MouseEvent.CLICK, ChoseMagic);
					heavySymbol.removeEventListener(MouseEvent.CLICK, ChoseHeavy);
					return;
				}
			}
		}
		
		public function ChoseArchery(e:MouseEvent):void {
			towerNumber = 0;
			cost = 35;
			towerIsChosen = true;
		}
		
		public function ChoseMagic(e:MouseEvent):void {
			towerNumber = 1;
			cost = 55;
			towerIsChosen = true;
		}
		
		public function ChoseHeavy(e:MouseEvent):void {
			towerNumber = 2;
			cost = 45;
			towerIsChosen = true;
		}
	}
}
