package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class LevelSelector extends MovieClip {
		
		public var returnButton:ReturnButton = new ReturnButton();
		public var returned:Boolean = false;
		
		public var leftArrow:LeftArrow = new LeftArrow();
		public var rightArrow:RightArrow = new RightArrow();
		
		public var screenshot:LevelScreenShots = new LevelScreenShots();
		public var currentScreenshot:Number = 1;
		
		public var levelArray:Array = new Array();
		public var choseLevel:Boolean = false;
		
		public var victory:Victory = new Victory();
		public var defeated:Defeated = new Defeated();
		
		public function LevelSelector() {
			// constructor code
			levelArray.push(new Level1());
			levelArray.push(new Level2());
			levelArray.push(new Level3());
			
			returnButton.addEventListener(MouseEvent.CLICK, CloseToMenu);
			addChild(returnButton);
			
			leftArrow.addEventListener(MouseEvent.CLICK, Previous);
			leftArrow.y = 360 - (leftArrow.height/2);
			leftArrow.alpha = 0.75;
			addChild(leftArrow);
			
			rightArrow.addEventListener(MouseEvent.CLICK, Next);
			rightArrow.x = 1180;
			rightArrow.y = 360 - (rightArrow.height/2);
			rightArrow.alpha = 0.75;
			addChild(rightArrow);
			
			screenshot.addEventListener(MouseEvent.CLICK, ChosenLevel);
			screenshot.x = 200;
			screenshot.y = 112.5;
			screenshot.gotoAndStop(currentScreenshot);
			addChild(screenshot);
		}
		
		public function Update():void {
			var i:Number = currentScreenshot - 1;
			if (levelArray[i].exited == false) {
				levelArray[i].Update();
			}
			if (levelArray[i].defeated == true) {
				addChild(defeated);
				defeated.addEventListener(MouseEvent.CLICK, RemoveDefeated);
				levelArray[i].defeated = false;
			}
			if (levelArray[i].victory == true) {
				addChild(victory);
				victory.addEventListener(MouseEvent.CLICK, RemoveVictory);
				levelArray[i].victory = false;
			}
		}
		
		public function ChosenLevel(e:MouseEvent):void {
			var i:Number = currentScreenshot - 1;
			levelArray[i].start = true;
			levelArray[i].exited = false;
			addChild(levelArray[i]);
		}
		
		public function Next(e:MouseEvent):void {
			currentScreenshot++;
			if (currentScreenshot > screenshot.totalFrames) {
				currentScreenshot = screenshot.totalFrames;
			}
			screenshot.gotoAndStop(currentScreenshot);
		}
		
		public function Previous(e:MouseEvent):void {
			currentScreenshot--;
			if (currentScreenshot <= 0) {
				currentScreenshot = 1;
			}
			screenshot.gotoAndStop(currentScreenshot);
		}
		
		public function RemoveDefeated(e:MouseEvent):void {
			removeChild(defeated);
			defeated.removeEventListener(MouseEvent.CLICK, RemoveDefeated);
		}
		
		public function RemoveVictory(e:MouseEvent):void {
			removeChild(victory);
			victory.removeEventListener(MouseEvent.CLICK, RemoveVictory);
		}
		
		public function CloseToMenu(e:MouseEvent):void {
			returned = true;
		}
	}
}
