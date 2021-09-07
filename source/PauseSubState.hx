package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
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

class PauseSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var loopNum:Int = 0;

	var menuItems:Array<String> = ['Resume', 'Restart Song', 'Botplay', 'Change Difficulty', 'Exit to menu'];
	var curSelected:Int = 0;

	public static var substated:Bool = false;

	public static var pauseMusic:FlxSound;

	public function new(x:Float, y:Float)
	{
		super();

		switch (PlayState.gameplayArea)
		{
			case "Marathon" | "Endless":
				menuItems = ['Resume', 'Restart Song', 'Botplay', 'Exit to menu'];
				loopNum = PlayState.loops+1;
			case "Charting":
				menuItems = ['Resume', 'Botplay', 'Chart', 'Restart Song', 'Exit to menu'];
			default:
			{
				menuItems = ['Resume', 'Restart Song', 'Botplay', 'Change Difficulty', 'Exit to menu'];
			}
		}	
		
		MenuMusic.PauseMusic();			
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));
		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		var levelInfo:FlxText = new FlxText(20, 15, 0, "", 32);
		levelInfo.text += PlayState.SONG.song;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
		levelInfo.updateHitbox();
		add(levelInfo);

		var levelDifficulty:FlxText = new FlxText(20, 15 + 32, 0, "", 32);
		levelDifficulty.text += CoolUtil.difficultyString();
		if (PlayState.gameplayArea == "Endless")
			levelDifficulty.text = 'Loop '+loopNum;
		else if (PlayState.gameplayArea == "Charting")
			levelDifficulty.text = 'Charting State';
		levelDifficulty.scrollFactor.set();
		levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
		levelDifficulty.updateHitbox();
		add(levelDifficulty);

		levelDifficulty.alpha = 0;
		levelInfo.alpha = 0;

		levelInfo.x = FlxG.width - (levelInfo.width + 20);
		levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20);

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});

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

		#if mobileC
		addVirtualPad(UP_DOWN, A_B);
		_virtualpad.cameras = cameras;
		#end
	}

	override function update(elapsed:Float)
	{
		if (pauseMusic.volume < 0.5 * _variables.mvolume/100)
			pauseMusic.volume += 0.01 * _variables.mvolume/100 * elapsed;

		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;
		var leftP = controls.LEFT_P;
		var rightP = controls.RIGHT_P;

		if (!substated && upP)
		{
			changeSelection(-1);
			MenuMusic.ScrollSound();
		}
		if (!substated && downP)
		{
			changeSelection(1);
			MenuMusic.ScrollSound();
		}

		if (!substated && accepted)
		{
			var daSelected:String = menuItems[curSelected];

			switch (daSelected)
			{
				case "Resume":
					close();
				case "Restart Song":
					FlxG.resetState();
					PlayState.ended = false;
				case "Botplay":
					_variables.botplay = !_variables.botplay;
					PlayState.botPlay.visible = _variables.botplay;
				case "Change Difficulty":
					updateDifficultyList();
				case "Chart":
					PlayState.ended = false;					
					FlxG.switchState(new ChartingState());
				case "Back":
					updateMenuList();
				case "Exit to menu":
					Main.exMode = false;
					Main.god = false;
					Main.skipDes = false;
					#if desktop
					PlayState.iconRPC = "";
					#end
					PlayState.mariohelping = false;
					Main.playedVidCut = false;
					PlayState.ended = false;
					PlayState.loops = 0;
					PlayState.speed = 0;
					switch (PlayState.gameplayArea)
					{
					case "Story":
						FlxG.switchState(new MenuWeek());
					case "Freeplay":
						FlxG.switchState(new MenuCategorys());
					case "Marathon":
						FlxG.switchState(new MenuMarathon());
					case "Endless":
						FlxG.switchState(new MenuEndless());
					case "Charting":
						FlxG.switchState(new MainMenuState());
					}
				case "Easy":
					PlayState.storyDifficulty = 0;
					PlayState.SONG = Song.loadFromJson(PlayState.SONG.song.toLowerCase()+'-easy', PlayState.SONG.song.toLowerCase());
					LoadingState.loadAndSwitchState(new PlayState(), true);
					FlxG.resetState();
				case "Normal":
					PlayState.storyDifficulty = 1;
					PlayState.SONG = Song.loadFromJson(PlayState.SONG.song.toLowerCase(), PlayState.SONG.song.toLowerCase());
					LoadingState.loadAndSwitchState(new PlayState(), true);
					FlxG.resetState();
				case "Hard":
					PlayState.storyDifficulty = 2;
					PlayState.SONG = Song.loadFromJson(PlayState.SONG.song.toLowerCase()+'-hard', PlayState.SONG.song.toLowerCase());
					LoadingState.loadAndSwitchState(new PlayState(), true);
					FlxG.resetState();
				case "Ex":
					PlayState.storyDifficulty = 3;
					PlayState.SONG = Song.loadFromJson(PlayState.SONG.song.toLowerCase()+'-ex', PlayState.SONG.song.toLowerCase());
					LoadingState.loadAndSwitchState(new PlayState(), true);
					FlxG.resetState();
				case "God":
					PlayState.storyDifficulty = 4;
					PlayState.SONG = Song.loadFromJson(PlayState.SONG.song.toLowerCase()+'-god', PlayState.SONG.song.toLowerCase());
					LoadingState.loadAndSwitchState(new PlayState(), true);
					FlxG.resetState();
			}
		}
	}

	function updateDifficultyList():Void
	{	
		switch (PlayState.SONG.song.toLowerCase())
		{
			default:
				menuItems = ['Easy', 'Normal', 'Hard', 'Back'];
			case 'jump-in':
				menuItems = ['Easy', 'Normal', 'Hard', 'Ex', 'Back'];
			case 'swing':
				menuItems = ['Easy', 'Normal', 'Hard', 'Ex', 'Back'];
			case 'split': 
				menuItems = ['Easy', 'Normal', 'Hard', 'Ex', 'Back'];
			case 'final-destination':
				menuItems = ['Easy', 'Normal', 'Hard', 'God', 'Back'];
		}
		
		remove(grpMenuShit);
		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			songText.itemType = "Classic";
			songText.targetY = i;
			grpMenuShit.add(songText);
		}

		curSelected = 0;
	}

	function updateMenuList():Void
	{	
		switch (PlayState.gameplayArea)
		{
			case "Marathon" | "Endless":
				menuItems = ['Resume', 'Restart Song', 'Botplay', 'Exit to menu'];
			case "Charting":
				menuItems = ['Resume', 'Botplay', 'Chart', 'Restart Song', 'Exit to menu'];
			default:
				menuItems = ['Resume', 'Restart Song', 'Botplay', 'Change Difficulty', 'Exit to menu'];
		}
		
		remove(grpMenuShit);
		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			songText.itemType = "Classic";
			songText.targetY = i;
			grpMenuShit.add(songText);
		}

		curSelected = 0;
	}

	override function destroy()
	{
		pauseMusic.destroy();

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
