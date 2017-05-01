package  {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	
	public class BossHealthBar extends MovieClip {
		
		public var healthBarBorder:BossHealthBarBorder = new BossHealthBarBorder();
		
		public var lostHealth:Sprite = new Sprite();
		public var lostHealthX:Number = 630;
		
		public function BossHealthBar() {
			// constructor code
			lostHealth.x = 5;
			lostHealth.y = 8;
			addChild(lostHealth);
			addChild(healthBarBorder);
		}
		
		public function getPercentageHealth(currentHealth:Number,oldHealth:Number,bossName:String) {
			healthBarBorder.NameBoss.text = bossName;
			var healthPercentage:Number = currentHealth/oldHealth*100;
			UpdateHealthBar(healthPercentage);
		}
		
		public function UpdateHealthBar(healthPercentage:Number) {
			var xx:Number = lostHealthX/100*healthPercentage;
			if (xx < 0)
				xx = 0;
			var wwidth:Number = lostHealthX - xx;
			if (wwidth > 630)
				wwidth = 630;
			lostHealth.graphics.clear();
			lostHealth.graphics.beginFill(0xff0000,1);
			lostHealth.graphics.drawRect(xx,0,wwidth,24);
			lostHealth.graphics.endFill();
		}
	}
}
