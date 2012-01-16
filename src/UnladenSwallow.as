package 
{
	import org.flixel.*;
	import States.MenuState;
	
	[SWF(width = "512", height = "480", backgroundColor = "#000000")]
	[Frame(factoryClass = "Preloader")]
	
	public class UnladenSwallow extends FlxGame 
	{		
		public function UnladenSwallow()
		{
			super(256, 240, MenuState, 2);
			
			FlxG.debug = true;
		}
	}
}