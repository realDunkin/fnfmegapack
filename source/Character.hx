package;

import flixel.animation.FlxAnimationController;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;
import ModifierVariables._modifiers;
import MainVariables._variables;

using StringTools;

class Character extends FlxSprite
{
	public var dadVar:Float = 4;
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var powerup:Bool = false;

	public var altAnim:String = "";

	public var exSpikes:FlxSprite;

	public var daZoom:Float = 1;

	public var ignoreidle:Bool = false;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;

		antialiasing = _variables.antialiasing;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'mario':
				tex = Paths.getSparrowAtlas('mario/mario_assets');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
				animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24, false);

			if (isPlayer)
			{
				addOffset('idle');
				addOffset("singUP", 11, 27);
				addOffset("singRIGHT", -53, 6);
				addOffset("singLEFT", 74, -8);
				addOffset("singDOWN", 77, -74);
				addOffset("singUPmiss", 16, 69);
				addOffset("singRIGHTmiss", -54, 52);
				addOffset("singLEFTmiss", 67, 32);
				addOffset("singDOWNmiss", 79, -30);
			}
			else
			{
				addOffset('idle');
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -68, -7);
				addOffset("singLEFT", 65, 9);
				addOffset("singDOWN", 200, -70);
				addOffset("singUPmiss", -19, 67);
				addOffset("singRIGHTmiss", -60, 41);
				addOffset("singLEFTmiss", 62, 64);
				addOffset("singDOWNmiss", 210, -28);
			}

				playAnim('idle');

				flipX = true;

			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', 0, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('characters/gfCar');
				frames = tex;
				animation.addByIndices('sad', 'GF Sad Hair Blowing CAR', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('sad', 0, -11);
				addOffset('danceRight', 0);

				playAnim('danceRight');

			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('characters/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByPrefix('sad', 'GF SAD', 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);
				addOffset('sad', 0, -2);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24, false);
				animation.addByPrefix('singUP', 'Dad Sing Note UP0', 24, false);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN0', 24, false);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			case 'spooky':
				tex = Paths.getSparrowAtlas('characters/spooky_kids_assets');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				addOffset('danceLeft');
				addOffset('danceRight');

				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);

				playAnim('danceRight');
			case 'mom':
				tex = Paths.getSparrowAtlas('characters/Mom_Assets');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');

			case 'mom-car':
				tex = Paths.getSparrowAtlas('characters/momCar');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');
			case 'monster':
				tex = Paths.getSparrowAtlas('characters/Monster_Assets');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);
				playAnim('idle');
			case 'monster-christmas':
				tex = Paths.getSparrowAtlas('characters/monsterChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');
			case 'pico':
				tex = Paths.getSparrowAtlas('characters/Pico_FNF_assetss');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				addOffset('idle');
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -68, -7);
				addOffset("singLEFT", 65, 9);
				addOffset("singDOWN", 200, -70);
				addOffset("singUPmiss", -19, 67);
				addOffset("singRIGHTmiss", -60, 41);
				addOffset("singLEFTmiss", 62, 64);
				addOffset("singDOWNmiss", 210, -28);

				playAnim('idle');

				flipX = true;

			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('worried', 'BF idle worried', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('frozen', 'BF frozen', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset('worried', -5, -4);
				addOffset('frozen', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('characters/bfChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('worried', 'BF idle worried', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('frozen', 'BF frozen', 24, false);

				addOffset('idle', -5);
				addOffset('worried', -5, -4);
				addOffset('frozen', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');
				if (_modifiers.FrightSwitch)
					{
						if (_modifiers.Fright >= 50 && _modifiers.Fright < 100)
							playAnim('scared');
						else if (_modifiers.Fright >= 100)
							playAnim('worried');
					}

				flipX = true;
			case 'bf-car':
				var tex = Paths.getSparrowAtlas('characters/bfCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('worried', 'BF idle worried', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('frozen', 'BF frozen', 24, false);

				addOffset('idle', -5);
				addOffset('worried', -5, -4);
				addOffset('frozen', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);

				playAnim('idle');
				if (_modifiers.FrightSwitch)
					{
						if (_modifiers.Fright >= 50 && _modifiers.Fright < 100)
							playAnim('scared');
						else if (_modifiers.Fright >= 100)
							playAnim('worried');
					}

				flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('worried', 'BF WORRIED', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);
				animation.addByPrefix('frozen', 'BF FROZEN', 24, false);
				animation.addByPrefix('scared', 'BF SHAKING', 24);

				addOffset('idle');
				addOffset('worried');
				addOffset('frozen');
				addOffset('scared');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');
				if (_modifiers.FrightSwitch)
					{
						if (_modifiers.Fright >= 50 && _modifiers.Fright < 100)
							playAnim('scared');
						else if (_modifiers.Fright >= 100)
							playAnim('worried');
					}

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'senpai':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				frames = Paths.getPackerAtlas('characters/spirit');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('characters/mom_dad_christmas_assets');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				addOffset('idle');
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);

				playAnim('idle');

			case 'gfTankmen':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/gfTankmen');
				frames = tex;
				animation.addByIndices('danceLeft', 'GF Dancing at Gunpoint', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing at Gunpoint', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByPrefix('sad', 'GF Crying at Gunpoint ', 24, false);
	
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);
				addOffset('sad', -2, -2);
	
				playAnim('danceRight');
			case 'tankman':
				tex = Paths.getSparrowAtlas('characters/tankmanCaptain');
				frames = tex;

				animation.addByPrefix('idle', 'Tankman Idle Dance instance', 24, false);
				animation.addByPrefix('singUP', 'Tankman UP note instance', 24, false);
				animation.addByPrefix('singDOWN', 'Tankman DOWN note instance', 24, false);
				animation.addByPrefix('singRIGHT', 'Tankman Note Left instance', 24, false);
				animation.addByPrefix('singLEFT', 'Tankman Right Note instance', 24, false);
				animation.addByPrefix('ugh', 'TANKMAN UGH instance', 15, false);
				animation.addByPrefix('good', 'PRETTY GOOD tankman instance', 24, false);
		
			if (isPlayer)
			{
				addOffset('idle');
				addOffset("ugh", -3, -10);
				addOffset("good", 111, 15);
				addOffset("singUP", 45, 50);
				addOffset("singLEFT", 94, -25);
				addOffset("singRIGHT", -14, -12);
				addOffset("singDOWN", 60, -110);
			}
			else
			{
				addOffset('idle');
				addOffset("ugh", -2, -8);
				addOffset("good", 1, 15);
				addOffset("singUP", 45, 50);
				addOffset("singLEFT", 90, -10);
				addOffset("singRIGHT", 0, -20);
				addOffset("singDOWN", 90, -100);
			}
		
				playAnim('idle');
				flipX = true;

			case 'picoasgf':
				var tex = Paths.getSparrowAtlas('characters/picoSpeaker');
				frames = tex;

				animation.addByIndices('idle', 'Pico shoot 1', [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24], "", 24, true);

				animation.addByIndices('shoot1', 'Pico shoot 1', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, true);
				animation.addByIndices('shoot2', 'Pico shoot 2', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByIndices('shoot3', 'Pico shoot 3', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByIndices('shoot4', 'Pico shoot 4', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				
				addOffset('shoot1', 0, 0);
				addOffset('shoot2', -1, -128);
				addOffset('shoot3', 412, -64);
				addOffset('shoot4', 439, -19);

				playAnim('shoot1');

			case 'bf-holding-gf':
				var tex = Paths.getSparrowAtlas('characters/bfgf');
				frames = tex;
				animation.addByPrefix('idle', 'BFgf idle dance w gf', 24, false);
				animation.addByPrefix('singUP', 'BFgf NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BFgf NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BFgf NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BFgf NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BFgf NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BFgf NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BFgf NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BFgf NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -49, 7);
				addOffset("singRIGHT", -48, 23);
				addOffset("singLEFT", 2, 4);
				addOffset("singDOWN", -20, -10);
				addOffset("singUPmiss", -39, 7);
				addOffset("singRIGHTmiss", -40, 31);
				addOffset("singLEFTmiss", 2, -6);
				addOffset("singDOWNmiss", -11, -19);
				

				playAnim('idle');

				flipX = true;

			case 'bf-holding-gf-dead':
				var tex = Paths.getSparrowAtlas('characters/bfgf-DEAD');
				frames = tex;
				animation.addByPrefix('firstDeath', "BF Dies with GF", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead with GF Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY confirm holding gf", 24, false);

				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				playAnim('firstDeath');
				flipX = true;
			case 'gfb':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/gfb_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GFb Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GFb left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GFb Right Note', 24, false);
				animation.addByPrefix('singUP', 'GFb Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GFb Down Note', 24, false);
				animation.addByIndices('sad', 'GFb sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GFb Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GFb Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GFb Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GFb Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GFb FEAR', 24);
	
				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);
	
				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);
	
				addOffset('scared', -2, -17);
	
				playAnim('danceRight');
			case 'bfb':
				var tex = Paths.getSparrowAtlas('characters/bfb_assets');
				frames = tex;
				animation.addByPrefix('idle', 'BFb idle dance', 24, false);
				animation.addByPrefix('singUP', 'BFb NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BFb NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BFb NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BFb NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BFb NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BFb NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BFb NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BFb NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BFb HEY', 24, false);
	
				animation.addByPrefix('firstDeath', "BFb dies", 24, false);
				animation.addByPrefix('deathLoop', "BFb Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BFb Dead confirm", 24, false);
	
				animation.addByPrefix('scared', 'BFb idle shaking', 24);
	
				if (isPlayer)
					{
						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -10, -50);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 21);
						addOffset("singLEFTmiss", 12, 24);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", 7, 4);
						addOffset('firstDeath', 37, 11);
						addOffset('deathLoop', 37, 5);
						addOffset('deathConfirm', 37, 69);
						addOffset('scared', -4);
					}
					else
					{
						addOffset('idle', -5, 0);
						addOffset("singUP", 2, 28);
						addOffset("singRIGHT", 42, -7);
						addOffset("singLEFT", -38, -6);
						addOffset("singDOWN", -30, -54);
						addOffset("singUPmiss", 1, 27);
						addOffset("singRIGHTmiss", 40, 21);
						addOffset("singLEFTmiss", -38, 12);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", -3, 4);
						addOffset('firstDeath', -3, -5);
						addOffset('deathLoop', -3, -5);
						addOffset('deathConfirm', -3, 62);
						addOffset('scared', -4, 0);
					}
	
				playAnim('idle');
	
				flipX = true;
			case 'dadb':
				// DAD ANIMATION LOADING CODE
				var tex = Paths.getSparrowAtlas('characters/dadb_assets');
				frames = tex;
				animation.addByPrefix('idle', 'Dadb idle dance', 24);
				animation.addByPrefix('singUP', 'Dadb Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dadb Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dadb Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dadb Sing Note LEFT', 24);
	
				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);
	
				playAnim('idle');
			case 'spookyb':
				tex = Paths.getSparrowAtlas('characters/spooky_b_assets');
				frames = tex;
				animation.addByPrefix('singUP', 'spookyb UP NOTE0', 24, false);
				animation.addByPrefix('singDOWN', 'spookyb DOWN note0', 24, false);
				animation.addByPrefix('singLEFT', 'spookyb sing left0', 24, false);
				animation.addByPrefix('singRIGHT', 'spookyb sing right0', 24, false);
				animation.addByIndices('danceLeft', 'spookyb dance idle0', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spookyb dance idle0', [8, 10, 12, 14], "", 12, false);

				addOffset('danceLeft');
				addOffset('danceRight');

				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);

				playAnim('danceRight');
			case 'picob':
				tex = Paths.getSparrowAtlas('characters/picob_assets');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
				animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24, false);

				if (isPlayer)
					{
						addOffset('idle');
						addOffset("singUP", 11, 27);
						addOffset("singRIGHT", -53, 6);
						addOffset("singLEFT", 74, -8);
						addOffset("singDOWN", 77, -74);
						addOffset("singUPmiss", 16, 69);
						addOffset("singRIGHTmiss", -54, 52);
						addOffset("singLEFTmiss", 67, 32);
						addOffset("singDOWNmiss", 79, -30);
					}
					else
					{
						addOffset('idle');
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -68, -7);
						addOffset("singLEFT", 65, 9);
						addOffset("singDOWN", 200, -70);
						addOffset("singUPmiss", -19, 67);
						addOffset("singRIGHTmiss", -60, 41);
						addOffset("singLEFTmiss", 62, 64);
						addOffset("singDOWNmiss", 210, -28);
					}

				playAnim('idle');

				flipX = true;
			case 'gfb-car':
				tex = Paths.getSparrowAtlas('characters/gfbCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
				false);
	
				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);
	
				playAnim('danceRight');
			case 'bfb-car':
				var tex = Paths.getSparrowAtlas('characters/bfbCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				if (isPlayer)
					{
						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -10, -50);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 21);
						addOffset("singLEFTmiss", 12, 24);
						addOffset("singDOWNmiss", -11, -19);
					}
					else
					{
						addOffset('idle', -5, 0);
						addOffset("singUP", 2, 28);
						addOffset("singRIGHT", 42, -7);
						addOffset("singLEFT", -38, -6);
						addOffset("singDOWN", -30, -54);
						addOffset("singUPmiss", 1, 27);
						addOffset("singRIGHTmiss", 40, 21);
						addOffset("singLEFTmiss", -38, 12);
						addOffset("singDOWNmiss", -11, -19);
					}
				playAnim('idle');

				flipX = true;
			case 'momb':
				tex = Paths.getSparrowAtlas('characters/Momb_Assets');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');
	
			case 'momb-car':
				tex = Paths.getSparrowAtlas('characters/mombCar');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');
			case 'gfb-christmas':
				tex = Paths.getSparrowAtlas('characters/gfbChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'bfb-christmas':
				var tex = Paths.getSparrowAtlas('characters/bfbChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;
			case 'parentsb-christmas':
				frames = Paths.getSparrowAtlas('characters/parentsb-christmas');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				addOffset('idle');
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);

				playAnim('idle');
			case 'monsterb-christmas':
				tex = Paths.getSparrowAtlas('characters/monsterbChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);
	
				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');
			case 'gfb-pixel':
				tex = Paths.getSparrowAtlas('characters/gfbPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
	
				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);
	
				playAnim('danceRight');
	
				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;
			case 'bfb-pixel':
				frames = Paths.getSparrowAtlas('characters/bfbPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bfb-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfbPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('firstDeath');

				antialiasing = false;
				flipX = true;
			case 'senpaib':
				frames = Paths.getSparrowAtlas('characters/senpaib');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpaib-angry':
				frames = Paths.getSparrowAtlas('characters/senpaib');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'spiritb':
				frames = Paths.getPackerAtlas('characters/spiritb');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;
			case 'gfb3':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('gfb3_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'gfb3-christmas':
				tex = Paths.getSparrowAtlas('gfb3Christmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				playAnim('danceRight');
			case 'gfb3-car':
				tex = Paths.getSparrowAtlas('gfb3Car');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
				false);
	
				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);
	
				playAnim('danceRight');
			case 'gfb3-pixel':
				tex = Paths.getSparrowAtlas('gfb3Pixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
	
				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);
	
				playAnim('danceRight');
	
				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;
			
			case 'bfb3':
				var tex = Paths.getSparrowAtlas('bfb3_assets');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				if (isPlayer)
					{
						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -10, -50);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 21);
						addOffset("singLEFTmiss", 12, 24);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", 7, 4);
						addOffset('firstDeath', 37, 11);
						addOffset('deathLoop', 37, 5);
						addOffset('deathConfirm', 37, 69);
						addOffset('scared', -4);
					}
					else
					{
						addOffset('idle', -5, 0);
						addOffset("singUP", 2, 28);
						addOffset("singRIGHT", 42, -7);
						addOffset("singLEFT", -38, -6);
						addOffset("singDOWN", -30, -54);
						addOffset("singUPmiss", 1, 27);
						addOffset("singRIGHTmiss", 40, 21);
						addOffset("singLEFTmiss", -38, 12);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", -3, 4);
						addOffset('firstDeath', -3, -5);
						addOffset('deathLoop', -3, -5);
						addOffset('deathConfirm', -3, 62);
						addOffset('scared', -4, 0);
					}

				playAnim('idle');

				flipX = true;
			case 'bfb3-christmas':
				var tex = Paths.getSparrowAtlas('bfb3Christmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);

				playAnim('idle');

				flipX = true;
			case 'bfb3-car':
				var tex = Paths.getSparrowAtlas('bfb3Car');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
	
				if (isPlayer)
					{
						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -10, -50);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 21);
						addOffset("singLEFTmiss", 12, 24);
						addOffset("singDOWNmiss", -11, -19);
					}
					else
					{
						addOffset('idle', -5, 0);
						addOffset("singUP", 2, 28);
						addOffset("singRIGHT", 42, -7);
						addOffset("singLEFT", -38, -6);
						addOffset("singDOWN", -30, -54);
						addOffset("singUPmiss", 1, 27);
						addOffset("singRIGHTmiss", 40, 21);
						addOffset("singLEFTmiss", -38, 12);
						addOffset("singDOWNmiss", -11, -19);
					}
				playAnim('idle');
	
				flipX = true;
			case 'bfb3-pixel':
				frames = Paths.getSparrowAtlas('bfb3Pixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bfb3-pixel-dead':
				frames = Paths.getSparrowAtlas('bfb3PixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');
	
				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;
			case 'dadb3':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('dadb3-assets');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);
	
				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);
	
				playAnim('idle');
			case 'spookyb3':
				tex = Paths.getSparrowAtlas('spookyb3_assets');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);
	
				addOffset('danceLeft');
				addOffset('danceRight');
	
				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);
	
				playAnim('danceRight');
			case 'picob3':
				tex = Paths.getSparrowAtlas('picob3_assets');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
				animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24, false);

				if (isPlayer)
					{
						addOffset('idle');
						addOffset("singUP", 11, 27);
						addOffset("singRIGHT", -53, 6);
						addOffset("singLEFT", 74, -8);
						addOffset("singDOWN", 77, -74);
						addOffset("singUPmiss", 16, 69);
						addOffset("singRIGHTmiss", -54, 52);
						addOffset("singLEFTmiss", 67, 32);
						addOffset("singDOWNmiss", 79, -30);
					}
					else
					{
						addOffset('idle');
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -68, -7);
						addOffset("singLEFT", 65, 9);
						addOffset("singDOWN", 200, -70);
						addOffset("singUPmiss", -19, 67);
						addOffset("singRIGHTmiss", -60, 41);
						addOffset("singLEFTmiss", 62, 64);
						addOffset("singDOWNmiss", 210, -28);
					}

				playAnim('idle');

				flipX = true;
			case 'momb3-car':
				tex = Paths.getSparrowAtlas('momb3Car');
				frames = tex;
	
				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);
	
				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);
	
				playAnim('idle');
			case 'parentsb3-christmas':
				frames = Paths.getSparrowAtlas('parentsb3-christmas');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);
	
				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);
	
				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);
	
				addOffset('idle');
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);
	
				playAnim('idle');
			case 'monsterb3-christmas':
				tex = Paths.getSparrowAtlas('monsterb3Christmas');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');
			case 'senpaib3':
				frames = Paths.getSparrowAtlas('senpaib3');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpaib3-angry':
				frames = Paths.getSparrowAtlas('senpaib3');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'spiritb3':
				frames = Paths.getPackerAtlas('spiritb3');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;
			case 'gfneo':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('gfneo');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'gfneo-car':
				tex = Paths.getSparrowAtlas('gfneoCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');
			case 'bfneo':
				var tex = Paths.getSparrowAtlas('bfneo');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				if (isPlayer)
				{
					addOffset('idle', -5);
					addOffset("singUP", -29, 27);
					addOffset("singRIGHT", -38, -7);
					addOffset("singLEFT", 12, -6);
					addOffset("singDOWN", -10, -50);
					addOffset("singUPmiss", -29, 27);
					addOffset("singRIGHTmiss", -30, 21);
					addOffset("singLEFTmiss", 12, 24);
					addOffset("singDOWNmiss", -11, -19);
					addOffset("hey", 7, 4);
					addOffset('firstDeath', 37, 11);
					addOffset('deathLoop', 37, 5);
					addOffset('deathConfirm', 37, 69);
					addOffset('scared', -4);
				}
				else
				{
					addOffset('idle', -5, 0);
					addOffset("singUP", 2, 28);
					addOffset("singRIGHT", 42, -7);
					addOffset("singLEFT", -38, -6);
					addOffset("singDOWN", -30, -54);
					addOffset("singUPmiss", 1, 27);
					addOffset("singRIGHTmiss", 40, 21);
					addOffset("singLEFTmiss", -38, 12);
					addOffset("singDOWNmiss", -11, -19);
					addOffset("hey", -3, 4);
					addOffset('firstDeath', -3, -5);
					addOffset('deathLoop', -3, -5);
					addOffset('deathConfirm', -3, 62);
					addOffset('scared', -4, 0);
				}

				playAnim('idle');

				flipX = true;
			case 'bfneo-car':
				var tex = Paths.getSparrowAtlas('bfneoCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				if (isPlayer)
					{
						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -10, -50);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 21);
						addOffset("singLEFTmiss", 12, 24);
						addOffset("singDOWNmiss", -11, -19);
					}
					else
					{
						addOffset('idle', -5, 0);
						addOffset("singUP", 2, 28);
						addOffset("singRIGHT", 42, -7);
						addOffset("singLEFT", -38, -6);
						addOffset("singDOWN", -30, -54);
						addOffset("singUPmiss", 1, 27);
						addOffset("singRIGHTmiss", 40, 21);
						addOffset("singLEFTmiss", -38, 12);
						addOffset("singDOWNmiss", -11, -19);
					}
				playAnim('idle');

				flipX = true;
			case 'dadneo':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('dadneo');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			case 'spookyneo':
				tex = Paths.getSparrowAtlas('spookyneo');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				addOffset('danceLeft');
				addOffset('danceRight');

				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);

				playAnim('danceRight');
			case 'piconeo':
				tex = Paths.getSparrowAtlas('piconeo');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
				animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24, false);

				if (isPlayer)
					{
						addOffset('idle');
						addOffset("singUP", 11, 27);
						addOffset("singRIGHT", -53, 6);
						addOffset("singLEFT", 74, -8);
						addOffset("singDOWN", 77, -74);
						addOffset("singUPmiss", 16, 69);
						addOffset("singRIGHTmiss", -54, 52);
						addOffset("singLEFTmiss", 67, 32);
						addOffset("singDOWNmiss", 79, -30);
					}
					else
					{
						addOffset('idle');
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -68, -7);
						addOffset("singLEFT", 65, 9);
						addOffset("singDOWN", 200, -70);
						addOffset("singUPmiss", -19, 67);
						addOffset("singRIGHTmiss", -60, 41);
						addOffset("singLEFTmiss", 62, 64);
						addOffset("singDOWNmiss", 210, -28);
					}

				playAnim('idle');

				flipX = true;
			case 'momneo-car':
				tex = Paths.getSparrowAtlas('momneoCar');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');
			case 'gfwhitty':
				tex = Paths.getSparrowAtlas('characters/gfwhitty');
				frames = tex;
				animation.addByPrefix('danceLeft', 'Idle Left', 24, false);
				animation.addByPrefix('danceRight', 'Idle Right', 24, false);
				animation.addByPrefix('sad', 'Sad', 24);
				animation.addByPrefix('scared', 'Scared', 24);

				addOffset('danceLeft', -150, -160);
				addOffset('danceRight', -150, -160);
				addOffset('sad', -150, -160);
				addOffset('scared', -150, -160);

				playAnim('danceRight');
			case 'gfwhittyscared':
				tex = Paths.getSparrowAtlas('characters/gfwhitty');
				frames = tex;
				animation.addByPrefix('idle', 'Scared', 24, true);

				addOffset('idle', -150, -260);

				playAnim('idle');
			case 'whitty':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/whitty');
				frames = tex;

				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Sing Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
				animation.addByPrefix('singDOWN', 'Sing Down', 24, false);
				animation.addByPrefix('singLEFT', 'Sing Left', 24, false);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			case 'whittycrazy':
				tex = Paths.getSparrowAtlas('characters/whittycrazy');
				frames = tex;

				animation.addByPrefix('idle', 'Whitty idle dance', 24, false);
				animation.addByPrefix('singUP', 'Whitty Sing Note UP', 24, false);
				animation.addByPrefix('singRIGHT', 'whitty sing note right', 24, false);
				animation.addByPrefix('singDOWN', 'Whitty Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Whitty Sing Note LEFT', 24, false);

			if (isPlayer)
			{	
				addOffset('idle', 150, 0);
				addOffset("singUP", 160, 100);
				addOffset("singRIGHT", 170, 20);
				addOffset("singLEFT", 262, -80);
				addOffset("singDOWN", 154, -136);
			}
			else
			{
				addOffset('idle', 150, 0);
				addOffset("singUP", 160, 100);
				addOffset("singRIGHT", 310, -90);
				addOffset("singLEFT", 222, 20);
				addOffset("singDOWN", 324, -136);
			}

				playAnim('idle');
			case 'nomongus':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/nomogus');
				frames = tex;

				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Sing Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
				animation.addByPrefix('singDOWN', 'Sing Down', 24, false);
				animation.addByPrefix('singLEFT', 'Sing Left', 24, false);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			case 'bfmongus':
				var tex = Paths.getSparrowAtlas('characters/bluemogus');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				if (isPlayer)
					{
						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -10, -50);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 21);
						addOffset("singLEFTmiss", 12, 24);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", 7, 4);
						addOffset('firstDeath', 37, 11);
						addOffset('deathLoop', 37, 5);
						addOffset('deathConfirm', 37, 69);
						addOffset('scared', -4);
					}
					else
					{
						addOffset('idle', -5, 0);
						addOffset("singUP", 2, 28);
						addOffset("singRIGHT", 42, -7);
						addOffset("singLEFT", -38, -6);
						addOffset("singDOWN", -30, -54);
						addOffset("singUPmiss", 1, 27);
						addOffset("singRIGHTmiss", 40, 21);
						addOffset("singLEFTmiss", -38, 12);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", -3, 4);
						addOffset('firstDeath', -3, -5);
						addOffset('deathLoop', -3, -5);
						addOffset('deathConfirm', -3, 62);
						addOffset('scared', -4, 0);
					}

				flipX = true;
			case 'gfsunset':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assetssunset');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'gfnight':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assetsnight');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'gfglitcher':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assetsglitcher');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'bfsunset':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIENDsunset');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				if (isPlayer)
					{
						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -10, -50);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 21);
						addOffset("singLEFTmiss", 12, 24);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", 7, 4);
						addOffset('firstDeath', 37, 11);
						addOffset('deathLoop', 37, 5);
						addOffset('deathConfirm', 37, 69);
						addOffset('scared', -4);
					}
					else
					{
						addOffset('idle', -5, 0);
						addOffset("singUP", 2, 28);
						addOffset("singRIGHT", 42, -7);
						addOffset("singLEFT", -38, -6);
						addOffset("singDOWN", -30, -54);
						addOffset("singUPmiss", 1, 27);
						addOffset("singRIGHTmiss", 40, 21);
						addOffset("singLEFTmiss", -38, 12);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", -3, 4);
						addOffset('firstDeath', -3, -5);
						addOffset('deathLoop', -3, -5);
						addOffset('deathConfirm', -3, 62);
						addOffset('scared', -4, 0);
					}

				playAnim('idle');

				flipX = true;
			case 'bfnight':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIENDnight');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				if (isPlayer)
					{
						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -10, -50);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 21);
						addOffset("singLEFTmiss", 12, 24);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", 7, 4);
						addOffset('firstDeath', 37, 11);
						addOffset('deathLoop', 37, 5);
						addOffset('deathConfirm', 37, 69);
						addOffset('scared', -4);
					}
					else
					{
						addOffset('idle', -5, 0);
						addOffset("singUP", 2, 28);
						addOffset("singRIGHT", 42, -7);
						addOffset("singLEFT", -38, -6);
						addOffset("singDOWN", -30, -54);
						addOffset("singUPmiss", 1, 27);
						addOffset("singRIGHTmiss", 40, 21);
						addOffset("singLEFTmiss", -38, 12);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", -3, 4);
						addOffset('firstDeath', -3, -5);
						addOffset('deathLoop', -3, -5);
						addOffset('deathConfirm', -3, 62);
						addOffset('scared', -4, 0);
					}

				playAnim('idle');

				flipX = true;
			case 'bfglitcher':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIENDglitcher');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				if (isPlayer)
					{
						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -10, -50);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 21);
						addOffset("singLEFTmiss", 12, 24);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", 7, 4);
						addOffset('firstDeath', 37, 11);
						addOffset('deathLoop', 37, 5);
						addOffset('deathConfirm', 37, 69);
						addOffset('scared', -4);
					}
					else
					{
						addOffset('idle', -5, 0);
						addOffset("singUP", 2, 28);
						addOffset("singRIGHT", 42, -7);
						addOffset("singLEFT", -38, -6);
						addOffset("singDOWN", -30, -54);
						addOffset("singUPmiss", 1, 27);
						addOffset("singRIGHTmiss", 40, 21);
						addOffset("singLEFTmiss", -38, 12);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", -3, 4);
						addOffset('firstDeath', -3, -5);
						addOffset('deathLoop', -3, -5);
						addOffset('deathConfirm', -3, 62);
						addOffset('scared', -4, 0);
					}

				playAnim('idle');

				flipX = true;
			case 'bfwire':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIENDwire');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				if (isPlayer)
					{
						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -10, -50);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 21);
						addOffset("singLEFTmiss", 12, 24);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", 7, 4);
						addOffset('firstDeath', 37, 11);
						addOffset('deathLoop', 37, 5);
						addOffset('deathConfirm', 37, 69);
						addOffset('scared', -4);
					}
					else
					{
						addOffset('idle', -5, 0);
						addOffset("singUP", 2, 28);
						addOffset("singRIGHT", 42, -7);
						addOffset("singLEFT", -38, -6);
						addOffset("singDOWN", -30, -54);
						addOffset("singUPmiss", 1, 27);
						addOffset("singRIGHTmiss", 40, 21);
						addOffset("singLEFTmiss", -38, 12);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", -3, 4);
						addOffset('firstDeath', -3, -5);
						addOffset('deathLoop', -3, -5);
						addOffset('deathConfirm', -3, 62);
						addOffset('scared', -4, 0);
					}

				playAnim('idle');

				flipX = true;
			case 'hex':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/hex');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'hexsunset':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/hexsunset');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'hexnight':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/hexnight');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			case 'hexVirus':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/Hex_Virus');
				frames = tex;
				animation.addByPrefix('idle', 'Hex crazy idle', 24);
				animation.addByPrefix('singUP', 'Hex crazy up', 24);
				animation.addByPrefix('singRIGHT', 'Hex crazy right', 24);
				animation.addByPrefix('singDOWN', 'Hex crazy down', 24);
				animation.addByPrefix('singLEFT', 'Hex crazy left', 24);

				addOffset('idle', 0, 40);
				addOffset("singUP", -4, 145);
				addOffset("singRIGHT", 0, 17);
				addOffset("singLEFT", 140, 100);
				addOffset("singDOWN", 22, -20);

				playAnim('idle');
			case 'hexViruswire':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/Hex_Viruswire');
				frames = tex;
				animation.addByPrefix('idle', 'Hex crazy idle', 24);
				animation.addByPrefix('singUP', 'Hex crazy up', 24);
				animation.addByPrefix('singRIGHT', 'Hex crazy right', 24);
				animation.addByPrefix('singDOWN', 'Hex crazy down', 24);
				animation.addByPrefix('singLEFT', 'Hex crazy left', 24);

				addOffset('idle', 0, 40);
				addOffset("singUP", -4, 145);
				addOffset("singRIGHT", 0, 17);
				addOffset("singLEFT", 140, 100);
				addOffset("singDOWN", 22, -20);

				playAnim('idle');

			case 'shaggy':
				tex = Paths.getSparrowAtlas('characters/shaggy');
				frames = tex;
				animation.addByPrefix('idle', 'shaggy_idle', 24);
				animation.addByPrefix('idle2', 'shaggy_idle2', 24);
				animation.addByPrefix('singUP', 'shaggy_up', 20);
				animation.addByPrefix('singRIGHT', 'shaggy_right', 20);
				animation.addByPrefix('singDOWN', 'shaggy_down', 24);
				animation.addByPrefix('singLEFT', 'shaggy_left', 24);
				animation.addByPrefix('catch', 'shaggy_catch', 30);
				animation.addByPrefix('hold', 'shaggy_hold', 30);
				animation.addByPrefix('h_half', 'shaggy_h_half', 30);
				animation.addByPrefix('fall', 'shaggy_fall', 30);
				animation.addByPrefix('kneel', 'shaggy_half_ground', 30);

				animation.addByPrefix('power', 'shaggy_powerup', 30);
				animation.addByPrefix('idle_s', 'shaggy_super_idle', 24);
				animation.addByPrefix('singUP_s', 'shaggy_sup2', 20);
				animation.addByPrefix('singRIGHT_s', 'shaggy_sright', 20);
				animation.addByPrefix('singDOWN_s', 'shaggy_sdown', 24);
				animation.addByPrefix('singLEFT_s', 'shaggy_sleft', 24);

				addOffset('idle');
				addOffset('idle2');
				addOffset("singUP", -6, 0);
				addOffset("singRIGHT", -20, -40);
				addOffset("singLEFT", 100, -120);
				addOffset("singDOWN", 0, -170);
				addOffset("catch", 140, 90);
				addOffset("hold", 90, 100);
				addOffset("h_half", 90, 0);
				addOffset("fall", 130, 0);
				addOffset("kneel", 110, -123);

				addOffset('idle_s');
				addOffset('power', 10, 0);
				addOffset("singUP_s", -6, 0);
				addOffset("singRIGHT_s", -20, -40);
				addOffset("singLEFT_s", 100, -120);
				addOffset("singDOWN_s", 0, -170);

				playAnim('idle');
				updateHitbox();
				
			case 'scooby':
				tex = Paths.getSparrowAtlas('characters/scooby');
				frames = tex;
				animation.addByPrefix('walk', 'scoob_walk', 30, false);
				animation.addByPrefix('idle', 'scoob_idle', 30, false);
				animation.addByPrefix('scare', 'scoob_scare', 24, false);
				animation.addByPrefix('blur', 'scoob_blur', 30, false);
				animation.addByPrefix('half', 'scoob_half', 30, false);
				animation.addByPrefix('fall', 'scoob_fall', 30, false);

				addOffset("walk", 100, 60);
				addOffset("idle");
				addOffset("scare", 40);
				addOffset("blur");
				addOffset("half");
				addOffset("fall", 420, 0);

				playAnim('walk', true);

			case 'pshaggy':
				tex = Paths.getSparrowAtlas('characters/pshaggy');
				frames = tex;
				animation.addByPrefix('idle', 'pshaggy_idle', 7, false);
				animation.addByPrefix('singUP', 'pshaggy_up', 28, false);
				animation.addByPrefix('singDOWN', 'pshaggy_down', 28, false);
				animation.addByPrefix('singLEFT', 'pshaggy_left', 28, false);
				animation.addByPrefix('singRIGHT', 'pshaggy_right', 28, false);
				animation.addByPrefix('back', 'pshaggy_back', 28, false);
				animation.addByPrefix('snap', 'pshaggy_snap', 7, false);
				animation.addByPrefix('snapped', 'pshaggy_did_snap', 28, false);
				animation.addByPrefix('smile', 'pshaggy_smile', 7, false);
				animation.addByPrefix('stand', 'pshaggy_stand', 7, false);

				addOffset("idle");
				addOffset("smile");
				var sOff = 20;
				addOffset("back", 0, -20 + sOff);
				addOffset("stand", 0, -20 + sOff);
				addOffset("snap", 10, 72 + sOff);
				addOffset("snapped", 0, 60 + sOff);
				addOffset("singUP", -6, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 10, 0);
				addOffset("singDOWN", 60, -100);

				playAnim('idle', true);
			case 'gf-mii':
				tex = Paths.getSparrowAtlas('characters/GF_MII_assets');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				playAnim('danceRight');
			case 'gfFC':
				tex = Paths.getSparrowAtlas('gfmiirounds/gf_FC');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -2, 35);
				addOffset('danceLeft', 0, 28);
				addOffset('danceRight', 0, 28);

				playAnim('danceRight');
				
			case 'gfDM':
				tex = Paths.getSparrowAtlas('gfmiirounds/gf_DM');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -2, 35);
				addOffset('danceLeft', 0, 28);
				addOffset('danceRight', 0, 28);

				playAnim('danceRight');
				
			case 'gfWU':
				tex = Paths.getSparrowAtlas('gfmiirounds/gf_WU');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -2, 35);
				addOffset('danceLeft', 0, 28);
				addOffset('danceRight', 0, 28);

				playAnim('danceRight');
				
			case 'gfKH':
				tex = Paths.getSparrowAtlas('gfmiirounds/gf_KH');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -2, 35);
				addOffset('danceLeft', 0, 28);
				addOffset('danceRight', 0, 28);

				playAnim('danceRight');
			case 'bfmii':
				tex = Paths.getSparrowAtlas('characters/BOYFRIENDMII');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
	
				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
	
				playAnim('idle');
	
				flipX = true;
			case 'bf-mii-dead':
				tex = Paths.getSparrowAtlas('characters/bfmiiDEAD');
				frames = tex;
				animation.addByPrefix('singUP', "BF MII Dies", 24, false);	
				animation.addByPrefix('firstDeath', "BF MII Dies", 24, false);
				animation.addByPrefix('deathLoop', "BF DEAD LOOP", 24, true);
				animation.addByPrefix('deathConfirm', "BF MII CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				playAnim('firstDeath');
				
				flipX = true;
			case 'matt':
				tex = Paths.getSparrowAtlas('characters/matt_assets');
				frames = tex;
				animation.addByPrefix('idle', "matt idle", 24);
				animation.addByPrefix('singUP', 'matt up note', 24, false);
				animation.addByPrefix('singDOWN', 'matt down note', 24, false);
				animation.addByPrefix('singLEFT', 'matt left note', 24, false);
				animation.addByPrefix('singRIGHT', 'matt right note', 24, false);
				addOffset("singUP", 0, 20);
				addOffset("singRIGHT", -15, -20);
				addOffset("singLEFT", 30, -40);
				addOffset("singDOWN", 0, -20);
				playAnim('idle');

			case 'mattmad':
				tex = Paths.getSparrowAtlas('characters/mattangry');
				frames = tex;
				animation.addByPrefix('idle', "matt idle", 24);
				animation.addByPrefix('singUP', 'matt up note', 24, false);
				animation.addByPrefix('singDOWN', 'matt down note', 24, false);
				animation.addByPrefix('singLEFT', 'matt left note', 24, false);
				animation.addByPrefix('singRIGHT', 'matt right note', 24, false);
				addOffset("singUP", 0, 10);
				addOffset("singRIGHT", -15, -20);
				addOffset("singLEFT", 30, -40);
				addOffset("singDOWN", 0, -20);
				playAnim('idle');
			case 'mattbox':
				tex = Paths.getSparrowAtlas('matt_box');
				frames = tex;
				
				animation.addByPrefix('idle', "Matt BoxIdle", 24);
				animation.addByPrefix('singUP', 'Matt BoxUp', 24, false);
				animation.addByPrefix('singDOWN', 'Matt BoxDown', 24, false);
				animation.addByPrefix('singLEFT', 'Matt BoxLeft', 24, false);
				animation.addByPrefix('singRIGHT', 'Matt BoxRight', 24, false);
				
				addOffset("singUP", 0, 20);
				addOffset("singRIGHT", -4, 0);
				addOffset("singLEFT", 2, -1);
				addOffset("singDOWN", -7, 3);
				playAnim('idle');

			case 'mattchill':
				tex = Paths.getSparrowAtlas('matt_chill');
				frames = tex;
				
				animation.addByPrefix('idle', "Matt ChillIdle", 24);
				animation.addByPrefix('singUP', 'Matt ChillUp', 24, false);
				animation.addByPrefix('singDOWN', 'Matt ChillDown', 24, false);
				animation.addByPrefix('singLEFT', 'Matt ChillLeft', 24, false);
				animation.addByPrefix('singRIGHT', 'Matt ChillRight', 24, false);
				animation.addByPrefix('snap', 'Matt ChillSnap', 24, false);
				
				addOffset("singUP", -9, 11);
				addOffset("singRIGHT", 16, -22);
				addOffset("singLEFT", -30, -24);
				addOffset("singDOWN", 15, -40);
				addOffset("snap", 0, -1);
				playAnim('idle');
				
			case 'matttko':
				tex = Paths.getSparrowAtlas('matt_tko');
				frames = tex;
				
				animation.addByPrefix('idle', "Mart ChillIdle", 24);
				animation.addByPrefix('singUP', 'Mart ChillUp', 24, false);
				animation.addByPrefix('singDOWN', 'Mart ChillDown', 24, false);
				animation.addByPrefix('singLEFT', 'Mart ChillLeft', 24, false);
				animation.addByPrefix('singRIGHT', 'Mart ChillRight', 24, false);
				
				addOffset("singUP", -9, 11);
				addOffset("singRIGHT", 16, -22);
				addOffset("singLEFT", -30, -24);
				addOffset("singDOWN", 15, -40);
				playAnim('idle');

			case 'mart':
				tex = Paths.getSparrowAtlas('mart_fartsetts');
				frames = tex;
				
				animation.addByPrefix('idle', "mart idle", 24);
				animation.addByPrefix('singUP', 'mart up', 24, false);
				animation.addByPrefix('singDOWN', 'mart down', 24, false);
				animation.addByPrefix('singLEFT', 'mart left', 24, false);
				animation.addByPrefix('singRIGHT', 'mart right', 24, false);
				animation.addByPrefix('troll', 'mart troll', 24, false);
				
				addOffset("singUP", -3, 27);
				addOffset("singRIGHT", -51, 1);
				addOffset("singLEFT", 22, 1);
				addOffset("singDOWN", -14, -36);
				addOffset("troll", -3, 27);

				playAnim('idle');
			case 'garcello':
				// GARCELLO ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('garcello_assets');
				frames = tex;
				animation.addByPrefix('idle', 'garcello idle dance', 24);
				animation.addByPrefix('singUP', 'garcello Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'garcello Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'garcello Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'garcello Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);

				playAnim('idle');

			case 'garcellotired':
				// GARCELLO TIRED ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('garcellotired_assets');
				frames = tex;
				animation.addByPrefix('idle', 'garcellotired idle dance', 24, false);
				animation.addByPrefix('singUP', 'garcellotired Sing Note UP', 24, false);
				animation.addByPrefix('singRIGHT', 'garcellotired Sing Note RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'garcellotired Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'garcellotired Sing Note LEFT', 24, false);

				animation.addByPrefix('singUP-alt', 'garcellotired Sing Note UP', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'garcellotired Sing Note RIGHT', 24, false);
				animation.addByPrefix('singLEFT-alt', 'garcellotired Sing Note LEFT', 24, false);
				animation.addByPrefix('singDOWN-alt', 'garcellotired cough', 24, false);

				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);
				addOffset("singUP-alt", 0, 0);
				addOffset("singRIGHT-alt", 0, 0);
				addOffset("singLEFT-alt", 0, 0);
				addOffset("singDOWN-alt", 0, 0);

				playAnim('idle');

			case 'garcellodead':
				// GARCELLO DEAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('garcellodead_assets');
				frames = tex;
				animation.addByPrefix('idle', 'garcello idle dance', 24);
				animation.addByPrefix('singUP', 'garcello Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'garcello Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'garcello Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'garcello Sing Note LEFT', 24);

				animation.addByPrefix('garTightBars', 'garcello coolguy', 15);

				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);
				addOffset("garTightBars", 0, 0);

				playAnim('idle');

			case 'garcelloghosty':
				// GARCELLO DEAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('garcelloghosty_assets');
				frames = tex;
				animation.addByPrefix('idle', 'garcello idle dance', 24);
				animation.addByPrefix('singUP', 'garcello Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'garcello Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'garcello Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'garcello Sing Note LEFT', 24);

				animation.addByPrefix('garFarewell', 'garcello coolguy', 15);

				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);
				addOffset("garTightBars", 0, 0);

				playAnim('idle');
			case 'gf-tabi':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('tabi/GF_TABI');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
				
			case 'gf-tabi-crazy':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('tabi/mad/PostExpGF_Assets');
				frames = tex;
				animation.addByIndices('danceLeft', 'GF LayedDownHurt ', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByIndices('danceRight', 'GF LayedDownHurt ', [8, 9, 10, 11, 12, 13, 14, 15], "", 24, false);
		
				addOffset('danceLeft', -300, -250);
				addOffset('danceRight', -300, -250);

				playAnim('danceRight');
			case 'bf-tabi':
				var tex = Paths.getSparrowAtlas('tabi/BOYFRIEND_TABI');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			case 'bf-knife':
				frames = Paths.getSparrowAtlas('tabi/mad/BF_Knife_death');
				animation.addByPrefix('idle', "BF dies", 24, false);
				animation.addByPrefix('singUP', "BF dies", 24, false);
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				
				addOffset("singUP", -29, 27);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 11);
				addOffset('idle', 37, 11);

				playAnim('idle');

				flipX = true;
			case 'tabi':
				frames = Paths.getSparrowAtlas('tabi/TABI');
				animation.addByPrefix('idle', 'Dad idle dance', 24, false);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24, false);

				addOffset('idle');

				addOffset("singUP", 44, 50);
				addOffset("singRIGHT", -15, 11);
				addOffset("singLEFT", 104, -28);
				addOffset("singDOWN", -5, -108);

				playAnim('idle');
			case 'bf-tabi-crazy':
				var tex = Paths.getSparrowAtlas('tabi/mad/BF_post_exp');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			case 'tabi-crazy':
				frames = Paths.getSparrowAtlas('tabi/mad/MadTabi');
				animation.addByPrefix('idle', 'MadTabiIdle', 24, false);
				animation.addByPrefix('singUP', 'MadTabiUp', 24, false);
				animation.addByPrefix('singDOWN', 'MadTabiDown', 24, false);
				animation.addByPrefix('singLEFT', 'MadTabiLeft', 24, false);
				animation.addByPrefix('singRIGHT', 'MadTabiRight', 24, false);

				addOffset('idle');

				addOffset("singUP", 59, 156);
				addOffset("singRIGHT", -15, -19);
				addOffset("singLEFT", 184, -5);
				addOffset("singDOWN", -5, -30);

				playAnim('idle');
			case 'gf-hell':
				tex = Paths.getSparrowAtlas('hellclwn/GF/gf_phase_3');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'gf-tied':
				tex = Paths.getSparrowAtlas('fourth/EX Tricky GF');
				frames = tex;

				trace(frames.frames.length);

				animation.addByIndices('danceLeft','GF Ex Tricky',[0,1,2,3,4,5,6,7,8], "", 24, false);
				animation.addByIndices('danceRight','GF Ex Tricky',[9,10,11,12,13,14,15,16,17,18,19], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				trace(animation.curAnim);
			case 'bf-hell':
				var tex = Paths.getSparrowAtlas('hellclwn/BF/BF_3rd_phase');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				animation.addByPrefix('stunned', 'BF hit', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);

				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			case 'tricky':
				tex = Paths.getSparrowAtlas('tricky');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24); 
				
				addOffset("idle", 0, -75);
				addOffset("singUP", 93, -76);
				addOffset("singRIGHT", 16, -176);
				addOffset("singLEFT", 103, -72);
				addOffset("singDOWN", 6, -84);

				playAnim('idle');
				
			case 'trickyH':
				tex = Paths.getSparrowAtlas('hellclwn/Tricky/smol');
				frames = tex;

				setGraphicSize(Std.int(width * 4));
				updateHitbox();
				animation.addByPrefix('idle', 'Phase 3 Tricky Idle', 24);
				animation.addByPrefix('singUP', 'Proper Up', 24);
				animation.addByPrefix('singRIGHT', 'Proper Right', 24);
				animation.addByPrefix('singLEFT', 'Proper Left', 24); 
				animation.addByPrefix('singDOWN', 'Proper Down', 24);
				
				addOffset("idle", 325, 0);
				addOffset("singUP", 575, -450);
				addOffset("singRIGHT",485, -300);
				addOffset("singLEFT", 516, 25);
				addOffset("singDOWN", 475, -450);

				updateHitbox();
				playAnim('idle');

			case 'trickyMask':
				tex = Paths.getSparrowAtlas('TrickyMask');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24); 
				
				addOffset("idle", 0, -117);
				addOffset("singUP", 93, -100);
				addOffset("singRIGHT", 16, -164);
				addOffset("singLEFT", 194, -95);
				addOffset("singDOWN", 32, -168);

				playAnim('idle');
			case 'bf-signDeath':
				frames = Paths.getSparrowAtlas('signDeath');
				animation.addByPrefix('firstDeath', 'BF dies', 24, false);
				animation.addByPrefix('deathLoop', 'BF Dead Loop', 24, true);
				animation.addByPrefix('deathConfirm', 'BF Dead confirm', 24, false);
				animation.play('firstDeath');
				
				addOffset('firstDeath');
				addOffset('deathLoop');
				addOffset('deathConfirm', 0, 40);
				

				updateHitbox();
				antialiasing = false;
				flipX = true;

				playAnim('firstDeath');
			case 'exTricky':
				frames = Paths.getSparrowAtlas('fourth/EXTRICKY');
				setGraphicSize(Std.int(width * 2));
				updateHitbox();

				exSpikes = new FlxSprite(x - 350,y - 170);
				exSpikes.frames = Paths.getSparrowAtlas('fourth/FloorSpikes');
				exSpikes.visible = false;
				exSpikes.setGraphicSize(Std.int(exSpikes.width * 2));
				exSpikes.updateHitbox();

				exSpikes.animation.addByPrefix('spike','Floor Spikes', 24, false);

				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('Hank', 'Hank', 24, true);

				addOffset('idle');
				addOffset('Hank');
				addOffset("singUP", 0, 100);
				addOffset("singRIGHT", -209,-29);
				addOffset("singLEFT",127,20);
				addOffset("singDOWN",-100,-340);

				playAnim('idle');

			case 'gf-sus':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GFsus_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);
				animation.addByPrefix('dead', 'gf DIES', 24, false);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
				
			case 'ghost-gf':
				tex = Paths.getSparrowAtlas('characters/ghost-gf');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, true);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'bf-sus':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND-sus');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('scaredamong', 'bf among scared', 24, false);
				animation.addByPrefix('deadamong', 'bf among die', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);
				addOffset('scaredamong', 60, 0);
				addOffset('deadamong', 118, 17);

				playAnim('idle');

				flipX = true;
			case 'bfghost':
				var tex = Paths.getSparrowAtlas('characters/bfghost');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'impostor':
				// Water Vapor#0180 dm him and ask for a special surprise
				tex = Paths.getSparrowAtlas('characters/impostor');
				frames = tex;
				animation.addByPrefix('idle', 'impostor idle', 12);
				animation.addByPrefix('singUP', 'impostor up', 12);
				animation.addByPrefix('singRIGHT', 'impostor right', 12);
				animation.addByPrefix('singDOWN', 'impostor down', 12);
				animation.addByPrefix('singLEFT', 'impostor left', 12);
				animation.addByPrefix('shoot1', 'impostor shoot 1', 24);
				animation.addByPrefix('shoot2', 'impostor shoot 2', 24);

				addOffset('idle');
				addOffset("singUP", -84, 0);
				addOffset("singRIGHT", -61, -20);
				addOffset("singLEFT", 91, -12);
				addOffset("singDOWN", -36, -65);
				addOffset("shoot1", -54, 75);
				addOffset("shoot2", -27, 124);

				playAnim('idle');

			case 'impostor2':
				// Water Vapor#0180 is the impostor
				tex = Paths.getSparrowAtlas('characters/impostor2');
				frames = tex;
				animation.addByPrefix('idle', 'impostor idle', 12);
				animation.addByPrefix('singUP', 'impostor up', 12);
				animation.addByPrefix('singRIGHT', 'impostor right', 12);
				animation.addByPrefix('singDOWN', 'impostor down', 12);
				animation.addByPrefix('singLEFT', 'impostor left', 12);

				addOffset('idle');
				addOffset("singUP", -84, 0);
				addOffset("singRIGHT", -61, -20);
				addOffset("singLEFT", 91, -12);
				addOffset("singDOWN", -36, -65);

				playAnim('idle');
			case 'gf-studio':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_NoSpeaker');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -18, -15);
				addOffset('danceLeft', 0, 0);
				addOffset('danceRight', 0, 0);

				playAnim('danceRight');
			case 'cyrix':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('Cyrix');
				frames = tex;
				animation.addByPrefix('idle', 'cyrix idle', 24);
				animation.addByPrefix('singUP', 'cyrix up note', 24);
				animation.addByPrefix('singRIGHT', 'cyrix right note', 24);
				animation.addByPrefix('singDOWN', 'cyrix down note', 24);
				animation.addByPrefix('singLEFT', 'cyrix left note', 24);
	
				addOffset('idle', 0, -3);
				addOffset("singUP", 8, -1);
				addOffset("singRIGHT", 14, -26);
				addOffset("singLEFT", -10, -11);
				addOffset("singDOWN", 0, -43);
	
				playAnim('idle');

				this.scale.x = 0.85;
				this.scale.y = 0.85;
			case 'cyrix-nervous':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('Cyrix_Nervous');
				frames = tex;

				animation.addByPrefix('idle', 'nevcyrix idle', 24);
				animation.addByPrefix('singUP', 'nevcyrix up note', 24);
				animation.addByPrefix('singRIGHT', 'nevcyrix right note', 24);
				animation.addByPrefix('singDOWN', 'nevcyrix down note', 24);
				animation.addByPrefix('singLEFT', 'nevcyrix left note', 24);
		
				addOffset('idle', 0, -3);
				addOffset("singUP", 8, -1);
				addOffset("singRIGHT", 14, -26);
				addOffset("singLEFT", -10, -11);
				addOffset("singDOWN", 0, -43);
		
				playAnim('idle');
	
				this.scale.x = 0.85;
				this.scale.y = 0.85;
			case 'cyrix-crazy':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('Cyrix_Crazy');
				frames = tex;
	
				animation.addByPrefix('idle', 'crazycyrix idle', 24);
				animation.addByPrefix('singUP', 'crazycyrix up note', 24);
				animation.addByPrefix('singRIGHT', 'crazycyrix right note', 24);
				animation.addByPrefix('singDOWN', 'crazycyrix down note', 24);
				animation.addByPrefix('singLEFT', 'crazycyrix left note', 24);
			
				addOffset('idle', 0, -94);
				addOffset("singUP", 0, -1);
				addOffset("singRIGHT", 0, -56);
				addOffset("singLEFT", 0, -30);
				addOffset("singDOWN", 0, -43);
			
				playAnim('idle');
		
				this.scale.x = 0.85;
				this.scale.y = 0.85;
			case 'zardy':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('Zardy');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Sing Up', 24, false);
				animation.addByPrefix('singLEFT', 'Sing Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
				animation.addByPrefix('singDOWN', 'Sing Down', 24, false);

				addOffset('idle');
				addOffset("singUP", -80, -3);
				addOffset("singRIGHT", -60, 10);
				addOffset("singLEFT", 120, 25);
				addOffset("singDOWN", -51, 0);

				playAnim('idle');
			case 'zardyb':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('Zardybside');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Sing Up', 24, false);
				animation.addByPrefix('singLEFT', 'Sing Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
				animation.addByPrefix('singDOWN', 'Sing Down', 24, false);

				addOffset('idle');
				addOffset("singUP", -80, -3);
				addOffset("singRIGHT", -60, 10);
				addOffset("singLEFT", 120, 25);
				addOffset("singDOWN", -51, 0);

				playAnim('idle');
			case 'gf-kapi':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GFkapi_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'bf-kapi':
				var tex = Paths.getSparrowAtlas('BOYFRIENDkapi');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			case 'kapi':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('Kapi');
				frames = tex;
				animation.addByIndices('idle', 'Dad idle dance', [2, 4, 6, 8, 10, 0], "", 12, false);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);
				animation.addByPrefix('meow', 'Dad meow', 24, false);
				animation.addByPrefix('stare', 'Dad stare', 24, false);
				
				addOffset('idle');
				
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				addOffset("stare");
				addOffset("meow");
				playAnim('idle');
			case 'kapimad':
				// DADMAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('KAPI_ANGRY');
				frames = tex;
				animation.addByIndices('idle', 'Dad idle dance', [2, 4, 6, 8, 10, 0], "", 12, false);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);
				animation.addByPrefix('meow', 'Dad meow', 24, false);

				
				addOffset('idle');
				
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				addOffset("meow");
				playAnim('idle');
			case 'gameandwatch':
				tex = Paths.getSparrowAtlas('gameandwatch');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByPrefix('idle', 'spooky dance idle', 24, false);

				addOffset('idle');

				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);

				playAnim('idle');
			case 'miku':
				tex = Paths.getSparrowAtlas('concert/ev_miku_assets');
				frames = tex;
				animation.addByPrefix('idle', 'Miku idle dance', 24);
				animation.addByPrefix('singUP', 'Miku Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Miku Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Miku Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Miku Sing Note LEFT', 24);

				
				addOffset('idle');				
				addOffset("singUP", 15, 50);
				addOffset("singRIGHT", -18, 26);
				addOffset("singLEFT", 29, 8);
				addOffset("singDOWN", -15, -37);

				playAnim('idle');
			case 'miku-mad':
				tex = Paths.getSparrowAtlas('concert/ev_miku_mad');
				frames = tex;
				animation.addByPrefix('idle', 'Miku idle dance', 24);
				animation.addByPrefix('singUP', 'Miku Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Miku Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Miku Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Miku Sing Note LEFT', 24);
				animation.addByPrefix('singUP-alt', 'Miku Scream Sing Note UP', 24);
				animation.addByPrefix('singRIGHT-alt', 'Miku Scream Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN-alt', 'Miku Scream Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT-alt', 'Miku Scream Sing Note LEFT', 24);

				
				addOffset('idle');				
				addOffset("singUP", 0, 3);
				addOffset("singRIGHT", -24, 1);
				addOffset("singLEFT", 37, 1);
				addOffset("singDOWN", 8, -1);
				addOffset("singUP-alt", 9, 1);
				addOffset("singRIGHT-alt", -24, 1);
				addOffset("singLEFT-alt", 39, 2);
				addOffset("singDOWN-alt", 10, 0);

				playAnim('idle');
			case 'agoti':
				tex = Paths.getSparrowAtlas('AGOTI');
				frames = tex;
				animation.addByPrefix('idle', 'Agoti_Idle', 24);
				animation.addByPrefix('singUP', 'Agoti_Up', 24);
				animation.addByPrefix('singRIGHT', 'Agoti_Right', 24);
				animation.addByPrefix('singDOWN', 'Agoti_Down', 24);
				animation.addByPrefix('singLEFT', 'Agoti_Left', 24);

				addOffset('idle', 0, 140);
				addOffset("singUP", 90, 220);
				addOffset("singRIGHT", 130, 90);
				addOffset("singLEFT", 240, 170);
				addOffset("singDOWN", 70, -50);

				playAnim('idle');

			case 'agoti-micless':
				tex = Paths.getSparrowAtlas('Alt_Agoti_Sprites_B');
				frames = tex;
				animation.addByPrefix('idle', 'Angry_Agoti_Idle', 24);
				animation.addByPrefix('singUP', 'Angry_Agoti_Up', 24);
				animation.addByPrefix('singRIGHT', 'Angry_Agoti_Right', 24);
				animation.addByPrefix('singDOWN', 'Angry_Agoti_Down', 24);
				animation.addByPrefix('singLEFT', 'Angry_Agoti_Left', 24);

				addOffset('idle', 0, 0);
				addOffset("singUP", 100, 140);
				addOffset("singRIGHT", 80, -20);
				addOffset("singLEFT", 170, -60);
				addOffset("singDOWN", 90, -130);

				playAnim('idle');

			case 'gf-rocks':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'itsumi':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('gfItsumi');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'salty':
				var tex = Paths.getSparrowAtlas('bfsalty');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			case 'dadexe':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('dadexe');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			case 'ghostngirl':
				tex = Paths.getSparrowAtlas('ghostngirl');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				addOffset('danceLeft');
				addOffset('danceRight');

				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);

				playAnim('danceRight');
			case 'opheebop':
				tex = Paths.getSparrowAtlas('opheebop');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);
				playAnim('idle');
			case 'connor':
				tex = Paths.getSparrowAtlas('picoconnor');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
				animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);

				addOffset('idle');
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -68, -7);
				addOffset("singLEFT", 65, 9);
				addOffset("singDOWN", 200, -70);

				playAnim('idle');

				flipX = true;
			case 'salty-car':
				var tex = Paths.getSparrowAtlas('saltyCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;
			case 'itsumi-car':
				tex = Paths.getSparrowAtlas('itsumiCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');
			case 'momexe-car':
				tex = Paths.getSparrowAtlas('momexeCar');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');
			case 'the-manager':
				frames = Paths.getSparrowAtlas('themanager');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				addOffset('idle');
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);

				playAnim('idle');
			case 'salty-christmas':
				var tex = Paths.getSparrowAtlas('saltyChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;
			case 'itsumi-christmas':
				tex = Paths.getSparrowAtlas('itsumiChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'opheebop-christmas':
				tex = Paths.getSparrowAtlas('opheebopChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');
			case 'itsumi-pixel':
				tex = Paths.getSparrowAtlas('itsumiPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'salty-pixel':
				frames = Paths.getSparrowAtlas('saltyPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'glitch':
				frames = Paths.getSparrowAtlas('glitch');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));

				antialiasing = false;
			case 'glitchy':
				frames = Paths.getSparrowAtlas('glitch');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));

				antialiasing = false;

			case 'glitchhead':
				frames = Paths.getPackerAtlas('glitchhead');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;
			case 'gf-crucified':
				tex = Paths.getSparrowAtlas('gf');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF idle', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF idle', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');
			case 'sky':
				frames = Paths.getSparrowAtlas('sky_assets');
				animation.addByIndices('danceRight', 'sky idle', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByIndices('danceLeft', 'sky idle', [8, 9, 10, 11, 12, 13, 14, 15], "", 24, false);
				animation.addByPrefix('singUP', 'sky up', 24, false);
				animation.addByPrefix('singDOWN', 'sky down', 24, false);
				animation.addByPrefix('singLEFT', 'sky left', 24, false);
				animation.addByPrefix('singRIGHT', 'sky right', 24, false);
				
				addOffset('danceRight');
				addOffset('danceLeft');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				
				playAnim('danceRight');
				
			case 'sky-annoyed':
				frames = Paths.getSparrowAtlas('sky_annoyed_assets');
				animation.addByIndices('danceRight', 'sky annoyed idle', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByIndices('danceLeft', 'sky annoyed idle', [8, 9, 10, 11, 12, 13, 14, 15], "", 24, false);
				animation.addByPrefix('singUP', 'sky annoyed up', 24, false);
				animation.addByPrefix('singDOWN', 'sky annoyed down', 24, false);
				animation.addByPrefix('singLEFT', 'sky annoyed left', 24, false);
				animation.addByPrefix('singRIGHT', 'sky annoyed right', 24, false);
				
				animation.addByPrefix('oh', 'sky annoyed oh', 24, true);
				animation.addByPrefix('grr', 'sky annoyed grr', 24, true);
				animation.addByPrefix('huh', 'sky annoyed huh', 24, true);
				animation.addByPrefix('ugh', 'sky annoyed ugh', 24, false);
				animation.addByPrefix('manifest', 'sky annoyed manifest', 24, false);
				
				animation.addByIndices('danceRight-alt', 'sky annoyed alt idle', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByIndices('danceLeft-alt', 'sky annoyed alt idle', [8, 9, 10, 11, 12, 13, 14, 15], "", 24, false);
				animation.addByPrefix('singUP-alt', 'sky annoyed alt up', 24, false);
				animation.addByPrefix('singDOWN-alt', 'sky annoyed alt down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'sky annoyed alt left', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'sky annoyed alt right', 24, false);
				
				addOffset('danceRight');
				addOffset('danceLeft');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				
				addOffset("oh");
				addOffset("grr");
				addOffset("huh");
				addOffset("ugh");
				addOffset("manifest");
				
				addOffset('danceRight-alt');
				addOffset('danceLeft-alt');
				addOffset("singUP-alt");
				addOffset("singRIGHT-alt");
				addOffset("singLEFT-alt");
				addOffset("singDOWN-alt");
				
				
				playAnim('danceRight');
				
			case 'sky-mad':
				frames = Paths.getSparrowAtlas('sky_mad_assets');
				animation.addByIndices('danceRight', 'sky mad idle', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByIndices('danceLeft', 'sky mad idle', [8, 9, 10, 11, 12, 13, 14, 15], "", 24, false);
				animation.addByPrefix('singUP', 'sky mad up', 24, false);
				animation.addByPrefix('singDOWN', 'sky mad down', 24, false);
				animation.addByPrefix('singLEFT', 'sky mad left', 24, false);
				animation.addByPrefix('singRIGHT', 'sky mad right', 24, false);
				
				animation.addByIndices('danceRight-alt', 'sky mad idle', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByIndices('danceLeft-alt', 'sky mad idle', [8, 9, 10, 11, 12, 13, 14, 15], "", 24, false);
				animation.addByPrefix('singUP-alt', 'sky mad up', 24, false);
				animation.addByPrefix('singDOWN-alt', 'sky mad down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'sky mad left', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'sky mad right', 24, false);
				
				addOffset('danceRight-alt');
				addOffset('danceLeft-alt');
				addOffset("singUP-alt");
				addOffset("singRIGHT-alt");
				addOffset("singLEFT-alt");
				addOffset("singDOWN-alt");
				
				addOffset('danceRight');
				addOffset('danceLeft');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				
				playAnim('danceRight');

			case 'shaggyred':
			// DAD ANIMATION LOADING CODE
			tex = Paths.getSparrowAtlas('shaggyred');
			if (Main.god) tex = Paths.getSparrowAtlas('god_shaggy');

			frames = tex;
			animation.addByPrefix('idle', 'shaggy_idle', 24);
			animation.addByPrefix('idle2', 'shaggy_idle2', 24);
			animation.addByPrefix('singUP', 'shaggy_up', 20);
			animation.addByPrefix('singRIGHT', 'shaggy_right', 20);
			animation.addByPrefix('singDOWN', 'shaggy_down', 24);
			animation.addByPrefix('singLEFT', 'shaggy_left', 24);
			animation.addByPrefix('catch', 'shaggy_catch', 30);
			animation.addByPrefix('hold', 'shaggy_hold', 30);
			animation.addByPrefix('h_half', 'shaggy_h_half', 30);
			animation.addByPrefix('fall', 'shaggy_fall', 30);
			animation.addByPrefix('kneel', 'shaggy_half_ground', 30);

			animation.addByPrefix('power', 'shaggy_powerup', 30);
			animation.addByPrefix('idle_s', 'shaggy_super_idle', 24);
			animation.addByPrefix('singUP_s', 'shaggy_sup2', 20);
			animation.addByPrefix('singRIGHT_s', 'shaggy_sright', 20);
			animation.addByPrefix('singDOWN_s', 'shaggy_sdown', 24);
			animation.addByPrefix('singLEFT_s', 'shaggy_sleft', 24);

			addOffset('idle');
			addOffset('idle2');
			addOffset("singUP", -6, 0);
			addOffset("singRIGHT", -20, -40);
			addOffset("singLEFT", 100, -120);
			addOffset("singDOWN", 0, -170);
			addOffset("catch", 140, 90);
			addOffset("hold", 90, 100);
			addOffset("h_half", 90, 0);
			addOffset("fall", 130, 0);
			addOffset("kneel", 110, -123);

			addOffset('idle_s');
			addOffset('power', 10, 0);
			addOffset("singUP_s", -6, 0);
			addOffset("singRIGHT_s", -20, -40);
			addOffset("singLEFT_s", 100, -120);
			addOffset("singDOWN_s", 0, -170);

			if (Main.god)
			{
				animation.addByPrefix('idle', 'shaggy_idle', 60);
				animation.addByPrefix('idle2', 'shaggy_idle2', 60);
			}

			playAnim('idle');
			updateHitbox();

			case 'mattblue':
			{
				tex = Paths.getSparrowAtlas('mattblue');
				if (Main.god) tex = Paths.getSparrowAtlas('god_matt');

				frames = tex;

				animation.addByPrefix('idle', "matt idle", 20, false);
				animation.addByPrefix('singUP', "matt up note", 24, false);
				animation.addByPrefix('singDOWN', "matt down note", 24, false);
				animation.addByPrefix('singLEFT', 'matt left note', 24, false);
				animation.addByPrefix('singRIGHT', 'matt right note', 24, false);

				animation.addByPrefix('singUPmiss', "miss up", 24, false);
				animation.addByPrefix('singDOWNmiss', "miss down", 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss right', 24, false);

				addOffset('idle');
				addOffset("singUP", -41, 21);
				addOffset("singRIGHT", -10, -14);
				addOffset("singLEFT", 63, -24);
				addOffset("singDOWN", -62, -19);

				if (isPlayer)
				{
					addOffset("singUP", -21, 21);
					addOffset("singRIGHT", -40, -14);
					addOffset("singLEFT", 63, -24);
					addOffset("singDOWN", -30, -19);
				}
				addOffset("singUPmiss", -21, 21);
				addOffset("singRIGHTmiss", -40, -14);
				addOffset("singLEFTmiss", 63, -24);
				addOffset("singDOWNmiss", -15, -28);

				if (Main.god)
				{
					addOffset("singUP", -105, 136);
					addOffset("singRIGHT", -133, -51);
					addOffset("singLEFT", 86, -23);
					addOffset("singDOWN", -111, 8);
				}

				playAnim('idle');
			}
			case 'matt-lost':
			{
				frames = Paths.getSparrowAtlas('matt_lost');
				animation.addByPrefix('idle', "matt lose retry", 24, false);
				animation.addByPrefix('firstDeath', "matt lose prev", 24, false);
				animation.addByPrefix('deathLoop', "matt lose idle", 24, true);
				animation.addByPrefix('deathConfirm', "matt lose retry", 24, false);

				addOffset('firstDeath', -5, -3);
				addOffset('deathLoop', 0, 10);
				addOffset('deathConfirm', 0, 20);
				playAnim('firstDeath');
				// pixel bullshit
				//setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = true;
				//flipX = true;
			}
			case 'bob':
				frames = Paths.getSparrowAtlas('characters/bob_assets');
				animation.addByPrefix('idle', 'BOB idle dance', 24, false);
				animation.addByPrefix('singUP', 'BOB Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'BOB Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'BOB Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'BOB Sing Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP", -36, 57);
				addOffset("singRIGHT", -62, 32);
				addOffset("singLEFT",31, 13);
				addOffset("singDOWN", -31, -10);

				playAnim('idle');
			case 'bosip':
				frames = Paths.getSparrowAtlas('characters/bosip_assets');
				animation.addByPrefix('idle', 'Bosip idle dance', 24, false);
				animation.addByPrefix('singUP', 'Bosip Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Bosip Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Bosip Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Bosip Sing Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP", 23, 24);
				addOffset("singRIGHT", -6, -18);
				addOffset("singLEFT", 64, 7);
				addOffset("singDOWN", 22, -18);

				playAnim('idle');
			case 'amor':
				frames = Paths.getSparrowAtlas('characters/amor_assets');
				animation.addByPrefix('idle', 'Amor idle dance', 24, false);
				animation.addByPrefix('singUP', 'Amor Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Amor Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Amor Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Amor Sing Note RIGHT', 24, false);
				animation.addByPrefix('drop', 'Amor drop', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 41);
				addOffset("singRIGHT", -11, 2);
				addOffset("singLEFT", 25, 1);
				addOffset("singDOWN", -23, -16);
				addOffset("drop", 42, 156);

				playAnim('idle');
			case 'bf-night':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIENDnightbobandbosip');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			case 'bf-ex':
				var tex = Paths.getSparrowAtlas('characters/BoyFriend_Assets_EX');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			case 'bf-night-ex':
				var tex = Paths.getSparrowAtlas('characters/BoyFriend_Assets_EX_night');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			case 'pc':
				frames = Paths.getSparrowAtlas('characters/pc');
				animation.addByPrefix('idle', 'PC idle', 24, false);
				animation.addByPrefix('singUP', 'PC Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'PC Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'PC Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'PC Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('idle');
			case 'bobex':
				frames = Paths.getSparrowAtlas('characters/bobEX');
				animation.addByPrefix('idle', 'BOB idle dance', 24, false);
				animation.addByPrefix('singUP', 'BOB Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'BOB Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'BOB Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'BOB Sing Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP", 114, 47);
				addOffset("singRIGHT", 78, -38);
				addOffset("singLEFT", 90, -14);
				addOffset("singDOWN", 19, -75);

				playAnim('idle');
			case 'bosipex':
				frames = Paths.getSparrowAtlas('characters/bosipex');
				animation.addByPrefix('idle', 'Bosip idle dance', 24, false);
				animation.addByPrefix('singUP', 'Bosip Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Bosip Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Bosip Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Bosip Sing Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP", 3, 50);
				addOffset("singRIGHT", -16, -13);
				addOffset("singLEFT", 66, 1);
				addOffset("singDOWN", 52, -63);

				playAnim('idle');
			case 'amorex':
				frames = Paths.getSparrowAtlas('characters/amorex');
				animation.addByPrefix('idle', 'amor idle big0', 24, false);
				animation.addByPrefix('singUP', 'amor up big', 24, false);
				animation.addByPrefix('singDOWN', 'amor down big', 24, false);
				animation.addByPrefix('singLEFT', 'amor left big', 24, false);
				animation.addByPrefix('singRIGHT', 'amor right big', 24, false);
				animation.addByPrefix('drop', 'amor fucking dies', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 41);
				addOffset("singRIGHT", -11, 2);
				addOffset("singLEFT", 24, 2);
				addOffset("singDOWN", -23, -22);
				addOffset("drop", 138, 94);

				playAnim('idle');
			case 'gf-bosip':
				tex = Paths.getSparrowAtlas('characters/Bosip_gf');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);
				addOffset('sad', 0);

				playAnim('danceRight');
			case 'gf-bob':
				tex = Paths.getSparrowAtlas('characters/Bob_gf');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);
				addOffset('sad', 0);

				playAnim('danceRight');
			case 'gf-nightbobandbosip':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GFbobandbosipnight_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'gf-ex':
				tex = Paths.getSparrowAtlas('characters/GF_ass_sets_outfit');
				frames = tex;
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByPrefix('alright', 'GF Alright', 24, false);
				animation.addByPrefix('spin', 'GF go for a spin', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);
				addOffset('spin', 0, -8);
				addOffset('alright', 0, -6);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);

				playAnim('danceRight');		
			case 'gf-night-ex':
				tex = Paths.getSparrowAtlas('characters/GF_ass_sets_outfit_with_bb');
				frames = tex;
				animation.addByIndices('sad', 'GF Dancing Beat EX instance 1', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat EX instance 1', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat EX instance 1', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);
				addOffset('sad', 0);

				playAnim('danceRight');	
			case 'bluskys':
				frames = Paths.getSparrowAtlas('characters/Bluskys');
				animation.addByPrefix('idle', 'Bluskys idle dance', 24, false);
				animation.addByPrefix('singUP', 'Bluskys Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Bluskys Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Bluskys Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Bluskys Sing Note RIGHT', 24, false);
				animation.addByPrefix('drop', 'Bluskys Letsgo', 24, false);

				addOffset('idle');
				addOffset("singUP", -30, 36);
				addOffset("singRIGHT", -64, -13);
				addOffset("singLEFT",-30, -12);
				addOffset("singDOWN", -35, -23);
				addOffset("drop", 55, 84);

				playAnim('idle');	
			case 'ash':
				frames = Paths.getSparrowAtlas('characters/ASH');
				animation.addByIndices('danceLeft', 'ASH idle dance', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], '', 24, false);
				animation.addByIndices('danceRight', 'ASH idle dance', [13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25], '', 24, false);
				animation.addByIndices('danceRightStatic', 'ASH idle dance', [0], '', 0, false);
				animation.addByPrefix('singUP', 'ASH Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'ASH Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'ASH Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'ASH Sing Note RIGHT', 24, false);

				addOffset('danceLeft');
				addOffset('danceRight');
				
				addOffset("singUP", 93, 41);
				addOffset("singRIGHT", -74, -23);
				addOffset("singLEFT", 122, -74);
				addOffset("singDOWN", -35, -93);

				playAnim('danceRight');
			case 'minishoey':
				frames = Paths.getSparrowAtlas('characters/Minishoey');
				animation.addByPrefix('idle', 'Minishoey idle dance', 24, false);
				animation.addByPrefix('singUP', 'Minishoey Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Minishoey Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Minishoey Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Minishoey Sing Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP", 16, 15);
				addOffset("singRIGHT", -27, 6);
				addOffset("singLEFT", 6, 4);
				addOffset("singDOWN", -18, -12);

				playAnim('idle');
			case 'jghost':
				frames = Paths.getSparrowAtlas('characters/Jghost');
				animation.addByPrefix('idle', 'Jghost idle dance', 24, false);
				animation.addByPrefix('singUP', 'Jghost Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Jghost Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Jghost Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Jghost Sing Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP", 54, 37);
				addOffset("singRIGHT", -22, -8);
				addOffset("singLEFT",301, -10);
				addOffset("singDOWN", -36, -55);

				playAnim('idle');

			case 'cerberus':
				frames = Paths.getSparrowAtlas('characters/Cerberus');
				animation.addByPrefix('idle', 'Cerberus idle dance', 24, false);
				animation.addByPrefix('singUP', 'Cerberus Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Cerberus Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Cerberus Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Cerberus Sing Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP", -27, 4);
				addOffset("singRIGHT", 6, -12);
				addOffset("singLEFT",-25, -12);
				addOffset("singDOWN", -24, -11);

				playAnim('idle');
			case 'cerbera':
				frames = Paths.getSparrowAtlas('characters/Cerb');
				animation.addByPrefix('idle', 'Cerb idle dance', 24, false);
				animation.addByPrefix('singUP', 'Cerb Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Cerb Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Cerb Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Cerb Sing Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP", 18, 20);
				addOffset("singRIGHT", 5, -13);
				addOffset("singLEFT",13, 9);
				addOffset("singDOWN", -23, -32);

				playAnim('idle');
			case 'gf-ronsip':
				tex = Paths.getSparrowAtlas('characters/GF_ANDRONCOOLGUYONSPEAKEROHMYGODHEISSOCOOL');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);
				addOffset('sad', -559, -715);

				playAnim('danceRight');
			case 'gf-but-bosip':
				tex = Paths.getSparrowAtlas('characters/worriedbosip');
				frames = tex;
				animation.addByPrefix('idle', 'BOSIP Scared', 24, false);

				addOffset('idle', 0);

				setGraphicSize(Std.int(width * 0.92));
				playAnim('idle');
			case 'gloopy':
				tex = Paths.getSparrowAtlas('bob/bob_asset');
				frames = tex;
				animation.addByPrefix('idle', "bob_idle", 24, false);
				animation.addByPrefix('singUP', 'bob_UP', 24, false);
				animation.addByPrefix('singDOWN', 'bob_DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'bob_LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'bob_RIGHT', 24, false);

				addOffset('idle');

				flipX = true;
			case 'gloopybob':
				frames = Paths.getSparrowAtlas('characters/STUPID_GLOOP_MAN');
				animation.addByPrefix('idle', 'bob_idle', 24, false);
				animation.addByPrefix('singUP', 'bob_up', 24, false);
				animation.addByPrefix('singDOWN', 'bob_down', 24, false);
				animation.addByPrefix('singLEFT', 'bob_left', 24, false);
				animation.addByPrefix('singRIGHT', 'bob_right', 24, false);
				animation.addByPrefix('drop', 'bobismad', 24, true);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("drop", -96, -21);

				playAnim('idle');
			case 'bfanders':
				var tex = Paths.getSparrowAtlas('characters/bfanders');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'Dad idle dance', 24, false);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note LEFT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singUPmiss', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHTmiss', 'Dad Sing Note LEFT', 24);
				animation.addByPrefix('singDOWNmiss', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFTmiss', 'Dad Sing Note RIGHT', 24);

				addOffset('idle');
				addOffset("singUP", 8, 99);
				addOffset("singLEFT", 119, 34);
				addOffset("singRIGHT", 79, 12);
				addOffset("singDOWN", 14, -20);
				addOffset("singUPmiss", 8, 99);
				addOffset("singLEFTmiss", 119, 34);
				addOffset("singRIGHTmiss", 79, 12);
				addOffset("singDOWNmiss", 14, -20);

				playAnim('idle');
			case 'verb':
				frames = Paths.getSparrowAtlas('characters/verbalase');
				animation.addByPrefix('idle', 'idle', 24, true);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);

				addOffset('idle');
				addOffset("singUP", 120, 130);
				addOffset("singRIGHT", 127);
				addOffset("singLEFT", 138, -2);
				addOffset("singDOWN", 160);

				playAnim('idle');

				flipX = false;
			case 'abungus':
				frames = Paths.getSparrowAtlas('characters/abungus');
				animation.addByPrefix('idle', 'idle', 24, true);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('idle');

				flipX = false;
			case 'ronsip':
				frames = Paths.getSparrowAtlas('characters/ronsip_assets');
				animation.addByPrefix('idle', 'RON_IDLE', 24, false);
				animation.addByPrefix('singUP', 'RON_UP', 24, false);
				animation.addByPrefix('singDOWN', 'RON_DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'RON_LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'RON_RIGHT', 24, false);

				//addOffset("singDOWN", 160 -180);
				animOffsets['singDOWN'] = [160, -180];
				addOffset('idle');
				addOffset("singUP", -20, -50);
				addOffset("singRIGHT", -30, -50);
				addOffset("singLEFT", 600, 220);
				
				playAnim('idle');
			case 'worriedbob':
				frames = Paths.getSparrowAtlas('characters/Worriedbob');

				animation.addByPrefix('idle', 'BOB idle dance', 24, false);
				animation.addByPrefix('singUP', 'BOB Sing Note UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BOB Sing Note LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BOB Sing Note RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BOB Sing Note DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'Bob Miss up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Bob Miss left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Bob Miss right', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Bob Miss down', 24, false);

				animation.addByPrefix('firstDeath', "bob fucking dies0", 24, false);
				animation.addByPrefix('deathLoop', "bob fucking dies loop", 24, true);
				animation.addByPrefix('deathConfirm', "bob fucking dies confirm", 24, false);

				addOffset('idle');
				addOffset("singUP", 17, 26);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 94, 3);
				addOffset("singDOWN", -11, -61);
				addOffset("singUPmiss", 31, 24);
				addOffset("singRIGHTmiss", -40, -7);
				addOffset("singLEFTmiss", 102, -2);
				addOffset("singDOWNmiss", -7, -61);
				addOffset('firstDeath', 116, -60);
				addOffset('deathLoop', 115, -62);
				addOffset('deathConfirm', 115, -51);

				playAnim('idle');

				flipX = true;
			case 'deadron':
				frames = Paths.getSparrowAtlas('sunsetbobandbosip/happy/RON_dies_lmaoripbozo_packwatch');
				animation.addByIndices('idle', 'rip my boy ron', [57], '', 24, false);
				
				addOffset('idle');

				playAnim('idle');
			case 'angrygloopy':
				tex = Paths.getSparrowAtlas('bob/angrybob_asset');
				frames = tex;
				animation.addByPrefix('idle', "bob_idle", 24, false);
				animation.addByPrefix('singUP', 'bob_UP', 24, false);
				animation.addByPrefix('singDOWN', 'bob_DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'bob_RIGHT', 24, false);
				animation.addByPrefix('singRIGHT', 'bob_LEFT', 24, false);

				addOffset('idle');

				flipX = true;
			case 'hellgloopy':
				tex = Paths.getSparrowAtlas('bob/hellbob_assets');
				frames = tex;
				animation.addByPrefix('idle', "bobismad", 24);
				animation.addByPrefix('singUP', 'lol', 24, false);
				animation.addByPrefix('singDOWN', 'lol', 24, false);
				animation.addByPrefix('singUPmiss', 'lol', 24);
				animation.addByPrefix('singDOWNmiss', 'lol', 24);

				//addOffset('idle', 0, 27);

				playAnim('idle');

				flipX = true;
			case 'gloop-gloopy':
				tex = Paths.getSparrowAtlas('bob/oohscary');
				frames = tex;
				animation.addByPrefix('idle', "bob_idle", 24, false);
				animation.addByPrefix('singUP', 'bob_UP', 24, false);
				animation.addByPrefix('singDOWN', 'bob_DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'bob_LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'bob_RIGHT', 24, false);
				animation.addByPrefix('Transform', 'bob_transform', 24, false);

				addOffset('idle');

				flipX = false;
			case 'glitched-gloopy':
				tex = Paths.getSparrowAtlas('bob/ScaryBobAaaaah');
				frames = tex;
				animation.addByPrefix('idle', "idle???-", 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);

				addOffset('idle');
			case 'ron':
				tex = Paths.getSparrowAtlas('bob/ron');
				frames = tex;
				animation.addByPrefix('idle', "Idle", 24);
				animation.addByPrefix('singUP', 'Sing Up', 24, false);
				animation.addByPrefix('singDOWN', 'Sing Down', 24, false);
				animation.addByPrefix('singLEFT', 'Sing Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
				animation.addByPrefix('cheer', 'Ugh', 24, false);
				addOffset('idle');
				addOffset("singUP", 42, 38);
				addOffset("singLEFT", 98, -27);
				addOffset("singRIGHT", -89, -51);
				addOffset("singDOWN", 40, -120);
				addOffset("Ugh", 71, -40);
			case 'little-man':
				tex = Paths.getSparrowAtlas('bob/Small_Guy');
				frames = tex;
				animation.addByPrefix('idle', "idle", 24);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				addOffset('idle');
				addOffset("singUP", -10, 8);
				addOffset("singLEFT", -8, 0);
				addOffset("singRIGHT", 0, 2);
				addOffset("singDOWN", 0, -10);
			case 'pizza':
				tex = Paths.getSparrowAtlas('littleman/PizzaMan');
				frames = tex;
				animation.addByPrefix('idle', "PizzasHere", 29);
				animation.addByPrefix('fall', "PizzasHere", 29);
				animation.addByPrefix('singUP', 'Up', 29, false);
				animation.addByPrefix('singDOWN', 'Down', 29, false);
				animation.addByPrefix('singLEFT', 'Left', 29, false);
				animation.addByPrefix('singRIGHT', 'Right', 29, false);

			case 'bfbob':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('worried', 'BF idle worried', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('frozen', 'BF frozen', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset('worried', -5, -4);
				addOffset('frozen', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
				
			case 'bf-spiked':
				frames = Paths.getSparrowAtlas('bob/BfSpiked');
				animation.addByPrefix('firstDeath', "BF idle dance", 24, false);
				animation.addByIndices('deathLoop', "BF idle dance", [44], "", 24, true);
				animation.addByIndices('deathConfirm', "BF idle dance", [44], "", 24, false);
				
				addOffset('firstDeath', 287,79);
				addOffset('deathLoop', 287, 79);
				addOffset('deathConfirm', 287,79);
				updateHitbox();
				flipX = true;
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf') && !curCharacter.startsWith('matt-lost'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (animation.curAnim.name.startsWith('sing'))
		{
			holdTimer += elapsed;
		}
		else
			holdTimer = 0;

		if (curCharacter == 'dad' || curCharacter == 'kapi' || curCharacter == 'shaggy' || curCharacter == 'shaggyred')
			dadVar = 6.1;
	
		switch (curCharacter)
		{
			case 'gf' | 'gfb' | 'gfb3' | 'gfneo' | 'gf-rocks' | 'itsumi' | 'gf-nightbobandbosip':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
			case 'exTricky':
				if (exSpikes.animation.frameIndex >= 3 && animation.curAnim.name == 'singUP')
				{
					trace('paused');
					exSpikes.animation.pause();
				}
		}

		if (!animation.curAnim.name.startsWith('sing') && !animation.curAnim.name.startsWith('dance') && !animation.curAnim.name.startsWith('idle') && !animation.curAnim.name.startsWith('deathConfirm') && animation.curAnim.finished)
		{
			dance();
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-christmas' | 'gf-car' | 'gf-pixel' | 'gfTankmen' | 'gfb' | 'gfb-car' | 'gfb-christmas' | 'gfb-pixel' | 'gfb3' | 'gfb3-christmas' | 'gfb3-car' | 'gfb3-pixel' | 'gfneo' | 'gfneo-car' | 'gfwhitty' | 'gfsunset' | 'gfnight' | 'gfglitcher' | 'gf-mii' | 'gf-tabi' | 'gf-tabi-crazy' | 'gf-hell' | 'gf-tied' | 'gf-sus' | 'ghostgf' | 'gf-studio' | 'gf-kapi' | 'gf-rocks' | 'itsumi' | 'itsumi-car' | 'itsumi-christmas' | 'itsumi-pixel' | 'gf-crucified' | 'gf-bosip' | 'gf-bob' | 'gf-nightbobandbosip' | 'gf-ex' | 'gf-night-ex' | 'gf-ronsip' | 'gfFC' | 'gfDM' | 'gfWU' | 'gfKH':
				{
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				}

				case 'picoasgf':
				{
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('idle');
						else
							playAnim('idle');
					}
				}

				case 'spooky' | 'spookyb' | 'spookyb3' | 'spookyneo' | 'ghostngirl':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				case 'shaggy':
				if (!powerup)
				{
					danced = !danced;
					if (danced)
						playAnim('idle2', true);
					else
						playAnim('idle', true);
				}
				else
				{
					playAnim('idle_s');
				}
				case 'shaggyred':
				if (!powerup)
				{
					danced = !danced;
					if (danced)
						playAnim('idle2', true);
					else
						playAnim('idle', true);
				}
				else
				{
					playAnim('idle_s');
				}
				case 'sky' | 'sky-mad' | 'sky-annoyed':
				{
					if(!animation.curAnim.name.startsWith("oh") || !animation.curAnim.name.startsWith("huh") || !animation.curAnim.name.startsWith("grr") || !animation.curAnim.name.startsWith("ugh")){
					danced = !danced;
					
						if (danced){
							playAnim('danceRight'+ altAnim);
						}else{
							playAnim('danceLeft' + altAnim);
						}
					}
				}
				case 'ash':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function setZoom(?toChange:Float = 1):Void
	{
		daZoom = toChange;
		scale.set(toChange, toChange);
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		if (curCharacter == 'exTricky')
		{
			if (AnimName == 'singUP')
			{
				trace('spikes');
				exSpikes.visible = true;
				if (exSpikes.animation.finished)
					exSpikes.animation.play('spike');
			}
			else if (!exSpikes.animation.finished)
			{
				exSpikes.animation.resume();
				trace('go back spikes');
				exSpikes.animation.finishCallback = function(pog:String) {
					trace('finished');
					exSpikes.visible = false;
					exSpikes.animation.finishCallback = null;
				}
			}
		}

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0] * daZoom, daOffset[1] * daZoom);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
