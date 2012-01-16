package  States
{
	import Entities.ThrobingSprite;
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	import States.PlayState;
	
	public class HighScoreState extends FlxState
	{
		[Embed(source = '../data/bkg.png')] private var _bkg:Class;
		
		private var _throbbing:ThrobingSprite = new Entities.ThrobingSprite(0, 0, _bkg);
		
		public function HighScoreState()
		{
			super();

			add(_throbbing);
			
			var backButton:FlxButton = new FlxButton(0, FlxG.height - 25, "BACK", onClickBack);
			backButton.x = FlxG.width/2 - backButton.width / 2;
			backButton.color = 0xff729954;
			backButton.label.color = 0xffd8eba2;
			this.add(backButton);
			
			var press:FlxText = new FlxText(0, 15, FlxG.width, "HIGHSCORES");
			press.alignment = "center";
			press.size = 30;
			add(press);
			
			var scores:FlxText = new FlxText(0, FlxG.height/3, FlxG.width, "");
			scores.alignment = "center";
			
			MenuState.highscores.bind("UnladenSwallow");
			var scrs:Array = MenuState.highscores.data.topFive.sort().slice(0, 5).reverse();
			for (var i:int = 0; i < 5; i++)
				scores.text += (i+1).toString() + ". " + scrs[i] + "\n\n";
			add(scores);
		}
		
		private function onClickBack():void 
		{
			FlxG.switchState(new MenuState());
		}
		
		override public function update():void 
		{
			super.update();
		}

	}
}