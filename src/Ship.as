package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxGroup;

	public class Ship extends FlxSprite
	{
		[Embed(source = '../assets/ginkei.PNG')] private var shipImg:Class;
		[Embed(source = '../assets/test_bullet.PNG')] private var bulletImg:Class;
		[Embed(source = '../assets/bullet_muzzle.PNG')] private var muzzleImg:Class;
		[Embed(source = '../assets/shoot.mp3')] private var shootSnd:Class;
		
		
		private static const SPEED:int = 2;
		private var bulletGroup:FlxGroup;
		private var bulletTimer:Number = 0;		
		
		private var flashbang:FlxEmitter = new FlxEmitter(x, y - 4);
		
		public function Ship(bulletGroup:FlxGroup, X:Number = 0, Y:Number = 0) 
		{
			this.bulletGroup = bulletGroup;
			super(X, Y, shipImg);
			
			flashbang = new FlxEmitter();
			flashbang.setXSpeed(-150,150);
			flashbang.setYSpeed(-200,0);
			flashbang.setRotation(-720,-720);
			flashbang.gravity = 350;
			flashbang.bounce = 0.5;
			flashbang.makeParticles(muzzleImg,100,10,true,0.5);
		}
		
		override public function update():void 
		{
			if (FlxG.keys.pressed("LEFT"))
				this.x -= SPEED;
			
			if (FlxG.keys.pressed("RIGHT"))
				this.x += SPEED;
				
			if (FlxG.keys.pressed("UP"))
				this.y -= SPEED;
			
			if (FlxG.keys.pressed("DOWN"))
				this.y += SPEED;
				
			if (FlxG.keys.pressed("X"))
			{
				shoot();
			}	
			super.update();
			
			if (bulletTimer > 0)
			{
				bulletTimer -= FlxG.elapsed;
				bulletTimer = Math.max(bulletTimer, 0);
			}
		}
		
		private function shoot():void
		{
			if (bulletTimer == 0)
			{				
				FlxG.play(shootSnd);

				flashbang.at(this);
				flashbang.start(true, 5, 0, 50);
				
				var bullet:FlxSprite = new FlxSprite(x, y - 5, bulletImg);

				bullet.velocity.y = -250;
				bulletGroup.add(bullet);
				bulletTimer = 1.0 / 10.0;
			}
		}
	}
}