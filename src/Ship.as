package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxGroup;
	import States.GameEnd;
	
	import Entities.Bullet;

	public class Ship extends FlxSprite
	{
		[Embed(source = 'data/enemies/green/player.png')] private var ImgPlayerGreen:Class;
		[Embed(source = 'data/enemies/red/player.png')] private var ImgPlayerRed:Class;
		
		[Embed(source = 'data/shoot.mp3')] private var shootSnd:Class;
		
		private static const SPEED:int = 2;
		private var _bullets:FlxGroup;
		private var _bulletTimer:Number = 0.0;
		private var _freeze:Number = 0.0;
		
		public var isGreen:Boolean = true;
		
		public function Ship(bulletGroup:FlxGroup, X:Number = 0, Y:Number = 0) 
		{
			_bullets = bulletGroup;
			_bulletTimer = 0.0;
			_freeze = 0.0;
			
			isGreen = true;
			
			super(X, Y, ImgPlayerGreen);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (_freeze > 0)
			{
				_freeze -= FlxG.elapsed;
				_freeze = Math.max(_freeze, 0);

				return;
			}
			
			// movement
			if (FlxG.keys.LEFT && this.x > 0)
				this.x -= SPEED;
			
			if (FlxG.keys.RIGHT && (this.x + this.width) < (FlxG.camera.x + FlxG.width))
				this.x += SPEED;
				
			if (FlxG.keys.pressed("UP") && this.y > 0)
				this.y -= SPEED;
			
			if (FlxG.keys.pressed("DOWN") && (this.y+this.height) < (FlxG.camera.x + FlxG.height))
				this.y += SPEED;	
				
			// actions
			if (FlxG.keys.justPressed("C"))
				flipPolarity();
			
			if (FlxG.keys.justPressed("X"))
				manualFire();
			
			if (FlxG.keys.pressed("X"))
				automaticFire();
			
			if (_bulletTimer > 0)
			{
				_bulletTimer -= FlxG.elapsed;
				_bulletTimer = Math.max(_bulletTimer, 0);
			}
		}
		
		private function automaticFire():void
		{
			if (_bulletTimer < 0)
			{	
				getMidpoint(_point);
				(_bullets.recycle(Bullet) as Bullet).shoot(_point.x - 4 - 4, y, isGreen);		// left   bullet
				(_bullets.recycle(Bullet) as Bullet).shoot(_point.x      + 4, y, isGreen);			// right bullet
				
				_bulletTimer = 0.1;
			}
		}
		
		private function manualFire():void
		{
			getMidpoint(_point);
			(_bullets.recycle(Bullet) as Bullet).shoot(_point.x - 4 / 2, _point.y - 2, isGreen);
			
			_bulletTimer = 0.2; // this is the pause between the manualFire and the automaticFire, if the player continues pressing the key
		}
		
		private function flipPolarity():void
		{
			flicker(0.3);
			_bulletTimer = 0.3;
			
			isGreen = !isGreen;			
			(isGreen) ? loadGraphic(ImgPlayerGreen) : loadGraphic(ImgPlayerRed);
		}
		
		public function freeze(time:Number):void
		{
			if (_freeze > 0) return;
			
			FlxG.shake(0.01);
			flicker(time);
			_freeze = time / 10.0;
		}
	}
}