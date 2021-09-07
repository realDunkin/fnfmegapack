package;

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
import flixel.addons.display.FlxBackdrop;
import MainVariables._variables;

using StringTools;

class SettingsState extends MusicBeatState
{
	public static var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image(''));
	var checker:FlxBackdrop = new FlxBackdrop(Paths.image('Options_Checker'), 0.2, 0.2, true, true);
	var gradientBar:FlxSprite = new FlxSprite(0,0).makeGraphic(FlxG.width, 300, 0xFFAA00AA);

	public static var mobilecontrolshown:Bool = false;

	public static var page:Int = 0;

	override public function create():Void
	{
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (!FlxG.sound.music.playing)
		{
			MenuMusic.continueMenuMusic();
		}

		super.create();

		persistentUpdate = persistentDraw = true;

		MenuMusic.switchimage();
		bg = MenuMusic.bg;
		if (_variables.music != "neo"){bg.color = 0xFF6A92EE;}				
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.015;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), 512, [0x00ff0000, 0x558DE7E5, 0xAAE6F0A9], 1, 90, true); 
		gradientBar.y = FlxG.height - gradientBar.height;
		add(gradientBar);
		gradientBar.scrollFactor.set(0, 0);

		add(checker);
		checker.scrollFactor.set(0, 0.07);

        var side:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('Options_Side'));
		side.scrollFactor.x = 0;
		side.scrollFactor.y = 0;
		side.antialiasing = true;
		add(side);
        side.x = 0;

		FlxG.camera.zoom = 3;
		FlxTween.tween(FlxG.camera, { zoom: 1}, 1.5, { ease: FlxEase.expoInOut });

		new FlxTimer().start(0.75, function(tmr:FlxTimer)
		{
			startIntro(page);
		}); //gotta wait for a trnsition to be over because that apparently breaks it.
	}

	function startIntro(page:Int)
	{
		switch (page)
		{
			case 0:
				FlxG.state.openSubState(new PAGE1settings());
			case 1:
				FlxG.state.openSubState(new PAGE2settings());
			case 2:
				FlxG.state.openSubState(new PAGE3settings());
			case 3:
				FlxG.state.openSubState(new PAGE4settings());
			case 4:
				FlxG.state.openSubState(new PAGE5settings());
			case 5:
				FlxG.state.openSubState(new PAGE6settings());
		}

		if (!mobilecontrolshown)
		{
			#if mobileC
			addVirtualPad(FULL, A_B_SHIFT);
			_virtualpad.cameras = cameras;
			#end
			mobilecontrolshown = true;
		}
	}

	override function update(elapsed:Float)
	{
		checker.x -= 0.21/(_variables.fps/60);
		checker.y -= 0.51/(_variables.fps/60);

		if (page < 0)
			page = 5;
		if (page > 5)
			page = 0;

		super.update(elapsed);
	}
}
