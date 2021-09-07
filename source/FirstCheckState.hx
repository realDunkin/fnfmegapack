  
package;

import lime.app.Application;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxTimer;
import MainVariables._variables;
#if desktop
import Discord.DiscordClient;
#end

class FirstCheckState extends MusicBeatState
{

	override public function create()
	{
		FlxG.mouse.visible = false;

		#if desktop
		DiscordClient.initialize();

		Application.current.onExit.add (function (exitCode) {
			DiscordClient.shutdown();
		 });
		#end

		PlayerSettings.init();

		super.create();
	}

	override public function update(elapsed:Float)
	{
		switch (_variables.firstTime)
		{
			case true:
				FlxG.switchState(new FirstTimeState()); // First time language setting
			case false:
			{	
				if (_variables.music == 'desktop')
				{
					trace ('play video intro');
					FlxG.switchState(new VideoState("assets/videos/desktopintro.webm",new TitleState()));
				}
				else
				{
					trace ('boring');
					FlxG.switchState(new TitleState()); // First time language setting
				}
			}
		}
	}
}