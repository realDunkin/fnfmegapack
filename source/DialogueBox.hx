package;

import haxe.Json;
#if desktop
import sys.io.File;
#end
import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import MainVariables._variables;
import ModifierVariables._modifiers;

using StringTools;

typedef Dialogue =
{
    var addY:Int;
    var canFlip:Bool;
}

class DialogueBox extends FlxSpriteGroup
{
	public static var _dialogue:Dialogue;

	var box:FlxSprite;

	var camLerp:Float = 0.14;



	//there's going to be a ton of these for making the system robust
	var bgALPHA:Int;
	var bgRED:Int;
	var bgGREEN:Int;
	var bgBLUE:Int;
	var curMusic:String = '';
	var charScale:Float;
	var dialogueColor:String = '';
	var shadowColor:String = '#FFFFFFFF';
	var portraitColor:String = '#FF000000';
	var fadeInTime:Float;
	var fadeInLoop:Int;
	var fadeOutTime:Float;
	var fadeOutLoop:Int;
	var bgFIT:Float;
	var bgFIL:Int;
	var handSprite:String = '#FFFFFFFF';
	var clickSound:String = '#FF000000';
	

	var curCharacter:String = '';
	var oldCharacter:String = '';
	var curVolume:String = '100';
	var curEmotion:String = '';
	var curShake:String = '0';
	var curShakeTime:String = '0';
	var curShakeDelay:String = '0';
	var curFlashTime:String = '0';
	var curFlashDelay:String = '0';
	var curSpeed:String = '0.04';
	var curFlip:String = 'false';
	var curFont:String = 'Pixel Arial 11 Bold';
	var curFontScale:String = '32';
	var curBox:String = 'pixel_normal';
	var oldBox:String = '';
	var curSound:String = 'pixelText';
	var timeCut:Int;



	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portrait:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		if (PlayState.dialogue == null)
			return;

		_dialogue = {
			addY: 0,
			canFlip: true,
		};

		this.dialogueList = dialogueList;

		setUp();

		if (_modifiers.VibeSwitch)
			{
				switch (_modifiers.Vibe)
				{
				case 0.8:
					FlxG.sound.playMusic(Paths.music('dialogueMusic/'+curMusic+'_HIFI'), 0);
				case 1.2:
					FlxG.sound.playMusic(Paths.music('dialogueMusic/'+curMusic+'_LOFI'), 0);
				default:
					FlxG.sound.playMusic(Paths.music('dialogueMusic/'+curMusic), 0);
				}
			}
		else
			FlxG.sound.playMusic(Paths.music('dialogueMusic/'+curMusic), 0);

