package Entities.Enemies 
{
	/**
	 * ...
	 * @author Zachary Tarvit
	 */
	public class littleBastard extends baseEnemy 
	{
		[Embed(source = '../../../assets/enemy.PNG')] private var enemyImg:Class;
		public function littleBastard(X:Number=0, Y:Number=0) 
		{
			super(X, Y);
			health = 1;
			loadGraphic(enemyImg);
			blueEnemy = true;
		}
		override public function takeDamage(damageAmount:int, isBlue:Boolean = true):void 
		{
			if(isBlue){
				super.takeDamage(damageAmount, isBlue);
			}
		}
	}

}