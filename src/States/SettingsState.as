package  States
{
	import Entities.ThrobingSprite;
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	import States.PlayState;
	
	public class SettingsState extends FlxState
	{
		[Embed(source = '../data/bkg.png')] private var Background:Class;
		[Embed(source = '../data/instructions.png')] private var Instructions:Class;
		
		private var _throbbing:ThrobingSprite = new ThrobingSprite(0, 0, Background);
		
		public function SettingsState()
		{
			super();
			
			add(_throbbing);
			add(new FlxSprite(0, 0, Instructions));

			var backButton:FlxButton = new FlxButton(0, FlxG.height - 25, "BACK", onClickBack);
			backButton.x = FlxG.width/2 - backButton.width / 2;
			backButton.color = 0xff729954;
			backButton.label.color = 0xffd8eba2;
			this.add(backButton);
			
			var press:FlxText = new FlxText(0, 15, FlxG.width, "INSTRUCTIONS");
			press.alignment = "center";
			press.size = 25;
			add(press);
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