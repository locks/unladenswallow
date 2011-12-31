package 
{
	import org.flixel.FlxGame;
	import States.TitleState;
	
	[SWF(width="512", height="480", backgroundColor="#000000")]
	public class Ginkei extends FlxGame 
	{
		public function Ginkei()
		{
			super(256, 240, TitleState, 2);
		}
	}
}