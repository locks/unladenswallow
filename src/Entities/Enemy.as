package  Entities
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxEmitter;
	
	import States.PlayState;

	public class Enemy extends FlxSprite
	{
		[Embed(source = '../data/enemies/red/small.png')] private var ImgSmallRed:Class;
		[Embed(source = '../data/enemies/green/small.png')] private var ImgSmallGreen:Class;

		[Embed(source = '../data/enemies/red/large_horizontal.png')] private var ImgHoverRed:Class;
		[Embed(source = '../data/enemies/green/large_horizontal.png')] private var ImgHoverGreen:Class;
	
		[Embed(source = '../data/enemies/red/large_vertical.png')] private var ImgFrigateRed:Class;
		[Embed(source = '../data/enemies/green/large_vertical.png')] private var ImgFrigateGreen:Class;

		[Embed(source = '../data/explosion.mp3')] private var SndExplosion:Class;
		[Embed(source = '../data/shoot.mp3')] private var SndShoot:Class;
		
		public var bullets:FlxGroup;
		
		public var shards:FlxEmitter;
		
		private var wob:int = 0;
		public var isGreen:Boolean;
		public var score:Number;
		
		private var speed:Number;
		private var amplitude:Number;
		private var initialX:Number;
		
		private var timer:Number;
		private var shootTimer:Number;
		
		public var type:Class;
		
		public function Enemy(X:Number = 0, Y:Number = 0, IsColorGreen:Boolean = true) 
		{
			isGreen = IsColorGreen;
			var image:Class = (isGreen) ? ImgHoverGreen : ImgHoverRed;
			
			setUp(X);

			super(X, Y, image);
		}
		
		override public function reset(X:Number, Y:Number):void
		{
			setUp(X);
			
			super.reset(X, Y);
		}
		
		private function setUp(X:Number):void
		{
			health = 5;
			score = 10;
			
			speed = 1;
			amplitude = 20;
			initialX = X;
			
			timer = 0;			
			shootTimer = 0;
		}
		
		override public function update():void 
		{
			super.update();
			
			timer++;
			shootTimer++;
			move();
			
			if (shootTimer > 0)
			{			
				shootTimer -= FlxG.elapsed;
				shootTimer = Math.max(shootTimer, 0);				
			}
			
			if (y > 240 + height) kill();
		}
		
		private function move():void 
		{
			getMidpoint(_point);
			
			if (type == ImgSmallRed || type == ImgSmallGreen)
			{
				health = 1;
				velocity.y = 40;
				velocity.x =  Math.sin(timer * 2 * Math.PI / 24) * amplitude * 10;
			}

			if (type == ImgHoverRed || type == ImgHoverGreen)
			{
				health = 10;
				velocity.y = 10;
				velocity.x =  Math.sin(timer * 2 * Math.PI / 24) * amplitude;

				if (Math.abs(PlayState.player.x - x) < 100 && timer > 3)
				{
					if (shootTimer > 80 && y-PlayState.player.y < 150)
					{
						getMidpoint(_point);
						(bullets.recycle(EnemyBullet) as EnemyBullet).shoot(_point.x - 10 - 4/2, y, isGreen);
						(bullets.recycle(EnemyBullet) as EnemyBullet).shoot(_point.x + 10 - 4/2, y, isGreen);
						
						shootTimer = 0;
					}
				}
			}
			
			if (type == ImgFrigateGreen || type == ImgFrigateRed)
			{
				velocity.y = 30;
				
				if (shootTimer > 60 && y-PlayState.player.y < 150)
				{
					getMidpoint(this._point);
					(bullets.recycle(EnemyBullet) as EnemyBullet).shoot(this._point.x - 2, this.y+this.height, this.isGreen, true);
					shootTimer = 0;
				}
			}
		}
		
		public function randomize():void
		{
			var red_types:Array = [ImgSmallRed, ImgHoverRed, ImgFrigateRed];
			var green_types:Array = [ImgSmallGreen, ImgHoverGreen, ImgFrigateGreen];
			
			var rand:Number = Math.random(); // 0 <> 1
			if (rand < 0.5)
			{
				isGreen = true;
				type = Class(FlxG.getRandom(green_types));
			} else {
				isGreen = false;
				type = Class(FlxG.getRandom(red_types));
			}
			
			loadGraphic(type);
		}
		
		private function randomRange(max:Number, min:Number = 0):Number
		{
			return Math.random() * (max - min) + min;
		}
		
		override public function kill():void
		{
			if (!alive) return;
			
			FlxG.play(SndExplosion);
			super.kill();
			
			shards.at(this);
			shards.start(true, 1, 0, 10);
		}

	}
}