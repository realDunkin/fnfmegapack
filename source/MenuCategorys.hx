package;

#if desktop
import Discord.DiscordClient;
#end

import flixel.util.FlxTimer;
import flixel.util.FlxGradient;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import MainVariables._variables;
import flixel.math.FlxMath;

using StringTools;

class MenuCategorys extends MusicBeatState
{
    public static var bg:FlxSprite = new FlxSprite(-89).loadGraphic(Paths.image(''));
	var checker:FlxBackdrop = new FlxBackdrop(Paths.image('Free_Checker'), 0.2, 0.2, true, true);
	var gradientBar:FlxSprite = new FlxSprite(0,0).makeGraphic(FlxG.width, 300, 0xFFAA00AA);
	var side:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('Modi_Bottom'));
	var name:FlxText = new FlxText(20, 69, FlxG.width, "", 48);
	var multi:FlxText = new FlxText(20, 69, FlxG.width, "", 48);
	var explain:FlxText = new FlxText(20, 69, 1200, "", 48);
	var niceText:FlxText = new FlxText(20, 69, FlxG.width, "", 48);

	var bf:Array<String> = ['bf', 'bfb', 'bfb3', 'bfneo', 'bf', 'bf', 'bf', 'bf', 'bf', 'bf', 'bf', 'bf', 'bf', 'bf', 'bf', 'bf', 'bf', 'salty', 'bf', 'bf', 'bf', 'bf'];
	var modslist:Array<String> = ['fnf', 'bside', 'b3', 'neo', 'whitty', 'hex', 'garcello', 'tabi', 'shaggy', 'matt', 'tricky', 'imposter', 'cyrix', 'zardy', 'kapi', 'miku', 'agoti', 'salty', 'sky', 'shaggymatt', 'bobandbosip', 'bob'];
	var modnames:Array<String> = ['Friday Night Funkin', 'B-Side Remixes', 'Friday Night Funkin B3 REMIXED', 'Friday Night Funkin: Neo', 'V.S. Whitty', 'VS Hex Mod', 'Smoke Em Out Struggle', 'V.S. TABI Ex Boyfriend', 'VS Shaggy Mod', 'Vs Matt (Wii Funkin)', 'The Full-Ass Tricky Mod', 'VS Impostor V2', 'Friday Night Funkin VS Cyrix - Full Week', 'V.S Zardy - Foolhardy', 'VS. KAPI - Arcade Showdown', 'Hatsune Miku / FULL WEEK', 'V.S. AGOTI Full Week', 'Saltys Sunday Night', 'vs Sky (bfswifeforever)', 'Shaggy x Matt - Full Week', 'VS. Bob & Bosip: The Expansion Update', 'literally every fnf mod ever (Vs Bob)'];
	var moddescription:Array<String> = 
	['Uh oh! Your tryin to kiss ur hot girlfriend, but her MEAN and EVIL dad is trying to KILL you! Hes an ex-rockstar, the only way to get to his heart? The power of music...\n[By ninjamuffin99, PhantomArcade, kawaisprite, and evilsk8er]', 
	'Remixes the games music and gives the visuals a fresh coat of paint.\n[By Rozebud, JADS, and Cval]', 
	'This here is a mod of all Biddle3s Friday Night Funkin remixes\n[By Biddle3 and BlazeTheWolf55]', 
	'Welcome to Friday Night Funkin: Neo, where everything is overhauled, from character colors, icons, backgrounds, and songs!!!\n[By JellyFishedm, Mr.M0isty, EvanClubYT, and MagnusStrom]', 
	'While strolling with your Girlfriend though an alleyway, you happen to notice an ominous glow coming from around the corner. Out steps Whitmore (Whitty)\n[By Sock.clip, Nate Anim8. and KadeDev]', 
	'Its Hex! This robotic lookin fella challenges you to a battle. Unlike your previous rivals though there seems to be no bad intent coming from him. Or is there?\n[By YingYang48, KadeDev, and Dj-Cat]', 
	'Face off against a man named GARCELLO, as he tries to peer pressure Boyfriend into smoking a strange cigarette.\n[By atsuover and Rageminer]', 
	'Your girlfriend, invited by her uncle, asks you to come along with her. When you arrive at the place, your girlfriends ex is there.\n[By Homskiy, GWebDev, Tenzubushi, and DaDrawingLad]',
	'Shaggy, the most powerful being in the universe, has come to Friday Night Funkin!Using 0.001% of his power, he sings against you to test your strength.\n[By srPerez]',
	'Challenge Matt from Wii Sports in a full week in this brand new Friday Night Funkin Mod!\n[By hayley_c0ntrol, Sulayre, TheOnlyVolume, Biddle3, Tata Charles#2677, fefe is taken, WhippyorcYT, DEAD SKULLXX, Jams3D, paciofd, and BeezyLove]',
	'[By Rozebud, Kadedev, Cval, JADS, MorØ, and YingYang]',
	'[By Clowfoe]',
	'As word spreads of your many adventures, a message comes in from the music producer Cyrix! He wants you in his studio, and is ready to mix up some new tracks! You ready to get funky?\n[By Matt$, AyeTSG, vomic, Kazolzen, SodaReishi, and TokyoGalaxy]',
	'You find yourself lost in a cornfield maze, and what do you find. Its Zardy! Though hes not here to scare you in the traditional way you would think.Can you fight him off?\n[By Rozebud, StarnyArt, KadeDev, and SwankyBox]',
	'Kapi is a playful cat who loves rhythm games though gets jealous quickly. Show him whos boss!..\n[By paperkitty]',
	'Your famous sister wants to meet your Girlfriend, till you find yourself put on the spot in front of thousands of people!Now you gotta impress her, your Girlfriend, and all these other people?!\n[By evdial and GenoX]',
	'One peculiar night, you and your Girlfriend stumble into a strange alley, descending into an entirely different place. Upon your landing, you meet a new face, AGOTI.\n[By AGOTI, BrightFyre, SugarRatio, and Kullix]',
	'In an old arcade cabinet stored away in Daddy Dearests Basement, a group of poor souls become active during Sunday nights.\n[By Tsuraran]',
	'\n[By bbpanzu]',
	'The hardest boss & The most powerful entity are joining forces to bring you one of the most challenging experiences in Friday Night Funkin!\n[By srPerez and Sulayre]',
	'Bob and Bosip were planning to go on with their usual day until they accidentally stumbled across Friday Night Funkin, and they have to beat Boyfriend in a rap battle to escape!\n[By AmorAltra and The Bob and Bosip Team]',
	'Uh Oh, the man Bob is angry and you made them angry and they are so angry man, what did you do to make them angry? Honestly don’t know I’m just a game description.\n[By wildythomas, phlox, and donney]'
	];

	var menuItems:FlxTypedGroup<FlxSprite>;
	var menuChecks:FlxTypedGroup<FlxSprite>;

	var items:Array<FlxSprite> = [];
	var checkmarks:Array<FlxSprite> = [];

	var camFollow:FlxObject;
	public static var curSelected:Int = 0;

	public static var substated:Bool = false;

	var camLerp:Float = 0.1;

    override function create()
    {
		substated = false;

        transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		menuItems = new FlxTypedGroup<FlxSprite>();
		menuChecks = new FlxTypedGroup<FlxSprite>();

		MenuMusic.switchimage();
		bg = MenuMusic.bg;
		if (_variables.music != "neo"){bg.color = 0xFF00ade2;}
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.03;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), 512, [0x00ff0000, 0x5585BDFF, 0xAAECE2FF], 1, 90, true); 
		gradientBar.y = FlxG.height - gradientBar.height;
		add(gradientBar);
		gradientBar.scrollFactor.set(0, 0);

		add(checker);
		checker.scrollFactor.set(0.07, 0.07);

		add(menuItems);
		add(menuChecks);

		refreshModifiers();

		side.scrollFactor.x = 0;
		side.scrollFactor.y = 0;
		side.antialiasing = true;
		side.screenCenter();
		add(side);
		side.y = FlxG.height - side.height;

		camFollow = new FlxObject(-1420, 360, 1, 1);
		add(camFollow);

		add(name);
        name.scrollFactor.x = 0;
        name.scrollFactor.y = 0;
        name.setFormat("VCR OSD Mono", 48, FlxColor.WHITE, LEFT);
        name.x = 20;
        name.y = 600;
        name.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);

		add(multi);
        multi.scrollFactor.x = 0;
        multi.scrollFactor.y = 0;
        multi.setFormat("VCR OSD Mono", 30, FlxColor.WHITE, RIGHT);
        multi.x = 20;
        multi.y = 618;
        multi.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);

		add(explain);
        explain.scrollFactor.x = 0;
        explain.scrollFactor.y = 0;
        explain.setFormat("VCR OSD Mono", 20, FlxColor.WHITE, LEFT);
        explain.x = 20;
        explain.y = 654;
        explain.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);

		

        super.create();
		changeItem();

		niceText.setFormat("VCR OSD Mono", 52, FlxColor.WHITE, CENTER);
        niceText.x = 350;
        niceText.y = 140;
		niceText.scrollFactor.set();
        niceText.setBorderStyle(OUTLINE, 0xFF000000, 3, 1);
		add(niceText);

		explain.alpha = niceText.alpha = multi.alpha = name.alpha = 0;
		FlxTween.tween(name, {alpha:1}, 0.7, {ease: FlxEase.quartInOut, startDelay: 0.4});
		FlxTween.tween(multi, {alpha:1}, 0.7, {ease: FlxEase.quartInOut, startDelay: 0.4});
		FlxTween.tween(niceText, {alpha:1}, 0.7, {ease: FlxEase.quartInOut, startDelay: 0.4});
		FlxTween.tween(explain, {alpha:1}, 0.7, {ease: FlxEase.quartInOut, startDelay: 0.4});
		side.y = FlxG.height;
		FlxTween.tween(side, {y:FlxG.height-side.height}, 0.6, {ease: FlxEase.quartInOut});

		FlxTween.tween(bg, { alpha:1}, 0.8, { ease: FlxEase.quartInOut});
		FlxG.camera.zoom = 0.6;
		FlxG.camera.alpha = 0;
		FlxTween.tween(FlxG.camera, { zoom:1, alpha:1}, 0.7, { ease: FlxEase.quartInOut});

		new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				selectable = true;
			});

		FlxG.camera.follow(camFollow, null, camLerp);

        #if desktop
			DiscordClient.changePresence("Selected: "+modnames[curSelected], null);
		#end

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				{
					MenuMusic.continueMenuMusic();
				}
		}
		
		#if mobileC
		addVirtualPad(LEFT_RIGHT, A_B);
		#end
    }

	var selectable:Bool = false;
	var goingBack:Bool = false;

	function refreshModifiers():Void
	{
			var tex = Paths.getSparrowAtlas('Category');
	
			for (i in 0...modslist.length)
			{
				var menuItem:FlxSprite = new FlxSprite(300 + (i * 250), 100);
				menuItem.frames = tex;
				menuItem.animation.addByPrefix('idle', modslist[i] + " Idle", 24, true);
				menuItem.animation.addByPrefix('select', modslist[i] + " Select", 24, true);
				menuItem.animation.play('idle');
				menuItem.ID = i;
				menuItem.antialiasing = true;
				menuItem.scrollFactor.x = 1;
				menuItem.scrollFactor.y = 1;
				menuItem.y = 500;
				
				menuItems.add(menuItem);

				items.push(menuItem);
			}
	}

    override function update(elapsed:Float)
        {
            checker.x -= 0.03/(_variables.fps/60);
		    checker.y -= 0.20/(_variables.fps/60);

			multi.x = FlxG.width - (multi.width + 60);
			multi.text = "";

			niceText.screenCenter(X);

			if (modslist[curSelected] == 'number')
				niceText.visible = true;
			else
				niceText.visible = false;

			niceText.text = modslist[curSelected];

            super.update(elapsed);

			if (selectable && !goingBack && !substated)
			{
				if (controls.LEFT_P)
				{
					changeItem(-1);
					MenuMusic.ScrollSound();
				}
	
				if (controls.RIGHT_P)
				{
					changeItem(1);
					MenuMusic.ScrollSound();
				}

				if (controls.BACK)
				{
					#if desktop
					PlayState.iconRPC = " ";
					#end
					FlxG.switchState(new PlaySelection());	

					FlxTween.tween(FlxG.camera, { zoom:0.6, alpha:-0.6}, 0.8, { ease: FlxEase.quartInOut});
					FlxTween.tween(bg, { alpha:0}, 0.8, { ease: FlxEase.quartInOut});
					FlxTween.tween(checker, { alpha:0}, 0.3, { ease: FlxEase.quartInOut});
					FlxTween.tween(gradientBar, { alpha:0}, 0.3, { ease: FlxEase.quartInOut});
					FlxTween.tween(side, { alpha:0}, 0.3, { ease: FlxEase.quartInOut});

					#if desktop
					DiscordClient.changePresence("Going Back!", null);
					#end

					FlxG.sound.play(Paths.sound('cancelMenu'), _variables.svolume/100);

					goingBack = true;
				}

				if (controls.ACCEPT)
				{
					MenuMusic.ConfirmSound();
	
					#if desktop
					DiscordClient.changePresence("Choose: "+modnames[curSelected],  null);
					#end

					menuItems.forEach(function(spr:FlxSprite)
					{
						var daChoice:String = modslist[curSelected];

						switch (daChoice)
						{
							case 'fnf':
								FlxG.switchState(new FreeplayFNF());
							case 'bside':
								FlxG.switchState(new FreeplayBSide());
							case 'b3':
								FlxG.switchState(new FreeplayB3());
							case 'neo':
								FlxG.switchState(new FreeplayNeo());
							case 'whitty':
								FlxG.switchState(new FreeplayWhitty());
							case 'hex':
								FlxG.switchState(new FreeplayHex());
							case 'garcello':
								FlxG.switchState(new FreeplayGarcello());
							case 'tabi':
								FlxG.switchState(new FreeplayTabi());
							case 'shaggy':
								FlxG.switchState(new FreeplayShaggy());
							case 'matt':
								FlxG.switchState(new FreeplayMatt());
							case 'tricky':
								FlxG.switchState(new FreeplayTricky());
							case 'imposter':
								FlxG.switchState(new FreeplayImposter());
							case 'cyrix':
								FlxG.switchState(new FreeplayCyrix());
							case 'zardy':
								FlxG.switchState(new FreeplayZardy());
							case 'kapi':
								FlxG.switchState(new FreeplayKapi());
							case 'miku':
								FlxG.switchState(new FreeplayMiku());
							case 'agoti':
								FlxG.switchState(new FreeplayAGOTI());
							case 'salty':
								FlxG.switchState(new FreeplaySalty());
							case 'sky':
								FlxG.switchState(new FreeplaySky());
							case 'shaggymatt':
								FlxG.switchState(new FreeplayShaggyMatt());
							case 'bobandbosip':
								FlxG.switchState(new FreeplayBobandBosip());
							case 'bob':
								FlxG.switchState(new FreeplayBob());
						}
					});
				}
			}

			menuItems.forEach(function(spr:FlxSprite)
				{

					if (spr.ID == curSelected)
					{
						camFollow.x = FlxMath.lerp(camFollow.x, spr.getGraphicMidpoint().x, camLerp/(_variables.fps/60));
						camFollow.y = FlxMath.lerp(camFollow.y, spr.getGraphicMidpoint().y, camLerp/(_variables.fps/60));
						name.text = modnames[spr.ID].toUpperCase();
						explain.text = moddescription[spr.ID];
					}

					spr.updateHitbox();

					spr.y = 360 - Math.exp(Math.abs(camFollow.x - 30 - spr.x + spr.width/2)/80);
					if (spr.y > -500)
						spr.y = 360 - Math.exp(Math.abs(camFollow.x - 30 - spr.x + spr.width/2)/80);
					else
						spr.y = -500;

					menuChecks.forEach(function(check:FlxSprite)
						{
							check.visible = checkmarks[check.ID].visible;

							check.y = items[check.ID].y + spr.height - spr.height/8*2;
							check.x = items[check.ID].getGraphicMidpoint().x - check.width/2;
						});
			});
        }

	function changeItem(huh:Int = 0)
		{
			curSelected += huh;
			
			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
	
			menuItems.forEach(function(spr:FlxSprite)
				{
					spr.animation.play('idle');
			
					if (spr.ID == curSelected)
					{
						spr.animation.play('select'); 
					}
				
					spr.updateHitbox();
				});

			#if desktop
			PlayState.iconRPC = bf[curSelected];
			DiscordClient.changePresence("Selected: "+modnames[curSelected], null);
			#end
		}
}
class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}