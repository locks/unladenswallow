package  States
{
	import Entities.*;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = '../data/adventure.mp3')] private var _titleMusic:Class;
		[Embed(source = '../data/bkg.png')] private var ImgBackground:Class;	
		[Embed(source="../data/enemies/neutral/gibs.png")] private var ImgGibs:Class;
		
		private var _bkgA:FlxSprite;
		private var _bkgB:FlxSprite;
		
		private var background:FlxGroup;
		
		private var _explosionShards:FlxEmitter;

				
		public static var player:Ship;
		protected var bulletGroup:FlxGroup;
		
		protected var enemiesGroup:FlxGroup;
		protected var enemiesBullets:FlxGroup;
		
		protected var _hud:FlxGroup;
		
		protected var _score:FlxText;
		protected var _timer:FlxText;
		
		public var baddiesTimer:Number;
		public var _countdown:Number;
		
		override public function update():void 
		{
			FlxG.overlap(bulletGroup, enemiesGroup, BulletToEnemies);
			FlxG.overlap(enemiesBullets, player, BulletToPlayer);
			FlxG.overlap(player, enemiesGroup, PlayerWithEnemy);
			
			super.update();
			
			_countdown -= FlxG.elapsed;
			if (_countdown < 0) {
				FlxG.music.stop();
				
				MenuState.highscores.bind("UnladenSwallow");
				MenuState.highscores.data.topFive.push(FlxG.score);
				MenuState.highscores.close();
				
				FlxG.switchState(new GameEnd());
			}
			
			_bkgA.y++;
			_bkgB.y++;
			if (_bkgB.y == FlxG.height)
			{
				_bkgA.y = 0 - _bkgA.height;
				_bkgB.y = 0;
			}
				
			if (baddiesTimer > 0)
			{
				baddiesTimer -= FlxG.elapsed;
				baddiesTimer = Math.max(baddiesTimer, 0);				
			} else {
				Spawn();
				FlxG.log("spawned");
	
				baddiesTimer = 3;
			}
			
			_score.text = "Score: " + FlxG.score.toString();
			_timer.text = "Timer: " + int(_countdown).toString();
		}
		
		private function PlayerWithEnemy(playerShip:Ship, enemy:Enemy):void 
		{
			enemy.kill();
			player.freeze(1);
			
			FlxG.score -= 50;
		}
		
		private function BulletToPlayer(bullet:EnemyBullet, player:Ship):void 
		{
			
			if (bullet.isGreen() == player.isGreen)
			{
				FlxG.score += 10;
			} else {
				player.freeze(1);
			}
			
			bullet.kill();
		}

		private function BulletToEnemies(bullet:Bullet, enemy:Enemy):void
		{
			var damage:int = 1;
			
			if (bullet._isGreen == enemy.isGreen)
				enemy.hurt(1);
			else
				enemy.hurt(3);
			
			if (!enemy.alive)
			{
				FlxG.score += enemy.score;
			}
			
			bullet.kill();
		}
		
		override public function create():void 
		{
			FlxG.music.play();
			FlxG.playMusic(_titleMusic);
			
			FlxG.score = 0;
			
			_countdown = 10;
			baddiesTimer = 3;
			FlxG.watch(this, "baddiesTimer", "timer");
			
			SetUpBackground();
			
			bulletGroup = new FlxGroup();
			enemiesGroup = new FlxGroup();
			enemiesBullets = new FlxGroup();
			_hud = new FlxGroup();
			
			_explosionShards = new FlxEmitter();
			_explosionShards.setXSpeed(-150,150);
			_explosionShards.setYSpeed(-200,0);
			_explosionShards.setRotation(-720,-720);
			_explosionShards.gravity = 350;
			_explosionShards.bounce = 0.5;
			_explosionShards.makeParticles(ImgGibs, 100, 10, true, 0.5);
			add(_explosionShards);
		
			player = new Ship(bulletGroup, FlxG.width / 2 - 8, FlxG.height - 32);
			
			_timer = new FlxText(0, 0, FlxG.width);
			_timer.alignment = "center";
			_timer.text = "Time Left: ";
			_hud.add(_timer);
			
			_score = new FlxText(FlxG.width / 4, 0, FlxG.width);
			_score.alignment = "center";
			_score.text = "Score: ";
			_hud.add(_score);
			
			add(bulletGroup);
			add(enemiesBullets);
			add(enemiesGroup);
			add(player);
			add(_hud);
			
			baddiesTimer = 1.0;
		}
		
		private function SetUpBackground():void 
		{
			background = new FlxGroup();
			
			_bkgA = new FlxSprite(0, 0, ImgBackground);
			_bkgB = new FlxSprite(0, 0, ImgBackground);
			
			_bkgA.y -= _bkgA.height;
			
			background.add(_bkgA);
			background.add(_bkgB);
			
			add(background);
		}
		
		private function Spawn():void
		{
			for (var i:int = 0; i < 4; i++) 
			{
					var enemy:Enemy = (enemiesGroup.recycle(Enemy) as Enemy);
					enemy.randomize();
					enemy.bullets = enemiesBullets;
					enemy.shards = _explosionShards;
					
					var xs:Number = 32 + (256-32-32) * Math.random();
					enemy.reset(xs, -32);
			}
		}
	}
}