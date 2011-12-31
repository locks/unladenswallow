package Entities.Enemies 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Zachary Tarvit
	 */
	public class baseEnemy extends FlxSprite 
	{
		public var blueEnemy:Boolean = true;
		public function baseEnemy(X:Number=0, Y:Number=0) 
		{
			super(X, Y);
		}
		public function takeDamage(damageAmount:int, isBlue:Boolean = true):void {
			health -= damageAmount;
			if (health <= 0)
				kill();
		}
		protected function fire():void {
			//Basic enemy class does not fire... yet.
		}
	}

}