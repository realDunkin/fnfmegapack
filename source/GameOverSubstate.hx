package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import MainVariables._variables;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;

	var camLerp:Float = 0.14;
	var zoomLerp:Float = 0.09;

	public static var stageSuffix:String = "";
	var daactualbf = PlayState.SONG.player1;
	var daStage = PlayState.curStage;

	public function new(x:Float, y:Float)
	{
		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.WHITE);
		red.scrollFactor.set();
		var daBf:String = '';
		switch (daactualbf)
		{
			default:
				stageSuffix = '';
				daBf = 'bf';
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'bf-holding-gf':
				daBf = 'bf-holding-gf-dead';
			case 'bfb' | 'bfb-car' | 'bfb-christmas':
				stageSuffix = '-b';
				daBf = 'bfb';
			case 'bfb-pixel':
				stageSuffix = '-pixelb';
				daBf = 'bfb-pixel-dead';
			case 'bfb3' | 'bfb3-car' | 'bfb3-christmas':
				stageSuffix = '-b3';
				daBf = 'bfb3';
			case 'bfb3-pixel':
				stageSuffix = '-pixelb3';
				daBf = 'bfb3-pixel-dead';
			case 'bfneo' | 'bfneo-car':
				stageSuffix = '-neo';
				daBf = 'bfneo';
			case 'bfsunset':
				stageSuffix = '';
				daBf = 'bfsunset';
			case 'bfnight':
				stageSuffix = '';
				daBf = 'bfnight';
			case 'bfglitcher':
				stageSuffix = '';
				daBf = 'bfglitcher';
			case 'bf-tabi-crazy':
				stageSuffix = '';
				daBf = 'bf-knife';
		//	case 'bfmii':
		//		stageSuffix = '';
		//		daBf = 'bf-mii-dead';
		//fucker keeps crashing :(
			case 'bf-hell':
				stageSuffix = '-clown';
				daBf = 'bf-signDeath';
			case 'bf-sus':
				stageSuffix = '-sus';
				daBf = 'bf-sus';
			case 'bfghost':
				stageSuffix = '-sus';
				daBf = 'bfghost';
			case 'bf-kapi':
				stageSuffix = '';
				daBf = 'bf-kapi';
			case 'salty':
				stageSuffix = '-salty';
				daBf = 'salty';
			case 'salty-pixel':
				stageSuffix = '-pixelsalty';
				daBf = 'bf-pixel-dead';
			case 'mattblue':
				stageSuffix = '';
				daBf = 'matt-lost';
			case 'bf-ex':
				stageSuffix = '-bobandbosip';
				daBf = 'bf-ex';
			case 'bf-night-ex':
				stageSuffix = '-bobandbosip';
				daBf = 'bf-night-ex';
			case 'bfbob':
				stageSuffix = '-BOB';
				daBf = 'bf-spiked';
		}

		PlayState.ended = false;

		super();

		Conductor.songPosition = 0;

		if (stageSuffix == '-BOB'){
			add(red);
		}

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		camFollow = new FlxObject(PlayState.cameraX, PlayState.cameraY, 1, 1);
		add(camFollow);
			
		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix ),_variables.svolume/100);
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');

		FlxG.camera.flash(0xFF0000, 0.4);

		if (PlayState.gameplayArea == "Endless")
		{
			var press:FlxText = new FlxText(20, 15, 1200, "GAME OVER!\nGo back to try again.", 32);
			press.alignment = CENTER;
			press.scrollFactor.set();
			press.setFormat(Paths.font("vcr.ttf"), 72);
			press.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
			press.updateHitbox();
			add(press);

			press.cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

			press.alpha = 0;
			FlxTween.tween(press, {alpha: 1, y: 550 - press.height}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});

			#if mobileC
			addVirtualPad(NONE, B);
			_virtualpad.cameras = cameras;
			#end
		}
		else
		{
			#if mobileC
			addVirtualPad(NONE, A_B);
			_virtualpad.cameras = cameras;
			#end
		}		
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT && PlayState.gameplayArea != "Endless")
		{
			endBullshit();
		}

		if (FlxG.keys.justPressed.R && PlayState.gameplayArea != "Endless")
		{
			PlayState.mariohelping = true;
			endBullshit();
			FlxG.sound.play(Paths.sound('mario/marioletsgo'), _variables.svolume/100);
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			Main.exMode = false;
			Main.god = false;
			PlayState.mariohelping = false;
			#if desktop
			PlayState.iconRPC = "";
			#end

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
					FlxG.switchState(new ChartingState());
			}
		}

		FlxG.camera.zoom = FlxMath.lerp(FlxG.camera.zoom, 1, zoomLerp/(_variables.fps/60));

		if (bf.animation.curAnim.name == 'firstDeath')
		{
			FlxG.camera.follow(camFollow, LOCKON, camLerp);
			camFollow.x = FlxMath.lerp(camFollow.x, bf.getGraphicMidpoint().x, (camLerp * _variables.cameraSpeed)/(_variables.fps/60));
			camFollow.y = FlxMath.lerp(camFollow.y, bf.getGraphicMidpoint().y, (camLerp * _variables.cameraSpeed)/(_variables.fps/60));
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix),_variables.mvolume/100);
			switch (daStage)
			{
				case 'tank':
					FlxG.sound.play(Paths.soundRandom('jeff/jeffGameover-', 1, 25));
					FlxG.sound.music.fadeIn(10, 0.2, 1*_variables.mvolume/100);
				case 'tankstress':
					FlxG.sound.play(Paths.soundRandom('jeff/jeffGameover-', 1, 25));
					FlxG.sound.music.fadeIn(10, 0.2, 1*_variables.mvolume/100);
			}	
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	var shake:Float = 0;

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix), _variables.mvolume/100);
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
