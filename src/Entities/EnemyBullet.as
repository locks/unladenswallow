package Entities 
{
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	import States.PlayState;
	
	public class EnemyBullet extends FlxSprite 
	{
		[Embed(source = '../data/bullets/enemy_green.png')] private var ImgGreenBullet:Class;
		[Embed(source = '../data/bullets/enemy_red.PNG')] private var ImgRedBullet:Class;
		
		[Embed(source = '../data/shoot.mp3')] private var SndShoot:Class;

		private var _speed:Number;
		public var _isGreen:Boolean;
		
		public function EnemyBullet() 
		{
			super();
			
			width = 5;
			height = 6;
			
			_speed = 100;
		}
		
		override public function update():void
		{
			super.update();
			
			if (!onScreen()) kill();
		}
		
		public function isGreen():Boolean
		{
			return _isGreen;
		}
		
		public function shoot(x:Number, y:Number, IsGreen:Boolean, random:Boolean = false):void
		{
			FlxG.play(SndShoot,0.5);
			
			super.reset(x, y);
			
			(random) ? randomPath() : playerPath();
			
			_isGreen = IsGreen;
			(_isGreen) ? loadGraphic(ImgGreenBullet) : loadGraphic(ImgRedBullet);
			
		}
		
		private function randomPath():void 
		{
			var min:Number = -10;
			var max:Number = 10;
			
			velocity.y = _speed;
			velocity.x = min + Math.random() * (max - min);
		}
		
		private function playerPath():void 
		{		
			var velX:Number = PlayState.player.x - x;
			var velY:Number = PlayState.player.y - y;

			var len:Number = Math.sqrt(velX*velX + velY*velY)

			velX /= len;
			velY /= len;

			velocity.x = velX * _speed;
			velocity.y = velY * _speed;
		}
		
	}

}