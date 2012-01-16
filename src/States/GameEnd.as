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
	
	public class GameEnd extends FlxState
	{
		[Embed(source = '../data/bkg.png')] private var _bkg:Class;
		[Embed(source = '../data/title.mp3')] private var _titleMusic:Class;

		private var _throbbing:ThrobingSprite = new Entities.ThrobingSprite(0, 0, _bkg);
		
		public function GameEnd()
		{
			super();
			
			FlxG.playMusic(_titleMusic);
			FlxG.mouse.show();

			add(_throbbing);
			
			var replayButton:FlxButton = new FlxButton(0, FlxG.height - 50, "REPLAY", onClickSettings);
			replayButton.x = FlxG.width / 2 - replayButton.width / 2;
			replayButton.color = 0xff729954;
			replayButton.label.color = 0xffd8eba2;
			add(replayButton);
			
			var backButton:FlxButton = new FlxButton(0, FlxG.height - 25, "MENU", onClickBack);
			backButton.x = FlxG.width/2 - backButton.width / 2;
			backButton.color = 0xff729954;
			backButton.label.color = 0xffd8eba2;
			add(backButton);
			
			var press:FlxText = new FlxText(0, 15, FlxG.width, "TIME OVER");
			press.alignment = "center";
			press.size = 30;
			add(press);
			
			var displayScore:FlxText = new FlxText(0, 70, FlxG.width, "Your score\n\n" + FlxG.score.toString());
			displayScore.alignment = "center";
			displayScore.size = 10;
			add(displayScore);
		}
		
		private function onClickSettings():void 
		{
			FlxG.switchState(new PlayState());
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