package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;

	public class Enemy extends FlxSprite
	{
		[Embed(source = '../assets/enemy.PNG')] private var enemyImg:Class;
		
		public var hp:int = 1;
		
		public function Enemy(X:Number = 0, Y:Number = 0) 
		{
			super(X, Y, enemyImg);
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		public function dead():Boolean
		{
			return hp < 1;
		}
		
		public function shoot():int
		{
			return (--hp);
		}
	}
}