		FlxG.sound.music.fadeIn(1, 0, 0.8 * Std.parseInt(curVolume)/100 * _variables.mvolume/100);

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), FlxColor.fromRGB(bgRED, bgGREEN, bgBLUE, bgALPHA));
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(bgFIT, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / bgFIL);
			if (bgFade.alpha > 1)
				bgFade.alpha = 1;
		}, bgFIL);

		portrait = new FlxSprite(-20, 40);
		portrait.frames = Paths.getSparrowAtlas('portraits/$curCharacter');
		portrait.animation.addByPrefix('neutral', 'neutral', 24, false);
		portrait.setGraphicSize(Std.int(portrait.width * PlayState.daPixelZoom * 0.9));
		portrait.updateHitbox();
		portrait.scale.set(charScale, charScale);
		portrait.updateHitbox();
		portrait.scrollFactor.set();
		add(portrait);
		portrait.visible = false;

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'thorns':
				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		}
		
		box = new FlxSprite(-20, 45);
		box.frames = Paths.getSparrowAtlas('dialogueBoxes/$curBox');
		box.animation.addByPrefix('open', 'open', 24, false);
		box.animation.addByPrefix('normal', 'normal', 24, true);
		box.animation.play('open');
		box.setGraphicSize(Std.int(FlxG.width * 0.9));
		box.updateHitbox();
		add(box);

		if (_dialogue.canFlip)
			box.flipX = portrait.flipX;

		box.screenCenter(X);
		box.y = 710 - box.height;

		if (curBox != null)
		{
			#if desktop
			var data:String = File.getContent(Paths.json('dialogueBoxes/'+curBox));
        	_dialogue = Json.parse(data);
			#end
		}

		box.y += _dialogue.addY;

		portrait.screenCenter(Y);

		handSelect = new FlxSprite(1240, 680).loadGraphic(Paths.image('dialogueHands/$handSprite'));
		handSelect.setGraphicSize(Std.int(100));
		handSelect.updateHitbox();
		handSelect.x -= handSelect.width;
		handSelect.y -= handSelect.height;
		add(handSelect);

		dropText = new FlxText(242, 482, Std.int(FlxG.width * 0.6), "", Std.parseInt(curFontScale));
		dropText.font = curFont;
		dropText.color = FlxColor.fromString(shadowColor);
		add(dropText);

		swagDialogue = new FlxTypeText(240, 480, Std.int(FlxG.width * 0.6), "", Std.parseInt(curFontScale));
		swagDialogue.font = curFont;
		swagDialogue.color = FlxColor.fromString(dialogueColor);
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound(curSound), 0.6*_variables.svolume/100)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{

		if (dialogueStarted)
		{
			FlxG.sound.music.volume = FlxMath.lerp(FlxG.sound.music.volume, 0.8 * Std.parseInt(curVolume)/100 * _variables.mvolume/100, camLerp/(_variables.fps/60));
			if (curFlip == 'true')
				portrait.x = FlxMath.lerp(portrait.x, 580 - portrait.width,(camLerp*2)/(_variables.fps/60));
			else
				portrait.x = FlxMath.lerp(portrait.x, 700,(camLerp*2)/(_variables.fps/60));
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'open' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		#if mobile
		var justTouched:Bool = false;

		for (touch in FlxG.touches.list)
		{
			justTouched = false;
			
			if (touch.justReleased){
				justTouched = true;
			}
		}
		#end

		if (FlxG.keys.justPressed.ANY #if mobile || justTouched #end && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('dialogueClicks/$clickSound'), 0.8* _variables.svolume/100);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(fadeOutTime, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / fadeOutLoop;
						bgFade.alpha -= 1 / fadeOutLoop * 0.7;
						portrait.visible = false;
						swagDialogue.alpha -= 1 / fadeOutLoop;
						handSelect.alpha -= 1 / fadeOutLoop;
						dropText.alpha = swagDialogue.alpha;
					}, fadeOutLoop);

					new FlxTimer().start(fadeOutTime * (fadeOutLoop+1), function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;
	var splitData:Array<String>;

	function setUp():Void
	{
		splitData = dialogueList[0].split("[");
		bgALPHA = Std.parseInt(splitData[1]);
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("[");
		bgRED = Std.parseInt(splitData[1]);
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("[");
		bgGREEN = Std.parseInt(splitData[1]);
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("[");
		bgBLUE = Std.parseInt(splitData[1]);
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("|");
		curMusic = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("*");
		curVolume = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("=");
		charScale = Std.parseFloat(splitData[1]);
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("#");
		curBox = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("<");
		fadeInTime = Std.parseFloat(splitData[1]);
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split(">");
		fadeInLoop = Std.parseInt(splitData[1]);
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("(");
		fadeOutTime = Std.parseFloat(splitData[1]);
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split(")");
		fadeOutLoop = Std.parseInt(splitData[1]);
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("{");
		bgFIT = Std.parseFloat(splitData[1]);
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("}");
		bgFIL = Std.parseInt(splitData[1]);
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("`");
		handSprite = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("~");
		clickSound = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		dialogueList.remove(dialogueList[0]);
	}

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);

		new FlxTimer().start(Std.parseInt(curShakeDelay)*Std.parseFloat(curSpeed), function(tmr:FlxTimer)
			{
				FlxG.cameras.shake(Std.parseFloat(curShake), Std.parseInt(curShakeTime)*Std.parseFloat(curSpeed));
			});

		new FlxTimer().start(Std.parseInt(curFlashDelay)*Std.parseFloat(curSpeed), function(tmr:FlxTimer)
			{
				FlxG.cameras.flash(0xFFFFFFFF, Std.parseInt(curFlashTime)*Std.parseFloat(curSpeed));
				if (Std.parseInt(curFlashTime) > 0)
				{
					switch (PlayState.curStage)
					{
						case 'school'|'schoolEvil'|'schoolb'|'schoolEvilb'|'schoolb3'|'schoolEvilb3':
							FlxG.sound.play(Paths.sound('shocker-pixel'), _variables.svolume/100);
						default:
							FlxG.sound.play(Paths.sound('shocker'), _variables.svolume/100);
					}
				}
			});

		portrait.frames = Paths.getSparrowAtlas('portraits/$curCharacter');
		portrait.visible = true;

		if (portrait.width < 256)
		{
			portrait.setGraphicSize(Std.int(portrait.width * 6));
			portrait.antialiasing = false;
		}
		else
			portrait.antialiasing = true;

		portrait.updateHitbox();

		if (curFlip == 'true')
			portrait.flipX = true;
		else
			portrait.flipX = false;	

		if (curCharacter != oldCharacter)
		{
			portrait.alpha = 0;

			new FlxTimer().start(fadeInTime, function(tmr:FlxTimer)
				{
					portrait.alpha += 1 / fadeInLoop;
				}, fadeInLoop);

			if (curFlip == 'true')
				portrait.x = 280 - portrait.width;
			else
				portrait.x = 1000;

			portrait.y = 441 - portrait.height;
		}

		if (curBox != oldBox)
		{
			remove(box);
			box = new FlxSprite(-20, 45);

			box.frames = Paths.getSparrowAtlas('dialogueBoxes/$curBox');
			box.animation.addByPrefix('open', 'open', 24, false);
			box.animation.addByPrefix('normal', 'normal', 24, true);

			dialogueOpened = false;
			box.animation.play('open');
			box.setGraphicSize(Std.int(FlxG.width * 0.9));
			box.updateHitbox();
			add(box);

			box.screenCenter(X);
			box.y = 710 - box.height;

			#if desktop
			var data:String = File.getContent(Paths.json('dialogueBoxes/'+curBox));
            _dialogue = Json.parse(data);
			#end

			box.y += _dialogue.addY;
		}

		if (_dialogue.canFlip)
			box.flipX = portrait.flipX;

		portrait.animation.addByPrefix(curEmotion, curEmotion, 24, false);
		portrait.animation.play(curEmotion);

		dropText.font = swagDialogue.font = curFont;
		dropText.size = swagDialogue.size = Std.parseInt(curFontScale);

		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogueSounds/$curSound'), 0.6*_variables.svolume/100)];

		dropText.color = FlxColor.fromString(shadowColor);
		swagDialogue.color = FlxColor.fromString(dialogueColor);

		if (portraitColor != '')
			portrait.color = FlxColor.fromString(portraitColor);

		if (timeCut > 0)
		{
			new FlxTimer().start(Std.parseFloat(curSpeed)*timeCut, function(tmr:FlxTimer)
				{
					dialogueList.remove(dialogueList[0]);
					FlxG.sound.play(Paths.sound('dialogueClicks/$clickSound'), 0.8* _variables.svolume/100);
					startDialogue();
				}, 1);
		}

		swagDialogue.start(Std.parseFloat(curSpeed), true);
	}

	function cleanDialog():Void
	{
		splitData = dialogueList[0].split(":");
		oldCharacter = curCharacter;
		curCharacter = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("!");
		curEmotion = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("[");
		curFont = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("]");
		curFontScale = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("*");
		curVolume = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("=");
		curShake = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("+");
		curShakeTime = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("-");
		curShakeDelay = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split('<');
		curFlashTime = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split(">");
		curFlashDelay = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split(";");
		curSpeed = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("|");
		curFlip = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("#");
		oldBox = curBox;
		curBox = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("^");
		curSound = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("!");
		dialogueColor = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("?");
		shadowColor = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split(".");
		portraitColor = splitData[1];
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();

		splitData = dialogueList[0].split("~");
		timeCut = Std.parseInt(splitData[1]);
		dialogueList[0] = dialogueList[0].substr(splitData[1].length + 2).trim();
	}
}
