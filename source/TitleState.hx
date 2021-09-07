package;

#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.util.FlxGradient;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;
import MainVariables._variables;

using StringTools;

class TitleState extends MusicBeatState
{
	static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var gradientBar:FlxSprite = new FlxSprite(0,0).makeGraphic(FlxG.width, 1, 0xFFAA00AA);
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var fnfSpr:FlxSprite;
	var FNF_Logo:FlxSprite;
	var FNF_EX:FlxSprite;

	var curWacky:Array<String> = [];

	var Timer:Float = 0;

	var wackyImage:FlxSprite;

	override public function create():Void
	{
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		#if polymod
		polymod.Polymod.init({modRoot: "mods", dirs: ['mods']});
		#end

		// DEBUG BULLSHIT	
		
		CachedFrames.init();

		MenuMarathon.loadCurrent();
		ModifierVariables.modifierSetup();
		ModifierVariables.loadCurrent();

		Highscore.load();
		super.create();
	}

	var logoBl:FlxSprite;
	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;

	function startIntro()
	{
		if (!initialized)
		{
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 0.5, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.42));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.5, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.42));

			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			// music.play();
			
			MenuMusic.startMenuMusic();
			FlxG.sound.music.fadeIn(4, 0, 0.7*_variables.mvolume/100);

			#if desktop
				DiscordClient.changePresence("Just started the game", null);
			#end
		}

		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		// bg.antialiasing = true;
		// bg.setGraphicSize(Std.int(bg.width * 0.6));
		// bg.updateHitbox();
		add(bg);

		logoBl = new FlxSprite(142, -17);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.antialiasing = true;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
		logoBl.animation.play('bump');
		logoBl.scale.set(0.6,0.6);
		logoBl.updateHitbox();
		// logoBl.screenCenter();
		// logoBl.color = FlxColor.BLACK;

		gfDance = new FlxSprite(FlxG.width * 0.35, FlxG.height * 1.2);
		gfDance.frames = Paths.getSparrowAtlas('gfDanceTitle');
		gfDance.animation.addByIndices('danceLeft', 'gfDance', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		gfDance.animation.addByIndices('danceRight', 'gfDance', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		gfDance.antialiasing = true;
		add(gfDance);

		var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.screenCenter();
		logo.antialiasing = true;
		// add(logo);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), 512, [0x0000ccff, 0x3366ffcc, 0x6666ff66], 1, 90, true); 
		gradientBar.y = FlxG.height - gradientBar.height;
		gradientBar.scale.y = 0;
		gradientBar.updateHitbox();
		add(gradientBar);
		FlxTween.tween(gradientBar, {'scale.y': 1.3}, 4, {ease: FlxEase.quadInOut});

		credTextShit = new Alphabet(0, 0, "ninjamuffin99\nPhantomArcade\nkawaisprite\nevilsk8er", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		fnfSpr = new FlxSprite(0, FlxG.height * 0.47).loadGraphic(Paths.image('logo'));
		add(fnfSpr);
		fnfSpr.visible = false;
		fnfSpr.setGraphicSize(Std.int(fnfSpr.width * 0.8));
		fnfSpr.updateHitbox();
		fnfSpr.antialiasing = true;

		FNF_Logo = new FlxSprite(0,0).loadGraphic(Paths.image('FNF_Logo'));
		FNF_EX = new FlxSprite(0,0).loadGraphic(Paths.image('FNF_MU'));
		add(FNF_EX);
		add(FNF_Logo);
		FNF_EX.scale.set(0.6,0.6);
		FNF_Logo.scale.set(0.6,0.6);
		FNF_EX.updateHitbox();
		FNF_Logo.updateHitbox();
		FNF_EX.antialiasing = true;
		FNF_Logo.antialiasing = true;

		FNF_EX.x = -1500;
		FNF_EX.y = 300;
		FNF_Logo.x = -1500;
		FNF_Logo.y = 300;

		add(logoBl);
		logoBl.visible = false;

		titleText = new FlxSprite(100, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = true;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		// titleText.screenCenter(X);
		add(titleText);
		titleText.visible = false;


		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		FlxG.mouse.visible = false;

		if (initialized)
			skipIntro();
		else
			initialized = true;

		// credGroup.add(credTextShit);

		#if desktop
			DiscordClient.changePresence("In the Title Screen", null);
		#end
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;

	var once:Bool = false;

	override function update(elapsed:Float)
	{
		if (!once)
		{
			once = true;
			new FlxTimer().start(1.2, function(tmr:FlxTimer)
				{
					startIntro();
				});
		}

		if (FlxG.keys.justPressed.ONE)
			MainVariables.DeleteSave();

		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		Timer += 1;
		gradientBar.scale.y += Math.sin(Timer/10)*0.001/(_variables.fps/60);
		gradientBar.updateHitbox();
		gradientBar.y = FlxG.height - gradientBar.height;
		//gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), Math.round(gradientBar.height), [0x00ff0000, 0xaaAE59E4, 0xff19ECFF], 1, 90, true); 

		if (skippedIntro)
			logoBl.angle = Math.sin(Timer/270) * 5/(_variables.fps/60);

		var pressedEnter:Bool = controls.ACCEPT;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		if (pressedEnter && !transitioning && skippedIntro)
		{

			titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
			MenuMusic.ConfirmSound();

			#if desktop
			DiscordClient.changePresence("Proceeding to the Main Menu", null);
			#end

			transitioning = true;
			// FlxG.sound.music.stop();

			FlxTween.tween(FlxG.camera, {y: FlxG.height}, 1.6, {ease: FlxEase.expoIn, startDelay: 0.4});
			
			if (_variables.music == "tricky")
				FlxG.sound.music.fadeOut(1.8, 0);

			new FlxTimer().start(1.8, function(tmr:FlxTimer)
			{
				if (_variables.music == "tricky")
				{
					FlxG.sound.music.stop();
					FlxG.sound.playMusic(Paths.musicRandom('trickymenu/nexus_', 1, 10), _variables.mvolume/100);
					Conductor.changeBPM(90);
				}
			});

			new FlxTimer().start(1.7, function(tmr:FlxTimer)
			{		

				// Get current version of FNF: Megapack
				//improved or not but works
				
				var http = new haxe.Http("https://raw.githubusercontent.com/realDunkin/fnfmegapack/default/version.downloadMe");
				var returnedData:Array<String> = [];
				
				http.onData = function (data:String)
				{
					var dataarray:Array<String> = data.trim().split(';');

					for (i in 0...dataarray.length)
					{
						returnedData[0] = dataarray[0];
						returnedData[1] = dataarray[1];
						returnedData[2] = dataarray[2];
					}
					
					OutdatedSubState.needVer = returnedData[0];
					OutdatedSubState.needName = returnedData[1];
					OutdatedSubState.currChanges = returnedData[2];

					if (OutdatedSubState.needVer >= MainMenuState.megapackVer)
					{
						if (OutdatedSubState.needVer == MainMenuState.megapackVer)
						{
							FlxG.switchState(new MainMenuState());
							trace('same version! ' + MainMenuState.megapackVer + ' equals ' + OutdatedSubState.needVer);
						}
						else
						{
							trace('outdated lmao! ' + MainMenuState.megapackVer + ' is less than ' + OutdatedSubState.needVer);
							FlxG.switchState(new OutdatedSubState());
						}					
					}
					else
					{
						trace('higher version? ' + MainMenuState.megapackVer + ' is greater than ' + OutdatedSubState.needVer);
						FlxG.switchState(new MainMenuState());
					}
				}
				
				http.onError = function (error) {
					trace('error: $error');
					FlxG.switchState(new MainMenuState()); // fail but we go anyway
				}
				
				http.request();
			});
			//
		}

		if (pressedEnter && !skippedIntro)
		{
			skipIntro();
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.x = -1500;
			FlxTween.quadMotion(money, -300, -100, 30+ (i*70), 150+ (i*130), 100 + (i*70), 80 + (i*130), 0.4, true, {ease: FlxEase.quadInOut});
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String)
	{
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.x = -1500;
		FlxTween.quadMotion(coolText, -300, -100, 10+ (textGroup.length*40), 150+ (textGroup.length*130), 30 + (textGroup.length*40), 80 + (textGroup.length*130), 0.4, true, {ease: FlxEase.quadInOut});
		credGroup.add(coolText);
		textGroup.add(coolText);
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	override function beatHit()
	{
		super.beatHit();

		logoBl.animation.play('bump');
		danceLeft = !danceLeft;

		if (danceLeft)
			gfDance.animation.play('danceRight');
		else
			gfDance.animation.play('danceLeft');

		FlxG.log.add(curBeat);

		if (_variables.music == "tricky")
		{
			switch (curBeat)
			{
				case 4:
					createCoolText(['Verwex,   Kadedev', 'Ash237', 'present']);
				case 6:
					deleteCoolText();
					createCoolText(['A modification', 'for']);
				case 8:
					fnfSpr.x = -1500;
					fnfSpr.visible = true;
					FlxTween.quadMotion(fnfSpr, -700, -700, 50+ (textGroup.length*130), 150 + (textGroup.length*50), 100 + (textGroup.length*130), 80 + (textGroup.length*50), 0.4, true, {ease: FlxEase.quadInOut});
				case 10:
					curWacky = FlxG.random.getObject(getIntroTextShit());
					deleteCoolText();
					fnfSpr.visible = false;
				case 12:
					createCoolText([curWacky[0]]);
				case 14:
					addMoreText(curWacky[1]);
				case 16:
					curWacky = FlxG.random.getObject(getIntroTextShit());
					deleteCoolText();				
					createCoolText([curWacky[0]]);
				case 18:
					addMoreText(curWacky[1]);
				case 20:
					curWacky = FlxG.random.getObject(getIntroTextShit());
					deleteCoolText();			
					createCoolText([curWacky[0]]);
				case 22:
					addMoreText(curWacky[1]);
				case 24:
					curWacky = FlxG.random.getObject(getIntroTextShit());
					deleteCoolText();				
					createCoolText([curWacky[0]]);
				case 26:
					addMoreText(curWacky[1]);
				case 28:
					deleteCoolText();
					FlxTween.tween(FNF_Logo, {y: 120, x: 210}, 0.8, {ease: FlxEase.backOut});
				case 30:
					FlxTween.tween(FNF_EX, {y: 48, x: 403}, 0.8, {ease: FlxEase.backOut});
				case 32:
					skipIntro();
			}
		}
		else
		{
			switch (curBeat)
			{
				case 4:
					createCoolText(['Verwex,   Kadedev', 'Ash237', 'present']);
				case 6:
					deleteCoolText();
					createCoolText(['A modification', 'for']);
				case 7:
					fnfSpr.x = -1500;
					fnfSpr.visible = true;
					FlxTween.quadMotion(fnfSpr, -700, -700, 50+ (textGroup.length*130), 150 + (textGroup.length*50), 100 + (textGroup.length*130), 80 + (textGroup.length*50), 0.4, true, {ease: FlxEase.quadInOut});
				case 8:
					curWacky = FlxG.random.getObject(getIntroTextShit());
					deleteCoolText();
					fnfSpr.visible = false;
				case 9:
					createCoolText([curWacky[0]]);
				case 11:
					addMoreText(curWacky[1]);
				case 12:
					deleteCoolText();
					FlxTween.tween(FNF_Logo, {y: 120, x: 210}, 0.8, {ease: FlxEase.backOut});
				case 14:
					FlxTween.tween(FNF_EX, {y: 48, x: 403}, 0.8, {ease: FlxEase.backOut});
				case 16:
					skipIntro();
			}
		}
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(fnfSpr);
			remove(FNF_Logo);
			remove(FNF_EX);

			FlxG.camera.flash(FlxColor.WHITE, 4, null, true);
			FlxTween.tween(logoBl, {'scale.x': 0.45, 'scale.y': 0.45, x: -165, y: -125}, 1.3, {ease: FlxEase.expoInOut, startDelay: 1.3});
			FlxTween.tween(gfDance, {y: 20}, 2.3, {ease: FlxEase.expoInOut, startDelay: 0.8});
			remove(credGroup);
			titleText.visible = true;
			logoBl.visible = true;
			skippedIntro = true;
		}
	}
}
