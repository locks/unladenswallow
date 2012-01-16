package  States
{
	import Entities.ThrobingSprite;
	import org.flixel.FlxButton;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	import States.PlayState;
	
	public class MenuState extends FlxState
	{
		[Embed(source = '../data/title.png')] private var _title:Class;
		[Embed(source = '../data/bkg.png')] private var _bkg:Class;
		[Embed(source = '../data/title.mp3')] private var _titleMusic:Class;
		
		private var _throbbing:ThrobingSprite = new ThrobingSprite(0, 0, _bkg);
		
		private var _titleLogo:FlxSprite = new FlxSprite(0, 0, _title);
		private var _titleBkg:FlxSprite = new FlxSprite(0, 0, _bkg);
				
		private var ship:Ship;
		
		private var _playButton:FlxButton;
		private var flixelButton:FlxButton;
		private var fading:Boolean;
		
		public static var highscores:FlxSave;
		
		public function MenuState()
		{
			super();
			
			add(_throbbing);
			add(_titleLogo);
			
			var settingsButton:FlxButton = new FlxButton(0, FlxG.height - 50, "INSTRUCTIONS", onClickSettings);
			settingsButton.x = FlxG.width / 2 - settingsButton.width / 2;
			settingsButton.color = 0xff729954;
			settingsButton.label.color = 0xffd8eba2;
			this.add(settingsButton);
			
			var highscoresButton:FlxButton = new FlxButton(0, FlxG.height - 25, "HIGHSCORES", onClickHighscores);
			highscoresButton.x = FlxG.width/2 - highscoresButton.width / 2;
			highscoresButton.color = 0xff729954;
			highscoresButton.label.color = 0xffd8eba2;
			this.add(highscoresButton);
			
			var press:FlxText = new FlxText(0, FlxG.height - 70, FlxG.width, "PRESS X+C TO PLAY");
			press.alignment = "center";
			this.add(press);
		}
		
		private function gameSave():void 
       {
           highscores = new FlxSave();
           highscores.bind("UnladenSwallow");
		   
           if (highscores.data == null)
               highscores.data.topFive = new Array(0, 0, 0, 0, 0);

           highscores.close();
       }
		
		override public function create():void {
			FlxG.playMusic(_titleMusic);
			FlxG.mouse.show();
			
			gameSave();
		}
		
		private function onClickHighscores():void 
		{
			FlxG.switchState(new HighScoreState());
		}
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.C && FlxG.keys.X) newGame();
			
			var value:Number = _titleBkg.alpha;
			
			if (fading)
			{
				(value > 0.2) ? _titleBkg.alpha = value - 0.01 : fading = false;
			} else
			{
				(value < 1.0) ? _titleBkg.alpha = value + 0.02 : fading = true;
			}
		}
		
		private function newGame():void 
		{
			FlxG.mouse.hide();
			FlxG.switchState(new PlayState());
		}
		
		private function onClickSettings():void
		{
			FlxG.switchState(new SettingsState());
		}
	}
}