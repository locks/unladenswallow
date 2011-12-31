package  States
{
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	import States.PlayState;
	
	public class TitleState extends FlxState
	{
		[Embed(source = '../../assets/Titles/UnladenSwallow.png')] private var _titleImage:Class;
		[Embed(source = '../../assets/Titles/Start.png')] private var _startOffImage:Class;
		[Embed(source = '../../assets/Titles/StartOn.png')] private var _startOnImage:Class;
		[Embed(source = '../../assets/ost/title.mp3')] private var _titleMusic:Class;
		
		private var ship:Ship;
		
		private var _playButton:FlxButton;
		private var flixelButton:FlxButton;
		
		public function TitleState()
		{
			super();
			
			
			this.add(new FlxSprite(0, 0, _titleImage));
			
			//_playButton.loadGraphic(button_on, button_off, onClickPlay);
			
			var flixelButton:FlxButton = new FlxButton(FlxG.width / 2 - 60/2, FlxG.height - 40, "GO", onClickPlay);
			flixelButton.color = 0xff729954;
			flixelButton.label.color = 0xffd8eba2;
			this.add(flixelButton);
			
			FlxG.mouse.show();
			FlxG.playMusic(_titleMusic);
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		override public function create():void 
		{
			
			FlxG.playMusic(_titleMusic);
		}
		
		private function onClickPlay():void
		{
			FlxG.mouse.hide();
			FlxG.music.stop();
			FlxG.switchState(new PlayState());
		}
	}
}