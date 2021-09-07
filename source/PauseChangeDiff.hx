package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import MainVariables._variables;

class PauseChangeDiff extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var loopNum:Int = 0;

	var menuItems:Array<String> = ['Easy', 'Normal', 'Hard', 'Back'];
	var curSelected:Int = 0;

	var substated:Bool = false;
//	public static var pauseMusic:FlxSound;

	public function new()
	{
		super();		

//		PauseSubState.pauseMusic = pauseMusic;
//		pauseMusic.volume = 0;
//		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));
//		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.scrollFactor.set();
		add(bg);

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			songText.itemType = "Classic";
			songText.targetY = i;
			grpMenuShit.add(songText);
		}

		changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (!substated && upP)
		{
			changeSelection(-1);
		}
		if (!substated && downP)
		{
			changeSelection(1);
		}

		if (!substated && accepted)
		{
			var daSelected:String = menuItems[curSelected];

			switch (daSelected)
			{
				case "Back":
					PauseSubState.substated = false;
					close();
				case "Easy":
					PauseSubState.substated = false;
					PlayState.storyDifficulty = 0;
					PlayState.SONG = Song.loadFromJson(PlayState.SONG.song.toLowerCase()+'-easy', PlayState.SONG.song.toLowerCase());
					LoadingState.loadAndSwitchState(new PlayState(), true);
					FlxG.resetState();
				case "Normal":
					PauseSubState.substated = false;
					PlayState.storyDifficulty = 1;
					PlayState.SONG = Song.loadFromJson(PlayState.SONG.song.toLowerCase(), PlayState.SONG.song.toLowerCase());
					LoadingState.loadAndSwitchState(new PlayState(), true);
					FlxG.resetState();
				case "Hard":
					PauseSubState.substated = false;
					PlayState.storyDifficulty = 2;
					PlayState.SONG = Song.loadFromJson(PlayState.SONG.song.toLowerCase()+'-hard', PlayState.SONG.song.toLowerCase());
					LoadingState.loadAndSwitchState(new PlayState(), true);
					FlxG.resetState();
			}
		}

		if (FlxG.keys.justPressed.J)
		{
			// for reference later!
			// PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxKey.J, null);
		}
	}

	override function destroy()
	{
		super.destroy();
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
