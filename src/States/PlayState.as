package  States
{
	import Entities.Enemies.baseEnemy;
	import Entities.Enemies.littleBastard;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	public class PlayState extends FlxState
	{
		[Embed(source = '../../assets/ost/work_song.mp3')] private var _titleMusic:Class;
		
		private var ship:Ship;
		
		private var bulletGroup:FlxGroup;
		private var enemiesGroup:FlxGroup;
		private var baddiesTimer:Number = 0;
		
		override public function update():void 
		{
			FlxG.overlap(bulletGroup, enemiesGroup, Collision);
			super.update();
				
			if (baddiesTimer > 0)
			{
				baddiesTimer -= FlxG.elapsed;
				baddiesTimer = Math.max(baddiesTimer, 0);				
			} else {
				
				if (enemiesGroup.members.length > 0)
 					var enemy:littleBastard = enemiesGroup.members[1];
					
					enemy.revive();
				
				baddiesTimer = 1.0;
			}

		}
		
		private function Collision(bullet:FlxObject, enemy:baseEnemy):void
		{
			enemy.takeDamage(1, true);
			bullet.kill();
		}
		
		override public function create():void 
		{
			FlxG.playMusic(_titleMusic);
			
			bulletGroup = new FlxGroup();
			ship = new Ship(bulletGroup, FlxG.width / 2 - 8, FlxG.height - 32);
			add(ship);
			add(bulletGroup);
			
			enemiesGroup = new FlxGroup();
			for (var i:int = 0; i < 3; ++i) 
			{
				for (var j:int = 0; j < 3; ++j) 
				{
					var enemy:littleBastard = new littleBastard(32 + 64 * i, 32 + 48 * j);
					enemiesGroup.add(enemy);
				}
			}
			add(enemiesGroup);
			
			baddiesTimer = 1.0;
			FlxG.paused = true;
		}
	}
}