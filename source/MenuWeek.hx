package;

import flixel.tweens.FlxEase;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.addons.display.FlxBackdrop;
import MainVariables._variables;
import flixel.util.FlxGradient;
#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class MenuWeek extends MusicBeatState
{
	var scoreText:FlxText;

	var weekData:Array<Dynamic> = [
		['Tutorial'],
		['Bopeebo', 'Fresh', 'Dadbattle'],
		['Spookeez', 'South', "Monster"],
		['Pico', 'Philly', "Blammed"],
		['Satin-Panties', "High", "Milf"],
		['Cocoa', 'Eggnog', 'Winter-Horrorland'],
		['Senpai', 'Roses', 'Thorns'],
		['ugh', 'guns', 'stress'],
		['Tutorial-B'],
		['Bopeebo-B', 'Fresh-B', 'Dadbattle-B'],
		['Spookeez-B', 'South-B'],
		['Pico-B', 'Philly-B', 'Blammed-B'],
		['Satin-Panties-B', 'High-B', 'Milf-B'],
		['Cocoa-B', 'Eggnog-B','Winter-Horrorland-B'],
		['Senpai-B', 'Roses-B', 'Thorns-B'],
		['Tutorial-B3'],
		['Bopeebo-B3', 'Fresh-B3', 'Dadbattle-B3'],
		['Spookeez-B3', 'South-B3'],
		['Pico-B3', 'Philly-B3', 'Blammed-B3'],
		['Satin-Panties-B3', 'High-B3', 'Milf-B3'],
		['Cocoa-B3', 'Eggnog-B3','Winter-Horrorland-B3'],
		['Senpai-B3', 'Roses-B3', 'Thorns-B3'],
		['Tutorial-Neo'],
		['Bopeebo-Neo', 'Fresh-Neo', 'Dadbattle-Neo'],
		['Spookeez-Neo', 'South-Neo'],
		['Pico-Neo', 'Philly-Neo', "Blammed-Neo"],
		['Satin-Panties-Neo', "High-Neo", "Milf-Neo"],
		['Lo-Fight', 'Overhead', 'Ballistic'],
		['dunk', 'ram', 'hello-world', 'glitcher'],
		['Headache', 'Nerves', 'Release', 'Fading'],
		['My-Battle', 'Last-Chance', 'Genocide'],
		['Where-are-you', 'Eruption', 'Kaio-ken'],
		['Whats-new', 'Blast', 'Super-saiyan'],
		['GOD-EATER'],
		['Light-It-Up','Ruckus','Target-Practice'],
		['Sporting','Boxing-Match'],
		['improbable-outset', 'madness', 'hellclown'],
		['Sussus-Moogus', 'Sabotage', 'Meltdown'],
		['Assembly', 'Voltage', 'Integer-Overflow', 'System-Crash'],
		['Foolhardy']
	];
	
	var curWeekData:Array<Dynamic> = [];

	public static var curDifficulty:Int = 1;

	public static var weekUnlocked:Array<Bool> = [true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true];

	var weekCharacters:Array<String> = [
		"gf",
		"dad",
		"spooky",
		"pico",
		"mom",
		"parents-christmas",
		"senpai",
		"tankman",
		"gf",
		"dad",
		"spooky",
		"pico",
		"mom",
		"parents-christmas",
		"senpai",
		"gf",
		"dad",
		"spooky",
		"pico",
		"mom",
		"parents-christmas",
		"senpai",
		"gf",
		"dad",
		"spooky",
		"pico",
		"mom",
		"whitty",
		"hex",
		"garcello",
		"tabi",
		"shaggy",
		"shaggy",
		"shaggy",
		"matt",
		"matt",
		"tricky",
		"impostor",
		"cyrix",
		"zardy"
	];

	var weekNumbers:Array<Int> = [
		0,
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11,
		12,
		13,
		14,
		15,
		16,
		17,
		18,
		19,
		20,
		21,
		22,
		23,
		24,
		25,
		26,
		27,
		28,
		29,
		30,
		31,
		31,
		31,
		32,
		32,
		33,
		34,
		35,
		36
	];

	var weekNames:Array<String> = [
		" ",
		"Daddy Dearest",
		"Spooky Month",
		"PICO",
		"MOMMY MUST MURDER",
		"RED SNOW",
		"Hating Simulator ft. Moawling",
		"Tankman",
		"Heatin' Up",
		"Rockstar",
		"Graveyard Shift",
		"Drop Out",
		"Popstar",
		"Thin Ice",
		'Hating Sim: Gold',
		" ",
		"Daddy Dearest",
		"Spooky Month",
		"PICO",
		"MOMMY MUST MURDER",
		"RED SNOW",
		"Hating Simulator ft. Moawling",
		" ",
		"Nigh Club Funkin'",
        "Spookeez Raveyard",
        "Allycats",
        "Mile High Funkin'",
		"Back Ally Blitz",
		"Hextravaganza",
		"SMOKE 'EM OUT STRUGGLE",
		"Curse",
		"Less Than 0.001%",
		"Up to 0.001%",
		"???%",
		"Matt's Tuesday Singing Lessons",
		"Matt is Done wiith your shit",
		"Circus Clown",
		"Vented",
		"Money Mixin'",
		"Foolhardy"
	];

	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;

	var sprDifficulty:FlxSprite;

	public static var bg:FlxSprite = new FlxSprite(-89).loadGraphic(Paths.image(''));
	var checker:FlxBackdrop = new FlxBackdrop(Paths.image('Week_Checker'), 0.2, 0.2, true, true);
	var gradientBar:FlxSprite = new FlxSprite(0,0).makeGraphic(FlxG.width, 300, 0xFFAA00AA);
	var side:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('Week_Top'));
	var bottom:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('Week_Bottom'));
	var boombox:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('Boombox'));

	var rankTable:Array<String> = ['P','X','X-','SS+','SS','SS-','S+','S','S-','A+','A','A-','B','C','D','E','NA'];
	var ranks:FlxTypedGroup<FlxSprite>;

	var characterUI:FlxSprite = new FlxSprite(20, 20);

	override function create()
	{
		FlxG.game.scaleX = 1;
		FlxG.game.x = 0;
		FlxG.game.scaleY = 1;
		FlxG.game.y = 0;

		ranks = new FlxTypedGroup<FlxSprite>();

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				{
					MenuMusic.continueMenuMusic();
				}
		}

		persistentUpdate = persistentDraw = true;

		MenuMusic.switchimage();
		bg = MenuMusic.bg;
		if (_variables.music != "neo"){bg.color = 0xFFe38502;}		
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.setGraphicSize(Std.int(MenuWeek.bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), 512, [0x00ff0000, 0x55F8FFAB, 0xAAFFDEF2], 1, 90, true); 
		gradientBar.y = FlxG.height - gradientBar.height;
		add(gradientBar);
		gradientBar.scrollFactor.set(0, 0);

		add(checker);
		checker.scrollFactor.set(0, 0.07);

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		for (i in 0...weekData.length)
			{
				var weekThing:MenuItem = new MenuItem(0, 40, i);
				weekThing.y += ((weekThing.height + 20) * i);
				weekThing.targetY = i;
				grpWeekText.add(weekThing);
	
				weekThing.screenCenter(X);
				weekThing.antialiasing = true;
				// weekThing.updateHitbox();
			}

		side.scrollFactor.x = 0;
		side.scrollFactor.y = 0;
		side.antialiasing = true;
		side.screenCenter();
		add(side);
		side.y = 0 - side.height;
		side.x = FlxG.width/2 - side.width/2;

		bottom.scrollFactor.x = 0;
		bottom.scrollFactor.y = 0;
		bottom.antialiasing = true;
		bottom.screenCenter();
		add(bottom);
		bottom.y = FlxG.height + bottom.height;

		scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
		scoreText.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		scoreText.alignment = CENTER;
		scoreText.setFormat("VCR OSD Mono", 32);
		scoreText.screenCenter(X);
		scoreText.y = 10;

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alignment = CENTER;
		txtWeekTitle.screenCenter(X);
		txtWeekTitle.y = scoreText.y + scoreText.height + 5;
		txtWeekTitle.alpha = 0;

		trace("Line 96");

		trace("Line 124");

		var diffTex = Paths.getSparrowAtlas('difficulties');
		sprDifficulty = new FlxSprite(0, 20);
		sprDifficulty.frames = diffTex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.play('easy');
		changeDifficulty();

		add(sprDifficulty);
		sprDifficulty.screenCenter(X);

		add(ranks);

		trace("Line 150");

		txtTracklist = new FlxText(FlxG.width * 0.05, 200, 0, "INCLUDES FAMOUS\n TRACKS LIKE:\n", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = scoreText.font;
		txtTracklist.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		txtTracklist.color = 0xFFe55777;
		txtTracklist.y = bottom.y + 60;
		add(txtTracklist);
		add(scoreText);
		add(txtWeekTitle);

		var tex = Paths.getSparrowAtlas('Week_CharUI');
		characterUI.frames = tex;
		characterUI.antialiasing = true;
		add(characterUI);

		updateText();

		trace("Line 165");	

		super.create();

		FlxTween.tween(bg, { alpha:1}, 0.8, { ease: FlxEase.quartInOut});
		FlxTween.tween(side, { y:0}, 0.8, { ease: FlxEase.quartInOut});
		FlxTween.tween(bottom, { y:FlxG.height - bottom.height}, 0.8, { ease: FlxEase.quartInOut});

		scoreText.alpha = sprDifficulty.alpha = characterUI.alpha = txtWeekTitle.alpha = 0;
		FlxTween.tween(scoreText, { alpha:1}, 0.8, { ease: FlxEase.quartInOut});
		FlxTween.tween(sprDifficulty, { alpha:1}, 0.8, { ease: FlxEase.quartInOut});
		FlxTween.tween(txtTracklist, { y:characterUI.y + 300}, 0.8, { ease: FlxEase.quartInOut});
		FlxTween.tween(characterUI, { alpha:1}, 0.8, { ease: FlxEase.quartInOut});
		FlxTween.tween(txtWeekTitle, { alpha:0.7}, 0.8, { ease: FlxEase.quartInOut});

		FlxG.camera.zoom = 0.6;
		FlxG.camera.alpha = 0;
		FlxTween.tween(FlxG.camera, { zoom:1, alpha:1}, 0.7, { ease: FlxEase.quartInOut});

		new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				selectable = true;
			});
			
		#if mobileC
		addVirtualPad(FULL, A_B);
		_virtualpad.cameras = cameras;
		#end
	}

	var selectable:Bool = false;

	override function update(elapsed:Float)
	{
		checker.x -= -0.12/(_variables.fps/60);
		checker.y -= -0.34/(_variables.fps/60);

		boombox.screenCenter();

		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5/(_variables.fps/60)));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "WEEK SCORE:" + lerpScore;

		scoreText.x = side.x + side.width/2 - scoreText.width/2;
		txtWeekTitle.x = side.x + side.width/2 - txtWeekTitle.width/2;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();

		// FlxG.watch.addQuick('font', scoreText.font);

		if (!selectedSomethin && selectable)
		{
			if (controls.UP_P)
			{
				changeWeek(-1);
			}

			if (controls.DOWN_P)
			{
				changeWeek(1);
			}

			if (controls.RIGHT_P)
				changeDifficulty(1);
			if (controls.LEFT_P)
				changeDifficulty(-1);

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !selectedSomethin && selectable)
		{
			#if desktop
			PlayState.iconRPC = " ";
			#end
			FlxG.sound.play(Paths.sound('cancelMenu'), _variables.svolume/100);
			selectedSomethin = true;
			FlxG.switchState(new PlaySelection());

			#if desktop
				DiscordClient.changePresence("Going Back!", null);
			#end

			FlxTween.tween(FlxG.camera, { zoom:0.6, alpha:-0.6}, 0.8, { ease: FlxEase.quartInOut});
			FlxTween.tween(bg, { alpha:0}, 0.8, { ease: FlxEase.quartInOut});
			FlxTween.tween(checker, { alpha:0}, 0.3, { ease: FlxEase.quartInOut});
			FlxTween.tween(gradientBar, { alpha:0}, 0.3, { ease: FlxEase.quartInOut});
			FlxTween.tween(side, { alpha:0}, 0.3, { ease: FlxEase.quartInOut});
			FlxTween.tween(bottom, { alpha:0}, 0.3, { ease: FlxEase.quartInOut});
		}

		super.update(elapsed);
	}

	var selectedSomethin:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			MenuMusic.ConfirmSound();

			grpWeekText.members[curWeek].startFlashing();

			PlayState.storyPlaylist = weekData[curWeek];
			trace(PlayState.storyPlaylist);
			PlayState.gameplayArea = "Story";
			selectedSomethin = true;

			var diffic = "";

			switch (curDifficulty)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
			}

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.storyWeek = weekNumbers[curWeek];
			PlayState.campaignScore = 0;

			trace('CUR WEEK' + PlayState.storyWeek);

			FlxTween.tween(bg, { alpha:0}, 0.6, { ease: FlxEase.quartInOut});
			FlxTween.tween(checker, { alpha:0}, 0.6, { ease: FlxEase.quartInOut});
			FlxTween.tween(characterUI, { x:3700}, 0.6, { ease: FlxEase.quartInOut});
			FlxTween.tween(txtTracklist, { x:-2600}, 0.6, { ease: FlxEase.quartInOut});
			FlxTween.tween(gradientBar, { alpha:0}, 0.6, { ease: FlxEase.quartInOut});
			FlxTween.tween(side, { alpha:0}, 0.8, { ease: FlxEase.quartInOut});
			FlxTween.tween(bottom, { alpha:0}, 0.8, { ease: FlxEase.quartInOut});
			FlxTween.tween(scoreText, { y:-50, alpha:0}, 0.8, { ease: FlxEase.quartInOut});
			FlxTween.tween(txtWeekTitle, { y:-50, alpha:0}, 0.8, { ease: FlxEase.quartInOut});
			FlxTween.tween(sprDifficulty, { y:-120, alpha:0}, 0.8, { ease: FlxEase.quartInOut});

			for (item in ranks.members)
				{
					FlxTween.tween(item, { x:2600}, 0.6, { ease: FlxEase.quartInOut});
				}

			#if desktop
				DiscordClient.changePresence("Selecting chart types.", null);
			#end

			for (item in grpWeekText.members)
				{
					FlxTween.tween(item, { alpha:0}, 0.9, { ease: FlxEase.quartInOut});
				}

			new FlxTimer().start(0.9, function(tmr:FlxTimer)
				{
					#if mobileC
					remove(_virtualpad);
					#end
					FlxG.state.openSubState(new Substate_ChartType());
				});
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		updateRank();

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('easy');
			case 1:
				sprDifficulty.animation.play('normal');
			case 2:
				sprDifficulty.animation.play('hard');
		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = txtWeekTitle.y + 5 ;
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end

		#if desktop
			PlayState.iconRPC = weekCharacters[curWeek];
			DiscordClient.changePresence("Deciding to play week "+curWeek+" on "+sprDifficulty.animation.name+"!", null);
		#end

		FlxTween.tween(sprDifficulty, {y: txtWeekTitle.y + 62, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		txtWeekTitle.x = side.x + side.width / 2 - txtWeekTitle.width / 2;

		updateRank();

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && weekUnlocked[curWeek])
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		#if desktop
			DiscordClient.changePresence("Deciding to play week " + curWeek + " on " + sprDifficulty.animation.name + "!", null);
		#end

		MenuMusic.ScrollSound();

		updateText();
	}

	function updateText()
	{
		txtTracklist.text = "INCLUDES FAMOUS\n TRACKS LIKE:\n\n";

		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
		{
			txtTracklist.text += i + "\n";
		}

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;

		characterUI.animation.addByPrefix(weekCharacters[curWeek], weekCharacters[curWeek], 24);
		characterUI.animation.play(weekCharacters[curWeek]);
		characterUI.scale.set(300 / characterUI.height, 300 / characterUI.height);
		characterUI.x = 1240 - characterUI.width;
		characterUI.y = 150;

		switch (characterUI.animation.curAnim.name)
		{
			case 'gf':
				characterUI.offset.set(0, 0);
				characterUI.flipX = false;
			case 'dad':
				characterUI.offset.set(-60, 50);
				characterUI.flipX = false;
			case 'spooky':
				characterUI.offset.set(-35, -37);
				characterUI.flipX = false;
			case 'pico':
				characterUI.offset.set(-50, -76);
				characterUI.flipX = true;
			case 'mom':
				characterUI.offset.set(-60, 58);
				characterUI.flipX = false;
			case 'parents-christmas':
				characterUI.offset.set(67, 47);
				characterUI.flipX = false;
			case 'senpai':
				characterUI.scale.set(600 / characterUI.height, 600 / characterUI.height);
				characterUI.offset.set(-107, -170);
				characterUI.flipX = false;
			case 'tankman':
				characterUI.scale.set(600 / characterUI.height, 600 / characterUI.height);
				characterUI.offset.set(-160, -160);
				characterUI.flipX = false;
			case 'whitty':
				characterUI.offset.set(-60, 50);
				characterUI.flipX = false;
			case 'hex':
				characterUI.offset.set(-60, 50);
				characterUI.flipX = false;
			case 'matt':
				characterUI.offset.set(-20, -70);
				characterUI.flipX = false;
			case 'shaggy':
				characterUI.offset.set(-60, 50);
				characterUI.flipX = false;
			case 'garcello':
				characterUI.offset.set(-60, -36);
				characterUI.flipX = false;
			case 'tabi':
				characterUI.offset.set(-60, 50);
				characterUI.flipX = false;
			case 'tricky':
				characterUI.offset.set(-20, 80);
				characterUI.flipX = false;
			case 'impostor':
				characterUI.offset.set(-20, -90);
				characterUI.flipX = false;
		}

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
	}

	function updateRank():Void
	{
		ranks.clear();

		curWeekData = weekData[curWeek];

		for (i in 0...curWeekData.length)
			{
				var rank:FlxSprite = new FlxSprite(958, 100);
				rank.loadGraphic(Paths.image('rankings/'+rankTable[Highscore.getRank(curWeekData[i], curDifficulty)]));
				rank.ID = i;
				rank.setGraphicSize(0,80);
				rank.updateHitbox();
				rank.antialiasing = true;
				rank.scrollFactor.set();
				rank.y = 30 + i*65;
					
				ranks.add(rank);
			}
	}
}
