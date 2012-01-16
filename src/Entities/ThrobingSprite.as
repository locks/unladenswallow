package Entities 
{
	import org.flixel.FlxSprite;
	
	public class ThrobingSprite extends FlxSprite 
	{
		[Embed(source = '../data/bkg.png')] private var _bkg:Class;
		
		private var fading:Boolean;
		
		public function ThrobingSprite(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			
			fading = true;
		}
		
		override public function update():void 
		{
			super.update();
			
			var value:Number = _alpha;
			
			if (fading)
			{
				(value > 0.2) ? alpha = value - 0.01 : fading = false;
			} else
			{
				(value < 1.0) ? alpha = value + 0.02 : fading = true;
			}
		}
		
	}

}