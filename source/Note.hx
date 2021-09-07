package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end
import ModifierVariables._modifiers;
import MainVariables._variables;

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;
	public var animOffsets:Map<String, Array<Dynamic>>;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var noteScore:Float = 1;
	public var mania:Int = 0;
	public var noteType:Int = 0;

	public static var noteyOff1:Array<Float> = [4, 0, 0, 0, 0, 0];
	public static var noteyOff2:Array<Float> = [0, 0, 0, 0, 0, 0];
	public static var noteyOff3:Array<Float> = [0, 0, 0, 0, 0, 0];

	public static var swagWidth:Float = 160 * 0.7;
	public static var noteScale:Float;
	public static var pixelnoteScale:Float;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;
	public static var EX1_NOTE:Int = 4;
	public static var EX2_NOTE:Int = 5;
	public static var canMissLeft:Bool = true;
	public static var canMissRight:Bool = true;
	public static var canMissUp:Bool = true;
	public static var canMissDown:Bool = true;

	public static var tooMuch:Float = 30;

	public var dType:Int = 0;
	public var bType:Int = 0;

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?arrowskin:String = '')
	{
		swagWidth = 160 * 0.7; //factor not the same as noteScale
		noteScale = 0.7;
		pixelnoteScale = 1;
		mania = 0;

		if (PlayState.SONG.mania == 1)
		{
			swagWidth = 120 * 0.7;
			noteScale = 0.6;
			pixelnoteScale = 0.83;
			mania = 1;
		}
		else if (PlayState.SONG.mania == 2)
		{
			swagWidth = 95 * 0.7;
			noteScale = 0.5;
			pixelnoteScale = 0.7;
			mania = 2;
		}
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;

		if (PlayState.mania == 0)
		{
			x += 90;
		}	
		if (PlayState.mania == 1)
		{
			x += 50;
		}
		if (PlayState.mania == 2)
		{
			x += 20;
		}
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;

		var t = Std.int(noteData / Main.dataJump[mania]);
		this.noteType = t;
		this.noteData = noteData % Main.keyAmmo[mania];

		this.strumTime = strumTime;

		var daStage:String = PlayState.SONG.notestyle;

		switch (daStage)
		{
			case 'pixel':
				frames = Paths.getSparrowAtlas('weeb/pixelUI/arrows-pixels' + arrowskin);

				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');
				animation.addByPrefix('whiteScroll', 'white0');
				animation.addByPrefix('yellowScroll', 'yellow0');
				animation.addByPrefix('violetScroll', 'violet0');
				animation.addByPrefix('blackScroll', 'black0');
				animation.addByPrefix('darkScroll', 'dark0');

				if (isSustainNote)
				{
					loadGraphic(Paths.image('weeb/pixelUI/arrowEnds' + arrowskin), true, 7, 6);

					animation.add('purpleholdend', [9]);
					animation.add('blueholdend', [10]);
					animation.add('greenholdend', [11]);
					animation.add('redholdend', [12]);
					
					animation.add('yellowholdend', [13]);
					animation.add('darkholdend', [14]);
					animation.add('violetholdend', [15]);
					animation.add('blackholdend', [16]);					
					animation.add('whiteholdend', [17]);

					animation.add('purplehold', [0]);
					animation.add('bluehold', [1]);
					animation.add('greenhold', [2]);
					animation.add('redhold', [3]);
					
					animation.add('yellowhold', [4]);
					animation.add('darkhold', [5]);
					animation.add('violethold', [6]);
					animation.add('blackhold', [7]);
					animation.add('whitehold', [8]);
				}

				switch (t)
				{
					case 1:
					{
						loadGraphic(Paths.image('weeb/pixelUI/NOTE_fire-pixel'), true, 21, 31);
					
						animation.add('greenFire', [6, 7, 6, 8], 8);
						animation.add('redFire', [9, 10, 9, 11], 8);
						animation.add('blueFire', [3, 4, 3, 5], 8);
						animation.add('purpleFire', [0, 1 ,0, 2], 8);
						animation.add('whiteFire', [6, 7, 6, 8], 8);
						animation.add('blackFire', [6, 7, 6, 8], 8);
						animation.add('darkFire', [9, 10, 9, 11], 8);
						animation.add('violetFire', [3, 4, 3, 5], 8);
						animation.add('yellowFire', [0, 1 ,0, 2], 8);
						x -= 15;
					}
					case 2:
					{
						loadGraphic(Paths.image('weeb/pixelUI/specialarrows-pizels'), true, 17, 17);
						animation.add('purpleHalo', [10]);
						animation.add('blueHalo', [11]);
						animation.add('greenHalo', [12]);
						animation.add('redHalo', [13]);
						animation.add('whiteHalo', [12]);
						animation.add('yellowHalo', [10]);
						animation.add('violetHalo', [11]);
						animation.add('blackHalo', [12]);
						animation.add('darkHalo', [13]);
					}
					case 3:
					{
						loadGraphic(Paths.image('weeb/pixelUI/specialarrows-pizels'), true, 17, 17);
						animation.add('Warning', [0]);
					}
					case 4:
					{
						loadGraphic(Paths.image('weeb/pixelUI/specialarrows-pizels'), true, 17, 17);
						animation.add('Stun', [1]);
					}
					case 5:
					{
						loadGraphic(Paths.image('weeb/pixelUI/specialarrows-pizels'), true, 17, 17);
						animation.add('purplePoisonBad', [2]);
						animation.add('bluePoisonBad', [3]);
						animation.add('greenPoisonBad', [4]);
						animation.add('redPoisonBad', [5]);
						animation.add('whitePoisonBad', [4]);
						animation.add('yellowPoisonBad', [2]);
						animation.add('violetPoisonBad', [3]);
						animation.add('blackPoisonBad', [4]);
						animation.add('darkPoisonBad', [5]);
					}
					case 6:
					{
						loadGraphic(Paths.image('weeb/pixelUI/specialarrows-pizels'), true, 17, 17);
						animation.add('purplePoisonGood', [6]);
						animation.add('bluePoisonGood', [7]);
						animation.add('greenPoisonGood', [8]);
						animation.add('redPoisonGood', [9]);
						animation.add('whitePoisonGood', [8]);
						animation.add('yellowPoisonGood', [6]);
						animation.add('violetPoisonGood', [7]);
						animation.add('blackPoisonGood', [8]);
						animation.add('darkPoisonGood', [9]);
					}
				}

				setGraphicSize(Std.int(width * PlayState.daPixelZoom * pixelnoteScale));
				updateHitbox();

			default:		
				switch (t)
				{
					case 0:
					{
						frames = Paths.getSparrowAtlas('NOTE_assets' + arrowskin);
						
						animation.addByPrefix('greenScroll', 'green0');
						animation.addByPrefix('redScroll', 'red0');
						animation.addByPrefix('blueScroll', 'blue0');
						animation.addByPrefix('purpleScroll', 'purple0');
						animation.addByPrefix('whiteScroll', 'white0');
						animation.addByPrefix('yellowScroll', 'yellow0');
						animation.addByPrefix('violetScroll', 'violet0');
						animation.addByPrefix('blackScroll', 'black0');
						animation.addByPrefix('darkScroll', 'dark0');
					
						animation.addByPrefix('purpleholdend', 'pruple end hold');
						animation.addByPrefix('greenholdend', 'green hold end');
						animation.addByPrefix('redholdend', 'red hold end');
						animation.addByPrefix('blueholdend', 'blue hold end');
						animation.addByPrefix('whiteholdend', 'white hold end');
						animation.addByPrefix('yellowholdend', 'yellow hold end');
						animation.addByPrefix('violetholdend', 'violet hold end');
						animation.addByPrefix('blackholdend', 'black hold end');
						animation.addByPrefix('darkholdend', 'dark hold end');

						animation.addByPrefix('purplehold', 'purple hold piece');
						animation.addByPrefix('greenhold', 'green hold piece');
						animation.addByPrefix('redhold', 'red hold piece');
						animation.addByPrefix('bluehold', 'blue hold piece');
						animation.addByPrefix('whitehold', 'white hold piece');
						animation.addByPrefix('yellowhold', 'yellow hold piece');
						animation.addByPrefix('violethold', 'violet hold piece');
						animation.addByPrefix('blackhold', 'black hold piece');
						animation.addByPrefix('darkhold', 'dark hold piece');

						setGraphicSize(Std.int(width * noteScale));
						antialiasing = _variables.antialiasing;
					}
					case 1:
					{
						frames = Paths.getSparrowAtlas('NOTE_fire');

						animation.addByPrefix('greenFire', 'green fire');
						animation.addByPrefix('redFire', 'red fire');
						animation.addByPrefix('blueFire', 'blue fire');
						animation.addByPrefix('purpleFire', 'purple fire');
						animation.addByPrefix('whiteFire', 'green fire');
						animation.addByPrefix('yellowFire', 'purple fire');
						animation.addByPrefix('violetFire', 'blue fire');
						animation.addByPrefix('blackFire', 'green fire');
						animation.addByPrefix('darkFire', 'red fire');

						switch (mania)
						{
							case 0:
							x -= 30;
							case 1:
							x -= 26;
							case 2:
							x -= 22;
						}

						setGraphicSize(Std.int(width * noteScale * 0.86));
						
						antialiasing = _variables.antialiasing;
					}
					case 2:
					{
						frames = Paths.getSparrowAtlas('NOTEhalo_assets');

						animation.addByPrefix('greenHalo', 'Green Arrow');
						animation.addByPrefix('redHalo', 'Red Arrow');
						animation.addByPrefix('blueHalo', 'Blue Arrow');
						animation.addByPrefix('purpleHalo', 'Purple Arrow');
						animation.addByPrefix('whiteHalo', 'Green Arrow');
						animation.addByPrefix('yellowHalo', 'Purple Arrow');
						animation.addByPrefix('violetHalo', 'Blue Arrow');
						animation.addByPrefix('blackHalo', 'Green Arrow');
						animation.addByPrefix('darkHalo', 'Red Arrow');

						switch (mania)
						{
							case 0:
							x -= 138;
							case 1:
							x -= 116;
							case 2:
							x -= 96;
						}

						setGraphicSize(Std.int(width * noteScale * 0.86));					

						antialiasing = _variables.antialiasing;
					}
					case 3:
					{
						loadGraphic(Paths.image('warningNote'), true, 157, 154);
						animation.add('Warning', [0]);

						setGraphicSize(Std.int(width * noteScale));
						antialiasing = _variables.antialiasing;
					}
					case 4:
					{
						loadGraphic(Paths.image('stunNote'), true, 157, 154);
						animation.add('Stun', [0]);

						setGraphicSize(Std.int(width * noteScale));
						antialiasing = _variables.antialiasing;
					}
					case 5:
					{
						frames = Paths.getSparrowAtlas('BobNotes');

						animation.addByPrefix('greenPoisonBad', 'vertedUp');
						animation.addByPrefix('redPoisonBad', 'vertedRight');
						animation.addByPrefix('bluePoisonBad', 'vertedDown');
						animation.addByPrefix('purplePoisonBad', 'vertedLeft');
						animation.addByPrefix('whitePoisonBad', 'vertedUp');
						animation.addByPrefix('blackPoisonBad', 'vertedUp');
						animation.addByPrefix('darkPoisonBad', 'vertedRight');
						animation.addByPrefix('violetPoisonBad', 'vertedDown');
						animation.addByPrefix('yellowPoisonBad', 'vertedLeft');

						setGraphicSize(Std.int(width * noteScale));
						antialiasing = _variables.antialiasing;
					}
					case 6:
					{
						frames = Paths.getSparrowAtlas('BobNotes');

						animation.addByPrefix('greenPoisonGood', 'hitUp');
						animation.addByPrefix('redPoisonGood', 'hitRight');
						animation.addByPrefix('bluePoisonGood', 'hitDown');
						animation.addByPrefix('purplePoisonGood', 'hitLeft');
						animation.addByPrefix('whitePoisonGood', 'hitUp');
						animation.addByPrefix('blackPoisonGood', 'hitUp');
						animation.addByPrefix('darkPoisonGood', 'hitRight');
						animation.addByPrefix('violetPoisonGood', 'hitDown');
						animation.addByPrefix('yellowPoisonGood', 'hitLeft');

						setGraphicSize(Std.int(width * noteScale));
						antialiasing = _variables.antialiasing;
					}
				}

			updateHitbox();
			antialiasing = _variables.antialiasing;
		}

		var frameN:Array<String> = ['purple', 'blue', 'green', 'red'];

		if (Main.switchside)
		{
			if (mania == 0) frameN = ['red', 'green', 'blue', 'purple'];
			else if (mania == 1) frameN = [ 'dark', 'blue', 'yellow', 'red', 'green', 'purple'];
			else if (mania == 2) frameN = ['dark', 'black', 'violet', 'yellow', 'white', 'red', 'green', 'blue', 'purple'];
		}
		else
		{
			if (mania == 0) frameN = ['purple', 'blue', 'green', 'red'];
			else if (mania == 1) frameN = ['purple', 'green', 'red', 'yellow', 'blue', 'dark'];
			else if (mania == 2) frameN = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'black', 'dark'];
		}				

		switch (t)
		{
			case 0:
				animation.play(frameN[noteData % Main.keyAmmo[mania]] + 'Scroll');
			case 1:
				animation.play(frameN[noteData % Main.keyAmmo[mania]] + 'Fire');
			case 2:
				animation.play(frameN[noteData % Main.keyAmmo[mania]] + 'Halo');
			case 3:
				animation.play('Warning');
			case 4:
				animation.play('Stun');
			case 5:
				animation.play(frameN[noteData % Main.keyAmmo[mania]] + 'PoisonBad');
			case 6:
				animation.play(frameN[noteData % Main.keyAmmo[mania]] + 'PoisonGood');
		}
		x += swagWidth * (noteData % Main.keyAmmo[mania]);
		
		
		if (!ChartingState.switchtocharting)
		{
			//switch shit
			if (Main.switchside)
			{
				flipX = true;
			}

			if ((_variables.scroll == "down" || _variables.scroll == "right") && !sustainNote)
				flipY = true;
	
			if ((_variables.scroll == "left") && !isSustainNote)
				angle += 90;
			else if ((_variables.scroll == "right") && !isSustainNote)
				angle -= 90;
	
			if (_modifiers.FlippedNotes && !isSustainNote)
			{
				flipX = true;
				flipY = !flipY;
			}
		}

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2;

			animation.play(frameN[noteData % Main.keyAmmo[mania]] + 'holdend');

			updateHitbox();

			x -= width / 2;

			if (PlayState.SONG.notestyle == 'pixel')
				x += 30;

			if (prevNote.isSustainNote)
			{
				prevNote.animation.play(frameN[prevNote.noteData] + 'hold');
				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}

			switch (prevNote.dType)
			{
				case 0:
					dType = 0;
				case 1:
					dType = 1;
				case 2:
					dType = 2;	
			}

			switch (prevNote.bType)
			{
				case 0:
					bType = 0;
				case 1:
					bType = 1;
				case 2:
					bType = 2;	
			}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		//no hold note for special notes ahahahahah
		switch (prevNote.noteType)
		{
			case 0:
			//dont remove hold note
			case 1:
			if(isSustainNote) 
			{ 
				this.kill(); 
			}
			case 2:
			if(isSustainNote) 
			{ 
				this.kill(); 
			}
			case 3:
			if(isSustainNote) 
			{ 
				this.kill(); 
			}
			case 4:
			if(isSustainNote) 
			{ 
				this.kill(); 
			}
			case 5:
			if(isSustainNote) 
			{ 
				this.kill(); 
			}
			case 6:
			if(isSustainNote) 
			{ 
				this.kill(); 
			}
		}
		

		if (mustPress)
		{		
			if (noteType == 1)
			{
				//trace ('fire notes');
				// make burning notes a lot harder to accidently hit because they're weirdchamp!
				if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 0.6)
					&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.4)) // also they're almost impossible to hit late!
				{
					canBeHit = true;
					setCanMiss(noteData, false);
				}
				else
				{
					canBeHit = false;
					setCanMiss(noteData, true);
				}
				if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				{
					tooLate = true;
					setCanMiss(noteData, false);
				}
			}
			else if (noteType == 2)
			{
				//trace ('halo notes');
				// these though, REALLY hard to hit.
				if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 0.3)
					&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.2)) // also they're almost impossible to hit late!
				{
					canBeHit = true;
					setCanMiss(noteData, false);
				}
				else
				{
					canBeHit = false;
					setCanMiss(noteData, true);
				}
				if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				{
					tooLate = true;
					setCanMiss(noteData, false);
				}
			}
			else
			{
				//trace ('anything else but fire and halo notes');
				// The * 0.5 is so that it's easier to hit them too late, instead of too early
				if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
					&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
				{
					canBeHit = true;
					setCanMiss(noteData, false);
				}
				else
				{
					canBeHit = false;
					setCanMiss(noteData, true);
				}
				if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				{
					tooLate = true;
					setCanMiss(noteData, false);
				}
			}		
		}
		else
		{
			canBeHit = false;
			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}

	public static function setCanMiss(data:Int, bool:Bool)
	{
		switch(data) {
			case 0:
				canMissLeft = bool;
			case 1:
				canMissDown = bool;
			case 2:
				canMissUp = bool;
			case 3:
				canMissRight = bool;
		}
	}
}
