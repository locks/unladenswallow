package Entities 
{
	import org.flixel.FlxG;
	
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Bullet extends FlxSprite 
	{
		[Embed(source = '../data/bullets/green.png')] private var ImgGreenBullet:Class;
		[Embed(source = '../data/bullets/red.PNG')] private var ImgRedBullet:Class;
		
		[Embed(source = '../data/shoot.mp3')] private var SndShoot:Class;

		private var _speed:Number;
		public var _isGreen:Boolean;
		
		public function Bullet() 
		{
			super();
			
			width = 5;
			height = 6;
			
			_speed = -250;
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
		
		public function shoot(x:Number, y:Number, IsGreen:Boolean):void
		{
			FlxG.play(SndShoot,0.5);
			
			super.reset(x, y);
			
			_isGreen = IsGreen;
			(_isGreen) ? loadGraphic(ImgGreenBullet) : loadGraphic(ImgRedBullet);
			
			velocity.y = _speed;
		}
		
	}

}