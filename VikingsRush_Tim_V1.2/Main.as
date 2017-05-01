package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Main extends MovieClip {
		
		public var menu:Menu = new Menu();
		public var levelSelector:LevelSelector = new LevelSelector();
		public static var muted:Boolean = true;
		
		public function Main() {
			// constructor code
			addChild(menu);
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		public function Update(e:Event):void {
			if (menu.started == true) {
				menu.started = false;
				addChild(levelSelector);
				menu.active = false;
				for (var i:Number=0;i<menu.arrows.length;i++) {
					menu.DestroyArrow(i);
					i--;
				}
				removeChild(menu);
			}
			else if (levelSelector.returned == true) {
				levelSelector.returned = false;
				addChild(menu);
				menu.active = true;
				removeChild(levelSelector);
			}
			if (menu.active == true)
				menu.Update();
			levelSelector.Update();
		}
	}
}
