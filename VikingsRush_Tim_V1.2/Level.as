package  {
	
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.MouseEvent;
	
	
	public class Level extends LevelUI {
		
		public var vikings:Array = new Array();
		public var spawnX:Number;
		public var spawnY:Number;
		public var currAmountVikings:Number = 0;
		public var uniqueNumber:Number = 0;
		public var addGold:Boolean = false;
		
		public var vikingPath:Array = new Array();
		public var point:Sprite;
		
		public var timerArray:Array = new Array();
		public var timerNum:Number = 0;
		public var timer:Timer = new Timer(1000,0);
		public var waveEnded:Boolean = true;
		
		public var nextWave:NextWave = new NextWave();
		public var someNmbr:Number = 0;
		
		public var buildLocation:Array = new Array();
		public var tower:Array = new Array();
		public var allowTowers:Array = new Array(true,true,true,true);
		
		public var arrows:Array = new Array();
		public var fireBalls:Array = new Array();
		public var iceBalls:Array = new Array();
		public var rocks:Array = new Array();
		public var smallRocks:Array = new Array();
		
		public var remainingParticles:Array = new Array();
		public var fixBullet:Number;
		
		public var boss:Boolean = false;
		public var bossHealth:BossHealthBar = new BossHealthBar();
		
		public var victory:Boolean = false;
		
		public function Level() {
			
			timer.addEventListener(TimerEvent.TIMER, SpawnViking);
			timer.stop();
			
			bossHealth.x = 320;
			
			nextWave.addEventListener(MouseEvent.CLICK, StartNextWave);
			nextWave.x = 1280 - nextWave.width;
			nextWave.y = 720 - nextWave.height;
			nextWave.gotoAndStop(1);
			addChild(nextWave);
		}
		
		public function UpdateLevel():void {
			UpdateUI();
			UpdateVikings();
			UpdateBuildLocation();
			UpdateTowers();
			UpdateBullets();
			UpdateProperties();
			RemainingParticles();
			towerProperties.Update();
			if (waveEnded == true && currAmountVikings == 0 && vikings.length != wave + 1)
				nextWave.gotoAndStop(2);
			else
				nextWave.gotoAndStop(1);
			if (vikings[wave].length == 0 && currAmountVikings == 0 && vikings.length == wave+1 && defeated == false && lives > 0) {
				victory = true;
				exited = true;
				(parent as MovieClip).removeChild(this);
				if (menuBool == true)
					OpenMenu(null);
			}
		}
		
		public function SpawnViking(e:TimerEvent):void {
			if (timerArray.length > timerNum && vikings[wave].length != currAmountVikings) {
				
			}
			else {
				timer.stop();
				waveEnded = true;
				return;
			}
			timerNum++;
			timer.delay = timerArray[timerNum];
			vikings[wave][currAmountVikings].activated = true;
			vikings[wave][currAmountVikings].position.x = spawnX;
			vikings[wave][currAmountVikings].position.y = spawnY;
			vikings[wave][currAmountVikings].uniqueNumber = uniqueNumber;
			vikings[wave][currAmountVikings].addEventListener(MouseEvent.CLICK, GetVikingProperties);
			addChild(vikings[wave][currAmountVikings]);
			this.setChildIndex(vikings[wave][currAmountVikings],1);
			currAmountVikings++;
			uniqueNumber++;
		}
		
		public function UpdateVikings():void {
			for (var i:Number=0;i<vikings[wave].length;i++) {
				if (vikings[wave][i].activated == true) {
					vikings[wave][i].Update();
					if (vikings[wave][i].hitTestObject(vikingPath[vikings[wave][i].checkNum]) && vikings[wave][i].hitPoint == false) {
						vikings[wave][i].hitPoint = true;
					}
					else {
						if (vikings[wave][i].hitPoint == true) {
							vikings[wave][i].checkNum++;
							vikings[wave][i].hitPoint = false;
							var tmpNum:Number = vikings[wave][i].checkNum + 1;
							if (tmpNum > vikingPath.length) {
								lives -= vikings[wave][i].damage;
								DestroyViking(i);
								return;
							}
						}
						var dir:Vector2 = new Vector2(vikingPath[vikings[wave][i].checkNum].x - vikings[wave][i].position.x, vikingPath[vikings[wave][i].checkNum].y - vikings[wave][i].position.y);
						dir.normalize();
						dir.multS(0.5);
						vikings[wave][i].acceleration = dir.copy();
					}
					if (vikings[wave][i].boss == true) {
						boss = true;
						bossHealth.getPercentageHealth(vikings[wave][i].lives,vikings[wave][i].oldLives,vikings[wave][i].bossName);
						addChild(bossHealth);
					}
				}
				
				
				
				
				//clear bullets that target the viking with 0 lives
				
				if (vikings[wave][i].lives <= 0) {
					for (var k:Number=0;k<arrows.length;k++) {
						if (arrows[k].target == vikings[wave][i].uniqueNumber) {
							DestroyBullet(arrows,k);
							k--;
						}
					}
					for (var j:Number=0;j<fireBalls.length;j++) {
						if (fireBalls[j].target == vikings[wave][i].uniqueNumber) {
							DestroyBullet(fireBalls,j);
							j--;
						}
					}
					for (var l:Number=0;l<iceBalls.length;l++) {
						if (iceBalls[l].target == vikings[wave][i].uniqueNumber) {
							DestroyBullet(iceBalls,l);
							l--;
						}
					}
					for (var m:Number=0;m<rocks.length;m++) {
						if (rocks[m].target == vikings[wave][i].uniqueNumber) {
							DestroyBullet(rocks,m);
							l--;
						}
					}
					if (vikings[wave][i].boss == true) {
						boss = false;
						removeChild(bossHealth);
					}
					addGold = true;
					DestroyViking(i);
					i--;
				}
			}
		}
		
		public function CreateViking(viking:Viking,waveNum:Number,spawnTime:Number) {
			vikings[waveNum].push(viking);
			timerArray.push(spawnTime);
		}
		
		public function DestroyViking(i:Number) {
			if (vikings[wave].length > 0 && i >= 0) {
				if (addGold == true) {
					LevelUI.gold += vikings[wave][i].gold;
				}
				addGold = false;
				vikings[wave][i].activated = false;
				removeChild(vikings[wave][i]);
				vikings[wave][i] = null;
				vikings[wave].splice(i,1);
				currAmountVikings--;
			}
		}
		
		
		
		
		public function UpdateTowers():void {
			for (var i:Number=0;i<tower.length;i++) {
				var vik:Number = 0;
				var shoot:Boolean = false;
				for (var j:Number=0;j<vikings[wave].length;j++) {
					
					// ALLOW THE TARGETS FOR THE TOWERS
					if (vikings[wave][j] is Thief)
						allowTowers = new Array(true,false,false,false);
					else 
						allowTowers = new Array(true,true,true,true);
					
					if (tower[i].shoot == true && vikings[wave][j].activated == true) {
						// ARCHERY TOWER
						if (tower[i] is ArcheryTower && allowTowers[0] == true) {
							var range:Vector2 = new Vector2(vikings[wave][j].position.x - tower[i].position.x - tower[i].wwidth/2,vikings[wave][j].position.y - tower[i].position.y - 40);
							vikings[wave][j].distance = range.mag();
							if (ArcheryTower.radius >= range.mag() && vikings[wave][j].distance <= vikings[wave][vik].distance) {
								
								tower[i].bowAngle = range.getAngle();
								var newBowPosition:Vector2 = new Vector2(1,0);
								newBowPosition.rotate(tower[i].bowAngle);
								newBowPosition.normalize();
								newBowPosition.multS(30);
								
								tower[i].bowAngle = Vector2.rad2deg(tower[i].bowAngle);
								tower[i].bow.rotation = tower[i].bowAngle;
								tower[i].bow.x = tower[i].bowPosition.x + newBowPosition.x;
								tower[i].bow.y = tower[i].bowPosition.y + newBowPosition.y;
								tower[i].Draw();
								
								vik = j;
								shoot = true;
							}
						}
						// FIRE TOWER
						if (tower[i] is MagicTower && allowTowers[1] == true && tower[i].currentFrame == 3) {
							
							range = new Vector2(vikings[wave][j].position.x - tower[i].position.x - tower[i].wwidth/2, vikings[wave][j].position.y - tower[i].position.y - tower[i].hheight/2);
							vikings[wave][j].distance = range.mag();
							if (MagicTower.radius >= range.mag() && vikings[wave][j].distance <= vikings[wave][vik].distance) {
								vik = j;
								shoot = true;
							}
						}
						// ICE TOWER
						else if (tower[i] is MagicTower && allowTowers[2] == true && tower[i].currentFrame == 2) {
							range = new Vector2(vikings[wave][j].position.x - tower[i].position.x - tower[i].wwidth/2, vikings[wave][j].position.y - tower[i].position.y - tower[i].hheight/2);
							vikings[wave][j].distance = range.mag();
							if (MagicTower.radius >= range.mag() && vikings[wave][j].distance <= vikings[wave][vik].distance) {
								vik = j;
								shoot = true;
							}
						}
						// HEAVY TOWER
						else if (tower[i] is HeavyTower && allowTowers[3] == true) {
							range = new Vector2(vikings[wave][j].position.x - tower[i].position.x - tower[i].wwidth/2, vikings[wave][j].position.y - tower[i].position.y - tower[i].hheight/2 + 25);
							vikings[wave][j].distance = range.mag();
							if (HeavyTower.radius >= range.mag() && vikings[wave][j].distance <= vikings[wave][vik].distance) {
								vik = j;
								shoot = true;
							}
						}
					}
				}
				if (shoot == true) {
					tower[i].shoot = false;
					tower[i].timer.start();
					if (tower[i] is ArcheryTower) {
						arrows.push(new Arrow);
						CreateBullet(arrows,tower[i].x + tower[i].wwidth/2,tower[i].y+40,tower[i].damage,tower[i].speed,vikings[wave][vik].uniqueNumber);
					}
					else if (tower[i] is MagicTower && tower[i].currentFrame == 3) {
						fireBalls.push(new FireBall);
						var fNum:Number = fireBalls.length - 1;
						fireBalls[fNum].fireChange = tower[i].fireChange;
						CreateBullet(fireBalls,tower[i].x + tower[i].wwidth/2,tower[i].y + tower[i].hheight/2,tower[i].damage,tower[i].speed,vikings[wave][vik].uniqueNumber);
					}
					else if (tower[i] is MagicTower && tower[i].currentFrame == 2) {
						iceBalls.push(new IceBall);
						var iNum = iceBalls.length - 1;
						iceBalls[iNum].slowChange = tower[i].slowChange;
						CreateBullet(iceBalls,tower[i].x + tower[i].wwidth/2,tower[i].y + tower[i].hheight/2,tower[i].damage,tower[i].speed,vikings[wave][vik].uniqueNumber);
					}
					else if (tower[i] is HeavyTower) {
						rocks.push(new Rock);
						CreateBullet(rocks,tower[i].x + tower[i].wwidth/2,tower[i].y + tower[i].hheight/2 - 25,tower[i].damage,tower[i].speed,vikings[wave][vik].uniqueNumber);
					}
				}
			}
		}
		
		
		
		public function CreateBullet(bullet:Array,xSpawn:Number,ySpawn:Number,damage:Number,speed:Number,target:Number) {
			var i:Number = bullet.length - 1;
			bullet[i].originialPosition = new Vector2(xSpawn,ySpawn);
			bullet[i].position.x = xSpawn;
			bullet[i].position.y = ySpawn;
			bullet[i].damage = damage;
			bullet[i].speed = speed;
			bullet[i].target = target;
			addChild(bullet[i]);
		}
		
		public function RemoveAllBullets(bullet:Array) {
			for (var i:Number=0;i<bullet.length;i++) {
				DestroyBullet(bullet,i);
				i--;
			}
		}
		
		public function UpdateBullets():void {
			if (vikings[wave].length <= 0) {
				RemoveAllBullets(arrows);
				RemoveAllBullets(fireBalls);
				RemoveAllBullets(iceBalls);
				RemoveAllBullets(rocks);
				return;
			}
			for (var m:Number=0;m<vikings[wave].length;m++) {
				//ARROWS
				for (var i:Number=0;i<arrows.length;i++) {
					fixBullet = i;
					BulletControl(arrows,i,m,ArcheryTower.radius);
					if (arrows.length > 0 && vikings[wave].length > 0 && fixBullet >= 0) {
						i = fixBullet;
						if (arrows[i].hitTestObject(vikings[wave][m]) && vikings[wave][m] is Shield && arrows[i].target == vikings[wave][m].uniqueNumber) {
							vikings[wave][m].Arrow(arrows[i].damage);
							DestroyBullet(arrows,i);
							i--;
						}
						else if (arrows[i].hitTestObject(vikings[wave][m]) && arrows[i].target == vikings[wave][m].uniqueNumber) {
							vikings[wave][m].lives -= arrows[i].damage;
							DestroyBullet(arrows,i);
							i--;
						}
					}
				}
				//FIREBALLS
				for (var p:Number=0;p<fireBalls.length;p++) {
					fixBullet = p;
					BulletControl(fireBalls,p,m,MagicTower.radius);
					if (fireBalls.length > 0 && vikings[wave].length > 0 && fixBullet >= 0) {
						p = fixBullet;
						if (fireBalls[p].particles.length < 10) {
							var particle = new FireParticles(fireBalls[p].position,fireBalls[p].velocity);
							CreateParticles(particle,fireBalls[p].particles);
						}
						if (fireBalls[p].hitTestObject(vikings[wave][m]) && fireBalls[p].target == vikings[wave][m].uniqueNumber) {
							fireBalls[p].BonusDamage();
							vikings[wave][m].lives -= fireBalls[p].damage;
							DestroyBullet(fireBalls,p);
							p--;
						}
					}
				}
				//ICEBALLS
				for (var j:Number=0;j<iceBalls.length;j++) {
					fixBullet = j;
					BulletControl(iceBalls,j,m,MagicTower.radius);
					if (iceBalls.length > 0 && vikings[wave].length > 0 && fixBullet >= 0) {
						j = fixBullet;
						if (iceBalls[j].particles.length < 10) {
							particle = new IceParticles(iceBalls[j].position,iceBalls[j].velocity);
							CreateParticles(particle,iceBalls[j].particles);
						}
						if (iceBalls[j].hitTestObject(vikings[wave][m]) && iceBalls[j].target == vikings[wave][m].uniqueNumber) {
							iceBalls[j].ApplySlow();
							if (iceBalls[j].slow == true) {
								vikings[wave][m].ApplySlow(iceBalls[j].slowDuration,iceBalls[j].slowPercentage);
							}
							vikings[wave][m].lives -= iceBalls[j].damage;
							DestroyBullet(iceBalls,j);
							j--;
						}
					}
				}
				//ROCKS
				for (var k:Number=0;k<rocks.length;k++) {
					fixBullet = k;
					BulletControl(rocks,k,m,HeavyTower.radius);
					if (rocks.length > 0 && vikings[wave].length > 0 && fixBullet >= 0) {
						k = fixBullet;
						if (rocks[k].hitTestObject(vikings[wave][m]) && rocks[k].target == vikings[wave][m].uniqueNumber) {
							vikings[wave][m].lives -= rocks[k].damage;
							var num:int = 0;
							for (var l:Number=0;l<6;l++) {
								particle = new RockParticles(rocks[k].position,rocks[k].velocity,num);
								particle.nonTarget = vikings[wave][m].uniqueNumber;
								num += 60;
								remainingParticles.push(particle);
								addChild(particle);
							}
							DestroyBullet(rocks,k);
							k--;
						}
					}
				}
			}
		}
		
		
		
		public function BulletControl(bullet:Array, i:Number, iViking:Number,radius:Number) {
			bullet[i].Update();
			if (vikings[wave].length <= 0)
				return;
			if (bullet.length <= 0) 
				return;
			if (bullet[i].includesParticles == true) {
				for (var j:Number=0;j<bullet[i].particles.length;j++) {
					bullet[i].particles[j].NewUpdate();
					if (bullet[i].particles[j].isDead() == true) {
						removeChild(bullet[i].particles[j]);
						bullet[i].particles.splice(j,1);
						j--;
					}
				}
			}
			if (bullet[i].target == vikings[wave][iViking].uniqueNumber) {
				var travelled:Vector2 = new Vector2(bullet[i].position.x - bullet[i].originialPosition.x, bullet[i].position.y - bullet[i].originialPosition.y);
				var dir:Vector2 = new Vector2(vikings[wave][iViking].position.x - bullet[i].x,vikings[wave][iViking].position.y - bullet[i].y);
				if (travelled.mag() > radius) {
					DestroyBullet(bullet,i);
					i--;
					fixBullet = i;
					return;
				}
				else {
					bullet[i].velocity.setTo(dir.x,dir.y);
					bullet[i].velocity.normalize();
					bullet[i].velocity.multS(bullet[i].speed/vikings[wave].length);
				}
			}
		}
		
		
		
		public function DestroyBullet(bullet:Array,i:Number) {
			if (bullet[i].includesParticles == true) {
				for (var j:Number=0;j<bullet[i].particles.length;j++) {
					if (bullet[i].particles.length > 0) {
						remainingParticles.push(bullet[i].particles[j]);
						bullet[i].particles.splice(j,1);
						j--;
					}
				}
			}
			removeChild(bullet[i]);
			bullet[i] = null;
			bullet.splice(i,1);
		}
		
		public function RemainingParticles() {
			for (var i:Number=0;i<remainingParticles.length;i++) {
				remainingParticles[i].NewUpdate();
				if (remainingParticles[i].isDead == true) {
					removeChild(remainingParticles[i]);
					remainingParticles.splice(i,1);
				}
				else if (remainingParticles[i] is RockParticles) {
					for (var j:Number=0;j<vikings[wave].length;j++) {
						if (i >= 0 && remainingParticles[i].hitTestObject(vikings[wave][j]) && vikings[wave].length > 0 && remainingParticles.length > 0 && remainingParticles[i].nonTarget != vikings[wave][j].uniqueNumber && remainingParticles[i] is RockParticles) {
							vikings[wave][j].lives -= remainingParticles[i].damage;
							DestroyBullet(remainingParticles,i);
							i--;
						}
					}
				}
			}
		}
		
		public function CreateParticles(particle:Particle,array:Array) {
			array.push(particle);
			addChild(particle);
		}
		
		
		
		public function UpdateBuildLocation():void {
			for (var i:Number=0;i<buildLocation.length;i++) {
				buildLocation[i].Update();
				if (buildLocation[i].towerNumber >= 0) {
					if (buildLocation[i].cost <= gold) {
						gold -= buildLocation[i].cost;
					}
					else {
						buildLocation[i].towerIsChosen = false;
						buildLocation[i].towerNumber = -1;
						return;
					}
					tower.push(buildLocation[i].allTowers[buildLocation[i].towerNumber]);
					var j:Number = tower.length - 1;
					tower[j].position.setTo(buildLocation[i].x,buildLocation[i].y);
					tower[j].addEventListener(MouseEvent.CLICK, GetTowerProperties);
					tower[j].Update();
					addChild(tower[j]);
					removeChild(buildLocation[i]);
					buildLocation[i] = null;
					buildLocation.splice(i,1);
				}
			}
		}
		
		
		
		public function BuildLocation(xPos:Number,yPos:Number) {
			buildLocation.push(new TowerBuilder());
			var i:Number = buildLocation.length - 1;
			buildLocation[i].x = xPos;
			buildLocation[i].y = yPos;
			addChild(buildLocation[i]);
			buildLocation[i].addEventListener(MouseEvent.CLICK, openBuildLocation);
			this.setChildIndex(buildLocation[i],1);
		}
		
		public function openBuildLocation(e:MouseEvent) {
			for (var i:Number=0;i<buildLocation.length;i++) {
				if (buildLocation[i] != e.currentTarget && buildLocation[i].clicked == true) {
					buildLocation[i].ChoseTower();
				}
			}
			e.currentTarget.ChoseTower();
		}
		
		
		
		public function StartNextWave(e:MouseEvent):void {
			//IMPORTANT! you will always need atleast 2 waves
			if (waveEnded == true && currAmountVikings == 0 && vikings.length != wave + 1) {
				wave++;
				timer.start();
				waveEnded = false;
				if (someNmbr == 0) {
					wave--;
					someNmbr++;
				}
			}
		}
		
		public function UpdateProperties() {
			if (showTower != null && showTower is Tower && boolShowTower == true) {
				ShowTowerProperties(showTower);
				boolShowViking = false;
				propertiesSwitchTower = true;
				addChild(towerProperties);
			}
			else if (boolShowTower == false && propertiesSwitchTower == true) {
				removeChild(towerProperties);
				propertiesSwitchTower = false;
			}
			if (showViking != null && showViking is Viking && showViking.activated == true && boolShowViking == true) {
				ShowVikingProperties(showViking);
				boolShowTower = false;
				propertiesSwitchViking = true;
				addChild(vikingProperties);
			}
			else if (boolShowViking == false && propertiesSwitchViking == true) {
				removeChild(vikingProperties);
				propertiesSwitchViking = false;
			}
			else {
				boolShowViking = false;
			}
		}
		
		public function GetVikingProperties(e:MouseEvent) {
			for (var i:Number=0;i<vikings[wave].length;i++) {
				if (vikings[wave][i] == e.currentTarget) {
					showViking = vikings[wave][i];
					boolShowViking = true;
					boolShowTower = false;
				}
			}
		}
		
		public function ShowVikingProperties(viking:Viking) {
			vikingProperties.speed.text = "Speed: " + viking.speedLimit.toString();
			vikingProperties.lives.text = "Lives: " + viking.lives.toString();
			vikingProperties.damage.text = "Damage: " + viking.damage.toString();
			vikingProperties.gold.text = "$$$: " + viking.gold.toString();
			vikingProperties.description.text = viking.description;
		}
		
		public function GetTowerProperties(e:MouseEvent) {
			for (var i:Number=0;i<tower.length;i++) {
				if (tower[i] == e.currentTarget) {
					showTower = tower[i];
					towerProperties.tower = tower[i];
					boolShowTower = true;
					boolShowViking = false;
				}
			}
		}
		
		public function ShowTowerProperties(tower:Tower) {
			towerProperties.speed.text = "Speed: " + tower.speed.toString();
			towerProperties.reloadSpeed.text = "ReloadSpeed: " + tower.reloadSpeedSec.toString();
			towerProperties.damage.text = "Damage: " + tower.damage.toString();
			towerProperties.radius.text = "Radius: " + tower.radius.toString();
			towerProperties.special.text = tower.special;
		}
 		
		
		
		public function CreatePoint(pointX:Number,pointY:Number):void {
			point = new Sprite();
			point.graphics.beginFill(0xfff,1);
			point.graphics.drawCircle(0,0,15);
			point.graphics.endFill();
			point.x = pointX;
			point.y = pointY;
			vikingPath.push(point);
			//addChild(point);
		}
		
		
		
		public function ClearLevel():void {
			//Set variables back to original state
			LevelUI.gold = 0;
			wave = 0;
			lives = 20;
			timer.stop();
			timer.delay = 1000;
			currAmountVikings = 0;
			timerNum = 0;
			someNmbr = 0;
			waveEnded = true;
			uniqueNumber = 0;
			boolShowViking = false;
			boolShowTower = false;
			//clear vikings array
			for (var i:Number=0;i<vikings.length;i++) {
				for (var j:Number=0;j<vikings[i].length;j++) {
					if (j >= 0 && vikings[i][j] is Viking) {
						if (vikings[i][j].activated == true) {
							vikings[i][j].activated = false;
							removeChild(vikings[i][j]);
						}
						vikings[i][j] = null;
						vikings[i].splice(j,1);
						j--;
					}
				}
			}
			//clear buidlocation array
			for (var k:Number=0;k<buildLocation.length;k++) {
				removeChild(buildLocation[k]);
				buildLocation[k] = null;
				buildLocation.splice(k,1);
				k--;
			}
			//clear tower array
			for (var l:Number=0;l<tower.length;l++) {
				removeChild(tower[l]);
				tower[l] = null;
				tower.splice(l,1);
				l--;
			}
			if (boss == true) {
				boss = false;
				removeChild(bossHealth);
			}
		}
	}	
}
