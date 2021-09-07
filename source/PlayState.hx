package;

import openfl.Lib;
#if sys
import sys.FileSystem;
import sys.io.Process;
#end
#if desktop
import Discord.DiscordClient;
#end
#if desktop
import sys.io.File;
#end
//import LoopState;
import lime.app.Application;
import lime.media.AudioContext;
import lime.media.AudioManager;
import openfl.filters.BitmapFilter;
import flixel.math.FlxRandom;
import flixel.input.keyboard.FlxKey;
import haxe.Exception;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import lime.graphics.Image;
import flixel.graphics.FlxGraphic;
import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;
import flixel.system.FlxAssets;
import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.effects.FlxSkewedSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxTimer;
import openfl.filters.ShaderFilter;
import MainVariables._variables;
import MainVariables._keybind;
import ModifierVariables._modifiers;
import Endless_Substate._endless;
import hscript.plus.ScriptState;
#if mobileC
import ui.Hitbox;
#end

using StringTools;

class PlayState extends MusicBeatState
{
	public static var instance:PlayState = null;

	public static var cheated:Bool = false;
	public static var staticVar:PlayState;
	public static var curStage:String = '';
	public static var SONG:SwagSong;
	public static var gameplayArea:String = "Story";
	public static var chartType:String = "standard";
	public static var storyWeek:Int = 0;

	public static var loops:Int = 0;
	public static var speed:Float = 0; 
	
	public static var storyPlaylist:Array<String> = [];
	public static var difficultyPlaylist:Array<String> = [];

	public static var storyDifficulty:Int = 0;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;
	public static var mania:Int = 0;
	public static var keyAmmo:Array<Int> = [4, 6, 9];
	public static var dataJump:Array<Int> = [8, 12, 18];
	public static var fadeouthud:Bool;

	var tank0:FlxSprite;
	var tank1:FlxSprite;
	var tank2:FlxSprite;
	var tank3:FlxSprite;
	var tank4:FlxSprite;
	var tank5:FlxSprite;
	var tankRolling:FlxSprite;
	var tankX:Int = 400;
	var tankSpeed:Float = FlxG.random.float(5, 7);
	var tankAngle:Float = FlxG.random.float(-90, 45);
	var tankWatchtower:FlxSprite;
	var tankmanRun:FlxTypedGroup<TankmenBG>;

	public static var songPosBG:FlxSprite;
	public static var songPosBar:FlxBar;
	var songName:FlxText;
	private var songPositionBar:Float = 0;

	var halloweenLevel:Bool = false;
	var doof:DialogueBox;

	var realSpeed:Float = 0;

	private var vocals:FlxSound;

	public static var dad:Character;
	public static var dad2:Character;
	private var gf:Character;
	private var boyfriend:Boyfriend;
	private var boyfriend2:Boyfriend;

	private var notes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];

	private var strumLine:FlxSprite;
	private var curSection:Int = 0;

	private var camFollow:FlxObject;

	private static var prevCamFollow:FlxObject;

	public var strumLineNotes:FlxTypedGroup<FlxSkewedSprite>;
	public var playerStrums:FlxTypedGroup<FlxSkewedSprite>;
	public var cpuStrums:FlxTypedGroup<FlxSkewedSprite>;
	private var hearts:FlxTypedGroup<FlxSprite>;

	private var camZooming:Bool = false;
	private var curSong:String = "";

	private var gfSpeed:Int = 1;
	private var health:Float = 1;
	private var combo:Int = 0;

	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;

	public static var generatedMusic:Bool = false;
	private var startingSong:Bool = false;

	private var iconP1:HealthIcon;
	private var iconP2:HealthIcon;
	private var iconP3:HealthIcon;
	private var iconP4:HealthIcon;
	public var camNOTES:FlxCamera;
	public var camHB:FlxCamera;
	public var note0:FlxCamera;
	public var note1:FlxCamera;
	public var note2:FlxCamera;
	public var note3:FlxCamera;
	public var note4:FlxCamera;
	public var noteCamArray:Array<FlxCamera> = [];
	public var camSus:FlxCamera; // sussy!!1!11
	public var camNOTEHUD:FlxCamera;
	public var camHUD:FlxCamera;
	public var camPAUSE:FlxCamera;
	public var camGame:FlxCamera;

	public static var arrowextra:String;

	var arrowextraDad:String;

	var notesHitArray:Array<Date> = [];
	var currentFrames:Int = 0;
	var notesplash:FlxSprite;

	var stuneffect:Bool = false;

	public static var dialogue:Array<String> = [];

	var halloweenBG:FlxSprite;
	var isHalloween:Bool = false;
	var leftboom:FlxSprite;
	var rightboom:FlxSprite;
	var bg:FlxSprite;
	var whittyFront:FlxSprite;

	var nightbobandbosipLights:FlxTypedGroup<FlxSprite>;
	var itbLights:FlxTypedGroup<FlxSprite>;
	var kapiLights:FlxTypedGroup<FlxSprite>;

	var phillyCityLights:FlxTypedGroup<FlxSprite>;
	var phillyTrain:FlxSprite;
	var trainSound:FlxSound;

	var limo:FlxSprite;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:FlxSprite;

	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var santa:FlxSprite;

	var bgGirls:BackgroundGirls;
	var wiggleShit:WiggleEffect = new WiggleEffect();

	var ballisticbg:FlxSprite;

	//foolhardy
	var mazebg:FlxSprite;

	var wire:FlxSprite;
	
	var bgBoppers:FlxSprite;

	var crowdmiku:FlxSprite;

	public static var mariohelping:Bool = false;

	//hb color change
	public static var player1hb:Int = 0xFFffffff;
	public static var player2hb:Int = 0xFFffffff;
	//

	var genocideBG:FlxSprite;
	var genocideBoard:FlxSprite;
	var siniFireBehind:FlxTypedGroup<SiniFire>;
	var siniFireFront:FlxTypedGroup<SiniFire>;

	private var LightsOutBG:FlxSprite;
	private var BlindingBG:FlxSprite;
	private var freezeIndicator:FlxSprite;

	// Will fire once to prevent debug spam messages and broken animations
	private var triggeredAlready:Bool = false;
	
	// Will decide if she's even allowed to headbang at all depending on the song
	private var allowedToHeadbang:Bool = false;

	var talking:Bool = true;
	var songScore:Int = 0;
	var scoreTxt:FlxText;
	var comboTxt:FlxText;
	public static var controlTxt:FlxText;
	public static var misses:Int = 0;
	var missTxt:FlxText;
	public static var accuracy:Float = 0.00;
	private var totalNotesHit:Float = 0;
	private var totalPlayed:Int = 0;
	var accuracyTxt:FlxText;
	var canDie:Bool = true;
	public static var arrowLane:Int = 0;
	var nps:Int = 0;
	var npsTxt:FlxText;
	public static var ended:Bool = false;

	var lives:Float = 1;
	var heartSprite:FlxSprite;
	var offbeatValue:Float = 0;
	var speedNote:Float = 1;
	var noteDrunk:Float = 0;
	var noteAccel:Float = 0;
	var paparazziInt:Int = 0;
	var missCounter:Int = 0;
	var frozen:Bool = false;

	public static var campaignScore:Int = 0;

	var defaultCamZoom:Float = 1.05;

	// how big to stretch the pixel art assets
	public static var daPixelZoom:Float = 6;

	public static var theFunne:Bool = true;
	var funneEffect:FlxSprite;

	//shaggy vars
	var burst:FlxSprite;
	var rock:FlxSprite;
	var gf_rock:FlxSprite;
	var doorFrame:FlxSprite;
	var dfS:Float = 1;
	var cs_reset:Bool = false;
	var s_ending:Bool = false;
	var godCutEnd:Bool = false;
	var godMoveBf:Bool = true;
	var godMoveGf:Bool = false;
	var godMoveSh:Bool = false;
	var gf_launched:Bool = false;
	var stress:Float;
	private var cutTime:Float;
	private var shaggyT:FlxTrail;
	private var ctrTime:Float = 0;
	private var notice:FlxText;
	private var nShadow:FlxText;
	var sh_r:Float = 600;
	//

	// tricky lines
	public var TrickyLinesSing:Array<String> = ["SUFFER","INCORRECT", "INCOMPLETE", "INSUFFICIENT", "INVALID", "CORRECTION", "MISTAKE", "REDUCE", "ERROR", "ADJUSTING", "IMPROBABLE", "IMPLAUSIBLE", "MISJUDGED"];
	public var ExTrickyLinesSing:Array<String> = ["YOU AREN'T HANK", "WHERE IS HANK", "HANK???", "WHO ARE YOU", "WHERE AM I", "THIS ISN'T RIGHT", "MIDGET", "SYSTEM UNRESPONSIVE", "WHY CAN'T I KILL?????"];
	public var TrickyLinesMiss:Array<String> = ["TERRIBLE", "WASTE", "MISS CALCULTED", "PREDICTED", "FAILURE", "DISGUSTING", "ABHORRENT", "FORESEEN", "CONTEMPTIBLE", "PROGNOSTICATE", "DISPICABLE", "REPREHENSIBLE"];

	//tricky full ass variables
	public var hank:FlxSprite;
	var tstatic:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('TrickyStatic'));// true, 320, 180
	var tStaticSound:FlxSound = new FlxSound().loadEmbedded(Paths.sound("staticSound"));
	public var covertricky:FlxSprite = new FlxSprite(-180,755).loadGraphic(Paths.image('fourth/cover'));
	public var holetricky:FlxSprite = new FlxSprite(50,530).loadGraphic(Paths.image('fourth/Spawnhole_Ground_BACK'));
	public var converHoletricky:FlxSprite = new FlxSprite(7,578).loadGraphic(Paths.image('fourth/Spawnhole_Ground_COVER'));
	var MAINLIGHT:FlxSprite;
	public var trans:FlxSprite;
	//
	

	//vs imposter shit fuck
	var snowfall1:FlxTypedGroup<Snowfall1>;
	var snowfall2:FlxTypedGroup<Snowfall2>;
	var redsnowfall1:FlxTypedGroup<RedSnowfall1>;
	var redsnowfall2:FlxTypedGroup<RedSnowfall2>;
	var redsnowfall3:FlxTypedGroup<RedSnowfall3>;
	var crowd:MogusBoppers;
	var _cb = 0;
	var flashSprite:FlxSprite = new FlxSprite(-70, -70).makeGraphic(5000, 5000, 0xFFb30000);
	//

	//cyrix variablezz
	var cy_spk1:StudioSpeaker;
	var cy_spk2:StudioSpeaker;
	var cy_crash:StudioCrashBG;

	//

	//kap
	var littleGuys:FlxSprite;
	var littleGuys2:FlxSprite;
	//

	//agoti
	var bgRocks:FlxSprite;
	var speaker:FlxSprite;
	//

	//sky
	var shiftbg:FlxSprite;
	var floor:FlxSprite;
	//

	//shaggymatt
	var shadow1:FlxSprite;
	var shadow2:FlxSprite;
	//

	//videoshittyshitshitfuckyou
	public var fuckingVolume:Float = 1;
	public var useVideo = false;
	public static var webmHandler:WebmHandler;

	public var playingDathing = false;

	public var videoSprite:FlxSprite;

	public var stopUpdate = false;
	public var removedVideo = false;
	//

	//bob and bosip
	var splitCamMode:Bool = false;
	var splitMode:Bool = false;
	var splitSoftMode:Bool = false;
	var splitExtraZoom:Bool = false;
	var coolerText:Bool = false;
	var coolGlowyLights:FlxTypedGroup<FlxSprite>;
	var coolGlowyLightsMirror:FlxTypedGroup<FlxSprite>;
	var songSpeedMultiplier:Float = 0;

	var dadCamOffset:FlxPoint;
	var pc:Character;

	var areYouReady:FlxTypedGroup<FlxSprite>;

	var theEntireFuckingStage:FlxTypedGroup<FlxSprite>;

	var mini:FlxSprite;
	var mordecai:FlxSprite;
	var thirdBop:FlxSprite;
	var walked:Bool = false;
	var walkingRight:Bool = true;
	var stopWalkTimer:Int = 0;
	var lightsTimer:Array<Int> = [200, 700];

	var healthDrainTimer:Int = -1;
	var healthDrainTarget:Float;
	var healthDraining:Bool = false;
	var SAD:FlxTypedGroup<FlxSprite>;
	var SADorder:Int = 0;

	var grpDieStage:FlxTypedGroup<FlxSprite>;
	var grpSlaughtStage:FlxTypedGroup<FlxSprite>;
	var waaaa:FlxSprite;
	var unregisteredHypercam:FlxSprite;

	public var bgbob:FlxSprite;
	public var groundbob:FlxSprite;
	//

	//bob onslught
	public var bobmadshake:FlxSprite;
	public var bobsound:FlxSound;

	//thx fnfhd
	var shootBeats:Array<Int> =    [128, 192, 200, 204, 254, 256, 260, 264, 268, 272, 276, 280, 284, 336, 338, 340, 342, 344, 346, 348, 351];
	var shootBeatsPos:Array<Int> = [0,   3,   0,   2,   3,   0,   3,   0,   3,   3,   2,   1,   1,   0,   0,   0,   3,   3,   0,   0,   3];
	var shootBeatsEasy:Array<Int> =    [128, 192, 200, 204, 254, 256, 260, 264, 268, 272, 276, 280, 284, 336, 340, 344, 346, 351];
	var shootBeatsPosEasy:Array<Int> = [0,   3,   0,   2,   3,   0,   3,   0,   3,   3,   2,   1,   1,   0,   0,   3,   0,   3];
	var DoIHit:Bool = true;
	var IsNoteSpinning:Bool = false;
	var SpinAmount:Float = 0;
	var windowX:Float = Lib.application.window.x;
	var windowY:Float = Lib.application.window.y;
	//paze SUCKS!!!!
	//


	public var genocideCommands:Array<Array<Dynamic>> = [];

	public var screenDanced:Bool = false;
	public var chromDanced:Bool = false;

	public var vignette:FlxSprite;

//	public var noteShaked:Bool = false;
	public var crazyMode:Bool = false;
	public var isGenocide:Bool = false;
	public var minusHealth:Bool = false;
	public var justDoItMakeYourDreamsComeTrue:Bool = false;
	public var doIt:Bool = true;
	public var samShit:FlxSprite;

	public static var botPlay:FlxText;

	var inCutscene:Bool = false;

	var songLength:Float = 0;
	#if desktop
	// Discord RPC variables
	var storyDifficultyText:String = "";
	public static var iconRPC:String = "";
	var detailsText:String = "";
	var detailsPausedText:String = "";
	#end

	var susWiggle:ShaderFilter;

	var modState = new ScriptState();

	var dialogueSuffix:String = "";

	public static var cameraX:Float;
	public static var cameraY:Float;

	var miscLerp:Float = 0.09;
	var camLerp:Float = 0.14;
	var zoomLerp:Float = 0.09;

	#if mobileC
	var _hitbox:Hitbox;
	#end

	override public function create()
	{
		fadeouthud = false;
		removedVideo = false;

		instance = this;
		ended = false;
		cheated = false;

		dialogue = null;

		sicks = 0;
		bads = 0;
		shits = 0;
		goods = 0;

		misses = 0;
		accuracy = 0.00;

		resetSpookyText = true;

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		if (_variables.hitsound.toLowerCase() != 'none')
			FlxG.sound.play(Paths.sound('hitsounds/' + _variables.hitsound), 0); // just a way to preload them

		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHB = new FlxCamera();
		camHB.bgColor.alpha = 0;
		camHB.alpha = 0;
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camHUD.alpha = 0;
		camSus = new FlxCamera();
		camSus.bgColor.alpha = 0;
		camSus.alpha = 0;
		camSus.flashSprite.width = camSus.flashSprite.width * 2;
		camSus.flashSprite.height = camSus.flashSprite.height * 2;
		camNOTES = new FlxCamera();
		camNOTES.bgColor.alpha = 0;
		camNOTES.alpha = 0;
		camNOTES.flashSprite.width = camSus.flashSprite.width;
		camNOTES.flashSprite.height = camSus.flashSprite.height;
		camNOTEHUD = new FlxCamera();
		camNOTEHUD.bgColor.alpha = 0;
		camNOTEHUD.alpha = 0;
		camNOTEHUD.flashSprite.width = camSus.flashSprite.width;
		camNOTEHUD.flashSprite.height = camSus.flashSprite.height;
		camPAUSE = new FlxCamera();
		camPAUSE.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camNOTEHUD);
		FlxG.cameras.add(camSus);
		FlxG.cameras.add(camNOTES);
		FlxG.cameras.add(camHB);
		FlxG.cameras.add(camHUD);
		FlxG.cameras.add(camPAUSE);

		modifierValues();
		
		//switch shit
		if (Main.switchside)
		{
			camHB.flashSprite.scaleX = -1;
			camNOTES.flashSprite.scaleX = -1;
			camNOTEHUD.flashSprite.scaleX = -1;
			camSus.flashSprite.scaleX = -1;			
		}

		if (_variables.scroll == "down" || _variables.scroll == "right")
		{
			camNOTES.flashSprite.scaleY = -1;
			camNOTEHUD.flashSprite.scaleY = -1;
			camSus.flashSprite.scaleY = -1;
		}

		if (_variables.scroll == 'left' || _variables.scroll == 'right')
		{
			camNOTES.angle -= 90;
			camNOTEHUD.angle -= 90;
			camSus.angle -= 90;

			camSus.y = -370;
			camNOTEHUD.y = -370;
			camNOTES.y = -370;

			if (_variables.scroll == "left")
			{
				camSus.x += 100;
				camNOTEHUD.x += 100;
				camNOTES.x += 100;
			}
			else if (_variables.scroll == "right")
			{
				camSus.x -= 95;
				camNOTEHUD.x -= 95;
				camNOTES.x -= 95;
			}

			camSus.height = FlxG.width + 200;
			camNOTES.height = FlxG.width + 200;
			camNOTEHUD.height = FlxG.width + 200;
		}

		// FlxG.cameras.setDefaultDrawTarget(camGame, true);
		// ! DEPRECATED
		FlxCamera.defaultCameras = [camGame];

		staticVar = this;

		persistentUpdate = true;
		persistentDraw = true;

		mania = SONG.mania;

		if (mania == 0)
			mania = 0;
		else if (mania == 1)
			mania = 1;
		else if (mania == 2)
			mania = 2;
		else
			mania = 0;

		if (SONG == null)
			SONG = Song.loadFromJson('tutorial');

		if (gameplayArea == "Endless")
			SONG.speed = _endless.speed;

		Conductor.mapBPMChanges(SONG);

		Conductor.changeBPM(SONG.bpm);

	/*	if (_modifiers.LoveSwitch && _modifiers.Fright < _modifiers.Love)
			dialogueSuffix = "-love";
		else if (_modifiers.FrightSwitch && _modifiers.Fright < 50 && _modifiers.Love <= _modifiers.Fright)
			dialogueSuffix = "-uneasy";
		else if (_modifiers.FrightSwitch && (_modifiers.Fright >= 50 && _modifiers.Fright < 100) && _modifiers.Love <= _modifiers.Fright)
			dialogueSuffix = "-scared";
		else if (_modifiers.FrightSwitch && (_modifiers.Fright >= 100 && _modifiers.Fright < 200) && _modifiers.Love <= _modifiers.Fright)
			dialogueSuffix = "-terrified";
		else if (_modifiers.FrightSwitch && _modifiers.Fright >= 200 && _modifiers.Love <= _modifiers.Fright)
			dialogueSuffix = "-depressed";
		//else if (_modifiers.FrightSwitch && _modifiers.Fright >= 310)
		//	dialogueSuffix = "-dead"; ///yiiiiikes
		else if(_modifiers.Practice)
			dialogueSuffix = "-practice";
		else if(_modifiers.Perfect)
			dialogueSuffix = "-perfect";*/


		switch (SONG.song.toLowerCase())
		{
			case 'senpai' | 'senpai-b' | 'senpai-b3' | 'roses' | 'roses-b' | 'roses-b3' | 'thorns' | 'thorns-b' | 'thorns-b3':
				dialogue = CoolUtil.coolTextFile(Paths.txt(SONG.song.toLowerCase()+'/dialogue'));
			case 'lo-fight' | 'overhead' | 'ballistic':
				dialogue = CoolUtil.coolTextFile(Paths.txt(SONG.song.toLowerCase()+'/dialogue'));
		}

		#if desktop
		// Making difficulty text for Discord Rich Presence.
		switch (storyDifficulty)
		{
			case 0:
				storyDifficultyText = "Easy";
			case 1:
				storyDifficultyText = "Normal";
			case 2:
				storyDifficultyText = "Hard";
			case 3:
				storyDifficultyText = "EX";
			case 4:
				storyDifficultyText = "GOD";
		}

		if (Main.switchside)
		{
			iconRPC = SONG.player1;
		}		
		else
		{
			iconRPC = SONG.player2;
		}

		// To avoid having duplicate images in Discord assets
		switch (iconRPC)
		{
			case 'bf-car' | 'bf-christmas' | 'bf-holding-gf' | 'bfsunset' | 'bfnight' | 'bfglitcher' | 'bfmii' | 'bf-tabi' | 'bf-tabi-crazy' | 'bf-hell' | 'bf-sus' | 'ghostbf' | 'bf-night':
				iconRPC = 'bf';
			case 'monster-christmas':
				iconRPC = 'monster';
			case 'mom-car':
				iconRPC = 'mom';
			case 'hexsunset':
				iconRPC = 'hex';
			case 'hexnight':
				iconRPC = 'hex';
			case 'hexViruswire':
				iconRPC = 'hexVirus';
			case 'garcellodead':
				iconRPC = 'garcelloghosty';
			case 'impostor2':
				iconRPC = 'impostor';
			case 'mattmad':
				iconRPC = 'matt';
			case 'cyrix-nervous':
				iconRPC = 'cyrix';
			case 'opheebop-christmas':
				iconRPC = 'opheebop';
			case 'momexe-car':
				iconRPC = 'momexe';
			case 'glitchy':
				iconRPC = 'glitch';
			case 'sky-annoyed':
				iconRPC = 'sky';
			case 'shaggyred':
				iconRPC = 'shaggy';
			case 'mattblue':
				iconRPC = 'matt';
			case 'bfanders':
				iconRPC = 'anders';
		}

		// String that contains the mode defined here so it isn't necessary to call changePresence for each mode
		switch (gameplayArea)
		{
		case "Story":
			detailsText = "Week Selection: Week " + storyWeek;
		case "Freeplay":
			detailsText = "Freeplay:";
		case "Marathon":
			detailsText = "Marathon:";
		case "Endless":
			detailsText = "Endless: Loop "+ loops;
		}

		// String for when the game is paused
		detailsPausedText = "BRB - " + detailsText;

		if (gameplayArea == "Endless")
			detailsPausedText = "BRB - Endless:";

		// Updating Discord Rich Presence.
		DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC);

		if (gameplayArea == "Endless")
			DiscordClient.changePresence(detailsText, SONG.song, iconRPC, true);
		#end

		switch (storyDifficulty)
		{
			case 0:
				Main.exMode = false;
				Main.god = false;
			case 1:
				Main.exMode = false;
				Main.god = false;
			case 2:
				Main.exMode = false;
				Main.god = false;
			case 3:
				Main.exMode = true;
				Main.god = false;
			case 4:
				Main.exMode = false;
				Main.god = true;
		}

		//dapixelzoom change because sky mod fucked it up
		switch (SONG.song.toLowerCase())
		{
			default:
			daPixelZoom = 6;
			case 'wife-forever' | 'sky' | 'manifest':
			daPixelZoom = 1;
		}

		switch (SONG.curStage)
		{
		default:
		{
			defaultCamZoom = 0.9;
			curStage = 'stage';
			var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
			bg.antialiasing = _variables.antialiasing;
			bg.scrollFactor.set(0.9, 0.9);
			bg.active = false;
			add(bg);

			var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness >= 35)
				stageFront = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefrontB'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -35)
				stageFront = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefrontLO'));
			stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
			stageFront.updateHitbox();
			stageFront.antialiasing = _variables.antialiasing;
			stageFront.scrollFactor.set(0.9, 0.9);
			stageFront.active = false;
			add(stageFront);

			var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness >= 35)
				stageCurtains = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtainsB'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -35)
				stageCurtains = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtainsLO'));
			stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
			stageCurtains.updateHitbox();
			stageCurtains.antialiasing = _variables.antialiasing;
			stageCurtains.scrollFactor.set(1.3, 1.3);
			stageCurtains.active = false;

			add(stageCurtains);
		}
		case 'spooky':
		{
			curStage = "spooky";
			halloweenLevel = true;

			var hallowTex = Paths.getSparrowAtlas('spooky/halloween_bg');

			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -45)
				hallowTex = Paths.getSparrowAtlas('spooky/halloween_LObg');

			halloweenBG = new FlxSprite(-200, -100);
			halloweenBG.frames = hallowTex;
			halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
			halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
			halloweenBG.animation.play('idle');
			halloweenBG.antialiasing = _variables.antialiasing;
			add(halloweenBG);

			var halloweenLight:FlxSprite = new FlxSprite(-100, -300);
			halloweenLight.frames = Paths.getSparrowAtlas('spooky/halloween_lightbulb');
			halloweenLight.scrollFactor.set(0.85, 0.85);
			halloweenLight.animation.addByPrefix('Lightbulb', 'Lightbulb', 18, true);
			halloweenLight.animation.play('Lightbulb');
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness >= 50)
				add(halloweenLight);

			isHalloween = true;
		}
		case 'philly':
		{
			curStage = 'philly';

			var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('philly/sky'));

			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -15)
				bg = new FlxSprite(-100).loadGraphic(Paths.image('philly/skyLO'));

			bg.scrollFactor.set(0.1, 0.1);
			add(bg);

			var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('philly/city'));
			city.scrollFactor.set(0.3, 0.3);
			city.antialiasing = _variables.antialiasing;
			city.setGraphicSize(Std.int(city.width * 0.85));
			city.updateHitbox();
			add(city);

			phillyCityLights = new FlxTypedGroup<FlxSprite>();
			add(phillyCityLights);

			for (i in 0...5)
			{
				var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('philly/win' + i));
				light.scrollFactor.set(0.3, 0.3);
				light.visible = false;
				light.setGraphicSize(Std.int(light.width * 0.85));
				light.updateHitbox();
				light.antialiasing = _variables.antialiasing;
				phillyCityLights.add(light);
			}

			var discoBall:FlxSprite = new FlxSprite(800, 0);
			discoBall.frames = Paths.getSparrowAtlas('philly/discoBall');
			discoBall.scrollFactor.set(0.45, 0.45);
			discoBall.animation.addByPrefix('discoBall', 'Glowing Ball', 24, true);
			discoBall.animation.play('discoBall');
			discoBall.antialiasing = _variables.antialiasing;
			discoBall.setGraphicSize(Std.int(discoBall.width * 1.3));
			add(discoBall);
			discoBall.visible = false;
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness >= 60)
				discoBall.visible = true;

			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -55)
				phillyCityLights.visible = false;

			var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('philly/behindTrain'));
			streetBehind.antialiasing = _variables.antialiasing;
			add(streetBehind);

			phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('philly/train'));
			phillyTrain.antialiasing = _variables.antialiasing;
			add(phillyTrain);

			trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
			FlxG.sound.list.add(trainSound);

			// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

			var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('philly/street'));
			street.antialiasing = _variables.antialiasing;
			add(street);

			var floorLights:FlxSprite = new FlxSprite(420, 70);
			floorLights.frames = Paths.getSparrowAtlas('philly/floorLights');
			floorLights.scrollFactor.set(1, 1);
			floorLights.animation.addByPrefix('floorLights', 'Floor Lights', 24, true);
			floorLights.animation.play('floorLights');
			floorLights.setGraphicSize(Std.int(floorLights.width * 3));
			floorLights.antialiasing = _variables.antialiasing;
			add(floorLights);
			floorLights.visible = false;
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness >= 30)
				floorLights.visible = true;
		}
		case 'limo':
		{
			curStage = 'limo';
			defaultCamZoom = 0.90;

			var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('limo/limoSunset'));
			skyBG.scrollFactor.set(0.1, 0.1);
			skyBG.antialiasing = _variables.antialiasing;
			add(skyBG);

			var TunnelBG:FlxSprite = new FlxSprite(-300, -100);
			TunnelBG.frames = Paths.getSparrowAtlas('limo/limoTunnel');
			TunnelBG.scrollFactor.set(0.25, 0.25);
			TunnelBG.animation.addByPrefix('tunnel', 'Tunnel');
			TunnelBG.animation.play('tunnel');
			TunnelBG.antialiasing = _variables.antialiasing;
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -55)
				add(TunnelBG);

			var limoStreet:FlxSprite = new FlxSprite(-850, -680);
			limoStreet.frames = Paths.getSparrowAtlas('limo/limoStreet');
			limoStreet.scrollFactor.set(0.25, 0.25);
			limoStreet.animation.addByPrefix('limoStreet', 'Tunnel');
			limoStreet.animation.play('limoStreet');
			limoStreet.antialiasing = _variables.antialiasing;
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness >= 45)
				add(limoStreet);

			var bgLimo:FlxSprite = new FlxSprite(-200, 480);
			bgLimo.frames = Paths.getSparrowAtlas('limo/bgLimo');
			bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
			bgLimo.animation.play('drive');
			bgLimo.scrollFactor.set(0.4, 0.4);
			bgLimo.antialiasing = _variables.antialiasing;
			add(bgLimo);

			grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
			add(grpLimoDancers);

			for (i in 0...5)
			{
				var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
				dancer.scrollFactor.set(0.4, 0.4);
				grpLimoDancers.add(dancer);
			}

			var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('limo/limoOverlay'));
			overlayShit.alpha = 0.5;
			overlayShit.antialiasing = _variables.antialiasing;
			// add(overlayShit);

			// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

			// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

			// overlayShit.shader = shaderBullshit;

			var limoTex = Paths.getSparrowAtlas('limo/limoDrive');

			limo = new FlxSprite(-120, 550);
			limo.frames = limoTex;
			limo.animation.addByPrefix('drive', "Limo stage", 24);
			limo.animation.play('drive');
			limo.antialiasing = _variables.antialiasing;

			fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('limo/fastCarLol'));
			// add(limo);
		}
		case 'mall':
		{
			curStage = 'mall';

			defaultCamZoom = 0.80;

			var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('christmas/bgWalls'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -65)
				bg = new FlxSprite(-1000, -500).loadGraphic(Paths.image('christmas/bgWallsLO'));
			bg.antialiasing = _variables.antialiasing;
			bg.scrollFactor.set(0.2, 0.2);
			bg.active = false;
			bg.setGraphicSize(Std.int(bg.width * 0.8));
			bg.updateHitbox();
			add(bg);

			upperBoppers = new FlxSprite(-240, -90);
			upperBoppers.frames = Paths.getSparrowAtlas('christmas/upperBop');
			upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
			upperBoppers.antialiasing = _variables.antialiasing;
			upperBoppers.scrollFactor.set(0.33, 0.33);
			upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
			upperBoppers.updateHitbox();
			add(upperBoppers);
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -30)
				upperBoppers.visible = false;

			var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image('christmas/bgEscalator'));
			bgEscalator.antialiasing = _variables.antialiasing;
			bgEscalator.scrollFactor.set(0.3, 0.3);
			bgEscalator.active = false;
			bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
			bgEscalator.updateHitbox();
			add(bgEscalator);

			var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('christmas/christmasTree'));
			tree.antialiasing = _variables.antialiasing;
			tree.scrollFactor.set(0.40, 0.40);
			add(tree);

			bottomBoppers = new FlxSprite(-300, 140);
			bottomBoppers.frames = Paths.getSparrowAtlas('christmas/bottomBop');
			bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
			bottomBoppers.antialiasing = _variables.antialiasing;
			bottomBoppers.scrollFactor.set(0.9, 0.9);
			bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
			bottomBoppers.updateHitbox();
			add(bottomBoppers);
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -45)
				bottomBoppers.visible = false;

			var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image('christmas/fgSnow'));
			fgSnow.active = false;
			fgSnow.antialiasing = _variables.antialiasing;
			add(fgSnow);

			santa = new FlxSprite(-840, 150);
			santa.frames = Paths.getSparrowAtlas('christmas/santa');
			santa.animation.addByPrefix('idle', 'santa idle in fear', 24, false);
			santa.antialiasing = _variables.antialiasing;
			add(santa);
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -70)
				santa.visible = false;
		}
		case 'mallEvil':
		{
			curStage = 'mallEvil';
			var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('christmas/evilBG'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -50)
				bg = new FlxSprite(-400, -500).loadGraphic(Paths.image('christmas/evilBGLO'));
			bg.antialiasing = _variables.antialiasing;
			bg.scrollFactor.set(0.2, 0.2);
			bg.active = false;
			bg.setGraphicSize(Std.int(bg.width * 0.8));
			bg.updateHitbox();
			add(bg);

			var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('christmas/evilTree'));
			evilTree.antialiasing = _variables.antialiasing;
			evilTree.scrollFactor.set(0.2, 0.2);
			add(evilTree);

			var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("christmas/evilSnow"));
			evilSnow.antialiasing = _variables.antialiasing;
			add(evilSnow);
		}
		case 'school':
		{
			curStage = 'school';

			// defaultCamZoom = 0.9;

			var bgSky = new FlxSprite().loadGraphic(Paths.image('weeb/weebSky'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -60)
				bgSky = new FlxSprite().loadGraphic(Paths.image('weeb/weebSkyLO'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness >= 20)
				bgSky = new FlxSprite().loadGraphic(Paths.image('weeb/weebSkyB'));
			bgSky.scrollFactor.set(0.1, 0.1);
			add(bgSky);

			var repositionShit = -200;

			var bgSchool:FlxSprite = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('weeb/weebSchool'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -60)
				bgSchool = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('weeb/weebSchoolLO'));
			bgSchool.scrollFactor.set(0.6, 0.90);
			add(bgSchool);

			var bgStreet:FlxSprite = new FlxSprite(repositionShit).loadGraphic(Paths.image('weeb/weebStreet'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -60)
				bgStreet = new FlxSprite(repositionShit).loadGraphic(Paths.image('weeb/weebStreetLO'));
			bgStreet.scrollFactor.set(0.95, 0.95);
			add(bgStreet);

			var fgTrees:FlxSprite = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('weeb/weebTreesBack'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -60)
				fgTrees = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('weeb/weebTreesBackLO'));
			fgTrees.scrollFactor.set(0.9, 0.9);
			add(fgTrees);

			var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
			var treetex = Paths.getPackerAtlas('weeb/weebTrees');
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -60)
				treetex = Paths.getPackerAtlas('weeb/weebTreesLO');
			bgTrees.frames = treetex;
			bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
			bgTrees.animation.play('treeLoop');
			bgTrees.scrollFactor.set(0.85, 0.85);
			add(bgTrees);

			var treeLeaves:FlxSprite = new FlxSprite(repositionShit, -40);
			treeLeaves.frames = Paths.getSparrowAtlas('weeb/petals');
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -60)
				treeLeaves.frames = Paths.getSparrowAtlas('weeb/petalsLO');
			treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
			treeLeaves.animation.play('leaves');
			treeLeaves.scrollFactor.set(0.85, 0.85);
			add(treeLeaves);

			var widShit = Std.int(bgSky.width * 6);

			bgSky.setGraphicSize(widShit);
			bgSchool.setGraphicSize(widShit);
			bgStreet.setGraphicSize(widShit);
			bgTrees.setGraphicSize(Std.int(widShit * 1.4));
			fgTrees.setGraphicSize(Std.int(widShit * 0.8));
			treeLeaves.setGraphicSize(widShit);

			fgTrees.updateHitbox();
			bgSky.updateHitbox();
			bgSchool.updateHitbox();
			bgStreet.updateHitbox();
			bgTrees.updateHitbox();
			treeLeaves.updateHitbox();

			bgGirls = new BackgroundGirls(-100, 190);
			bgGirls.scrollFactor.set(0.9, 0.9);

			if (SONG.song.toLowerCase() == 'roses')
			{
				bgGirls.getScared();
			}

			bgGirls.setGraphicSize(Std.int(bgGirls.width * daPixelZoom));
			bgGirls.updateHitbox();
			add(bgGirls);
			if (_modifiers.BrightnessSwitch && (_modifiers.Brightness <= -30 || _modifiers.Brightness >= 40 ))
				bgGirls.visible = false;
		}
		case 'schoolEvil':
		{
			curStage = 'schoolEvil';

			var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
			var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);

			var posX = 400;
			var posY = 200;

			var bg:FlxSprite = new FlxSprite(posX, posY);
			bg.frames = Paths.getSparrowAtlas('weeb/animatedEvilSchool');
			bg.animation.addByPrefix('idle', 'background 2', 24);
			bg.animation.play('idle');
			bg.scrollFactor.set(0.8, 0.9);
			bg.scale.set(6, 6);
			add(bg);
		}
		case 'tank':
		{
				defaultCamZoom = 0.9;
				curStage = 'tank';
				var bg:FlxSprite = new FlxSprite(-400,-400);
				bg.loadGraphic(Paths.image("tankSky"));
				bg.scrollFactor.set(0, 0);
				bg.antialiasing = true;
				//bg.setGraphicSize(Std.int(bg.width * 1.5));
				add(bg);

				var clouds:FlxSprite = new FlxSprite(FlxG.random.int(-700, -100), FlxG.random.int(-20, 20)).loadGraphic(Paths.image('tankClouds'));
				clouds.scrollFactor.set(0.1, 0.1);
				clouds.velocity.x = FlxG.random.float(5, 15);
				clouds.antialiasing = true;
				clouds.updateHitbox();
				add(clouds);

				var mountains:FlxSprite = new FlxSprite(-300,-20).loadGraphic(Paths.image('tankMountains'));
				mountains.scrollFactor.set(0.2, 0.2);
				mountains.setGraphicSize(Std.int(1.2 * mountains.width));
				mountains.updateHitbox();
				mountains.antialiasing = true;
				add(mountains);

				var buildings:FlxSprite = new FlxSprite(-200,0).loadGraphic(Paths.image('tankBuildings'));
				buildings.scrollFactor.set(0.3, 0.3);
				buildings.setGraphicSize(Std.int(buildings.width * 1.1));
				buildings.updateHitbox();
				buildings.antialiasing = true;
				add(buildings);

				var ruins:FlxSprite = new FlxSprite(-200,0).loadGraphic(Paths.image('tankRuins'));
				ruins.scrollFactor.set(0.35, 0.35);
				ruins.setGraphicSize(Std.int(ruins.width * 1.1));
				ruins.updateHitbox();
				ruins.antialiasing = true;
				add(ruins);


				var smokeLeft:FlxSprite = new FlxSprite(-200,-100);
				smokeLeft.frames = Paths.getSparrowAtlas('smokeLeft');
				smokeLeft.animation.addByPrefix('idle', 'SmokeBlurLeft ', 24, true);
				smokeLeft.scrollFactor.set(0.4, 0.4);
				smokeLeft.antialiasing = true;
				smokeLeft.animation.play('idle');
				
				add(smokeLeft);

				var smokeRight:FlxSprite = new FlxSprite(1100,-100);
				smokeRight.frames = Paths.getSparrowAtlas('smokeRight');
				smokeRight.animation.addByPrefix('idle', 'SmokeRight ', 24, true);
				smokeRight.scrollFactor.set(0.4, 0.4);
				smokeRight.antialiasing = true;
				smokeRight.animation.play('idle');
				
				add(smokeRight);


				tankWatchtower = new FlxSprite(100,30);
				tankWatchtower.frames = Paths.getSparrowAtlas('tankWatchtower');
				tankWatchtower.animation.addByPrefix('idle', 'watchtower gradient color instance 1', 24, false);
				tankWatchtower.scrollFactor.set(0.5, 0.5);
				tankWatchtower.antialiasing = true;
				
				
				add(tankWatchtower);

				
				tankRolling = new FlxSprite(300,300);
				tankRolling.frames = Paths.getSparrowAtlas('tankRolling');
				tankRolling.animation.addByPrefix('idle', 'BG tank w lighting ', 24, true);
				tankRolling.scrollFactor.set(0.5, 0.5);
				tankRolling.antialiasing = true;
				tankRolling.animation.play('idle');
				
				add(tankRolling);

				

				var ground:FlxSprite = new FlxSprite(-420,-150).loadGraphic(Paths.image('tankGround'));
				ground.scrollFactor.set();
				ground.antialiasing = true;
				ground.setGraphicSize(Std.int(ground.width * 1.15));
				ground.scrollFactor.set(1, 1);
				
				ground.updateHitbox();
				add(ground);

				moveTank();

				tank0 = new FlxSprite(-500,650);
				tank0.frames = Paths.getSparrowAtlas('tank0');
				tank0.animation.addByPrefix('idle', 'fg tankhead far right ', 24, false);
				tank0.scrollFactor.set(1.7, 1.5);
				tank0.antialiasing = true;
				
				tank0.updateHitbox();
				
				
				


				tank1 = new FlxSprite(-300,750);
				tank1.frames = Paths.getSparrowAtlas('tank1');
				tank1.animation.addByPrefix('idle', 'fg tankhead 5 ', 24, false);
				tank1.scrollFactor.set(2.0, 0.2);
				tank1.antialiasing = true;
				
				tank1.updateHitbox();
				
				
				


				tank2 = new FlxSprite(450,940);
				tank2.frames = Paths.getSparrowAtlas('tank2');
				tank2.animation.addByPrefix('idle', 'foreground man 3 ', 24, false);
				tank2.scrollFactor.set(1.5, 1.5);
				tank2.antialiasing = true;
				
				tank2.updateHitbox();
				
				


				tank3 = new FlxSprite(1300,1200);
				tank3.frames = Paths.getSparrowAtlas('tank3');
				tank3.animation.addByPrefix('idle', 'fg tankhead 4 ', 24, false);
				tank3.scrollFactor.set(3.5, 2.5);
				tank3.antialiasing = true;
				
				tank3.updateHitbox();
				
				


				tank4 = new FlxSprite(1300,900);
				tank4.frames = Paths.getSparrowAtlas('tank4');
				tank4.animation.addByPrefix('idle', 'fg tankman bobbin 3 ', 24, false);
				tank4.scrollFactor.set(1.5, 1.5);
				tank4.antialiasing = true;
				
				tank4.updateHitbox();
				
				

				tank5 = new FlxSprite(1620,700);
				tank5.frames = Paths.getSparrowAtlas('tank5');
				tank5.animation.addByPrefix('idle', 'fg tankhead far right ', 24, false);
				tank5.scrollFactor.set(1.5, 1.5);
				tank5.antialiasing = true;
				
				tank5.updateHitbox();
		}
		case 'tankstress':
		{
				defaultCamZoom = 0.9;
				curStage = 'tankstress';
				var bg:FlxSprite = new FlxSprite(-400,-400);
				bg.loadGraphic(Paths.image("tankSky"));
				bg.scrollFactor.set(0, 0);
				bg.antialiasing = true;
				//bg.setGraphicSize(Std.int(bg.width * 1.5));
				add(bg);

				var clouds:FlxSprite = new FlxSprite(FlxG.random.int(-700, -100), FlxG.random.int(-20, 20)).loadGraphic(Paths.image('tankClouds'));
				clouds.scrollFactor.set(0.1, 0.1);
				clouds.velocity.x = FlxG.random.float(5, 15);
				clouds.antialiasing = true;
				clouds.updateHitbox();
				add(clouds);

				var mountains:FlxSprite = new FlxSprite(-300,-20).loadGraphic(Paths.image('tankMountains'));
				mountains.scrollFactor.set(0.2, 0.2);
				mountains.setGraphicSize(Std.int(1.2 * mountains.width));
				mountains.updateHitbox();
				mountains.antialiasing = true;
				add(mountains);

				var buildings:FlxSprite = new FlxSprite(-200,0).loadGraphic(Paths.image('tankBuildings'));
				buildings.scrollFactor.set(0.3, 0.3);
				buildings.setGraphicSize(Std.int(buildings.width * 1.1));
				buildings.updateHitbox();
				buildings.antialiasing = true;
				add(buildings);

				var ruins:FlxSprite = new FlxSprite(-200,0).loadGraphic(Paths.image('tankRuins'));
				ruins.scrollFactor.set(0.35, 0.35);
				ruins.setGraphicSize(Std.int(ruins.width * 1.1));
				ruins.updateHitbox();
				ruins.antialiasing = true;
				add(ruins);


				var smokeLeft:FlxSprite = new FlxSprite(-200,-100);
				smokeLeft.frames = Paths.getSparrowAtlas('smokeLeft');
				smokeLeft.animation.addByPrefix('idle', 'SmokeBlurLeft ', 24, true);
				smokeLeft.scrollFactor.set(0.4, 0.4);
				smokeLeft.antialiasing = true;
				smokeLeft.animation.play('idle');
				
				add(smokeLeft);

				var smokeRight:FlxSprite = new FlxSprite(1100,-100);
				smokeRight.frames = Paths.getSparrowAtlas('smokeRight');
				smokeRight.animation.addByPrefix('idle', 'SmokeRight ', 24, true);
				smokeRight.scrollFactor.set(0.4, 0.4);
				smokeRight.antialiasing = true;
				smokeRight.animation.play('idle');
				
				add(smokeRight);


				tankWatchtower = new FlxSprite(100,30);
				tankWatchtower.frames = Paths.getSparrowAtlas('tankWatchtower');
				tankWatchtower.animation.addByPrefix('idle', 'watchtower gradient color instance 1', 24, false);
				tankWatchtower.scrollFactor.set(0.5, 0.5);
				tankWatchtower.antialiasing = true;
				
				
				add(tankWatchtower);

				
				tankRolling = new FlxSprite(300,300);
				tankRolling.frames = Paths.getSparrowAtlas('tankRolling');
				tankRolling.animation.addByPrefix('idle', 'BG tank w lighting ', 24, true);
				tankRolling.scrollFactor.set(0.5, 0.5);
				tankRolling.antialiasing = true;
				tankRolling.animation.play('idle');
				
				add(tankRolling);
				tankmanRun = new FlxTypedGroup<TankmenBG>();
				add(tankmanRun);

				var ground:FlxSprite = new FlxSprite(-420,-150).loadGraphic(Paths.image('tankGround'));
				ground.scrollFactor.set();
				ground.antialiasing = true;
				ground.setGraphicSize(Std.int(ground.width * 1.15));
				ground.scrollFactor.set(1, 1);
				
				ground.updateHitbox();
				add(ground);

				moveTank();

				tank0 = new FlxSprite(-500,650);
				tank0.frames = Paths.getSparrowAtlas('tank0');
				tank0.animation.addByPrefix('idle', 'fg tankhead far right ', 24, false);
				tank0.scrollFactor.set(1.7, 1.5);
				tank0.antialiasing = true;
				
				tank0.updateHitbox();
				
				
				


				tank1 = new FlxSprite(-300,750);
				tank1.frames = Paths.getSparrowAtlas('tank1');
				tank1.animation.addByPrefix('idle', 'fg tankhead 5 ', 24, false);
				tank1.scrollFactor.set(2.0, 0.2);
				tank1.antialiasing = true;
				
				tank1.updateHitbox();
				
				
				


				tank2 = new FlxSprite(450,940);
				tank2.frames = Paths.getSparrowAtlas('tank2');
				tank2.animation.addByPrefix('idle', 'foreground man 3 ', 24, false);
				tank2.scrollFactor.set(1.5, 1.5);
				tank2.antialiasing = true;
				
				tank2.updateHitbox();
				
				


				tank3 = new FlxSprite(1300,1200);
				tank3.frames = Paths.getSparrowAtlas('tank3');
				tank3.animation.addByPrefix('idle', 'fg tankhead 4 ', 24, false);
				tank3.scrollFactor.set(3.5, 2.5);
				tank3.antialiasing = true;
				
				tank3.updateHitbox();
				
				


				tank4 = new FlxSprite(1300,900);
				tank4.frames = Paths.getSparrowAtlas('tank4');
				tank4.animation.addByPrefix('idle', 'fg tankman bobbin 3 ', 24, false);
				tank4.scrollFactor.set(1.5, 1.5);
				tank4.antialiasing = true;
				
				tank4.updateHitbox();
				
				

				tank5 = new FlxSprite(1620,700);
				tank5.frames = Paths.getSparrowAtlas('tank5');
				tank5.animation.addByPrefix('idle', 'fg tankhead far right ', 24, false);
				tank5.scrollFactor.set(1.5, 1.5);
				tank5.antialiasing = true;
				
				tank5.updateHitbox();
		}
		case 'mallb':
		{
			curStage = 'mallb';

			defaultCamZoom = 0.80;

			var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('christmasb/bgWalls'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -65)
				bg = new FlxSprite(-1000, -500).loadGraphic(Paths.image('christmasb/bgWallsLO'));
			bg.antialiasing = _variables.antialiasing;
			bg.scrollFactor.set(0.2, 0.2);
			bg.active = false;
			bg.setGraphicSize(Std.int(bg.width * 0.8));
			bg.updateHitbox();
			add(bg);

			upperBoppers = new FlxSprite(-240, -90);
			upperBoppers.frames = Paths.getSparrowAtlas('christmasb/upperBop');
			upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
			upperBoppers.antialiasing = _variables.antialiasing;
			upperBoppers.scrollFactor.set(0.33, 0.33);
			upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
			upperBoppers.updateHitbox();
			add(upperBoppers);
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -30)
				upperBoppers.visible = false;

			var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image('christmasb/bgEscalator'));
			bgEscalator.antialiasing = _variables.antialiasing;
			bgEscalator.scrollFactor.set(0.3, 0.3);
			bgEscalator.active = false;
			bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
			bgEscalator.updateHitbox();
			add(bgEscalator);

			var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('christmasb/christmasTree'));
			tree.antialiasing = _variables.antialiasing;
			tree.scrollFactor.set(0.40, 0.40);
			add(tree);

			bottomBoppers = new FlxSprite(-300, 140);
			bottomBoppers.frames = Paths.getSparrowAtlas('christmasb/bottomBop');
			bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
			bottomBoppers.antialiasing = _variables.antialiasing;
			bottomBoppers.scrollFactor.set(0.9, 0.9);
			bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
			bottomBoppers.updateHitbox();
			add(bottomBoppers);
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -45)
				bottomBoppers.visible = false;

			var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image('christmasb/fgSnow'));
			fgSnow.active = false;
			fgSnow.antialiasing = _variables.antialiasing;
			add(fgSnow);

			santa = new FlxSprite(-840, 150);
			santa.frames = Paths.getSparrowAtlas('christmasb/santa');
			santa.animation.addByPrefix('idle', 'santa idle in fear', 24, false);
			santa.antialiasing = _variables.antialiasing;
			add(santa);
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -70)
				santa.visible = false;
		}
		case 'mallbEvil':
		{
			curStage = 'mallbEvil';
			var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('christmasb/evilBG'));
			if (_modifiers.BrightnessSwitch && _modifiers.Brightness <= -50)
				bg = new FlxSprite(-400, -500).loadGraphic(Paths.image('christmasb/evilBGLO'));
			bg.antialiasing = _variables.antialiasing;
			bg.scrollFactor.set(0.2, 0.2);
			bg.active = false;
			bg.setGraphicSize(Std.int(bg.width * 0.8));
			bg.updateHitbox();
			add(bg);

			var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('christmasb/evilTree'));
			evilTree.antialiasing = _variables.antialiasing;
			evilTree.scrollFactor.set(0.2, 0.2);
			add(evilTree);

			var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("christmasb/evilSnow"));
			evilSnow.antialiasing = _variables.antialiasing;
			add(evilSnow);
		}
		case 'stageneo':
			{
					defaultCamZoom = 0.9;
					curStage = 'stageneo';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageneo/stageback'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stageneo/stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);

					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stageneo/stagecurtains'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = true;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;

					add(stageCurtains);
			}
		case 'spookyneo': 
			{
				curStage = 'spookyneo';
				halloweenLevel = true;

				var hallowTex = Paths.getSparrowAtlas('spookyneo/halloween_bg');

				halloweenBG = new FlxSprite(-200, -100);
				halloweenBG.frames = hallowTex;
				halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
				halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
				halloweenBG.animation.play('idle');
				halloweenBG.antialiasing = true;
				add(halloweenBG);
				
				leftboom = new FlxSprite(0, 550);
				leftboom.frames = Paths.getSparrowAtlas('spookyneo/BoomLEFT');
				leftboom.animation.addByPrefix('boom', 'stereo boom', 24, false);
				leftboom.antialiasing = true;
				leftboom.scrollFactor.set(1, 1);
				leftboom.updateHitbox();
				add(leftboom);

				rightboom = new FlxSprite(1150, 550);
				rightboom.frames = Paths.getSparrowAtlas('spookyneo/BoomRIGHT');
				rightboom.animation.addByPrefix('boom', 'stereo boom', 24, false);
				rightboom.antialiasing = true;
				rightboom.scrollFactor.set(1, 1);
				rightboom.updateHitbox();
				add(rightboom);
				
				isHalloween = true;
			}
		case 'phillyneo': 
			{
				curStage = 'phillyneo';

				var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('phillyneo/sky'));
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);

					var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('phillyneo/city'));
				city.scrollFactor.set(0.3, 0.3);
				city.setGraphicSize(Std.int(city.width * 0.85));
				city.updateHitbox();
				add(city);

				phillyCityLights = new FlxTypedGroup<FlxSprite>();
				add(phillyCityLights);

				for (i in 0...5)
				{
						var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('phillyneo/win' + i));
						light.scrollFactor.set(0.3, 0.3);
						light.visible = false;
						light.setGraphicSize(Std.int(light.width * 0.85));
						light.updateHitbox();
						light.antialiasing = true;
						phillyCityLights.add(light);
				}

				var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('phillyneo/behindTrain'));
				add(streetBehind);

					phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('phillyneo/train'));
				add(phillyTrain);

				trainSound = new FlxSound().loadEmbedded(Paths.sound('cop_passes'));
				FlxG.sound.list.add(trainSound);

				// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

				var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('phillyneo/street'));
					add(street);
			}
		case 'limoneo':
			{
					curStage = 'limoneo';
					defaultCamZoom = 0.60;

					var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('limoneo/limoSunset'));
					skyBG.scrollFactor.set(0.1, 0.1);
					skyBG.setGraphicSize(Std.int(skyBG.width * 2));
					add(skyBG);

					var limoTex = Paths.getSparrowAtlas('limoneo/limoDrive');

					limo = new FlxSprite(-50, 715);
					limo.frames = limoTex;
					limo.animation.addByPrefix('drive', "Limo stage", 24);
					limo.animation.play('drive');
					limo.setGraphicSize(Std.int(limo.width * 1.45));
					limo.antialiasing = true;

					add(limo);
					for (i in 0...15)
					{
						var cloud2:FlxSprite = new FlxSprite((370 * i) + 300, 550).loadGraphic(Paths.image('limoneo/cloud'));
							add(cloud2);
					}

					for (i in 0...15)
					{
							var cloud:FlxSprite = new FlxSprite((370 * i) + 300, 550).loadGraphic(Paths.image('limoneo/cloud'));
							add(cloud);
					}
			}
		case 'ally':
			{
				defaultCamZoom = 0.9;
				curStage = 'ally';
				var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('ally/whittyBack'));
				bg.antialiasing = _variables.antialiasing;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;
				add(bg);

				var whittyFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('ally/whittyFront'));
				whittyFront.setGraphicSize(Std.int(whittyFront.width * 1.1));
				whittyFront.updateHitbox();
				whittyFront.antialiasing = _variables.antialiasing;
				whittyFront.scrollFactor.set(0.9, 0.9);
				whittyFront.active = false;
				add(whittyFront);
			}
		case 'allycrazy':
			{
				defaultCamZoom = 0.9;
				curStage = 'allycrazy';
				//Defines the variable as a sprite (image)
				ballisticbg = new FlxSprite(-600, -100);
				
				//Gets the png
				ballisticbg.frames = Paths.getSparrowAtlas('ally/BallisticBackground');
				
				//Gets the animation name from the .XML (MUST HAVE THE SAME ANIMATION NAME AS IN THE XML)
				ballisticbg.animation.addByPrefix('start', 'Background Whitty Start', 24, false);
                ballisticbg.animation.addByPrefix('gaming', 'Background Whitty Startup', 24, false);
				ballisticbg.animation.addByPrefix('gameButMove', "Background Whitty Moving0", 16, false);
				
				//Random stuff that positions and edits the image
				ballisticbg.antialiasing = _variables.antialiasing;
				ballisticbg.scrollFactor.set(0.9, 0.9);
				ballisticbg.updateHitbox();
				ballisticbg.active = true;
				add(ballisticbg);
			}
		case 'basketball':
			{
					defaultCamZoom = 0.9;
					curStage = 'basketball';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('day/stageback'));
					bg.antialiasing = _variables.antialiasing;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('day/stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = _variables.antialiasing;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);
			}
		case 'basketballsunset':
			{
					defaultCamZoom = 0.9;
					curStage = 'basketballsunset';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('sunset/stageback'));
					bg.antialiasing = _variables.antialiasing;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('sunset/stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = _variables.antialiasing;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);
			}
		case 'basketballnight':
			{
					defaultCamZoom = 0.9;
					curStage = 'basketballnight';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('night/stageback'));
					bg.antialiasing = _variables.antialiasing;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('night/stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = _variables.antialiasing;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);
			}
		case 'basketballglitcher':
			{
					defaultCamZoom = 0.9;
					curStage = 'basketballglitcher';
					
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('glitcher/stageback'));
					bg.antialiasing = _variables.antialiasing;
					bg.scrollFactor.set(0.9, 0.9);
					add(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('glitcher/stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = _variables.antialiasing;
					stageFront.scrollFactor.set(0.9, 0.9);
					add(stageFront);

					wire = new FlxSprite(-600, -200).loadGraphic(Paths.image('WIRE/WIREStageBack'));
					wire.antialiasing = _variables.antialiasing;
					wire.scrollFactor.set(0.9, 0.9);
					wire.visible = false;
			}
		case 'garAlley':
			{
					defaultCamZoom = 0.9;
					curStage = 'garAlley';

					var bg:FlxSprite = new FlxSprite(-500, -170).loadGraphic(Paths.image('garStagebg'));
					bg.antialiasing = _variables.antialiasing;
					bg.scrollFactor.set(0.7, 0.7);
					bg.active = false;
					add(bg);

					var bgAlley:FlxSprite = new FlxSprite(-500, -200).loadGraphic(Paths.image('garStage'));
					bgAlley.antialiasing = _variables.antialiasing;
					bgAlley.scrollFactor.set(0.9, 0.9);
					bgAlley.active = false;
					add(bgAlley);

			}
		case 'garAlleyDead':
			{
					defaultCamZoom = 0.9;
					curStage = 'garAlleyDead';

					var bg:FlxSprite = new FlxSprite(-500, -170).loadGraphic(Paths.image('garStagebgAlt'));
					bg.antialiasing = _variables.antialiasing;
					bg.scrollFactor.set(0.7, 0.7);
					bg.active = false;
					add(bg);

					var smoker:FlxSprite = new FlxSprite(0, -290);
					smoker.frames = Paths.getSparrowAtlas('garSmoke');
					smoker.setGraphicSize(Std.int(smoker.width * 1.7));
					smoker.alpha = 0.3;
					smoker.animation.addByPrefix('garsmoke', "smokey", 13);
					smoker.animation.play('garsmoke');
					smoker.scrollFactor.set(0.7, 0.7);
					add(smoker);

					var bgAlley:FlxSprite = new FlxSprite(-500, -200).loadGraphic(Paths.image('garStagealt'));
					bgAlley.antialiasing = _variables.antialiasing;
					bgAlley.scrollFactor.set(0.9, 0.9);
					bgAlley.active = false;
					add(bgAlley);

					var corpse:FlxSprite = new FlxSprite(-230, 540).loadGraphic(Paths.image('gardead'));
					corpse.antialiasing = _variables.antialiasing;
					corpse.scrollFactor.set(0.9, 0.9);
					corpse.active = false;
					add(corpse);

			}
		case 'garAlleyDip':
			{
					defaultCamZoom = 0.9;
					curStage = 'garAlleyDip';

					var bg:FlxSprite = new FlxSprite(-500, -170).loadGraphic(Paths.image('garStagebgRise'));
					bg.antialiasing = _variables.antialiasing;
					bg.scrollFactor.set(0.7, 0.7);
					bg.active = false;
					add(bg);

					var bgAlley:FlxSprite = new FlxSprite(-500, -200).loadGraphic(Paths.image('garStageRise'));
					bgAlley.antialiasing = _variables.antialiasing;
					bgAlley.scrollFactor.set(0.9, 0.9);
					bgAlley.active = false;
					add(bgAlley);

					var corpse:FlxSprite = new FlxSprite(-230, 540).loadGraphic(Paths.image('gardead'));
					corpse.antialiasing = _variables.antialiasing;
					corpse.scrollFactor.set(0.9, 0.9);
					corpse.active = false;
					add(corpse);

			}
		case 'curse':
			{
				defaultCamZoom = 0.8;
				curStage = 'curse';
				var bg:FlxSprite = new FlxSprite(-600, -300).loadGraphic(Paths.image('tabi/normal_stage'));
				bg.antialiasing = _variables.antialiasing;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;
				add(bg);
			}
		case 'genocide':
		{
			defaultCamZoom = 0.8;
			curStage = 'genocide';
			/*var bg:FlxSprite = new FlxSprite(-600, -300).loadGraphic(Paths.image('tabi/mad/youhavebeendestroyed'));
			bg.antialiasing = _variables.antialiasing;
			bg.scrollFactor.set(0.9, 0.9);
			bg.active = false;
			add(bg);
			var fireRow:FlxTypedGroup<TabiFire> = new FlxTypedGroup<TabiFire>();
			for (i in 0...3)
			{
				fireRow.add(new TabiFire(10 + (i * 450), 200));
			}
			add(fireRow);*/
			//and a 1 and a 2 and a 3 and your pc is fucked lol
			/*var prefixShit:String = 'fuckedpc/PNG_Sequence/StageFire';
			var shitList:Array<String> = [];
			for (i in 0...84)
			{
				var ourUse:Array<String> = [Std.string(i)];
				var ourUse2:Array<String> = Std.string(i).split("");
				while (ourUse2.length < 2)
				{
					ourUse.push("0");
					ourUse2.push("0");
				}
				ourUse.reverse();
				//trace(ourUse);
				shitList.push(prefixShit + ourUse.join(""));
			}*/
			
			siniFireBehind = new FlxTypedGroup<SiniFire>();
			siniFireFront = new FlxTypedGroup<SiniFire>();
			
			//genocideBG = new SequenceBG(-600, -300, shitList, true, 2560, 1400, true);
			genocideBG = new FlxSprite(-600, -300).loadGraphic(Paths.image('fire/wadsaaa'));
			genocideBG.antialiasing = _variables.antialiasing;
			genocideBG.scrollFactor.set(0.9, 0.9);
			add(genocideBG);
			
			//Time for sini's amazing fires lol
			//this one is behind the board
			//idk how to position this
			//i guess fuck my life lol
			for (i in 0...2)
			{
				var daFire:SiniFire = new SiniFire(genocideBG.x + (720 + (((95 * 10) / 2) * i)), genocideBG.y + 180, true, false, 30, i * 10, 84);
				daFire.antialiasing = _variables.antialiasing;
				daFire.scrollFactor.set(0.9, 0.9);
				daFire.scale.set(0.4, 1);
				daFire.y += 50;
				siniFireBehind.add(daFire);
			}
			
			add(siniFireBehind);
			
			//genocide board is already in genocidebg but u know shit layering for fire lol
			genocideBoard = new FlxSprite(genocideBG.x, genocideBG.y).loadGraphic(Paths.image('fire/boards'));
			genocideBoard.antialiasing = _variables.antialiasing;
			genocideBoard.scrollFactor.set(0.9, 0.9);
			add(genocideBoard);
			
			//front fire shit

			var fire1:SiniFire = new SiniFire(genocideBG.x + (-100), genocideBG.y + 889, true, false, 30);
			fire1.antialiasing = _variables.antialiasing;
			fire1.scrollFactor.set(0.9, 0.9);
			fire1.scale.set(2.5, 1.5);
			fire1.y -= fire1.height * 1.5;
			fire1.flipX = true;
			
			var fire2:SiniFire = new SiniFire((fire1.x + fire1.width) - 80, genocideBG.y + 889, true, false, 30);
			fire2.antialiasing = _variables.antialiasing;
			fire2.scrollFactor.set(0.9, 0.9);
			//fire2.scale.set(2.5, 1);
			fire2.y -= fire2.height * 1;
			
			var fire3:SiniFire = new SiniFire((fire2.x + fire2.width) - 30, genocideBG.y + 889, true, false, 30);
			fire3.antialiasing = _variables.antialiasing;
			fire3.scrollFactor.set(0.9, 0.9);
			//fire3.scale.set(2.5, 1);
			fire3.y -= fire3.height * 1;
			
			var fire4:SiniFire = new SiniFire((fire3.x + fire3.width) - 10, genocideBG.y + 889, true, false, 30);
			fire4.antialiasing = _variables.antialiasing;
			fire4.scrollFactor.set(0.9, 0.9);
			fire4.scale.set(1.5, 1.5);
			fire4.y -= fire4.height * 1.5;

			siniFireFront.add(fire1);
			siniFireFront.add(fire2);
			siniFireFront.add(fire3);
			siniFireFront.add(fire4);

			add(siniFireFront);
			
			//more layering shit
			var fuckYouFurniture:FlxSprite = new FlxSprite(genocideBG.x, genocideBG.y).loadGraphic(Paths.image('fire/glowyfurniture'));
			fuckYouFurniture.antialiasing = _variables.antialiasing;
			fuckYouFurniture.scrollFactor.set(0.9, 0.9);
			add(fuckYouFurniture);
		}
		case 'shaggystage':
			{
				defaultCamZoom = 0.9;
				curStage = 'shaggystage';
				var bg:FlxSprite = new FlxSprite(-400, -160).loadGraphic(Paths.image('bgshaggy'));
				bg.setGraphicSize(Std.int(bg.width * 1.5));
				bg.antialiasing = _variables.antialiasing;
				bg.scrollFactor.set(0.95, 0.95);
				bg.active = false;
				add(bg);

				var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
			}
		case 'shaggysky':
			{
				defaultCamZoom = 0.65;
				curStage = 'shaggysky';

				var sky = new FlxSprite(-850, -850);
				sky.frames = Paths.getSparrowAtlas('god_bg');
				sky.animation.addByPrefix('sky', "bg", 30);
				sky.setGraphicSize(Std.int(sky.width * 0.8));
				sky.animation.play('sky');
				sky.scrollFactor.set(0.1, 0.1);
				sky.antialiasing = _variables.antialiasing;
				add(sky);

				var bgcloud = new FlxSprite(-850, -1250);
				bgcloud.frames = Paths.getSparrowAtlas('god_bg');
				bgcloud.animation.addByPrefix('c', "cloud_smol", 30);
				//bgcloud.setGraphicSize(Std.int(bgcloud.width * 0.8));
				bgcloud.animation.play('c');
				bgcloud.scrollFactor.set(0.3, 0.3);
				bgcloud.antialiasing = _variables.antialiasing;
				add(bgcloud);

				add(new MansionDebris(300, -800, 'norm', 0.4, 1, 0, 1));
				add(new MansionDebris(600, -300, 'tiny', 0.4, 1.5, 0, 1));
				add(new MansionDebris(-150, -400, 'spike', 0.4, 1.1, 0, 1));
				add(new MansionDebris(-750, -850, 'small', 0.4, 1.5, 0, 1));

				/*
				add(new MansionDebris(-300, -1700, 'norm', 0.5, 1, 0, 1));
				add(new MansionDebris(-600, -1100, 'tiny', 0.5, 1.5, 0, 1));
				add(new MansionDebris(900, -1850, 'spike', 0.5, 1.2, 0, 1));
				add(new MansionDebris(1500, -1300, 'small', 0.5, 1.5, 0, 1));
				*/

				add(new MansionDebris(-300, -1700, 'norm', 0.75, 1, 0, 1));
				add(new MansionDebris(-1000, -1750, 'rect', 0.75, 2, 0, 1));
				add(new MansionDebris(-600, -1100, 'tiny', 0.75, 1.5, 0, 1));
				add(new MansionDebris(900, -1850, 'spike', 0.75, 1.2, 0, 1));
				add(new MansionDebris(1500, -1300, 'small', 0.75, 1.5, 0, 1));
				add(new MansionDebris(-600, -800, 'spike', 0.75, 1.3, 0, 1));
				add(new MansionDebris(-1000, -900, 'small', 0.75, 1.7, 0, 1));

				var fgcloud = new FlxSprite(-1150, -2900);
				fgcloud.frames = Paths.getSparrowAtlas('god_bg');
				fgcloud.animation.addByPrefix('c', "cloud_big", 30);
				//bgcloud.setGraphicSize(Std.int(bgcloud.width * 0.8));
				fgcloud.animation.play('c');
				fgcloud.scrollFactor.set(0.9, 0.9);
				fgcloud.antialiasing = _variables.antialiasing;
				add(fgcloud);

				var bg:FlxSprite = new FlxSprite(-400, -160).loadGraphic(Paths.image('bgshaggy'));
				bg.setGraphicSize(Std.int(bg.width * 1.5));
				bg.antialiasing = _variables.antialiasing;
				bg.scrollFactor.set(0.95, 0.95);
				bg.active = false;
				add(bg);

				var techo = new FlxSprite(0, -20);
				techo.frames = Paths.getSparrowAtlas('god_bg');
				techo.animation.addByPrefix('r', "broken_techo", 30);
				techo.setGraphicSize(Std.int(techo.frameWidth * 1.5));
				techo.animation.play('r');
				techo.scrollFactor.set(0.95, 0.95);
				techo.antialiasing = _variables.antialiasing;
				add(techo);

				gf_rock = new FlxSprite(20, 20);
				gf_rock.frames = Paths.getSparrowAtlas('god_bg');
				gf_rock.animation.addByPrefix('rock', "gf_rock", 30);
				gf_rock.animation.play('rock');
				gf_rock.scrollFactor.set(0.8, 0.8);
				gf_rock.antialiasing = _variables.antialiasing;
				add(gf_rock);

				rock = new FlxSprite(20, 20);
				rock.frames = Paths.getSparrowAtlas('god_bg');
				rock.animation.addByPrefix('rock', "rock", 30);
				rock.animation.play('rock');
				rock.scrollFactor.set(1, 1);
				rock.antialiasing = _variables.antialiasing;
				add(rock);
			}
			case 'swordarena':
			{
					defaultCamZoom = 0.8;
					curStage = 'swordarena';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('arena-bg'));
					bg.antialiasing = _variables.antialiasing;
					bg.scrollFactor.set(0.9, 0.9);
					bg.setGraphicSize(Std.int(bg.width * 1));
					bg.active = false;
					add(bg);

					bgBoppers = new FlxSprite(-600, 140);
					bgBoppers.frames = Paths.getSparrowAtlas('arena-characters');
					bgBoppers.animation.addByPrefix('bop', "bg-characters", 24, false);
					bgBoppers.antialiasing = _variables.antialiasing;
					bgBoppers.scrollFactor.set(0.99, 0.9);
					bgBoppers.setGraphicSize(Std.int(bgBoppers.width * 1));
					bgBoppers.updateHitbox();
					add(bgBoppers);

					var bgRail:FlxSprite = new FlxSprite(-600, 320).loadGraphic(Paths.image('railing'));
					bgRail.antialiasing = _variables.antialiasing;
					bgRail.scrollFactor.set(0.9, 0.9);
					bgRail.active = false;
					bgRail.setGraphicSize(Std.int(bgRail.width * 1));
					bgRail.updateHitbox();
					add(bgRail);
			}
			case 'arenanight':
			{
					defaultCamZoom = 0.9;
					curStage = 'arenanight';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('boxingnight1'));
					bg.antialiasing = _variables.antialiasing;
					bg.scrollFactor.set(0, 0);
					bg.setGraphicSize(Std.int(bg.width * 1));
					bg.active = false;
					add(bg);

					var bg2:FlxSprite = new FlxSprite(-800, -200).loadGraphic(Paths.image('boxingnight2'));
					bg2.antialiasing = _variables.antialiasing;
					bg2.scrollFactor.set(1.2, 1.2);
					bg2.setGraphicSize(Std.int(bg.width * 1.3));
					bg2.active = false;
					add(bg2);

					var bg3:FlxSprite = new FlxSprite(-600, -400).loadGraphic(Paths.image('boxingnight3'));
					bg3.antialiasing = _variables.antialiasing;
					bg3.scrollFactor.set(0.9, 0.9);
					bg3.setGraphicSize(Std.int(bg.width * 0.9));
					bg3.active = false;
					add(bg3);
			}
			case 'boxwiik3':
			{
					defaultCamZoom = 0.9;
					curStage = 'boxwiik3';
                    var boxwall:FlxSprite = new FlxSprite(-400, -200);
					boxwall.frames = Paths.getSparrowAtlas('matt/boxwall');
					boxwall.animation.addByPrefix('wallbang', "wallboom", 24);
					boxwall.animation.play('wallbang');
					boxwall.scrollFactor.set(0.9, 0.9);
					add(boxwall);
					
					var boxfloor:FlxSprite = new FlxSprite(-400, -250);
					boxfloor.frames = Paths.getSparrowAtlas('matt/boxfloor');
					boxfloor.animation.addByPrefix('floorbang', "floorboom", 24);
					boxfloor.animation.play('floorbang');
					boxfloor.scrollFactor.set(0.9, 0.9);
					add(boxfloor);
					
			}
			case 'boxTKO':
			{
					defaultCamZoom = 0.9;
					curStage = 'boxTKO';
                    var whitewall:FlxSprite = new FlxSprite(-400, -200).loadGraphic(Paths.image('matt/backwhite'));
					whitewall.antialiasing = true;
					whitewall.scrollFactor.set(0.9, 0.9);
					whitewall.active = false;
					add(whitewall);
					
					var floorblack:FlxSprite = new FlxSprite(-400, -250).loadGraphic(Paths.image('matt/floorblack'));
					floorblack.antialiasing = true;
					floorblack.scrollFactor.set(0.9, 0.9);
					floorblack.active = false;
					add(floorblack);
			}
			case 'boxKHF':
			{
                    defaultCamZoom = 0.9;
					curStage = 'boxKHF';
                    var backtroll:FlxSprite = new FlxSprite(-400, -200).loadGraphic(Paths.image('matt/backtroll'));
					backtroll.antialiasing = true;
					backtroll.scrollFactor.set(0.9, 0.9);
					backtroll.active = false;
					add(backtroll);
					
					var floortroll:FlxSprite = new FlxSprite(-400, -250).loadGraphic(Paths.image('matt/floortroll'));
					floortroll.antialiasing = true;
					floortroll.scrollFactor.set(0.9, 0.9);
					floortroll.active = false;
					add(floortroll);
			}
			case 'nevada':
				{
					//trace("line 538");
					defaultCamZoom = 0.75;
					curStage = 'nevada';
		
					tstatic.antialiasing = true;
					tstatic.scrollFactor.set(0,0);
					tstatic.setGraphicSize(Std.int(tstatic.width * 8.3));
					tstatic.animation.add('static', [0, 1, 2], 24, true);
					tstatic.animation.play('static');
		
					tstatic.alpha = 0;
		
					var bg:FlxSprite = new FlxSprite(-350, -300).loadGraphic(Paths.image('red'));
					// bg.setGraphicSize(Std.int(bg.width * 2.5));
					// bg.updateHitbox();
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					var stageFront:FlxSprite;
					if (SONG.song.toLowerCase() != 'madness')
					{
						add(bg);
						stageFront = new FlxSprite(-1100, -460).loadGraphic(Paths.image('island_but_dumb'));
					}
					else
						stageFront = new FlxSprite(-1100, -460).loadGraphic(Paths.image('island_but_rocks_float'));
		
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.4));
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);
					
					MAINLIGHT = new FlxSprite(-470, -150).loadGraphic(Paths.image('hue'));
					MAINLIGHT.alpha - 0.3;
					MAINLIGHT.setGraphicSize(Std.int(MAINLIGHT.width * 0.9));
					MAINLIGHT.blend = "screen";
					MAINLIGHT.updateHitbox();
					MAINLIGHT.antialiasing = true;
					MAINLIGHT.scrollFactor.set(1.2, 1.2);
				}
				case 'nevadaSpook':
				{
					//trace("line 538");
					defaultCamZoom = 0.35;
					curStage = 'nevadaSpook';
		
					tstatic.antialiasing = true;
					tstatic.scrollFactor.set(0,0);
					tstatic.setGraphicSize(Std.int(tstatic.width * 10));
					tstatic.screenCenter(Y);
					tstatic.animation.add('static', [0, 1, 2], 24, true);
					tstatic.animation.play('static');
		
					tstatic.alpha = 0;
		
					var bg:FlxSprite = new FlxSprite(-1000, -1000).loadGraphic(Paths.image('fourth/bg'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.setGraphicSize(Std.int(bg.width * 5));
					bg.active = false;
					add(bg);
		
					var stageFront:FlxSprite = new FlxSprite(-2000, -400).loadGraphic(Paths.image('hellclwn/island_but_red'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 2.6));
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);
					
					hank = new FlxSprite(60,-170);
					hank.frames = Paths.getSparrowAtlas('hellclwn/Hank');
					hank.animation.addByPrefix('dance','Hank',24);
					hank.animation.play('dance');
					hank.scrollFactor.set(0.9, 0.9);
					hank.setGraphicSize(Std.int(hank.width * 1.55));
					hank.antialiasing = true;
					
		
					add(hank);
				}
				case 'auditorHell':
				{
					//trace("line 538");
					defaultCamZoom = 0.55;
					curStage = 'auditorHell';
		
					tstatic.antialiasing = true;
					tstatic.scrollFactor.set(0,0);
					tstatic.setGraphicSize(Std.int(tstatic.width * 8.3));
					tstatic.animation.add('static', [0, 1, 2], 24, true);
					tstatic.animation.play('static');
		
					tstatic.alpha = 0;
		
					var bg:FlxSprite = new FlxSprite(-10, -10).loadGraphic(Paths.image('fourth/bg'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					bg.setGraphicSize(Std.int(bg.width * 4));
					add(bg);

					holetricky.antialiasing = true;
					holetricky.scrollFactor.set(0.9, 0.9);
					holetricky.setGraphicSize(Std.int(holetricky.width * 1.55));	

					converHoletricky.antialiasing = true;
					converHoletricky.scrollFactor.set(0.9, 0.9);
					converHoletricky.setGraphicSize(Std.int(converHoletricky.width * 1.3));
					
					covertricky.antialiasing = true;
					covertricky.scrollFactor.set(0.9, 0.9);
					covertricky.setGraphicSize(Std.int(covertricky.width * 1.55));
		
					var energyWall:FlxSprite = new FlxSprite(1350,-690).loadGraphic(Paths.image("fourth/Energywall"));
					energyWall.antialiasing = true;
					energyWall.scrollFactor.set(0.9, 0.9);
					add(energyWall);
					
					var stageFront:FlxSprite = new FlxSprite(-350, -355).loadGraphic(Paths.image('fourth/daBackground'));
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.55));
					add(stageFront);
				}
			case 'sabotage':
				{
					defaultCamZoom = 0.9;
					curStage = 'sabotage';
					var bg:FlxSprite = new FlxSprite(-200, -300).loadGraphic(Paths.image('polusSky'));
					bg.setGraphicSize(Std.int(bg.width * 1.5));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.5, 0.5);
					bg.active = false;
					add(bg);


					var rocks:FlxSprite = new FlxSprite(-800, -300).loadGraphic(Paths.image('polusrocks'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.6, 0.6);
					rocks.active = false;
					add(rocks);

				
					var rocks:FlxSprite = new FlxSprite(-450, -200).loadGraphic(Paths.image('polusWarehouse'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.9, 0.9);
					rocks.active = false;
					add(rocks);
					
					var rocks:FlxSprite = new FlxSprite(-1000, 0).loadGraphic(Paths.image('polusHills'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.9, 0.9);
					rocks.active = false;
					add(rocks);

					var stageFront:FlxSprite = new FlxSprite(-400, 450).loadGraphic(Paths.image('polusGround'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.5));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(1, 1);
					stageFront.active = false;
					add(stageFront);


					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = true;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;


				}
			case 'meltdown':
			{
					defaultCamZoom = 0.9;
					curStage = 'meltdown';
					var bg:FlxSprite = new FlxSprite(-200, -300).loadGraphic(Paths.image('polusSky'));
					bg.setGraphicSize(Std.int(bg.width * 1.5));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.5, 0.5);
					bg.active = false;
					add(bg);


					var rocks:FlxSprite = new FlxSprite(-800, -300).loadGraphic(Paths.image('polusrocks'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.6, 0.6);
					rocks.active = false;
					add(rocks);

				
					var rocks:FlxSprite = new FlxSprite(-450, -200).loadGraphic(Paths.image('polusWarehouse'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.9, 0.9);
					rocks.active = false;
					add(rocks);
					
					var rocks:FlxSprite = new FlxSprite(-1000, 0).loadGraphic(Paths.image('polusHills'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.9, 0.9);
					rocks.active = false;
					add(rocks);

					crowd = new MogusBoppers(0, 150);
					crowd.setGraphicSize(Std.int(crowd.width * 1.5));
					crowd.updateHitbox();
					crowd.scrollFactor.set(0.9, 0.9);
					crowd.active = false;
					add(crowd);

					var stageFront:FlxSprite = new FlxSprite(-400, 450).loadGraphic(Paths.image('polusGround'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.5));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(1, 1);
					stageFront.active = false;
					add(stageFront);


					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = true;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;


			}
			case 'sussus-moogus':
			{
					defaultCamZoom = 0.9;
					curStage = 'sussus-moogus';
					var bg:FlxSprite = new FlxSprite(-200, -300).loadGraphic(Paths.image('polusSky'));
					bg.setGraphicSize(Std.int(bg.width * 1.5));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.5, 0.5);
					bg.active = false;
					add(bg);


					var rocks:FlxSprite = new FlxSprite(-800, -300).loadGraphic(Paths.image('polusrocks'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.6, 0.6);
					rocks.active = false;
					add(rocks);

				
					var rocks:FlxSprite = new FlxSprite(-450, -200).loadGraphic(Paths.image('polusWarehouse'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.9, 0.9);
					rocks.active = false;
					add(rocks);
					
					var rocks:FlxSprite = new FlxSprite(-1000, 0).loadGraphic(Paths.image('polusHills'));
					rocks.setGraphicSize(Std.int(rocks.width * 1.5));
					rocks.updateHitbox();
					rocks.antialiasing = true;
					rocks.scrollFactor.set(0.9, 0.9);
					rocks.active = false;
					add(rocks);

					var stageFront:FlxSprite = new FlxSprite(-400, 450).loadGraphic(Paths.image('polusGround'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.5));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(1, 1);
					stageFront.active = false;
					add(stageFront);


					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = true;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;					
			}
			case 'studio':
			{
					defaultCamZoom = 0.9;
					curStage = 'studio';

					var speakerScale:Float = 0.845;

					var bg_back:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('studio/studio_evenfurtherback'));
					bg_back.setGraphicSize(Std.int(bg_back.width * 0.845));
					bg_back.screenCenter();
					bg_back.antialiasing = true;
					bg_back.scrollFactor.set(0.85, 0.85);
					bg_back.active = false;
					bg_back.x += 32;
					add(bg_back);

					var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('studio/studio_back'));
					bg.setGraphicSize(Std.int(bg.width * 0.845));
					bg.screenCenter();
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					cy_spk1 = new StudioSpeaker(0, 0);
					cy_spk1.scale.x = speakerScale;
					cy_spk1.scale.y = speakerScale;
					cy_spk1.screenCenter();
					cy_spk1.scrollFactor.set(0.9, 0.9);
					cy_spk1.x += -672;
					cy_spk1.y += -32;
					add(cy_spk1);

					cy_spk2 = new StudioSpeaker(0, 0);
					cy_spk2.scale.x = speakerScale;
					cy_spk2.scale.y = speakerScale;
					cy_spk2.screenCenter();
					cy_spk2.scrollFactor.set(0.9, 0.9);
					cy_spk2.x += 640;
					cy_spk2.y += -32;
					cy_spk2.flipX = true;
					add(cy_spk2);

					var bg_fx:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('studio/studio_fx'));
					bg_fx.setGraphicSize(Std.int(bg.width * 0.845));
					bg_fx.screenCenter();
					bg_fx.antialiasing = true;
					bg_fx.scrollFactor.set(0.9, 0.9);
					bg_fx.active = false;
					add(bg_fx);
			}
			case 'studio-crash':
			{
				defaultCamZoom = 0.9;
				curStage = 'studio-crash';

				cy_crash = new StudioCrashBG(0, 0);
				cy_crash.setGraphicSize(Std.int(cy_crash.width * 1.75));
				cy_crash.screenCenter();
				cy_crash.antialiasing = true;
				cy_crash.scrollFactor.set(0.85, 0.85);
				cy_crash.x += 32;
				cy_crash.y += 80;

				add(cy_crash);
				cy_crash.animation.play('code');
			}
			case 'maze':
			{
				defaultCamZoom = 0.9;
				curStage = 'maze';
				//Defines the variable as a sprite (image)
				mazebg = new FlxSprite(-600, -100);
				
				//Gets the png
				mazebg.frames = Paths.getSparrowAtlas('Maze');
				
				//Gets the animation name from the .XML (MUST HAVE THE SAME ANIMATION NAME AS IN THE XML)
				mazebg.animation.addByIndices('move', "Stage", [ 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], "", 16, false);

				//Random stuff that positions and edits the image
				mazebg.antialiasing = _variables.antialiasing;
				mazebg.scrollFactor.set(0.9, 0.9);
				mazebg.updateHitbox();
				mazebg.active = true;
				add(mazebg);
			}
		/*	case 'maze2':
			{
				camZoom = 0.7;
				curStage = 'maze2';
				ZardyBackground = new FlxSprite(-600, -200);
				ZardyBackground.frames = Paths.getSparrowAtlas('five-minute-song/Zardy2BG');
				ZardyBackground.animation.addByPrefix('Maze','BG', 24);
				ZardyBackground.antialiasing = true;
				ZardyBackground.animation.play('Maze');
				add(ZardyBackground);

				PlayState.instance.vine = new FlxSprite(155,620);

				PlayState.instance.vine.antialiasing = true;

				// load these once so it doesn't lag when we load em

				hand = new FlxSprite(0,0).loadGraphic(Paths.image("five-minute-song/Arm0"));
				mic = new FlxSprite(0,0).loadGraphic(Paths.image("five-minute-song/Mic"));
				add(hand);
				add(mic);
				remove(mic);
				remove(hand);

				vine.frames = Paths.getSparrowAtlas("five-minute-song/ZardyWeek2_Vines");
		
				vine.animation.addByPrefix("vine","Vine Whip instance",24,false);
				vine.setGraphicSize(Std.int(vine.width * 0.85));
				
				vine.alpha = 0;
		
				add(vine);
			}*/
			case 'stagekapi':
			{
				defaultCamZoom = 0.9;
				curStage = 'stagekapi';
				var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('kapi/stageback'));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;
				add(bg);

				var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('kapi/stagefront'));
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
				stageFront.updateHitbox();
				stageFront.antialiasing = true;
				stageFront.scrollFactor.set(0.9, 0.9);
				stageFront.active = false;
				add(stageFront);

				var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('kapi/stagecurtains'));
				stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
				stageCurtains.updateHitbox();
				stageCurtains.antialiasing = true;
				stageCurtains.scrollFactor.set(1.3, 1.3);
				stageCurtains.active = false;

				add(stageCurtains);
				
				kapiLights = new FlxTypedGroup<FlxSprite>();
				add(kapiLights);

				for (i in 0...4)
				{
						var light:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('kapi/win' + i));
						light.scrollFactor.set(0.9, 0.9);
						light.visible = false;
						light.updateHitbox();
						light.antialiasing = true;
						kapiLights.add(light);
				
				}
			}
			case 'stagekapi2':
			{
				defaultCamZoom = 0.9;
				curStage = 'stagekapi2';
				var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('kapi/stageback'));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;
				add(bg);

				var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('kapi/stagefront'));
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
				stageFront.updateHitbox();
				stageFront.antialiasing = true;
				stageFront.scrollFactor.set(0.9, 0.9);
				stageFront.active = false;
				add(stageFront);

				var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('kapi/stagecurtains'));
				stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
				stageCurtains.updateHitbox();
				stageCurtains.antialiasing = true;
				stageCurtains.scrollFactor.set(1.3, 1.3);
				stageCurtains.active = false;

				add(stageCurtains);
				
				kapiLights = new FlxTypedGroup<FlxSprite>();
				add(kapiLights);

				for (i in 0...4)
				{
						var light:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('kapi/win' + i));
						light.scrollFactor.set(0.9, 0.9);
						light.visible = false;
						light.updateHitbox();
						light.antialiasing = true;
						kapiLights.add(light);
				
				}
				// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

				littleGuys = new FlxSprite(25, 200);
							littleGuys.frames = Paths.getSparrowAtlas('kapi/littleguys');
							littleGuys.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
							littleGuys.antialiasing = true;
								littleGuys.scrollFactor.set(0.9, 0.9);
				littleGuys.setGraphicSize(Std.int(littleGuys.width * 1));
						littleGuys.updateHitbox();
							add(littleGuys);

			}
			case 'stagekapi3':
			{
					defaultCamZoom = 0.9;
					curStage = 'stagekapi3';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('kapi/sunset'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('kapi/stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);

					kapiLights = new FlxTypedGroup<FlxSprite>();
					add(kapiLights);

					for (i in 0...4)
					{
							var light:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('kapi/win' + i));
							light.scrollFactor.set(0.9, 0.9);
							light.visible = false;
							light.updateHitbox();
							light.antialiasing = true;
							kapiLights.add(light);
					
					}
					// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

					upperBoppers = new FlxSprite(-600, -200);
					upperBoppers.frames = Paths.getSparrowAtlas('kapi/upperBop');
		                  upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
		                  upperBoppers.antialiasing = true;
		                  upperBoppers.scrollFactor.set(1.05, 1.05);
		                  upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 1));
		                  upperBoppers.updateHitbox();
		                  add(upperBoppers);
 					
					littleGuys = new FlxSprite(25, 200);
		                	 littleGuys.frames = Paths.getSparrowAtlas('kapi/littleguys');
		                	  littleGuys.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
		                	  littleGuys.antialiasing = true;
	                        	 littleGuys.scrollFactor.set(0.9, 0.9);
 					littleGuys.setGraphicSize(Std.int(littleGuys.width * 1));
		                 	littleGuys.updateHitbox();
		               	 	  add(littleGuys);
				
			}
			case 'stagekapi4':
			{
					curStage = 'stagekapi4';
					defaultCamZoom = 0.9;
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('kapi/closed'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					bottomBoppers = new FlxSprite(-600, -200);
		                	 bottomBoppers.frames = Paths.getSparrowAtlas('kapi/bgFreaks');
		                	  bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
		                	  bottomBoppers.antialiasing = true;
	                        	  bottomBoppers.scrollFactor.set(0.92, 0.92);
 						bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
		                 	 bottomBoppers.updateHitbox();
		               	 	  add(bottomBoppers);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('kapi/stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);

					kapiLights = new FlxTypedGroup<FlxSprite>();
					add(kapiLights);

					for (i in 0...4)
					{
							var light:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('kapi/win' + i));
							light.scrollFactor.set(0.9, 0.9);
							light.visible = false;
							light.updateHitbox();
							light.antialiasing = true;
							kapiLights.add(light);
					
					}
					// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

				upperBoppers = new FlxSprite(-600, -200);
		                  upperBoppers.frames = Paths.getSparrowAtlas('kapi/upperBop');
		                  upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
		                  upperBoppers.antialiasing = true;
		                  upperBoppers.scrollFactor.set(1.05, 1.05);
		                  upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 1));
		                  upperBoppers.updateHitbox();
		                  add(upperBoppers);
 				
				
			}		
			case 'flatzone':
			{
				curStage = "flatzone";

				var hallowTex = Paths.getSparrowAtlas('flatzone');
				halloweenBG = new FlxSprite(-200, -100);
				halloweenBG.frames = hallowTex;
				halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
				halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
				halloweenBG.animation.play('idle');
				halloweenBG.antialiasing = _variables.antialiasing;
				add(halloweenBG);
			}
			case 'concert':
			{
				defaultCamZoom = 0.78;
				curStage = 'concert';

				var back:FlxSprite = new FlxSprite(-320, -100).loadGraphic(Paths.image('concert/back'));
				back.setGraphicSize(Std.int(back.width * 1.1));
				back.updateHitbox();
				back.antialiasing = _variables.antialiasing;
				back.scrollFactor.set(0.9, 0.9);
				back.active = false;
				add(back);

				var bg:FlxSprite = new FlxSprite(-320, -100).loadGraphic(Paths.image('concert/stageback'));
				bg.setGraphicSize(Std.int(bg.width * 1.1));
				bg.updateHitbox();
				bg.antialiasing = _variables.antialiasing;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;
				add(bg);

				var front:FlxSprite = new FlxSprite(-425, -150).loadGraphic(Paths.image('concert/front'));
				front.setGraphicSize(Std.int(front.width * 1.2));
				front.updateHitbox();
				front.antialiasing = _variables.antialiasing;
				front.scrollFactor.set(0.9, 0.9);
				front.active = false;

				add(front);

				crowdmiku = new FlxSprite(-100, 650);
				crowdmiku.frames = Paths.getSparrowAtlas('concert/bunch_of_simps');
				crowdmiku.animation.addByPrefix('bop', 'Downer Crowd Bob', 24, false);
				crowdmiku.antialiasing = true;
				crowdmiku.scrollFactor.set(0.9, 0.9);
				crowdmiku.setGraphicSize(Std.int(crowdmiku.width * 1));
				crowdmiku.updateHitbox();
			}
			case 'void':
			{
				defaultCamZoom = 0.55;
				curStage = 'void';

				var white:FlxSprite = new FlxSprite().makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.WHITE);
				white.screenCenter();
				white.scrollFactor.set();
				add(white);

				var void:FlxSprite = new FlxSprite(0, 0);
				void.frames = Paths.getSparrowAtlas('The_void');
				void.animation.addByPrefix('move', 'VoidShift', 50, true);
				void.animation.play('move');
				void.setGraphicSize(Std.int(void.width * 2.5));
				void.screenCenter();
				void.y += 250;
				void.x += 55;
				void.antialiasing = true;
				void.scrollFactor.set(0.7, 0.7);
				add(void);

				bgRocks = new FlxSprite(-1000, -700).loadGraphic(Paths.image('Void_Back'));
				bgRocks.setGraphicSize(Std.int(bgRocks.width * 0.5));
				bgRocks.antialiasing = true;
				bgRocks.scrollFactor.set(0.7, 0.7);
				add(bgRocks);

				var frontRocks:FlxSprite = new FlxSprite(-1000, -600).loadGraphic(Paths.image('Void_Front'));
				//frontRocks.setGraphicSize(Std.int(frontRocks.width * 3));
				frontRocks.updateHitbox();
				frontRocks.antialiasing = true;
				frontRocks.scrollFactor.set(0.9, 0.9);
				add(frontRocks);
			}
			case 'pillars':
			{
				defaultCamZoom = 0.55;
				curStage = 'pillars';

				var white:FlxSprite = new FlxSprite().makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.fromRGB(255, 230, 230));
				white.screenCenter();
				white.scrollFactor.set();
				add(white);

				var void:FlxSprite = new FlxSprite(0, 0);
				void.frames = Paths.getSparrowAtlas('The_void');
				void.animation.addByPrefix('move', 'VoidShift', 50, true);
				void.animation.play('move');
				void.setGraphicSize(Std.int(void.width * 2.5));
				void.screenCenter();
				void.y += 250;
				void.x += 55;
				void.antialiasing = true;
				void.scrollFactor.set(0.7, 0.7);
				add(void);

				var bgpillar:FlxSprite = new FlxSprite(-1000, -700);
				bgpillar.frames = Paths.getSparrowAtlas('Pillar_BG_Stage');
				bgpillar.animation.addByPrefix('move', 'Pillar_BG', 24, true);
				bgpillar.animation.play('move');
				bgpillar.setGraphicSize(Std.int(bgpillar.width * 1.25));
				bgpillar.antialiasing = true;
				bgpillar.scrollFactor.set(0.7, 0.7);
				add(bgpillar);

				speaker = new FlxSprite(-650, 600);
				speaker.frames = Paths.getSparrowAtlas('LoudSpeaker_Moving');
				speaker.animation.addByPrefix('bop', 'StereoMoving', 24, false);
				speaker.updateHitbox();
				speaker.antialiasing = true;
				speaker.scrollFactor.set(0.9, 0.9);
				add(speaker);
			}
			case 'stagesalty':
			{
				defaultCamZoom = 0.9;
				curStage = 'stagesalty';
				var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stagesalty/stageback'));
				bg.antialiasing = _variables.antialiasing;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;
				add(bg);

				var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagesalty/stagefront'));
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
				stageFront.updateHitbox();
				stageFront.antialiasing = _variables.antialiasing;
				stageFront.scrollFactor.set(0.9, 0.9);
				stageFront.active = false;
				add(stageFront);

				var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagesalty/stagecurtains'));
				stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
				stageCurtains.updateHitbox();
				stageCurtains.antialiasing = _variables.antialiasing;
				stageCurtains.scrollFactor.set(1.3, 1.3);
				stageCurtains.active = false;

				add(stageCurtains);
			}
			case 'spookysalty': 
			{
				curStage = 'spookysalty';
				halloweenLevel = true;

				var hallowTex = Paths.getSparrowAtlas('spookysalty/halloween_bg');

				halloweenBG = new FlxSprite(-200, -100);
				halloweenBG.frames = hallowTex;
				halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
				halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
				halloweenBG.animation.play('idle');
				halloweenBG.antialiasing = true;
				add(halloweenBG);

				isHalloween = true;
			}
			case 'phillysalty': 
			{
				curStage = 'phillysalty';

				var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('phillysalty/sky'));
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);

				var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('phillysalty/city'));
				city.scrollFactor.set(0.3, 0.3);
				city.setGraphicSize(Std.int(city.width * 0.85));
				city.updateHitbox();
				add(city);

				phillyCityLights = new FlxTypedGroup<FlxSprite>();
				add(phillyCityLights);

				for (i in 0...5)
				{
						var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('phillysalty/win' + i));
						light.scrollFactor.set(0.3, 0.3);
						light.visible = false;
						light.setGraphicSize(Std.int(light.width * 0.85));
						light.updateHitbox();
						light.antialiasing = true;
						phillyCityLights.add(light);
				}

				var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('phillysalty/behindTrain'));
				add(streetBehind);

				phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('phillysalty/train'));
					add(phillyTrain);

				trainSound = new FlxSound().loadEmbedded(Paths.sound('wind_passes'));
				FlxG.sound.list.add(trainSound);

				// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

				var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('phillysalty/street'));
				add(street);
			}
			case 'limosalty':
			{
					curStage = 'limosalty';
					defaultCamZoom = 0.90;

					var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('limosalty/limoSunset'));
					skyBG.scrollFactor.set(0.1, 0.1);
					add(skyBG);

					var bgLimo:FlxSprite = new FlxSprite(-200, 480);
					bgLimo.frames = Paths.getSparrowAtlas('limosalty/bgLimo');
					bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
					bgLimo.animation.play('drive');
					bgLimo.scrollFactor.set(0.4, 0.4);
					add(bgLimo);
		
					grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
					add(grpLimoDancers);
	
					for (i in 0...5)
					{
							var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
							dancer.scrollFactor.set(0.4, 0.4);
							grpLimoDancers.add(dancer);
					}
				

					var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('limosalty/limoOverlay'));
					overlayShit.alpha = 0.5;
					// add(overlayShit);

					// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

					// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

					// overlayShit.shader = shaderBullshit;

					var limoTex = Paths.getSparrowAtlas('limosalty/limoDrive');

					limo = new FlxSprite(-120, 550);
					limo.frames = limoTex;
					limo.animation.addByPrefix('drive', "Limo stage", 24);
					limo.animation.play('drive');
					limo.antialiasing = true;

					fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('limosalty/fastCarLol'));
					// add(limo);
			}
			case 'mallsalty':
			{
					curStage = 'mallsalty';

					defaultCamZoom = 0.80;

					var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('christmassalty/bgWalls'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.2, 0.2);
					bg.active = false;
					bg.setGraphicSize(Std.int(bg.width * 0.8));
					bg.updateHitbox();
					add(bg);

					upperBoppers = new FlxSprite(-240, -90);
					upperBoppers.frames = Paths.getSparrowAtlas('christmassalty/upperBop');
					upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
					upperBoppers.antialiasing = true;
					upperBoppers.scrollFactor.set(0.33, 0.33);
					upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
					upperBoppers.updateHitbox();
					add(upperBoppers);


					var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image('christmassalty/bgEscalator'));
					bgEscalator.antialiasing = true;
					bgEscalator.scrollFactor.set(0.3, 0.3);
					bgEscalator.active = false;
					bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
					bgEscalator.updateHitbox();
					add(bgEscalator);

					var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('christmassalty/christmasTree'));
					tree.antialiasing = true;
					tree.scrollFactor.set(0.40, 0.40);
					add(tree);

					bottomBoppers = new FlxSprite(-300, 140);
					bottomBoppers.frames = Paths.getSparrowAtlas('christmassalty/bottomBop');
					bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
					bottomBoppers.antialiasing = true;
					bottomBoppers.scrollFactor.set(0.9, 0.9);
					bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
					bottomBoppers.updateHitbox();
					add(bottomBoppers);


					var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image('christmassalty/fgSnow'));
					fgSnow.active = false;
					fgSnow.antialiasing = true;
					add(fgSnow);

					santa = new FlxSprite(-840, 150);
					santa.frames = Paths.getSparrowAtlas('christmassalty/santa');
					santa.animation.addByPrefix('idle', 'santa idle in fear', 24, false);
					santa.antialiasing = true;
					add(santa);
			}
			case 'mallEvilsalty':
			{
					curStage = 'mallEvilsalty';
					var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('christmassalty/evilBG'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.2, 0.2);
					bg.active = false;
					bg.setGraphicSize(Std.int(bg.width * 0.8));
					bg.updateHitbox();
					add(bg);

					var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('christmassalty/evilTree'));
					evilTree.antialiasing = true;
					evilTree.scrollFactor.set(0.2, 0.2);
					add(evilTree);

					var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("christmassalty/evilSnow"));
					evilSnow.antialiasing = true;
					add(evilSnow);
			}
			case 'saltyschool':
			{
					curStage = 'saltyschool';

					// defaultCamZoom = 0.9;

					var bgSky = new FlxSprite().loadGraphic(Paths.image('weebsalty/weebSky'));
					bgSky.scrollFactor.set(0.1, 0.1);
					add(bgSky);

					var repositionShit = -200;

					var bgSchool:FlxSprite = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('weebsalty/weebSchool'));
					bgSchool.scrollFactor.set(0.6, 0.90);
					add(bgSchool);

					var bgStreet:FlxSprite = new FlxSprite(repositionShit).loadGraphic(Paths.image('weebsalty/weebStreet'));
					bgStreet.scrollFactor.set(0.95, 0.95);
					add(bgStreet);

					var fgTrees:FlxSprite = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('weebsalty/weebTreesBack'));
					fgTrees.scrollFactor.set(0.9, 0.9);
					add(fgTrees);

					var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
					var treetex = Paths.getPackerAtlas('weebsalty/weebTrees');
					bgTrees.frames = treetex;
					bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
					bgTrees.animation.play('treeLoop');
					bgTrees.scrollFactor.set(0.85, 0.85);
					add(bgTrees);

					var treeLeaves:FlxSprite = new FlxSprite(repositionShit, -40);
					treeLeaves.frames = Paths.getSparrowAtlas('weebsalty/petals');
					treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
					treeLeaves.animation.play('leaves');
					treeLeaves.scrollFactor.set(0.85, 0.85);
					add(treeLeaves);

					var widShit = Std.int(bgSky.width * 6);

					bgSky.setGraphicSize(widShit);
					bgSchool.setGraphicSize(widShit);
					bgStreet.setGraphicSize(widShit);
					bgTrees.setGraphicSize(Std.int(widShit * 1.4));
					fgTrees.setGraphicSize(Std.int(widShit * 0.8));
					treeLeaves.setGraphicSize(widShit);

					fgTrees.updateHitbox();
					bgSky.updateHitbox();
					bgSchool.updateHitbox();
					bgStreet.updateHitbox();
					bgTrees.updateHitbox();
					treeLeaves.updateHitbox();
			}
			case 'saltyschoolEvil':
			{
					curStage = 'saltyschoolEvil';

					var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
					var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);

					var posX = 400;
					var posY = 200;

					var bg:FlxSprite = new FlxSprite(posX, posY);
					bg.frames = Paths.getSparrowAtlas('weebsalty/animatedEvilSchool');
					bg.animation.addByPrefix('idle', 'background 2', 24);
					bg.animation.play('idle');
					bg.scrollFactor.set(0.8, 0.9);
					bg.scale.set(6, 6);
					add(bg);
			}
			case 'theShift':
			{
					defaultCamZoom = 0.9;
					curStage = 'theShift';
					shiftbg = new FlxSprite( -388.05, -232);
					shiftbg.frames = Paths.getSparrowAtlas("bg_normal");
					shiftbg.animation.addByIndices("idle", "bg",[5],"", 24, false);
					shiftbg.animation.addByPrefix("bop", "bg", 24, false);
					shiftbg.animation.play("idle");
					
					shiftbg.updateHitbox();
					shiftbg.antialiasing = true;
					shiftbg.scrollFactor.set(0, 1);
					add(shiftbg);
					
			}
			case 'theShift2':
			{
					defaultCamZoom = 0.9;
					curStage = 'theShift2';
					shiftbg = new FlxSprite( -388.05, -232);
					shiftbg.frames = Paths.getSparrowAtlas("bg_annoyed");
					shiftbg.animation.addByIndices("idle", "bg2",[5],"", 24, false);
					shiftbg.animation.addByPrefix("bop", "bg2", 24, false);
					shiftbg.animation.addByPrefix("manifest", "bgBOOM", 24, false);
					shiftbg.animation.play("idle");
					
					shiftbg.updateHitbox();
					shiftbg.antialiasing = true;
					shiftbg.scrollFactor.set(0, 1);
					add(shiftbg);
					
			}
			case 'theManifest':
			{
					defaultCamZoom = 0.9;
					curStage = 'theManifest';
					shiftbg = new FlxSprite( -388.05, -232);
					shiftbg.frames = Paths.getSparrowAtlas("bg_manifest");
					shiftbg.animation.addByIndices("idle", "bg_manifest",[5],"", 24, false);
					shiftbg.animation.addByPrefix("bop", "bg_manifest", 24, false);
					shiftbg.animation.play("idle");
					shiftbg.updateHitbox();
					shiftbg.antialiasing = true;
					shiftbg.scrollFactor.set(0.4, 0.4);
					add(shiftbg);
					
					floor = new FlxSprite( -1053.1, -464.7);
					floor.frames = Paths.getSparrowAtlas("floorManifest");
					floor.animation.addByIndices("idle", "floorManifest",[5],"", 24, false);
					floor.animation.addByPrefix("bop", "floorManifest", 24, false);
					floor.animation.play("idle");
					floor.updateHitbox();
					floor.antialiasing = true;
					floor.scrollFactor.set(0.9, 0.9);
					add(floor);					
			}
			case 'stage_2matt':
			{
				defaultCamZoom = 0.9;
				curStage = 'stage_2matt';
				var bg:FlxSprite = new FlxSprite(-400, -160).loadGraphic(Paths.image('bg_lemon'));
				bg.setGraphicSize(Std.int(bg.width * 1.5));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.95, 0.95);
				bg.active = false;
				add(bg);
			}
			case 'boxingmatt':
			{
				defaultCamZoom = 0.9;
				curStage = 'boxingmatt';
				var bg:FlxSprite = new FlxSprite(-400, -220).loadGraphic(Paths.image('bg_boxn'));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.8, 0.8);
				bg.active = false;
				add(bg);

				var bg_r:FlxSprite = new FlxSprite(-810, -380).loadGraphic(Paths.image('bg_boxr'));
				bg_r.antialiasing = true;
				bg_r.scrollFactor.set(1, 1);
				bg_r.active = false;
				add(bg_r);

				if (SONG.song.toLowerCase() == 'final-destination')
				{
					shadow1 = new FlxSprite(0, -20).loadGraphic(Paths.image('shadows'));
					shadow1.scrollFactor.set();
					shadow1.antialiasing = true;
					shadow1.alpha = 0;

					shadow2 = new FlxSprite(0, -20).loadGraphic(Paths.image('shadows'));
					shadow2.scrollFactor.set();
					shadow2.antialiasing = true;
					shadow2.alpha = 0;
				}
			}
			case 'daybobandbosip':
			{
				defaultCamZoom = 0.75;
				curStage = 'daybobandbosip';
				var bg1:FlxSprite = new FlxSprite(-970, -580).loadGraphic(Paths.image('daybobandbosip/BG1'));
				bg1.antialiasing = true;
				bg1.scale.set(0.8, 0.8);
				bg1.scrollFactor.set(0.3, 0.3);
				bg1.active = false;
				add(bg1);

				var bg2:FlxSprite = new FlxSprite(-1240, -650).loadGraphic(Paths.image('daybobandbosip/BG2'));
				bg2.antialiasing = true;
				bg2.scale.set(0.5, 0.5);
				bg2.scrollFactor.set(0.6, 0.6);
				bg2.active = false;
				add(bg2);

				if (Main.exMode) {
					mini = new FlxSprite(-270, -90);
					mini.frames = Paths.getSparrowAtlas('daybobandbosip/ex_crowd');
					mini.animation.addByPrefix('idle', 'bobidlebig', 24, false);
					mini.animation.play('idle');
					//mini.scale.set(0.5, 0.5);
					//mini.scrollFactor.set(0.6, 0.6);
					add(mini);

					mordecai = new FlxSprite(141, 103);
				}
				else {
					mini = new FlxSprite(849, 189);
					mini.frames = Paths.getSparrowAtlas('daybobandbosip/mini');
					mini.animation.addByPrefix('idle', 'mini', 24, false);
					mini.animation.play('idle');
					mini.scale.set(0.4, 0.4);
					mini.scrollFactor.set(0.6, 0.6);
					add(mini);

					mordecai = new FlxSprite(130, 160);
					mordecai.frames = Paths.getSparrowAtlas('daybobandbosip/bluskystv');
					mordecai.animation.addByIndices('walk1', 'bluskystv', [29, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] , '', 24, false);
					mordecai.animation.addByIndices('walk2', 'bluskystv', [14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28] , '', 24, false);
					mordecai.animation.play('walk1');
					mordecai.scale.set(0.4, 0.4);
					mordecai.scrollFactor.set(0.6, 0.6);
					add(mordecai);
				}

				var bg3:FlxSprite = new FlxSprite(-630, -330).loadGraphic(Paths.image('daybobandbosip/BG3'));
				bg3.antialiasing = true;
				bg3.scale.set(0.8, 0.8);
				bg3.active = false;
				add(bg3);
			}
			case 'sunsetbobandbosip':
			{
				defaultCamZoom = 0.75;
				curStage = 'sunsetbobandbosip';
				var bg1:FlxSprite = new FlxSprite(-970, -580).loadGraphic(Paths.image('sunsetbobandbosip/BG1'));
				bg1.antialiasing = true;
				bg1.scale.set(0.8, 0.8);
				bg1.scrollFactor.set(0.3, 0.3);
				bg1.active = false;
				add(bg1);

				var bg2:FlxSprite = new FlxSprite(-1240, -680).loadGraphic(Paths.image('sunsetbobandbosip/BG2'));
				bg2.antialiasing = true;
				bg2.scale.set(0.5, 0.5);
				bg2.scrollFactor.set(0.6, 0.6);
				bg2.active = false;
				add(bg2);
			
				if (Main.exMode) {
					mini = new FlxSprite(-270, -90);
					mini.frames = Paths.getSparrowAtlas('sunsetbobandbosip/ex_crowd_sunset');
					mini.animation.addByPrefix('idle', 'bobidlebig', 24, false);
					mini.animation.play('idle');
					//mini.scale.set(0.5, 0.5);
					//mini.scrollFactor.set(0.6, 0.6);
					add(mini);

					mordecai = new FlxSprite(141, 103);
				}
				else {
					mini = new FlxSprite(817, 190);
					mini.frames = Paths.getSparrowAtlas('sunsetbobandbosip/femboy and edgy jigglypuff');
					mini.animation.addByPrefix('idle', 'femboy', 24, false);
					mini.animation.play('idle');
					mini.scale.set(0.5, 0.5);
					mini.scrollFactor.set(0.6, 0.6);
					add(mini);

					mordecai = new FlxSprite(141, 103);
					mordecai.frames = Paths.getSparrowAtlas('sunsetbobandbosip/jacob');
					mordecai.animation.addByPrefix('idle', 'jacob', 24, false);
					mordecai.animation.play('idle');
					mordecai.scale.set(0.5, 0.5);
					mordecai.scrollFactor.set(0.6, 0.6);
					add(mordecai);
				}

				var bg3:FlxSprite = new FlxSprite(-630, -330).loadGraphic(Paths.image('sunsetbobandbosip/BG3'));
				bg3.antialiasing = true;
				bg3.scale.set(0.8, 0.8);
				bg3.active = false;
				add(bg3);
			}
			case 'nightbobandbosip':
			{
				defaultCamZoom = 0.75;
				curStage = 'nightbobandbosip';
				theEntireFuckingStage = new FlxTypedGroup<FlxSprite>();
				add(theEntireFuckingStage);

				var bg1:FlxSprite = new FlxSprite(-970, -580).loadGraphic(Paths.image('nightbobandbosip/BG1'));
				bg1.antialiasing = true;
				bg1.scale.set(0.8, 0.8);
				bg1.scrollFactor.set(0.3, 0.3);
				bg1.active = false;
				theEntireFuckingStage.add(bg1);

				var bg2:FlxSprite = new FlxSprite(-1240, -650).loadGraphic(Paths.image('nightbobandbosip/BG2'));
				bg2.antialiasing = true;
				bg2.scale.set(0.5, 0.5);
				bg2.scrollFactor.set(0.6, 0.6);
				bg2.active = false;
				theEntireFuckingStage.add(bg2);

				mini = new FlxSprite(818, 189);
				mini.frames = Paths.getSparrowAtlas('nightbobandbosip/bobsip');
				mini.animation.addByPrefix('idle', 'bobsip', 24, false);
				mini.animation.play('idle');
				mini.scale.set(0.5, 0.5);
				mini.scrollFactor.set(0.6, 0.6);
				if (!Main.exMode)
					theEntireFuckingStage.add(mini);

				var bg3:FlxSprite = new FlxSprite(-630, -330).loadGraphic(Paths.image('nightbobandbosip/BG3'));
				bg3.antialiasing = true;
				bg3.scale.set(0.8, 0.8);
				bg3.active = false;
				theEntireFuckingStage.add(bg3);

				var bg4:FlxSprite = new FlxSprite(-1390, -740).loadGraphic(Paths.image('nightbobandbosip/BG4'));
				bg4.antialiasing = true;
				bg4.scale.set(0.6, 0.6);
				bg4.active = false;
				theEntireFuckingStage.add(bg4);

				var bg5:FlxSprite = new FlxSprite(-34, 90);
				bg5.antialiasing = true;
				bg5.scale.set(1.4, 1.4);
				bg5.frames = Paths.getSparrowAtlas('nightbobandbosip/pixelthing');
				bg5.animation.addByPrefix('idle', 'pixelthing', 24);
				bg5.animation.play('idle');
				add(bg5);

				pc = new Character(115, 166, 'pc');
				pc.debugMode = true;
				pc.antialiasing = true;
				add(pc);
			}
			case 'ITB':
			{
				defaultCamZoom = 0.70;
				curStage = 'ITB';
				var bg17:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/Layer 5'));
				bg17.antialiasing = true;
				bg17.scrollFactor.set(0.3, 0.3);
				bg17.active = false;
				add(bg17);

				var bg16:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/Layer 4'));
				bg16.antialiasing = true;
				bg16.scrollFactor.set(0.4, 0.4);
				bg16.active = false;
				add(bg16);

				var bg15:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/Layer 3'));
				bg15.antialiasing = true;
				bg15.scrollFactor.set(0.6, 0.6);
				bg15.active = false;
				add(bg15);

				var bg14:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/Layer 2'));
				bg14.antialiasing = true;
				bg14.scrollFactor.set(0.7, 0.7);
				bg14.active = false;
				add(bg14);

				var bg1:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/Layer 1 (back tree)'));
				bg1.antialiasing = true;
				bg1.scrollFactor.set(0.7, 0.7);
				bg1.active = false;
				add(bg1);

				var bg13:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/Layer 1 (Tree)'));
				bg13.antialiasing = true;
				bg13.active = false;
				add(bg13);

				var bg4:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/Layer 1 (flower and grass)'));
				bg4.antialiasing = true;
				bg4.active = false;
				add(bg4);

				itbLights = new FlxTypedGroup<FlxSprite>();
				add(itbLights);

				var bg9:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/layer 1 (light 1)'));
				bg9.antialiasing = true;
				bg9.scrollFactor.set(0.8, 0.8);
				bg9.alpha = 0;
				bg9.active = false;
				itbLights.add(bg9);

				var bg10:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/Layer 1 (Light 2)'));
				bg10.antialiasing = true;
				bg10.scrollFactor.set(0.8, 0.8);
				bg10.alpha = 0;
				bg10.active = false;
				itbLights.add(bg10);

				var bg5:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/Layer 1 (Grass 2)'));
				bg5.antialiasing = true;
				bg5.active = false;
				add(bg5);

				switch (SONG.song.toLowerCase()) {
					case 'yap-squad' | 'intertwined':
						mini = new FlxSprite(-571, -68);
						mini.frames = Paths.getSparrowAtlas('ITB/itb_crowd_back');
						mini.animation.addByPrefix('idle', 'itb_crowd_back', 24, false);
						mini.animation.play('idle');
						mini.scale.set(0.55, 0.55);
						add(mini);
				}
			}
			case 'diebobandbosip':
			{
				defaultCamZoom = 0.75;
				curStage = 'diebobandbosip';

				grpDieStage = new FlxTypedGroup<FlxSprite>();
				add(grpDieStage);

				var bg1:FlxSprite = new FlxSprite(-970, -580).loadGraphic(Paths.image('daybobandbosip/happy/happy_sky'));
				bg1.antialiasing = true;
				bg1.scale.set(0.8, 0.8);
				bg1.scrollFactor.set(0.3, 0.3);
				bg1.active = false;
				grpDieStage.add(bg1);

				var bg2:FlxSprite = new FlxSprite(-1240, -650).loadGraphic(Paths.image('daybobandbosip/happy/happy_back'));
				bg2.antialiasing = true;
				bg2.scale.set(0.5, 0.5);
				bg2.scrollFactor.set(0.6, 0.6);
				bg2.active = false;
				grpDieStage.add(bg2);

				var bg3:FlxSprite = new FlxSprite(-630, -330).loadGraphic(Paths.image('daybobandbosip/happy/happy_front'));
				bg3.antialiasing = true;
				bg3.scale.set(0.8, 0.8);
				bg3.active = false;
				grpDieStage.add(bg3);
			}
			case 'sunshitbobandbosip':
			{
				defaultCamZoom = 0.75;
				curStage = 'sunshitbobandbosip';

				grpDieStage = new FlxTypedGroup<FlxSprite>();
				add(grpDieStage);


				var bg1:FlxSprite = new FlxSprite(-970, -580).loadGraphic(Paths.image('sunsetbobandbosip/happy/bosip_sky'));
				bg1.antialiasing = true;
				bg1.scale.set(0.8, 0.8);
				bg1.scrollFactor.set(0.3, 0.3);
				bg1.active = false;
				grpDieStage.add(bg1);

				var bg2:FlxSprite = new FlxSprite(-1240, -680).loadGraphic(Paths.image('sunsetbobandbosip/happy/bosip_back'));
				bg2.antialiasing = true;
				bg2.scale.set(0.5, 0.5);
				bg2.scrollFactor.set(0.6, 0.6);
				bg2.active = false;
				grpDieStage.add(bg2);

				var bg3:FlxSprite = new FlxSprite(-630, -330).loadGraphic(Paths.image('sunsetbobandbosip/happy/bosip_front'));
				bg3.antialiasing = true;
				bg3.scale.set(0.8, 0.8);
				bg3.active = false;
				grpDieStage.add(bg3);
					
			}
			case 'sunshinestage' :
			{
				curStage = 'sunshinestage';

				var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('bob/happysky'));
				bg.updateHitbox();
				bg.active = false;
				bg.antialiasing = true;
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);
				
				var ground:FlxSprite = new FlxSprite(-537, -158).loadGraphic(Paths.image('bob/happyground'));
				ground.updateHitbox();
				ground.active = false;
				ground.antialiasing = true;
				add(ground);
			}
			
			case 'witheredstage' :
			{
				curStage = 'witheredstage';

				var bg:FlxSprite = new FlxSprite( -100).loadGraphic(Paths.image('bob/slightlyannyoed_sky'));
				bg.updateHitbox();
				bg.active = false;
				bg.antialiasing = true;
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);
				
				var ground:FlxSprite = new FlxSprite(-537, -158).loadGraphic(Paths.image('bob/slightlyannyoed_ground'));
				ground.updateHitbox();
				ground.active = false;
				ground.antialiasing = true;
				add(ground);
			}
			
			//phlox is a little baby
			case 'hellstage':
			{
				curStage = 'hellstage';
		
				var bg:FlxSprite = new FlxSprite( -100).loadGraphic(Paths.image('bob/hell'));
				bg.updateHitbox();
				bg.active = false;
				bg.antialiasing = true;
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);
				
				var thingidk:FlxSprite = new FlxSprite( -271).loadGraphic(Paths.image('bob/middlething'));
				thingidk.updateHitbox();
				thingidk.active = false;
				thingidk.antialiasing = true;
				thingidk.scrollFactor.set(0.3, 0.3);
				add(thingidk);
				
				var dead:FlxSprite = new FlxSprite( -60, 50).loadGraphic(Paths.image('bob/theydead'));
				dead.updateHitbox();
				dead.active = false;
				dead.antialiasing = true;
				dead.scrollFactor.set(0.8, 0.8);
				add(dead);

				var ground:FlxSprite = new FlxSprite(-537, -158).loadGraphic(Paths.image('bob/ground'));
				ground.updateHitbox();
				ground.active = false;
				ground.antialiasing = true;
				add(ground);			
			}
			case 'slaughtstage' :
			{
				defaultCamZoom = 0.9;
				curStage = 'slaughtstage';
				var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('bob/scary_sky'));
				bg.updateHitbox();
				bg.active = false;
				bg.antialiasing = true;
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);
				/*var glitchEffect = new FlxGlitchEffect(8,10,0.4,FlxGlitchDirection.HORIZONTAL);
				var glitchSprite = new FlxEffectSprite(bg, [glitchEffect]);
				add(glitchSprite);*/
				
				var ground:FlxSprite = new FlxSprite(-537, -158).loadGraphic(Paths.image('bob/GlitchedGround'));
				ground.updateHitbox();
				ground.active = false;
				ground.antialiasing = true;
				add(ground);
				
			}
			case 'troublestage' :
			{
				defaultCamZoom = 0.9;
				curStage = 'troublestage';
				var bg:FlxSprite = new FlxSprite(-100,10).loadGraphic(Paths.image('bob/nothappy_sky'));
				bg.updateHitbox();
				bg.scale.x = 1.2;
				bg.scale.y = 1.2;
				bg.active = false;
				bg.antialiasing = true;
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);
				/*var glitchEffect = new FlxGlitchEffect(8,10,0.4,FlxGlitchDirection.HORIZONTAL);
				var glitchSprite = new FlxEffectSprite(bg, [glitchEffect]);
				add(glitchSprite);*/
				
				var ground:FlxSprite = new FlxSprite(-537, -250).loadGraphic(Paths.image('bob/nothappy_ground'));
				ground.updateHitbox();
				ground.active = false;
				ground.antialiasing = true;
				add(ground);

				var deadron:FlxSprite = new FlxSprite(-700, 600).loadGraphic(Paths.image('bob/GoodHeDied'));
				deadron.updateHitbox();
				deadron.active = false;
				deadron.scale.x = 0.8;
				deadron.scale.y = 0.8;
				deadron.antialiasing = true;
				add(deadron);
				
			}
			case 'ronstage':
			{
				defaultCamZoom = 0.9;
				curStage = 'ronstage';
				var bg:FlxSprite = new FlxSprite(-100,10).loadGraphic(Paths.image('bob/happyRon_sky'));
				bg.updateHitbox();
				bg.scale.x = 1.2;
				bg.scale.y = 1.2;
				bg.active = false;
				bg.antialiasing = true;
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);
				/*var glitchEffect = new FlxGlitchEffect(8,10,0.4,FlxGlitchDirection.HORIZONTAL);
				var glitchSprite = new FlxEffectSprite(bg, [glitchEffect]);
				add(glitchSprite);*/
				
				var ground:FlxSprite = new FlxSprite(-537, -250).loadGraphic(Paths.image('bob/happyRon_ground'));
				ground.updateHitbox();
				ground.active = false;
				ground.antialiasing = true;
				add(ground);
			}
		}

		var gfVersion:String = 'gf';

		switch (SONG.gfVersion)
		{
			default:
				gfVersion = 'gf';
			case 'gf-car':
				gfVersion = 'gf-car';
			case 'gf-christmas':
				gfVersion = 'gf-christmas';
			case 'gf-pixel':
				gfVersion = 'gf-pixel';
			case 'gfTankmen':
				gfVersion = 'gfTankmen';
			case 'picoasgf':
				gfVersion = 'picoasgf';
			case 'gfb':
				gfVersion = 'gfb';
			case 'gfb-car':
				gfVersion = 'gfb-car';
			case 'gfb-christmas':
				gfVersion = 'gfb-christmas';
			case 'gfb-pixel':
				gfVersion = 'gfb-pixel';
			case 'gfb3':
				gfVersion = 'gfb3';
			case 'gfb3-car':
				gfVersion = 'gfb3-car';
			case 'gfb3-christmas':
				gfVersion = 'gfb3-christmas';
			case 'gfb3-pixel':
				gfVersion = 'gfb3-pixel';
			case 'gfneo':
				gfVersion = 'gfneo';
			case 'gfneo-car':
				gfVersion = 'gfneo-car';
			case 'gfwhitty':
				gfVersion = 'gfwhitty';
			case 'gfwhittyscared':
				gfVersion = 'gfwhittyscared';
			case 'gfsunset':
				gfVersion = 'gfsunset';
			case 'gfnight':
				gfVersion = 'gfnight';
			case 'gfglitcher':
				gfVersion = 'gfglitcher';
			case 'gf-mii':
				gfVersion = 'gf-mii';
			case 'gfFC':
				gfVersion = 'gfFC';
			case 'gfDM':
				gfVersion = 'gfDM';
			case 'gfWU':
				gfVersion = 'gfWU';
			case 'gfKH':
				gfVersion = 'gfKH';
			case 'gf-tabi':
				gfVersion = 'gf-tabi';
			case 'gf-tabi-crazy':
				gfVersion = 'gf-tabi-crazy';
				var destBoombox:FlxSprite = new FlxSprite(400, 130).loadGraphic(Paths.image('tabi/mad/Destroyed_boombox'));
				destBoombox.y += (destBoombox.height - 648) * -1;
				destBoombox.y += 150;
				destBoombox.x -= 110;
				destBoombox.scale.set(1.2, 1.2);
				add(destBoombox);
			case 'gf-hell':
				gfVersion = 'gf-hell';
			case 'gf-tied':
				gfVersion = 'gf-tied';
			case 'gf-sus':
				gfVersion = 'gf-sus';
			case 'ghost-gf':
				gfVersion = 'ghost-gf';
			case 'gf-studio':
				gfVersion = 'gf-studio';
			case 'gf-kapi':
				gfVersion = 'gf-kapi';
			case 'gf-rocks':
				gfVersion = 'gf-rocks';
			case 'itsumi':
				gfVersion = 'itsumi';
			case 'itsumi-car':
				gfVersion = 'itsumi-car';
			case 'itsumi-christmas':
				gfVersion = 'itsumi-christmas';
			case 'itsumi-pixel':
				gfVersion = 'itsumi-pixel';
			case 'gf-crucified':
				gfVersion = 'gf-crucified';
			case 'gf-ex':
				gfVersion = 'gf-ex';
			case 'gf-bob':
				gfVersion = 'gf-bob';
			case 'gf-bosip':
				gfVersion = 'gf-bosip';
			case 'gf-night-ex':
				gfVersion = 'gf-night-ex';
			case 'gf-nightbobandbosip':
				gfVersion = 'gf-nightbobandbosip';
			case 'gf-ronsip':
				gfVersion = 'gf-ronsip';
			case 'gf-but-bosip':
				gfVersion = 'gf-but-bosip';
				gfSpeed = 2;
				trace('shithdhfdof');
		}

		gf = new Character(400, 130, gfVersion);
		gf.scrollFactor.set(0.95, 0.95);
		switch (SONG.song.toLowerCase()) {
			case 'ronald-mcdonald-slide':
				waaaa = new FlxSprite().loadGraphic(Paths.image('sunsetbobandbosip/happy/waaaaa'));
				add(waaaa);
				waaaa.cameras = [camHUD];
				waaaa.visible = false;

				unregisteredHypercam = new FlxSprite().loadGraphic(Paths.image('sunsetbobandbosip/happy/unregistered-hypercam-2-png-Transparent-Images-Free'));
				add(unregisteredHypercam);
				unregisteredHypercam.cameras = [camHUD];
				unregisteredHypercam.visible = false;

				
				SAD = new FlxTypedGroup<FlxSprite>();
				SAD.cameras = [camHUD];
				add(SAD);
				for (i in 0...4) {
					var suffix:String = '';
					switch (i) {
						case 0:
							suffix = 'AMOR';
						case 1:
							suffix = 'BF';
						case 2:
							suffix = 'BOB';
						case 3:
							suffix = 'BOSIP';
					}
					var spr = new FlxSprite().loadGraphic(Paths.image('sad/original size/SAD ' + suffix));
					spr.cameras = [camHUD];
					spr.screenCenter();
					spr.alpha = 0;
					SAD.add(spr);
				}
				var angyRonsip:FlxSprite = new FlxSprite(-1200, -100);
				angyRonsip.frames = Paths.getSparrowAtlas('sunsetbobandbosip/happy/RON_dies_lmaoripbozo_packwatch');
			case 'jump-out':
				dad = new Character(100, 100, 'verb');
				boyfriend = new Boyfriend(100, 100, 'bfanders');
				SAD = new FlxTypedGroup<FlxSprite>();
				SAD.cameras = [camHUD];
				add(SAD);
				for (i in 0...4) {
					var suffix:String = '';
					switch (i) {
						case 0:
							suffix = 'AMOR';
						case 1:
							suffix = 'BF';
						case 2:
							suffix = 'BOB';
						case 3:
							suffix = 'BOSIP';
					}
					var spr = new FlxSprite().loadGraphic(Paths.image('sad/original size/SAD ' + suffix));
					spr.cameras = [camHUD];
					spr.screenCenter();
					spr.alpha = 0;
					SAD.add(spr);
				}

				bgbob = new FlxSprite(-100).loadGraphic(Paths.image('onslaught/scary_sky'));
				bgbob.updateHitbox();
				bgbob.active = false;
				bgbob.antialiasing = true;
				bgbob.scrollFactor.set(0.1, 0.7);
				add(bgbob);
				
				groundbob = new FlxSprite(-537, -158).loadGraphic(Paths.image('onslaught/GlitchedGround'));
				groundbob.updateHitbox();
				groundbob.active = false;
				groundbob.antialiasing = true;
				add(groundbob);

				bgbob.visible = false;
				groundbob.visible = false;
		}

		switch (gfVersion)
		{
			case 'none':
				gf.visible = false;
			case 'picoasgf':
				gf.y += -55;
				gf.x -= 200;
			case 'gf-bosip':
				gf.y -= 40;
				gf.x -= 30;
			case 'gf-night-ex':
				gf.x -= 30;
				gf.y -= 40;
			case 'gf-ronsip':
				gf.x -= 820;
				gf.y -= 700;
			case 'gf-but-bosip':
				gf.x += 350;
				gf.y -= 30;
			case 'gf-pixel' | 'gfb-pixel' | 'gfb3-pixel' | 'itsumi-pixel':
				gf.x += 180;
				gf.y += 300;			
		}

		if (curStage == 'studio' || curStage == 'studio-crash') {
			if (gfVersion == 'gf-studio') {
				gf.scrollFactor.set(0.9, 0.9);

				gf.scale.x = 0.85;
				gf.scale.y = 0.85;

				gf.x += 96;
				gf.y += 176;
			}
		}

		dad = new Character(100, 100, SONG.player2);

		if (SONG.exDad)
		{
			dad2 = new Character(-80, 100, SONG.player3);
		}	

		var dadFlxPoint:FlxPoint = dad.getGraphicMidpoint();
		var camPos:FlxPoint = FlxPoint.get(dadFlxPoint.x, dadFlxPoint.y);

		if (SONG.player2.contains('bf') || SONG.player2.contains('salty'))
		{
			dad.x = 100;
			dad.y = 450;
		}

		switch (SONG.player2)
		{
			case 'gf':
				dad.setPosition(dad.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfb':
				dad.setPosition(dad.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfb3':
				dad.setPosition(dad.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfneo':
				dad.setPosition(dad.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfwhitty':
				dad.setPosition(dad.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfsunset':
				dad.setPosition(dad.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfnight':
				dad.setPosition(dad.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfglitcher':
				dad.setPosition(dad.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'itsumi':
				dad.setPosition(dad.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gf-ex':
				dad.setPosition(dad.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case "spooky":
				dad.y += 200;
			case "spookyb":
				dad.y += 200;
			case "spookyb3":
				dad.y += 200;
			case "spookyneo":
				dad.y += 200;
			case "tankman":
				dad.y += 180;
			case "monster":
				dad.y += 100;
			case 'monster-christmas':
				dad.y += 130;
			case 'monsterb-christmas':
				dad.y += 130;	
			case 'monsterb3-christmas':
				dad.y += 130;	
			case 'dad':
				camPos.x += 400;
			case 'dadb':
				camPos.x += 400;
			case 'dadb3':
				camPos.x += 400;
			case 'pico':
				camPos.x += 600;
				dad.y += 300;
			case 'mario':
				camPos.x += 600;
				dad.y += 300;
			case 'picob':
				camPos.x += 600;
				dad.y += 300;
			case 'picob3':
				camPos.x += 600;
				dad.y += 300;
			case 'piconeo':
				camPos.x += 600;
				dad.y += 300;
			case 'parents-christmas':
				dad.x -= 500;
			case 'parentsb-christmas':
				dad.x -= 500;
			case 'parentsb3-christmas':
				dad.x -= 500;
			case 'senpai':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'senpai-angry':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'spirit':
				dad.x -= 150;
				dad.y += 100;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'senpaib':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'senpaib-angry':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'senpaib3':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'senpaib3-angry':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'spiritb3':
				dad.x -= 150;
				dad.y += 100;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'whitty':
				camPos.x += 400;
			case 'whittycrazy':
				camPos.x += 400;
			case "gameandwatch":
				dad.y += 200;
			case 'hexVirus':
				dad.y += 150;
			case 'shaggy':
				camPos.set(dad.getGraphicMidpoint().x + 100, dad.getGraphicMidpoint().y);
			case "matt":
				dad.y += 300;
			case 'mattblue':
				dad.y += 320;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
				if (Main.god) dad.x -= 30;
			case "mattmad":
				dad.y += 300;
			case "mattbox":
				dad.y += 330;
			case "mattchill":
				dad.y += 320;
			case 'matttko':
				dad.y += 310;
			case 'mart':
				dad.y += 450;
				dad.x += 79;
			case 'tabi':
				dad.x -= 300;
			case 'tabi-crazy':
				dad.x -= 300;
				dad.y += 50;
			case 'tricky':
				camPos.x += 400;
				camPos.y += 600;
			case 'trickyMask':
				camPos.x += 400;
			case 'trickyH':
				camPos.set(dadFlxPoint.x, dadFlxPoint.y + 500);
				dad.y -= 1000;
				dad.x -= 700;
				gf.x -= 120;
				gf.y += 180;
			case 'exTricky':
				dad.x -= 150;
				dad.y -= 365 - 100;
				gf.x += 345 + 100;
				gf.y -= 25 - 50;
				dad.visible = false;
			case 'impostor':
				camPos.y += -200;
				camPos.x += 400;
				dad.x = 0;
				dad.y = 490;
			case 'impostor2':
				camPos.y += -200;
				camPos.x += 400;
				dad.x = 0;
				dad.y = 490;
			case 'agoti':
				camPos.x += 400;
				dad.y += 100;
				dad.x -= 100;
			case 'agoti-micless':
				dad.y += 150;
				dad.x -= 100;
			case "ghostngirl":
				dad.y += 200;
			case "opheebop":
				dad.y += 100;
				camPos.x += 70;
			case 'connor':
				camPos.x += 600;
				dad.y += 300;
			case 'the-manager':
				dad.x -= 500;
			case 'opheebop-christmas':
				dad.y += 130;
			case 'glitch':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'glitchy':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'glitchhead':
				dad.x -= 150;
				dad.y += 100;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'jghost':
				dad.x -= 40;
				dad.y -= 20;
			case 'bluskys':
				dad.y += 100;
			case 'minishoey':
				dad.y += 50;
			case 'ash':
				dad.y += 20;
			case 'cerberus':
				dad.y += 230;
				dad.x += 50;
			case 'cerbera':
				dad.y += 420;
				dad.x += 50;
			case 'bob':
				dad.y += 50;
			case 'bobex':
				dad.y += 80;
			case 'bosip':
				dad.y -= 50;
			case 'bosipex':
				dad.y += 0;
			case 'gloopy' | 'gloopybob':
				camPos.x += 600;
				dad.y += 280;
			case 'ronsip':
				dad.y += 100;
			case 'angrygloopy':
				camPos.x += 600;
				dad.y += 300;
			case 'hellgloopy':
				camPos.x += 600;
				dad.y += 350;
			case 'gloop-gloopy':
				camPos.x += 600;
				dad.y += 300;
			case 'glitched-gloopy':
				camPos.x += 600;
				dad.y += 300;
			case 'ron':
				camPos.x -= 27;
				camPos.y += 268;
				dad.y += 268;
				dad.x -= 27;
			case 'little-man':
				camPos.x -= 124;
				camPos.y += 644;
				dad.x += 124;
				dad.y += 644;
		}

		if (SONG.exDad)
		{
			switch (SONG.player3)
			{
				case 'gf':
					dad2.setPosition(dad2.x, gf.y);
					gf.visible = false;
					if (gameplayArea == "Story")
					{
						camPos.x += 600;
						tweenCamIn();
					}
				case 'gfb':
					dad2.setPosition(dad2.x, gf.y);
					gf.visible = false;
					if (gameplayArea == "Story")
					{
						camPos.x += 600;
						tweenCamIn();
					}
				case 'gfb3':
					dad2.setPosition(dad2.x, gf.y);
					gf.visible = false;
					if (gameplayArea == "Story")
					{
						camPos.x += 600;
						tweenCamIn();
					}
				case 'gfneo':
					dad2.setPosition(dad2.x, gf.y);
					gf.visible = false;
					if (gameplayArea == "Story")
					{
						camPos.x += 600;
						tweenCamIn();
					}
				case 'gfwhitty':
					dad2.setPosition(dad2.x, gf.y);
					gf.visible = false;
					if (gameplayArea == "Story")
					{
						camPos.x += 600;
						tweenCamIn();
					}
				case 'gfsunset':
					dad2.setPosition(dad2.x, gf.y);
					gf.visible = false;
					if (gameplayArea == "Story")
					{
						camPos.x += 600;
						tweenCamIn();
					}
				case 'gfnight':
					dad2.setPosition(dad2.x, gf.y);
					gf.visible = false;
					if (gameplayArea == "Story")
					{
						camPos.x += 600;
						tweenCamIn();
					}
				case 'gfglitcher':
					dad2.setPosition(dad2.x, gf.y);
					gf.visible = false;
					if (gameplayArea == "Story")
					{
						camPos.x += 600;
						tweenCamIn();
					}
				case 'itsumi':
					dad2.setPosition(dad2.x, gf.y);
					gf.visible = false;
					if (gameplayArea == "Story")
					{
						camPos.x += 600;
						tweenCamIn();
					}
				case "spooky":
					dad2.y += 200;
				case "spookyb":
					dad2.y += 200;
				case "spookyb3":
					dad2.y += 200;
				case "spookyneo":
					dad2.y += 200;
				case "tankman":
					dad2.y += 180;
				case "monster":
					dad2.y += 100;
				case 'monster-christmas':
					dad2.y += 130;
				case 'monsterb-christmas':
					dad2.y += 130;	
				case 'monsterb3-christmas':
					dad2.y += 130;	
				case 'dad2':
					camPos.x += 400;
				case 'dadb':
					camPos.x += 400;
				case 'dadb3':
					camPos.x += 400;
				case 'pico':
					camPos.x += 600;
					dad2.y += 300;
				case 'mario':
					camPos.x += 600;
					dad2.y += 300;
				case 'picob':
					camPos.x += 600;
					dad2.y += 300;
				case 'picob3':
					camPos.x += 600;
					dad2.y += 300;
				case 'piconeo':
					camPos.x += 600;
					dad2.y += 300;
				case 'parents-christmas':
					dad2.x -= 500;
				case 'parentsb-christmas':
					dad2.x -= 500;
				case 'parentsb3-christmas':
					dad2.x -= 500;
				case 'senpai':
					dad2.x += 150;
					dad2.y += 360;
					camPos.set(dad2.getGraphicMidpoint().x + 300, dad2.getGraphicMidpoint().y);
				case 'senpai-angry':
					dad2.x += 150;
					dad2.y += 360;
					camPos.set(dad2.getGraphicMidpoint().x + 300, dad2.getGraphicMidpoint().y);
				case 'spirit':
					dad2.x -= 150;
					dad2.y += 100;
					camPos.set(dad2.getGraphicMidpoint().x + 300, dad2.getGraphicMidpoint().y);
				case 'senpaib':
					dad2.x += 150;
					dad2.y += 360;
					camPos.set(dad2.getGraphicMidpoint().x + 300, dad2.getGraphicMidpoint().y);
				case 'senpaib-angry':
					dad2.x += 150;
					dad2.y += 360;
					camPos.set(dad2.getGraphicMidpoint().x + 300, dad2.getGraphicMidpoint().y);
				case 'senpaib3':
					dad2.x += 150;
					dad2.y += 360;
					camPos.set(dad2.getGraphicMidpoint().x + 300, dad2.getGraphicMidpoint().y);
				case 'senpaib3-angry':
					dad2.x += 150;
					dad2.y += 360;
					camPos.set(dad2.getGraphicMidpoint().x + 300, dad2.getGraphicMidpoint().y);
				case 'spiritb3':
					dad2.x -= 150;
					dad2.y += 100;
					camPos.set(dad2.getGraphicMidpoint().x + 300, dad2.getGraphicMidpoint().y);
				case 'whitty':
					camPos.x += 400;
				case 'whittycrazy':
					camPos.x += 400;
				case 'hexVirus':
					dad2.y += 150;
				case 'shaggy':
					camPos.set(dad2.getGraphicMidpoint().x + 100, dad2.getGraphicMidpoint().y);
				case "matt":
					dad2.y += 300;
				case 'mattblue':
					dad2.y += 320;
					camPos.set(dad2.getGraphicMidpoint().x + 300, dad2.getGraphicMidpoint().y);
					if (Main.god) dad2.x -= 30;
				case "mattmad":
					dad2.y += 300;
				case "mattbox":
					dad2.y += 330;
				case "mattchill":
					dad2.y += 320;
				case 'matttko':
					dad2.y += 310;
				case 'mart':
					dad2.y += 450;
					dad2.x += 79;
				case 'tabi':
					dad2.x -= 300;
				case 'tabi-crazy':
					dad2.x -= 300;
					dad2.y += 50;
				case 'tricky':
					camPos.x += 400;
					camPos.y += 600;
				case 'trickyMask':
					camPos.x += 400;
				case 'trickyH':
					camPos.set(dadFlxPoint.x, dadFlxPoint.y + 500);
					dad2.y -= 1000;
					dad2.x -= 700;
					gf.x -= 120;
					gf.y += 180;
				case 'exTricky':
					dad2.x -= 150;
					dad2.y -= 365 - 100;
					gf.x += 345 + 100;
					gf.y -= 25 - 50;
					dad2.visible = false;
				case 'impostor':
					camPos.y += -200;
					camPos.x += 400;
					dad2.x = 0;
					dad2.y = 490;
				case 'impostor2':
					camPos.y += -200;
					camPos.x += 400;
					dad2.x = 0;
					dad2.y = 490;
				case 'agoti':
					camPos.x += 400;
					dad2.y += 100;
					dad2.x -= 100;
				case 'agoti-micless':
					dad2.y += 150;
					dad2.x -= 100;
				case "ghostngirl":
					dad2.y += 200;
				case "opheebop":
					dad2.y += 100;
					camPos.x += 70;
				case 'connor':
					camPos.x += 600;
					dad2.y += 300;
				case 'the-manager':
					dad2.x -= 500;
				case 'opheebop-christmas':
					dad2.y += 130;
				case 'glitch':
					dad2.x += 150;
					dad2.y += 360;
					camPos.set(dad2.getGraphicMidpoint().x + 300, dad2.getGraphicMidpoint().y);
				case 'glitchy':
					dad2.x += 150;
					dad2.y += 360;
					camPos.set(dad2.getGraphicMidpoint().x + 300, dad2.getGraphicMidpoint().y);
				case 'glitchhead':
					dad2.x -= 150;
					dad2.y += 100;
					camPos.set(dad2.getGraphicMidpoint().x + 300, dad2.getGraphicMidpoint().y);
				case 'jghost':
					dad2.x -= 40;
					dad2.y -= 20;
				case 'bluskys':
					dad2.y += 100;
				case 'minishoey':
					dad2.y += 50;
				case 'ash':
					dad2.y += 20;
				case 'cerberus':
					dad2.y += 230;
					dad2.x += 50;
				case 'cerbera':
					dad2.y += 420;
					dad2.x += 50;
				case 'bob':
					dad2.y += 50;
				case 'bobex':
					dad2.y += 80;
				case 'bosip':
					dad2.y -= 50;
				case 'bosipex':
					dad2.y += 0;
				case 'gloopy' | 'gloopybob':
					camPos.x += 600;
					dad2.y += 280;
				case 'ronsip':
					dad2.y += 100;
				case 'angrygloopy':
					camPos.x += 600;
					dad2.y += 300;
				case 'hellgloopy':
					camPos.x += 600;
					dad2.y += 350;
				case 'gloop-gloopy':
					camPos.x += 600;
					dad2.y += 300;
				case 'glitched-gloopy':
					camPos.x += 600;
					dad2.y += 300;
				case 'ron':
					camPos.x -= 27;
					camPos.y += 268;
					dad2.y += 268;
					dad2.x -= 27;
				case 'little-man':
					camPos.x -= 124;
					camPos.y += 644;
					dad2.x += 124;
					dad2.y += 644;
			}
		}		

		if (SONG.exBF)
		{
			boyfriend2 = new Boyfriend(950, 450, SONG.player4);
		}

		if (mariohelping)
		{
			SONG.player1 == 'mario';
		}

		boyfriend = new Boyfriend(770, 450, SONG.player1);
		

		if (!SONG.player1.contains('bf') && !SONG.player1.contains('salty'))
		{
			boyfriend.x = 770;
			boyfriend.y = 100;
		}

		switch (SONG.player1)
		{
			case 'bf-pixel' | 'bfb-pixel' | 'bfb3-pixel' | 'salty-pixel':
				boyfriend.x += 200;
				boyfriend.y += 220;
			case 'gf':
				boyfriend.setPosition(boyfriend.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfb':
				boyfriend.setPosition(boyfriend.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfb3':
				boyfriend.setPosition(boyfriend.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfneo':
				boyfriend.setPosition(boyfriend.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfwhitty':
				boyfriend.setPosition(boyfriend.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfsunset':
				boyfriend.setPosition(boyfriend.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfnight':
				boyfriend.setPosition(boyfriend.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gfglitcher':
				boyfriend.setPosition(boyfriend.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'itsumi':
				boyfriend.setPosition(boyfriend.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gf-ex':
				boyfriend.setPosition(boyfriend.x, gf.y);
				gf.visible = false;
				if (gameplayArea == "Story")
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case "spooky":
				boyfriend.y += 200;
			case "spookyb":
				boyfriend.y += 200;
			case "spookyb3":
				boyfriend.y += 200;
			case "spookyneo":
				boyfriend.y += 200;
			case "tankman":
				boyfriend.y += 180;
			case "monster":
				boyfriend.y += 100;
			case 'monster-christmas':
				boyfriend.y += 130;
			case 'monsterb-christmas':
				boyfriend.y += 130;	
			case 'monsterb3-christmas':
				boyfriend.y += 130;	
			case 'boyfriend':
				camPos.x += 400;
			case 'boyfriendb':
				camPos.x += 400;
			case 'boyfriendb3':
				camPos.x += 400;
			case 'pico':
				camPos.x += 600;
				boyfriend.y += 300;
			case 'mario':
				camPos.x += 600;
				boyfriend.y += 300;
			case 'picob':
				camPos.x += 600;
				boyfriend.y += 300;
			case 'picob3':
				camPos.x += 600;
				boyfriend.y += 300;
			case 'piconeo':
				camPos.x += 600;
				boyfriend.y += 300;
			case 'parents-christmas':
				boyfriend.x -= 500;
			case 'parentsb-christmas':
				boyfriend.x -= 500;
			case 'parentsb3-christmas':
				boyfriend.x -= 500;
			case 'senpai':
				boyfriend.x += 150;
				boyfriend.y += 360;
				camPos.set(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y);
			case 'senpai-angry':
				boyfriend.x += 150;
				boyfriend.y += 360;
				camPos.set(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y);
			case 'spirit':
				boyfriend.x -= 150;
				boyfriend.y += 100;
				camPos.set(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y);
			case 'senpaib':
				boyfriend.x += 150;
				boyfriend.y += 360;
				camPos.set(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y);
			case 'senpaib-angry':
				boyfriend.x += 150;
				boyfriend.y += 360;
				camPos.set(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y);
			case 'senpaib3':
				boyfriend.x += 150;
				boyfriend.y += 360;
				camPos.set(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y);
			case 'senpaib3-angry':
				boyfriend.x += 150;
				boyfriend.y += 360;
				camPos.set(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y);
			case 'spiritb3':
				boyfriend.x -= 150;
				boyfriend.y += 100;
				camPos.set(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y);
			case 'whitty':
				camPos.x += 400;
			case 'whittycrazy':
				camPos.x += 400;
			case "gameandwatch":
				boyfriend.y += 200;
			case 'hexVirus':
				boyfriend.y += 150;
			case 'shaggy':
				camPos.set(boyfriend.getGraphicMidpoint().x + 100, boyfriend.getGraphicMidpoint().y);
			case "matt":
				boyfriend.y += 300;
			case 'mattblue':
				boyfriend.y += 320;
				camPos.set(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y);
				if (Main.god) boyfriend.x -= 30;
			case "mattmad":
				boyfriend.y += 300;
			case "mattbox":
				boyfriend.y += 330;
			case "mattchill":
				boyfriend.y += 320;
			case 'matttko':
				boyfriend.y += 310;
			case 'mart':
				boyfriend.y += 450;
				boyfriend.x += 79;
			case 'tabi':
				boyfriend.x -= 300;
			case 'tabi-crazy':
				boyfriend.x -= 300;
				boyfriend.y += 50;
			case 'tricky':
				camPos.x += 400;
				camPos.y += 600;
			case 'trickyMask':
				camPos.x += 400;
			case 'trickyH':
				boyfriend.y -= 1000;
				boyfriend.x -= 700;
				gf.x -= 120;
				gf.y += 180;
			case 'exTricky':
				boyfriend.x -= 150;
				boyfriend.y -= 365 - 100;
				gf.x += 345 + 100;
				gf.y -= 25 - 50;
				boyfriend.visible = false;
			case 'impostor':
				camPos.y += -200;
				camPos.x += 400;
				boyfriend.x = 0;
				boyfriend.y = 490;
			case 'impostor2':
				camPos.y += -200;
				camPos.x += 400;
				boyfriend.x = 0;
				boyfriend.y = 490;
			case 'agoti':
				camPos.x += 400;
				boyfriend.y += 100;
				boyfriend.x -= 100;
			case 'agoti-micless':
				boyfriend.y += 150;
				boyfriend.x -= 100;
			case "ghostngirl":
				boyfriend.y += 200;
			case "opheebop":
				boyfriend.y += 100;
				camPos.x += 70;
			case 'connor':
				camPos.x += 600;
				boyfriend.y += 300;
			case 'the-manager':
				boyfriend.x -= 500;
			case 'opheebop-christmas':
				boyfriend.y += 130;
			case 'glitch':
				boyfriend.x += 150;
				boyfriend.y += 360;
				camPos.set(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y);
			case 'glitchy':
				boyfriend.x += 150;
				boyfriend.y += 360;
				camPos.set(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y);
			case 'glitchhead':
				boyfriend.x -= 150;
				boyfriend.y += 100;
				camPos.set(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y);
			case 'jghost':
				boyfriend.x -= 40;
				boyfriend.y -= 20;
			case 'bluskys':
				boyfriend.y += 100;
			case 'minishoey':
				boyfriend.y += 50;
			case 'ash':
				boyfriend.y += 20;
			case 'cerberus':
				boyfriend.y += 230;
				boyfriend.x += 50;
			case 'cerbera':
				boyfriend.y += 420;
				boyfriend.x += 50;
			case 'bob':
				boyfriend.y += 50;
			case 'bobex':
				boyfriend.y += 80;
			case 'bosip':
				boyfriend.y -= 50;
			case 'bosipex':
				boyfriend.y += 0;
			case 'gloopy' | 'gloopybob':
				camPos.x += 600;
				boyfriend.y += 280;
			case 'worriedbob':
				boyfriend.y = 130;
			case 'bfanders':
				boyfriend.y -= 330;
				boyfriend.x -= 150;
			case 'angrygloopy':
				camPos.x += 600;
				boyfriend.y += 300;
			case 'hellgloopy':
				camPos.x += 600;
				boyfriend.y += 350;
			case 'gloop-gloopy':
				camPos.x += 600;
				boyfriend.y += 300;
			case 'glitched-gloopy':
				camPos.x += 600;
				boyfriend.y += 300;
			case 'ron':
				camPos.x -= 27;
				camPos.y += 268;
				boyfriend.y += 268;
				boyfriend.x -= 27;
			case 'little-man':
				camPos.x -= 124;
				camPos.y += 644;
				boyfriend.x += 124;
				boyfriend.y += 644;
		}

		// REPOSITIONING PER STAGE
		switch (curStage)
		{
			case 'limo':
				boyfriend.y -= 220;
				boyfriend.x += 260;

				if (SONG.exBF)
				{
					boyfriend2.y -= 220;
					boyfriend2.x += 260;
				}
				resetFastCar();
				add(fastCar);
			case 'limob':
				boyfriend.y -= 220;
				boyfriend.x += 260;
	
				if (SONG.exBF)
				{
					boyfriend2.y -= 220;
					boyfriend2.x += 260;
				}
				resetFastCar();
				add(fastCar);
			case 'limob3':
				boyfriend.y -= 220;
				boyfriend.x += 260;
		
				if (SONG.exBF)
				{
					boyfriend2.y -= 220;
					boyfriend2.x += 260;
				}
				resetFastCar();
				add(fastCar);
			case 'limoneo':
				boyfriend.y -= 240;
				boyfriend.x += 260;
				dad.x += 340;
				dad.y -= 280;
				gf.x += 220;
				gf.y -= 200;
				if (SONG.exDad)
				{
					dad2.x += 340;
					dad2.y -= 280;
				}
				if (SONG.exBF)
				{
					boyfriend2.y -= 240;
					boyfriend2.x += 260;
				}
			case 'mall':
				boyfriend.x += 200;
			
				if (SONG.exBF)
					boyfriend2.y += 200;

			case 'mallb':
				boyfriend.x += 200;

				if (SONG.exBF)
					boyfriend2.y += 200;

			case 'mallEvil':
				boyfriend.x += 320;
				dad.y -= 80;

				if (SONG.exBF)
					boyfriend2.x += 320;
				if (SONG.exDad)
					dad2.y -= 80;

			case 'mallbEvil':
				boyfriend.x += 320;
				dad.y -= 80;

				if (SONG.exBF)
					boyfriend2.x += 320;
				if (SONG.exDad)
					dad2.y -= 80;
				
			case 'schoolEvil':
				// trailArea.scrollFactor.set();
				var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
				// evilTrail.changeValuesEnabled(false, false, false, false);
				// evilTrail.changeGraphic()
				add(evilTrail);
				// evilTrail.scrollFactor.set(1.1, 1.1);

			case 'tank':
				boyfriend.x += 40;
				if (SONG.exBF)
				{
					boyfriend2.x += 40;
				}
				dad.y += 60;
				dad.x -= 80;
				if (SONG.exDad)
				{
					dad2.x += 60;
					dad2.y -= 80;
				}
			case 'tankstress':
				//gf.y += 10;
				//gf.x -= 30;
				gf.y += -155;
				gf.x -= 90;

				boyfriend.x += 40;
				if (SONG.exBF)
				{
					boyfriend2.x += 40;
				}
				dad.y += 60;
				dad.x -= 80;
				if (SONG.exDad)
				{
					dad2.x += 60;
					dad2.y -= 80;
				}
			case 'garAlley':
				boyfriend.x += 50;
				if (SONG.exBF)
					boyfriend2.x += 50;
			case 'garAlleyDead':
				// evilTrail.changeValuesEnabled(false, false, false, false);
				// evilTrail.changeGraphic()
				// add(evilTrail);
				// evilTrail.scrollFactor.set(1.1, 1.1);
				boyfriend.x += 50;
				if (SONG.exBF)
					boyfriend2.x += 50;
			case 'swordarena':
				boyfriend.x += 200;
				if (SONG.exBF)
					boyfriend2.x += 200;
			case 'arenanight':
				boyfriend.x += 200;
				if (SONG.exBF)
					boyfriend2.x += 200;
			case 'curse':
				boyfriend.setZoom(1.2);
				boyfriend.x += 300;
				gf.setZoom(1.2);
				gf.y -= 110;
				gf.x -= 50;
				if (SONG.exBF)
					boyfriend2.x += 300;
			case 'genocide':
				boyfriend.setZoom(1.2);
				boyfriend.x += 300;
				if (SONG.exBF)
					boyfriend2.x += 300;

				gf.setZoom(1);
				//gf.y -= 20;
				gf.x += 100;
				var tabiTrail = new FlxTrail(dad, null, 4, 24, 0.6, 0.9);
				add(tabiTrail);
			case 'nevada':
				boyfriend.y -= 0;
				boyfriend.x += 260;
				if (SONG.exBF)
					boyfriend2.x += 260;
			case 'nevadaSpook':
				boyfriend.x += 120;
				boyfriend.y += 120;
				if (SONG.exBF)
				{
					boyfriend2.x += 120;
					boyfriend2.y += 120;
				}
			case 'auditorHell':
				boyfriend.y -= 160;
				boyfriend.x += 350 + 50;
				if (SONG.exBF)
				{
					boyfriend2.x -= 160;
					boyfriend2.y += 350 + 50;
				}
			case 'meltdown':
				gf.y -= 100;
			case 'sabotage':
				gf.y -= 100;
			case 'maze':
				boyfriend.y += 200;
				if (SONG.exBF)
				{
					boyfriend2.y += 200;
				}
				gf.y += 200;
				dad.y += 200;
				dad.x -= 150;
			case 'mazeb':
				boyfriend.y += 200;
				if (SONG.exBF)
				{
					boyfriend2.y += 200;
				}
				gf.y += 200;
				dad.y += 200;
				dad.x -= 150;
			case 'void':
				boyfriend.y += 50;
				boyfriend.x += 100; 
				if (SONG.exBF)
				{
					boyfriend2.x += 50;
					boyfriend2.y += 100;
				}
			case 'pillars':
				boyfriend.y += 50;
				boyfriend.x += 100;
				if (SONG.exBF)
				{
					boyfriend2.x += 50;
					boyfriend2.y += 100;
				} 
				gf.y -= 250;
				gf.angle = 70;
			case 'limosalty':
				boyfriend.y -= 220;
				boyfriend.x += 260;
				if (SONG.exBF)
				{
					boyfriend2.y -= 220;
					boyfriend2.x += 260;
				} 

				resetFastCar();
				add(fastCar);

			case 'mallsalty':
				boyfriend.x += 200;
				if (SONG.exBF)
				{
					boyfriend2.x += 200;
				} 
			case 'mallEvilsalty':
				boyfriend.x += 320;
				if (SONG.exBF)
				{
					boyfriend2.x += 320;
				} 
				dad.y -= 80;

			case 'saltyschoolEvil':
				// trailArea.scrollFactor.set();
				var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
				// evilTrail.changeValuesEnabled(false, false, false, false);
				// evilTrail.changeGraphic()
				add(evilTrail);
				// evilTrail.scrollFactor.set(1.1, 1.1);

			case 'theShift':
				boyfriend.x = 828.75;
				boyfriend.y = 265.65;
				dad.x = 30.15;
				dad.y = 37.95;
				gf.x = 359.7;
				gf.y = -37.95;
				if (SONG.exBF)
				{
					boyfriend2.x = 828.75;
					boyfriend2.y = 265.65;
				} 
				if (SONG.exDad)
				{
					dad2.x = 30.15;
					dad2.y = 37.95;
				} 
			case 'theManifest':
				boyfriend.x = 828.75;
				boyfriend.y = 265.65;
				dad.x = 119.3;
				dad.y = 93.9;
				gf.x = 479.3;
				gf.y = -56.1;
				if (SONG.exBF)
				{
					boyfriend2.x = 828.75;
					boyfriend2.y = 265.65;
				} 
				if (SONG.exDad)
				{
					dad2.x = 119.3;
					dad2.y = 93.9;
				} 
			case 'stage_2matt':
				gf.alpha = 0;
				boyfriend.y -= 20;

				if (SONG.exBF)
					boyfriend2.y -= 20;
			case 'sky':
				//
			case 'boxingmatt':
				gf.x += 70;
				boyfriend.x += 130;
				if (SONG.exBF)
					boyfriend2.x += 130;
			case 'daybobandbosip' | 'sunsetbobandbosip' | 'sunshitbobandbosip' | 'diebobandbosip':
				dad.x -= 150;
				dad.y -= 11;
				boyfriend.x += 191;
				boyfriend.y -= 20;
				if (SONG.player1 == 'bf-bob') {
					boyfriend.x -= 60;
					boyfriend.y -= 70;
				}
				gf.x -= 70;
				gf.y -= 50;
				camPos.x = 536.63;
				camPos.y = 449.94;
			case 'nightbobandbosip':
				dad.x -= 370;
				dad.y + 39	;
				boyfriend.x += 191;
				boyfriend.y -= 20;
				gf.x += 300;
				gf.y -= 50;
			case 'ITB':
				dad.x -= 380;
				dad.y -= 10;
				gf.x -= 239;
				gf.y -= 70;
				gf.scrollFactor.set(1, 1);
				camPos.x = 272.46;
				camPos.y = 420.96;
		}

		add(gf);

		switch (curStage) {
			case 'ITB':
				var bg8:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/Layer 1 (Lamp)'));
				bg8.antialiasing = true;
				//bg8.scale.set(0.6, 0.6);
				//bg8.scrollFactor.set(0.8, 0.8);
				bg8.active = false;
				add(bg8);

				var bg6:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/Layer 1 (Grass)'));
				bg6.antialiasing = true;
				//bg6.scrollFactor.set(0.9, 0.9);
				//bg6.scale.set(0.6, 0.6);
				bg6.active = false;
				add(bg6);

				var bg7:FlxSprite = new FlxSprite(-701, -300).loadGraphic(Paths.image('ITB/Layer 1 (Ground)'));
				bg7.antialiasing = true;
				//bg7.scale.set(0.6, 0.6);
				bg7.active = false;
				add(bg7);

				switch (SONG.song.toLowerCase()) {
					case 'conscience' | 'yap-squad' | 'intertwined':
						mordecai = new FlxSprite(-1531, -230);
						mordecai.frames = Paths.getSparrowAtlas('ITB/itb_crowd_middle');
						mordecai.animation.addByPrefix('idle', 'itb_crowd_middle', 24, false);
						mordecai.animation.play('idle');
						mordecai.scale.set(0.6, 0.6);
						add(mordecai);
				}
		}
		
		if (curStage == 'basketballglitcher')
		{
			add(wire);
		}

		if (SONG.song.toLowerCase() == 'god-eater')
		{
			shaggyT = new FlxTrail(dad, null, 5, 7, 0.3, 0.001);
			add(shaggyT);

			doorFrame = new FlxSprite(-160, 160).loadGraphic(Paths.image('doorframe'));
			doorFrame.updateHitbox();
			doorFrame.setGraphicSize(1);
			doorFrame.alpha = 0;
			doorFrame.antialiasing = _variables.antialiasing;
			doorFrame.scrollFactor.set(1, 1);
			doorFrame.active = false;
			add(doorFrame);
		}

		// Shitty layering but whatev it works LOL
		if (curStage == 'limo')
			add(limo);
		if (curStage == 'limob')
			add(limo);
		if (curStage == 'limob3')
			add(limo);
		if (curStage == 'limoneo')
			add(limo);
		if (curStage == 'limosalty')
			add(limo);

		if (curStage == 'auditorHell')
			add(holetricky);

		if (SONG.exDad) add(dad2);
		add(dad);		

		if (curStage == 'auditorHell')
		{
			// Clown init
			cloneOne = new FlxSprite(0, 0);
			cloneTwo = new FlxSprite(0, 0);
			cloneOne.frames = CachedFrames.cachedInstance.fromSparrow('cln', 'fourth/Clone');
			cloneTwo.frames = CachedFrames.cachedInstance.fromSparrow('cln', 'fourth/Clone');
			cloneOne.setGraphicSize(Std.int(cloneOne.width * 2));
			cloneOne.updateHitbox();
			cloneTwo.setGraphicSize(Std.int(cloneTwo.width * 2));
			cloneTwo.updateHitbox();
			cloneOne.alpha = 0;
			cloneTwo.alpha = 0;
			cloneOne.animation.addByPrefix('clone', 'Clone', 24, false);
			cloneTwo.animation.addByPrefix('clone', 'Clone', 24, false);

			// cover crap

			add(cloneOne);
			add(cloneTwo);
			add(covertricky);
			add(converHoletricky);
			add(dad.exSpikes);
		}

		//the DEAD BITCH
		var deadass:FlxSprite = new FlxSprite(800, 650).loadGraphic(Paths.image('bfdead'));
		deadass.setGraphicSize(Std.int(deadass.width * 1));
		deadass.updateHitbox();
		deadass.antialiasing = true;
		deadass.scrollFactor.set(1, 1);
		deadass.active = false;
		if (curStage == 'meltdown')
		{
			add(deadass);
		}

		if (SONG.exBF) add(boyfriend2);
		add(boyfriend);

		if (curStage == 'ITB') {
				thirdBop = new FlxSprite(-1560, 542);
				thirdBop.scale.set(0.6, 0.6);
				thirdBop.scrollFactor.set(1.3, 1.3);
				thirdBop.frames = Paths.getSparrowAtlas('ITB/itb_crowd_front');
				thirdBop.animation.addByPrefix('idle', 'itb_crowd_front', 24, false);
				thirdBop.animation.play('idle');
				add(thirdBop);
		}

		if (curStage == 'daybobandbosip') {
			phillyTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('daybobandbosip/PP_truck'));
			phillyTrain.scale.set(1.2, 1.2);
			phillyTrain.visible = false;
			add(phillyTrain);
		}
		if (curStage == 'sunsetbobandbosip') {
			phillyTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
			phillyTrain.scale.set(1.2, 1.2);
			phillyTrain.visible = false;
			add(phillyTrain);
		}

		if (curStage == 'tank' || curStage == 'tankstress'){

			add(tank0);
			add(tank1);
			add(tank2);
			add(tank4);
			add(tank5);
			add(tank3);
		}

		snowfall1 = new FlxTypedGroup<Snowfall1>();	

		for (i in 0...9)
		{
			var snow1:Snowfall1 = new Snowfall1((370 * i) - 600, 340);
			snow1.scrollFactor.set(1, 1);
			snowfall1.add(snow1);
		}
		
		snowfall2 = new FlxTypedGroup<Snowfall2>();

		for (i in 0...9)
		{
			var snow2:Snowfall2 = new Snowfall2((370 * i) -600, -30);
			snow2.scrollFactor.set(1, 1);
			snowfall2.add(snow2);
		}

		redsnowfall1 = new FlxTypedGroup<RedSnowfall1>();	

		for (i in 0...9)
		{
			var redsnow1:RedSnowfall1 = new RedSnowfall1((370 * i) - 600, 340);
			redsnow1.scrollFactor.set(1, 1);
			redsnowfall1.add(redsnow1);
		}
		
		redsnowfall2 = new FlxTypedGroup<RedSnowfall2>();

		for (i in 0...9)
		{
			var redsnow2:RedSnowfall2 = new RedSnowfall2((370 * i) -600, -5);
			redsnow2.scrollFactor.set(1, 1);
			redsnowfall2.add(redsnow2);
		}

		if (dad.curCharacter == 'trickyH')
		{
			gf.setGraphicSize(Std.int(gf.width * 0.8));
			boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.8));
			gf.x += 220;
		}

		if (curStage == 'nevada')
		{	
			add(MAINLIGHT);
		}

		if (curStage == 'curse')
		{
			var sumtable:FlxSprite = new FlxSprite(-600, -300).loadGraphic(Paths.image('tabi/sumtable'));
			sumtable.antialiasing = _variables.antialiasing;
			sumtable.scrollFactor.set(0.9, 0.9);
			sumtable.active = false;
			add(sumtable);
		}
		if (curStage == 'genocide')
		{
			var sumsticks:FlxSprite = new FlxSprite(-600, -300).loadGraphic(Paths.image('tabi/mad/overlayingsticks'));
			sumsticks.antialiasing = _variables.antialiasing;
			sumsticks.scrollFactor.set(0.9, 0.9);
			sumsticks.active = false;
			add(sumsticks);
		}
		if (curStage == 'garAlleyDead')
		{
			var smoke:FlxSprite = new FlxSprite(0, 0);
			smoke.frames = Paths.getSparrowAtlas('garSmoke');
			smoke.setGraphicSize(Std.int(smoke.width * 1.6));
			smoke.animation.addByPrefix('garsmoke', "smokey", 15);
			smoke.animation.play('garsmoke');
			smoke.scrollFactor.set(1.1, 1.1);
			add(smoke);
		}
		if (curStage == 'concert')
		{
			add(crowdmiku);
		}

		doof = new DialogueBox(false, dialogue);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;

		Conductor.songPosition = -5000;

		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();

		// le wiggle
		wiggleShit.waveAmplitude = 0.07;
		wiggleShit.effectType = WiggleEffect.WiggleEffectType.DREAMY;
		wiggleShit.waveFrequency = 0;
		wiggleShit.waveSpeed = 1.8; // fasto
		wiggleShit.shader.uTime.value = [(strumLine.y - Note.swagWidth * 4) / FlxG.height]; // from 4mbr0s3 2
		susWiggle = new ShaderFilter(wiggleShit.shader);
		// le wiggle 2
		var wiggleShit2:WiggleEffect = new WiggleEffect();
		wiggleShit2.waveAmplitude = 0.10;
		wiggleShit2.effectType = WiggleEffect.WiggleEffectType.HEAT_WAVE_VERTICAL;
		wiggleShit2.waveFrequency = 0;
		wiggleShit2.waveSpeed = 1.8; // fasto
		wiggleShit2.shader.uTime.value = [(strumLine.y - Note.swagWidth * 4) / FlxG.height]; // from 4mbr0s3 2
		var susWiggle2 = new ShaderFilter(wiggleShit2.shader);
		camSus.setFilters([susWiggle]); // only enable it for snake notes

		strumLineNotes = new FlxTypedGroup<FlxSkewedSprite>();
		add(strumLineNotes);

		if (_modifiers.InvisibleNotes)
		{
			strumLine.visible = false;
			strumLineNotes.visible = false;
		}

		playerStrums = new FlxTypedGroup<FlxSkewedSprite>();
		cpuStrums = new FlxTypedGroup<FlxSkewedSprite>();

		// startCountdown();

		generateSong(SONG.song);
		speed = SONG.speed;

		// add(strumLine);

		camFollow = new FlxObject(0, 0, 1, 1);

		camFollow.setPosition(camPos.x, camPos.y);

		camPos.put();
		dadFlxPoint.put();

		if (dad.curCharacter == 'trickyH')
		{
			var dadmidpoint = dad.getGraphicMidpoint();
			camFollow.setPosition(dadmidpoint.x + 150, dadmidpoint.y + 265);
			dadmidpoint.put();
		}

		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, camLerp);
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;

		if (_variables.songPosition) // I dont wanna talk about this code :(
			{
				songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
				if (_variables.scroll == "down")
					songPosBG.y = FlxG.height * 0.9 + 45; 
				songPosBG.screenCenter(X);
				songPosBG.scrollFactor.set();
				add(songPosBG);
				songPosBG.cameras = [camHUD];
				
				songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
					'songPositionBar', 0, 90000);
				songPosBar.scrollFactor.set();
				songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
				add(songPosBar);
				songPosBar.cameras = [camHUD];
	
				var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - 20,songPosBG.y,0,SONG.song, 16);
				if (_variables.scroll == "down")
					songName.y -= 3;
				songName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
				songName.scrollFactor.set();
				add(songName);
				songName.cameras = [camHUD];
			}

		healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('healthBar'));
		if (_variables.scroll == "down")
			healthBarBG.y = 50;
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'health', 0, 2);
		healthBar.scrollFactor.set();
		
		HealthBarColor.ColorChange();

		if (Main.switchside)
		{
			healthBar.createFilledBar(player1hb, player2hb);
		}
		else
		{
			healthBar.createFilledBar(player2hb, player1hb);
		}

		add(healthBar);

		botPlay = new FlxText(healthBar.x, healthBar.y - 100, 0, "BotPlay", 20);
		if (_variables.scroll == "down")
		{
			botPlay.y += 200;
		}
		botPlay.setFormat(Paths.font("vcr.ttf"), 30, FlxColor.WHITE, RIGHT);
		botPlay.setBorderStyle(OUTLINE, 0xFF000000, 3, 1);
		botPlay.scrollFactor.set();
		botPlay.screenCenter(X);
		botPlay.visible = _variables.botplay;

		scoreTxt = new FlxText(healthBarBG.x - healthBarBG.width/2, healthBarBG.y + 26, 0, "", 20);
		if (_variables.scroll == "down")
			scoreTxt.y = healthBarBG.y - 18;
		scoreTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, RIGHT);
		scoreTxt.setBorderStyle(OUTLINE, 0xFF000000, 3, 1);
		scoreTxt.scrollFactor.set();
		add(scoreTxt);
		scoreTxt.visible = _variables.scoreDisplay;

		controlTxt = new FlxText(healthBarBG.x - healthBarBG.width/2 + 950, healthBarBG.y + 26, 0, "", 20);
		if (_variables.scroll == "down")
			controlTxt.y = scoreTxt.y + 26;
		controlTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, RIGHT);
		controlTxt.setBorderStyle(OUTLINE, 0xFF000000, 3, 1);
		controlTxt.scrollFactor.set();
		add(controlTxt);

		missTxt = new FlxText(scoreTxt.x, scoreTxt.y - 26, 0, "", 20);
		if (_variables.scroll == "down")
			missTxt.y = scoreTxt.y + 26;
		missTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, RIGHT);
		missTxt.setBorderStyle(OUTLINE, 0xFF000000, 3, 1);
		missTxt.scrollFactor.set();
		add(missTxt);
		missTxt.visible = _variables.missesDisplay;
		
		comboTxt = new FlxText(missTxt.x, missTxt.y - 26, 0, "", 20);
		if (_variables.scroll == "down")
			comboTxt.y = healthBarBG.y + 26;
		comboTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, RIGHT);
		comboTxt.setBorderStyle(OUTLINE, 0xFF000000, 3, 1);
		comboTxt.scrollFactor.set();
		add(comboTxt);
		comboTxt.visible = _variables.combotextDisplay;

		accuracyTxt = new FlxText(comboTxt.x, comboTxt.y - 26, 0, "", 20);
		if (_variables.scroll == "down")
			accuracyTxt.y = missTxt.y + 26;
		accuracyTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, RIGHT);
		accuracyTxt.setBorderStyle(OUTLINE, 0xFF000000, 3, 1);
		accuracyTxt.scrollFactor.set();
		add(accuracyTxt);
		accuracyTxt.visible = _variables.accuracyDisplay;

		npsTxt = new FlxText(accuracyTxt.x, accuracyTxt.y - 26, 0, "", 20);
		if (_variables.scroll == "down")
			npsTxt.y = accuracyTxt.y + 26;
		npsTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, RIGHT);
		npsTxt.setBorderStyle(OUTLINE, 0xFF000000, 3, 1);
		npsTxt.scrollFactor.set();
		add(npsTxt);
		npsTxt.visible = _variables.nps;

		if (Main.switchside)
		{
			if (SONG.player2 == 'shaggy' && dad.powerup)
			{
				iconP1 = new HealthIcon('shaggypower', true);
			}
			else
			{
				iconP1 = new HealthIcon(SONG.player2, true);
			}
		}
		else
		{
			iconP1 = new HealthIcon(SONG.player1, true);
		}

		if (!Main.switchside && SONG.exBF || Main.switchside && SONG.exDad)
		{
			iconP1.y = healthBar.y - (iconP1.height / 4);
			iconP1.setGraphicSize(Std.int(iconP1.width * 0.001));
		}
		else
		{
			iconP1.y = healthBar.y - (iconP1.height / 2);
		}
		add(iconP1);

		if (Main.switchside)
		{
			iconP2 = new HealthIcon(SONG.player1, false);
		}
		else
		{
			if (SONG.player2 == 'shaggy' && dad.powerup)
			{
				iconP2 = new HealthIcon('shaggypower', false);
			}
			else
			{
				iconP2 = new HealthIcon(SONG.player2, false);
			}
		}		
		
		if (!Main.switchside && SONG.exDad || Main.switchside && SONG.exBF)
		{
			iconP2.y = healthBar.y - (iconP2.height / 4);
			iconP2.setGraphicSize(Std.int(iconP2.width * 0.001));
		}
		else
		{
			iconP2.y = healthBar.y - (iconP2.height / 2);
		}

		add(iconP2);

		if (!Main.switchside && SONG.exDad || Main.switchside && SONG.exBF)
		{
			if (Main.switchside && SONG.exBF)
			{
				iconP3 = new HealthIcon(SONG.player4, false);
			}
			else
			{
				iconP3 = new HealthIcon(SONG.player3, false);
			}		

			iconP3.y = healthBar.y - (iconP3.height / 2);
			iconP3.setGraphicSize(Std.int(iconP3.width * 0.001));
	
			add(iconP3);
		}

		if (!Main.switchside && SONG.exBF || Main.switchside && SONG.exDad)
		{
			if (Main.switchside && SONG.exDad)
			{
				iconP4 = new HealthIcon(SONG.player3, true);
			}
			else
			{
				iconP4 = new HealthIcon(SONG.player4, true);
			}		

			iconP4.y = healthBar.y - (iconP4.height / 2);
			iconP4.setGraphicSize(Std.int(iconP4.width * 0.001));
	
			add(iconP4);
		}
		

		hearts = new FlxTypedGroup<FlxSprite>();
		add(hearts);
		
		add(botPlay);

		if (_modifiers.Enigma)
			{
				iconP1.visible = false;
				iconP2.visible = false;
				healthBar.visible = false;
				healthBarBG.visible = false;
				hearts.visible = false;
			}

		var heartTex = Paths.getSparrowAtlas('heartUI');
		switch (SONG.notestyle)
		{
			case 'pixel':
				heartTex = Paths.getSparrowAtlas('weeb/pixelUI/heartUI-pixel');
		}

		for (i in 0...Std.int(_modifiers.Lives))
			{
				heartSprite = new FlxSprite(healthBarBG.x + 5 + (i * 40), 20);
				heartSprite.frames = heartTex;
				heartSprite.antialiasing = false;
				heartSprite.updateHitbox();
				heartSprite.y = healthBarBG.y + healthBarBG.height + 10;
				heartSprite.scrollFactor.set();
				heartSprite.animation.addByPrefix('Idle', "Hearts", 24, false);
				heartSprite.ID = i;
				if (_variables.scroll == "down")
					heartSprite.y = healthBarBG.y - heartSprite.height - 10;
				if (!_modifiers.LivesSwitch)
					heartSprite.visible = false;

				hearts.add(heartSprite);
			}

		freezeIndicator = new FlxSprite(0, 0).loadGraphic(Paths.image('FreezeIndicator'));
		add(freezeIndicator);
		switch (SONG.notestyle)
		{
			case 'pixel':
				freezeIndicator.loadGraphic(Paths.image('weeb/pixelUI/FreezeIndicator-pixel'));
		}
		freezeIndicator.alpha = 0;
	

		LightsOutBG = new FlxSprite(0, 0).loadGraphic(Paths.image('LightsOutBG'));
		add(LightsOutBG);
		switch (SONG.notestyle)
		{
			case 'pixel':
				LightsOutBG.loadGraphic(Paths.image('weeb/pixelUI/LightsOutBG-pixel'));
		}

		BlindingBG = new FlxSprite(0, 0).loadGraphic(Paths.image('BlindingBG'));
		add(BlindingBG);
		switch (SONG.notestyle)
		{
			case 'pixel':
				BlindingBG.loadGraphic(Paths.image('weeb/pixelUI/BlindingBG-pixel'));
		}
		if (_modifiers.BrightnessSwitch)
		{
			LightsOutBG.alpha = _modifiers.Brightness / 100 * -1;
			BlindingBG.alpha = _modifiers.Brightness / 100;
		}
		else
		{
			LightsOutBG.alpha = 0;
			BlindingBG.alpha = 0;
		}

		strumLineNotes.cameras = [camNOTEHUD];
		notes.cameras = [camNOTES];
		hearts.cameras = [camHUD];
		healthBar.cameras = [camHB];
		healthBarBG.cameras = [camHB];	
		iconP1.cameras = [camHB];
		iconP2.cameras = [camHB];
		if (!Main.switchside && SONG.exDad || Main.switchside && SONG.exBF)
		{
			iconP3.cameras = [camHB];
		}
		if (!Main.switchside && SONG.exBF || Main.switchside && SONG.exDad)
		{
			iconP4.cameras = [camHB];
		}
		botPlay.cameras = [camHUD];
		scoreTxt.cameras = [camHUD];
		comboTxt.cameras = [camHUD];
		controlTxt.cameras = [camHUD];
		missTxt.cameras = [camHUD];
		accuracyTxt.cameras = [camHUD];
		npsTxt.cameras = [camHUD];
		doof.cameras = [camPAUSE];
		freezeIndicator.cameras = [camPAUSE];
		LightsOutBG.cameras = [camPAUSE];
		BlindingBG.cameras = [camPAUSE];

		#if mobileC

		var curcontrol:HitboxType = DEFAULT;

		switch (mania){
			case 1:
				curcontrol = SIX;
			case 2:
				curcontrol = NINE;
			default:
				curcontrol = DEFAULT;
		}
		_hitbox = new Hitbox(curcontrol);

		var camcontrol = new FlxCamera();
		FlxG.cameras.add(camcontrol);
		camcontrol.bgColor.alpha = 0;
		_hitbox.cameras = [camcontrol];

		_hitbox.visible = false;
		
		add(_hitbox);
		#end

		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;

		if (curStage == "nevada" || curStage == "nevadaSpook" || curStage == 'auditorHell')
			add(tstatic);

		if (curStage == 'auditorHell')
			tstatic.alpha = 0.1;

		if (curStage == 'nevadaSpook' || curStage == 'auditorHell')
		{
			tstatic.setGraphicSize(Std.int(tstatic.width * 12));
			tstatic.x += 600;
		}

		if (gameplayArea == "Story" && _variables.cutscene && !Main.playedVidCut)
		{
			switch (curSong.toLowerCase())
			{
				case "winter-horrorland" | "winter-horrorland-b" | "winter-horrorland-b3":
					var blackScreen:FlxSprite = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
					add(blackScreen);
					blackScreen.scrollFactor.set();
					camHUD.visible = false;
					camHB.visible = false;

					new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						remove(blackScreen);
						FlxG.sound.play(Paths.sound('Lights_Turn_On'), _variables.svolume/100);
						camFollow.y = -2050;
						camFollow.x += 200;
						FlxG.camera.focusOn(camFollow.getPosition());
						FlxG.camera.zoom = 1.5;

						new FlxTimer().start(0.8, function(tmr:FlxTimer)
						{
							camHUD.visible = true;
							camHB.visible = false;
							remove(blackScreen);
							FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 2.5, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									startCountdown();
								}
							});
						});
					});
				case 'senpai' | 'senpai-b' | 'senpai-b3':
					schoolIntro(doof);
				case 'roses' | 'roses-b' | 'roses-b3':
					FlxG.sound.play(Paths.sound('ANGRY'), _variables.svolume/100);
					FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'), _variables.svolume/100);
					schoolIntro(doof);
				case 'thorns' | 'thorns-b' | 'thorns-b3':
					schoolIntro(doof);
				case 'ugh':
					videoIntro();
				case 'guns':
					videoIntro();
				case 'stress':
					videoIntro();
				case 'satin-panties-neo':
					limoneointro(doof);
				case 'madness':
					videoIntro();
				case 'hellclown':
					videoIntro();
				case 'lo-fight':
					whittyIntro(doof);
				case 'overhead':
					schoolIntro(doof);
				case 'ballistic':
					ballzIntro(doof);
				case 'kaio-ken' | 'super-saiyan' | 'blast':
					superShaggy();
				case "god-eater":
					s_ending = true;
					if (!Main.skipDes)
					{
						godIntro();
						Main.skipDes = true;
					}
					else
					{
						godCutEnd = true;
						godMoveGf = true;
						godMoveSh = true;
						new FlxTimer().start(1, function(tmr:FlxTimer)
						{
							startCountdown();
						});
					}
				case 'improbable-outset':
					trickyCutscene();
			}

			Main.playedVidCut = true;
			trace ('next time dont play vid');
		}
		else if (!Main.switchside)
		{
			switch (curSong.toLowerCase())
			{
				case 'satin-panties-neo':
					limoneointro(doof);
				case 'kaio-ken' | 'super-saiyan' | 'blast':
				{
					dad.powerup = true;

				//	camFollow = new FlxObject(0, 0, 1, 1);

				//	camFollow.setPosition(dad.getMidpoint().x - 100, dad.getMidpoint().y - 0);

				//	add(camFollow);
				//	FlxG.camera.follow(camFollow, LOCKON, 0.04);
					superShaggy();
				}
				case 'god-eater':
					godCutEnd = true;
					godMoveGf = true;
					godMoveSh = true;
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						startCountdown();
					});
				case 'expurgation':
					camFollow.setPosition(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
					var spawnAnim = new FlxSprite(-150,-380);
					spawnAnim.frames = Paths.getSparrowAtlas('fourth/EXENTER');

					spawnAnim.animation.addByPrefix('start','Entrance',24,false);

					add(spawnAnim);

					spawnAnim.animation.play('start');
					var p = new FlxSound().loadEmbedded(Paths.sound("fourth/Trickyspawn"));
					var pp = new FlxSound().loadEmbedded(Paths.sound("fourth/TrickyGlitch"));
					p.play();
					spawnAnim.animation.finishCallback = function(pog:String)
						{
							pp.fadeOut();
							dad.visible = true;
							remove(spawnAnim);
							startCountdown();
						}
					new FlxTimer().start(0.001, function(tmr:FlxTimer)
						{
							if (spawnAnim.animation.frameIndex == 24)
							{
								pp.play();
							}
							else
								tmr.reset(0.001);
						});
				default:
					startCountdown();
			}

			Main.playedVidCut = true;
			trace ('next time dont play vid');
		}
		else
		{
			startCountdown();
			trace ('already played cutscene');
		}
		
		if (SONG.song.toLowerCase() == 'split') {
			nightbobandbosipLights = new FlxTypedGroup<FlxSprite>();
			add(nightbobandbosipLights);

			coolGlowyLights = new FlxTypedGroup<FlxSprite>();
			add(coolGlowyLights);
			coolGlowyLightsMirror = new FlxTypedGroup<FlxSprite>();
			add(coolGlowyLightsMirror);
			for (i in 0...4)
			{
				var light:FlxSprite = new FlxSprite().loadGraphic(Paths.image('nightbobandbosip/light' + i));
				light.scrollFactor.set(0, 0);
				light.cameras = [camHUD];
				light.visible = false;
				light.updateHitbox();
				light.antialiasing = true;
				nightbobandbosipLights.add(light);

				var glow:FlxSprite = new FlxSprite().loadGraphic(Paths.image('nightbobandbosip/Glow' + i));
				glow.scrollFactor.set(0, 0);
				glow.cameras = [camHUD];
				glow.visible = false;
				glow.updateHitbox();
				glow.antialiasing = true;
				coolGlowyLights.add(glow);

				var glow2:FlxSprite = new FlxSprite().loadGraphic(Paths.image('nightbobandbosip/Glow' + i));
				glow2.scrollFactor.set(0, 0);
				glow2.cameras = [camHUD];
				glow2.visible = false;
				glow2.updateHitbox();
				glow2.antialiasing = true;
				coolGlowyLightsMirror.add(glow2);
			}
		}

		if (SONG.song.toLowerCase() == 'run')
		{
			bobmadshake = new FlxSprite( -198, -118).loadGraphic(Paths.image('bob/bobscreen'));
			bobmadshake.scrollFactor.set(0, 0);
			bobmadshake.visible = false;
			
			bobsound = new FlxSound().loadEmbedded(Paths.sound('bobscreen'));
			add(bobmadshake);
		}

		super.create();

		areYouReady = new FlxTypedGroup<FlxSprite>();
		add(areYouReady);
		for (i in 0...3) {
			var shit:FlxSprite = new FlxSprite();
			switch (i) {
				case 0:
					shit = new FlxSprite().loadGraphic(Paths.image('splitcountdown/ARE'));
				case 1:
					shit = new FlxSprite().loadGraphic(Paths.image('splitcountdown/YOU'));
				case 2:
					shit = new FlxSprite().loadGraphic(Paths.image('splitcountdown/READY'));
			}
			shit.cameras = [camHUD];
			shit.visible = false;
			areYouReady.add(shit);
		}
	}

	function dialogueOrCountdown():Void
	{
		trace(dialogue);
		if (dialogue == null)
			startCountdown();
		else
			schoolIntro(doof);
	}

	function modifierValues():Void
	{
		if (_modifiers.LivesSwitch)
			lives = _modifiers.Lives;

		if (_modifiers.StartHealthSwitch)
			health = 1 + _modifiers.StartHealth / 100;

		if (_modifiers.HitZonesSwitch)
		{
			Conductor.safeFrames = Std.int(13 + _modifiers.HitZones);
			Conductor.safeZoneOffset = (Conductor.safeFrames / 60) * 1000;
			Conductor.timeScale = Conductor.safeZoneOffset / 166;
		}
		else
		{
			Conductor.safeFrames = 13; // why tf did i forget this
			Conductor.safeZoneOffset = (Conductor.safeFrames / 60) * 1000;
			Conductor.timeScale = Conductor.safeZoneOffset / 166;
		}

		if (_modifiers.Mirror)
		{
			camGame.flashSprite.scaleX *= -1;
			camNOTEHUD.flashSprite.scaleX *= -1;
			camSus.flashSprite.scaleX *= -1;
			camNOTES.flashSprite.scaleX *= -1;
			camHUD.flashSprite.scaleX *= -1;
			camHB.flashSprite.scaleX *= -1;
		}

		if (_modifiers.UpsideDown)
		{
			camGame.flashSprite.scaleY *= -1;
			camNOTEHUD.flashSprite.scaleY *= -1;
			camSus.flashSprite.scaleY *= -1;
			camNOTES.flashSprite.scaleY *= -1;
			camHUD.flashSprite.scaleY *= -1;
			camHB.flashSprite.scaleY *= -1;
		}
	}

	function updateAccuracy()
	{
		totalPlayed += 1;
		accuracy = totalNotesHit / totalPlayed * 100;
		if (accuracy >= 100.00)
		{
			if (misses == 0)
				accuracy = 100.00;
			else
			{
				accuracy = 99.98;
			}
		}

		accuracyTxt.text = "Accuracy: " + truncateFloat(accuracy, 2) + "%";
	}

	function videoIntro():Void
	{
		#if desktop
		switch (curSong.toLowerCase())
		{
			case 'ugh':
			FlxG.switchState(new VideoState("assets/videos/week7/ugh/ughCutscene.webm",new PlayState()));
			case 'guns':
			FlxG.switchState(new VideoState("assets/videos/week7/guns/gunsCutscene.webm",new PlayState()));
			case 'stress':
			FlxG.switchState(new VideoState("assets/videos/week7/stress/stressCutscene.webm",new PlayState()));
			case 'madness':
			FlxG.switchState(new VideoState("assets/videos/tricky/HankFuckingShootsTricky.webm", new PlayState()));
			case 'hellclown':
			FlxG.switchState(new VideoState("assets/videos/tricky/HELLCLOWN_ENGADGED.webm",new PlayState()));
		}
		#end
	}
	function dialogueEnding(?dialogueBox:DialogueBox):Void
	{
		if (dialogueBox != null)
		{
			trace(dialogue);

			inCutscene = true;

			add(dialogueBox);
		}
		else
			openSubState(new RankingSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
	}
	function schoolIntro(?dialogueBox:DialogueBox):Void
	{
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		add(black);

		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
		red.scrollFactor.set();

		var senpaiEvil:FlxSprite = new FlxSprite();
		senpaiEvil.frames = Paths.getSparrowAtlas('weeb/senpaiCrazy');
		senpaiEvil.animation.addByPrefix('idle', 'Senpai Pre Explosion', 24, false);
		senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * 6));
		senpaiEvil.scrollFactor.set();
		senpaiEvil.updateHitbox();
		senpaiEvil.screenCenter();

		if (SONG.song.toLowerCase() == 'roses' || SONG.song.toLowerCase() == 'thorns' || SONG.song.toLowerCase() == 'winter-horrorland')
		{
			remove(black);

			if (SONG.song.toLowerCase() == 'thorns')
			{
				add(red);
			}
		}
		if (SONG.song.toLowerCase() == 'roses-b' || SONG.song.toLowerCase() == 'thorns-b')
			{
				remove(black);
	
				if (SONG.song.toLowerCase() == 'thorns-b')
				{
					add(red);
				}
			}
		if (SONG.song.toLowerCase() == 'roses-b3' || SONG.song.toLowerCase() == 'thorns-b3')
			{
				remove(black);
	
				if (SONG.song.toLowerCase() == 'thorns-b3')
				{
					add(red);
				}
			}

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			black.alpha -= 0.15;

			if (black.alpha > 0)
			{
				tmr.reset(0.3);
			}
			else
			{
				if (dialogueBox != null)
				{
					inCutscene = true;

					if (SONG.song.toLowerCase() == 'thorns' || SONG.song.toLowerCase() == 'thorns-b' || SONG.song.toLowerCase() == 'thorns-b3')
					{
						add(senpaiEvil);
						senpaiEvil.alpha = 0;
						new FlxTimer().start(0.3, function(swagTimer:FlxTimer)
						{
							senpaiEvil.alpha += 0.15;
							if (senpaiEvil.alpha < 1)
							{
								swagTimer.reset();
							}
							else
							{
								senpaiEvil.animation.play('idle');
								FlxG.sound.play(Paths.sound('Senpai_Dies'), _variables.svolume/100, false, null, true, function()
								{
									remove(senpaiEvil);
									remove(red);
									FlxG.camera.fade(FlxColor.WHITE, 0.01, true, function()
									{
										add(dialogueBox);
									}, true);
								});
								new FlxTimer().start(3.2, function(deadTime:FlxTimer)
								{
									FlxG.camera.fade(FlxColor.WHITE, 1.6, false);
								});
							}
						});
					}
					else
					{
						add(dialogueBox);
					}
				}
				else
					startCountdown();

				remove(black);
			}
		});
	}
	
	function whittyIntro(?dialogueBox:DialogueBox):Void
		{	
			var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.fromRGB(19, 0, 0));
			black.scrollFactor.set();
			var black2:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
			black2.scrollFactor.set();
			black2.alpha = 0;
			var black3:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
			black3.scrollFactor.set();
			if (curSong.toLowerCase() != 'ballistic')
				add(black);

			var epic:Bool = false;
			var white:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.WHITE);
			white.scrollFactor.set();
			white.alpha = 0;

			trace('what animation to play, hmmmm');

			var wat:Bool = true;

			trace('cur song: ' + curSong);

			trace('funny lo-fight!!!');
				inCutscene = true;
				remove(dad);
				var animation:FlxSprite = new FlxSprite(-290,-100);
				animation.frames = Paths.getSparrowAtlas('cutscene/whittyCutscene');
				animation.animation.addByPrefix('startup', 'Whitty Cutscene Startup ', 24, false);
				animation.antialiasing = _variables.antialiasing;
				add(animation);
				black2.visible = true;
				black3.visible = true;
				add(black2);
				add(black3);
				black2.alpha = 0;
				black3.alpha = 0;
				trace(black2);
				trace(black3);

				var city:FlxSound = new FlxSound().loadEmbedded(Paths.sound('whitty/city'), true);
				var rip:FlxSound = new FlxSound().loadEmbedded(Paths.sound('whitty/rip'));
				var fire:FlxSound = new FlxSound().loadEmbedded(Paths.sound('whitty/fire'));
				var BEEP:FlxSound = new FlxSound().loadEmbedded(Paths.sound('whitty/beepboop'));
				city.fadeIn();
				camFollow.setPosition(dad.getMidpoint().x + 40, dad.getMidpoint().y - 180);

				camHUD.visible = false;
				camHB.visible = false;

				gf.y = 90000000;
				boyfriend.x += 314;

				new FlxTimer().start(0.01, function(tmr:FlxTimer)
					{

						if (!wat)
							{
								tmr.reset(3);
								wat = true;
							}
						else
						{
						// animation

						black.alpha -= 0.15;
			
						if (black.alpha > 0)
						{
							tmr.reset(0.3);
						}
						else
						{

							if (animation.animation.curAnim == null)
								animation.animation.play('startup');

							if (!animation.animation.finished)
								{
									tmr.reset(0.01);
									trace('animation at frame ' + animation.animation.frameIndex);

									switch(animation.animation.frameIndex)
									{
										case 0:
											trace('play city sounds');
										case 41:
											trace('fire');
											if (!fire.playing)
												fire.play();
										case 34:
											trace('paper rip');
											if (!rip.playing)
												rip.play();
										case 147:
											trace('BEEP');
											if (!BEEP.playing)
												{
													camFollow.setPosition(dad.getMidpoint().x + 460, dad.getMidpoint().y - 100);
													BEEP.play();
													boyfriend.playAnim('singLEFT', true);
												}
										case 154:
											if (boyfriend.animation.curAnim.name != 'idle')
												boyfriend.playAnim('idle');
									}
								}
							else
							{
								// CODE LOL!!!!
								if (black2.alpha != 1)
								{
									black2.alpha += 0.4;
									tmr.reset(0.1);
									trace('increase blackness lmao!!!');
								}
								else
								{
									if (black2.alpha == 1 && black2.visible)
										{
											black2.visible = false;
											black3.alpha = 1;
											trace('transision ' + black2.visible + ' ' + black3.alpha);
											remove(animation);
											add(dad);
											gf.y = 140;
											boyfriend.x -= 314;
											camHUD.visible = true;
											camHB.visible = true;
											tmr.reset(0.3);
										}
									else if (black3.alpha != 0)
										{
											black3.alpha -= 0.1;
											tmr.reset(0.3);
											trace('decrease blackness lmao!!!');
										}
										else 
										{
													if (dialogueBox != null)
													{
														add(dialogueBox);
														city.fadeOut();
													}
													else
													{
														startCountdown();
													}
												remove(black);
										}
								}
							}
						}
					}
					});
			}
		function ballzIntro(?dialogueBox:DialogueBox):Void
			{	
				var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.fromRGB(19, 0, 0));
				black.scrollFactor.set();
				var black2:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
				black2.scrollFactor.set();
				black2.alpha = 0;
				var black3:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
				black3.scrollFactor.set();
				if (curSong.toLowerCase() != 'ballistic')
					add(black);

				var epic:Bool = false;
				var white:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.WHITE);
				white.scrollFactor.set();
				white.alpha = 0;

				trace('what animation to play, hmmmm');

				var wat:Bool = true;

				trace('cur song: ' + curSong);

				trace('funny ballistic!!!');
				add(white);
				trace(white);
				var noMore:Bool = false;
				inCutscene = true;

				var wind:FlxSound = new FlxSound().loadEmbedded(Paths.sound('whitty/windLmao'),true);
				var mBreak:FlxSound = new FlxSound().loadEmbedded(Paths.sound('whitty/micBreak'));
				var mThrow:FlxSound = new FlxSound().loadEmbedded(Paths.sound('whitty/micThrow'));
				var mSlam:FlxSound = new FlxSound().loadEmbedded(Paths.sound('whitty/slammin'));
				var TOE:FlxSound = new FlxSound().loadEmbedded(Paths.sound('whitty/ouchMyToe'));
				var soljaBOY:FlxSound = new FlxSound().loadEmbedded(Paths.sound('whitty/souljaboyCrank'));
				var rumble:FlxSound = new FlxSound().loadEmbedded(Paths.sound('whitty/rumb'));

				remove(dad);

				var animation:FlxSprite = new FlxSprite(-480,-100);
				animation.frames = Paths.getSparrowAtlas('cutscene/cuttinDeezeBalls');
				animation.animation.addByPrefix('startup', 'Whitty Ballistic Cutscene', 24, false);
				animation.antialiasing = _variables.antialiasing;
				add(animation);
				

				camFollow.setPosition(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);

				remove(funneEffect);

				wind.fadeIn();
				camHUD.visible = false;
				camHB.visible = false;

				new FlxTimer().start(0.01, function(tmr:FlxTimer)
					{
						// animation

						if (!wat)
							{
								tmr.reset(1.5);
								wat = true;
							}
						else
						{

						
						if (animation.animation.curAnim == null) // check thingy go BEE BOOP
							{
								ballisticbg.animation.play('start', true);
								animation.animation.play('startup'); // if beopoe then make go BEP
								trace('start ' + animation.animation.curAnim.name);
							}
						if (!animation.animation.finished && animation.animation.curAnim.name == 'startup') // beep?
						{
							tmr.reset(0.01); // fuck
							noMore = true; // fuck outta here animation
							trace(animation.animation.frameIndex);
							switch(animation.animation.frameIndex)
							{
								case 87:
									if (!mThrow.playing)
										mThrow.play();
								case 86:
									if (!mSlam.playing)
										mSlam.play();
								case 128:
									if (!soljaBOY.playing)
										{
											soljaBOY.play();
											ballisticbg.animation.play('gaming', true);
											camFollow.camera.shake(0.01, 3);
										}
								case 123:
									if (!rumble.playing)
										rumble.play();
								case 135:
									camFollow.camera.stopFX();
								case 158:
									if (!TOE.playing)
									{
										TOE.play();
										camFollow.camera.stopFX();
										camFollow.camera.shake(0.03, 6);
									}
								case 52:
									if (!mBreak.playing)
										{
											mBreak.play();
										}
							}
						}
						else
						{
							// white screen thingy

							camFollow.camera.stopFX();

							if (white.alpha < 1 && !epic)
							{
								white.alpha += 0.4;
								tmr.reset(0.1);
							}
							else
							{
								if (!epic)
									{
										epic = true;
										trace('epic ' + epic);
										remove(animation);
										TOE.fadeOut();
										tmr.reset(0.1);
										ballisticbg.animation.play("gameButMove", true);
										dad = new Character(100, 100, SONG.player2);
										add(dad);
									}
								else
									{
										if (white.alpha != 0)
											{

												white.alpha -= 0.1;
												tmr.reset(0.1);
											}
										else 
										{
											if (dialogueBox != null)
												{
													camHUD.visible = true;
													camHB.visible = true;
													wind.fadeOut();
													healthBar.visible = true;
													healthBarBG.visible = true;
													scoreTxt.visible = true;
													comboTxt.visible = true;
													controlTxt.visible = true;
													iconP1.visible = true;
													iconP2.visible = true;
													add(dialogueBox);
												}
												else
												{
													startCountdown();
												}
												remove(white);
										}
									}
							}
						}
					}
					});
			}
		function limoneointro(?dialogueBox:DialogueBox):Void
			{	
				var bfneo:FlxSprite = new FlxSprite();
				bfneo.frames = Paths.getSparrowAtlas('BFCAR_SHOCKED');
				bfneo.animation.addByPrefix('shock', 'BF hit', 24, false);
				bfneo.setGraphicSize(Std.int(bfneo.width * 1));
				bfneo.scrollFactor.set(1, 1);
				bfneo.updateHitbox();
				bfneo.x += 1000;
				bfneo.y += 200;
		
				new FlxTimer().start(0, function(tmr:FlxTimer)
				{
						if (dialogueBox != null)
						{
							inCutscene = true;
							camFollow.y = 2000;
							camFollow.x = 800;
							if (SONG.song.toLowerCase() == 'satin-panties-neo')
							{
								new FlxTimer().start(0, function(deadTime:FlxTimer)
									{
										startCountdown();
										remove(dialogueBox);		
									});
								new FlxTimer().start(2, function(deadTime:FlxTimer)
									{
										remove(bfneo);	
										boyfriend.visible = true;	
									});
								add(bfneo);
								boyfriend.visible = false;
								bfneo.animation.play('shock');
								
								}
							else
							{
								add(dialogueBox);
							}
						}
						else
							startCountdown();
				});
			}
		function garIntro(?dialogueBox:DialogueBox):Void
			{
				var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
				black.scrollFactor.set();
				add(black);
		
				var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
				red.scrollFactor.set();
		
				var sexycutscene:FlxSprite = new FlxSprite();
				sexycutscene.antialiasing = _variables.antialiasing;
				sexycutscene.frames = Paths.getSparrowAtlas('GAR_CUTSCENE');
				sexycutscene.animation.addByPrefix('video', 'garcutscene', 15, false);
				sexycutscene.setGraphicSize(Std.int(sexycutscene.width * 2));
				sexycutscene.scrollFactor.set();
				sexycutscene.updateHitbox();
				sexycutscene.screenCenter();
		
				if (SONG.song.toLowerCase() == 'nerves' || SONG.song.toLowerCase() == 'release')
				{
					remove(black);
		
					if (SONG.song.toLowerCase() == 'release')
					{
						add(red);
					}
				}
		
				new FlxTimer().start(0.1, function(tmr:FlxTimer)
				{
					black.alpha -= 0.15;
		
					if (black.alpha > 0)
					{
						tmr.reset(0.1);
					}
					else
					{
						if (dialogueBox != null)
						{
							inCutscene = true;
		
							if (SONG.song.toLowerCase() == 'release')
							{
								camHUD.visible = false;
								camHB.visible = false;
								add(red);
								add(sexycutscene);
								sexycutscene.animation.play('video');
		
								FlxG.sound.play(Paths.sound('Garcello_Dies'), 1, false, null, true, function()
									{
										remove(red);
										remove(sexycutscene);
										FlxG.sound.play(Paths.sound('Wind_Fadeout'));
		
										FlxG.camera.fade(FlxColor.WHITE, 5, true, function()
										{
											add(dialogueBox);
											camHUD.visible = true;
											camHB.visible = true;
										}, true);
									});
							}
							else
							{
								add(dialogueBox);
							}
						}
						else
							startCountdown();
		
						remove(black);
					}
				});
			}
		function superShaggy()
			{
				#if desktop
				trace ('iconRPC = shaggypower');
				iconRPC = 'shaggypower';
				#end
				new FlxTimer().start(0.008, function(ct:FlxTimer)
				{
					switch (cutTime)
					{
						case 0:
							camFollow = new FlxObject(0, 0, 1, 1);
							add(camFollow);
							FlxG.camera.follow(camFollow, LOCKON, 0.04);
						case 15:
							dad.playAnim('power');
						case 48:
							dad.playAnim('idle_s');
							dad.powerup = true;
							burst = new FlxSprite(-1110, 0);
							FlxG.sound.play(Paths.sound('burst'),_variables.svolume/100);
							remove(burst);
							burst = new FlxSprite(dad.getMidpoint().x - 1000, dad.getMidpoint().y - 100);
							burst.frames = Paths.getSparrowAtlas('shaggy');
							burst.animation.addByPrefix('burst', "burst", 30);
							burst.animation.play('burst');
							//burst.setGraphicSize(Std.int(burst.width * 1.5));
							burst.antialiasing = _variables.antialiasing;
							add(burst);
		
							FlxG.sound.play(Paths.sound('powerup'),_variables.svolume/100);
						case 62:
							burst.y = 0;
							remove(burst);
						case 95:
							FlxG.camera.angle = 0;
						case 130:
							startCountdown();
					}
		
					var ssh:Float = 45;
					var stime:Float = 30;
					var corneta:Float = (stime - (cutTime - ssh)) / stime;
		
					if (cutTime % 6 >= 3)
					{
						corneta *= -1;
					}
					if (cutTime >= ssh && cutTime <= ssh + stime)
					{
						FlxG.camera.angle = corneta * 5;
					}
					cutTime ++;
					ct.reset(0.008);
				});
			}
		public function godIntro()
			{
				dad.playAnim('back', true);
				new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					dad.playAnim('snap', true);
					new FlxTimer().start(0.85, function(tmr2:FlxTimer)
					{
						FlxG.sound.play(Paths.sound('SNAP'),_variables.svolume/100);
						FlxG.sound.play(Paths.sound('undSnap'),_variables.svolume/100);
						sShake = 10;
						//pon el sonido con los efectos circulares
						new FlxTimer().start(0.06, function(tmr3:FlxTimer)
						{
							dad.playAnim('snapped', true);
						});
						new FlxTimer().start(1.5, function(tmr4:FlxTimer)
						{
							//la camara tiembla y puede ser que aparezcan rocas?
							new FlxTimer().start(0.001, function(shkUp:FlxTimer)
							{
								sShake += 0.51;
								if (!godCutEnd) shkUp.reset(0.001);
							});
							new FlxTimer().start(1, function(tmr5:FlxTimer)
							{
								add(new MansionDebris(-300, -120, 'ceil', 1, 1, -4, -40));
								add(new MansionDebris(0, -120, 'ceil', 1, 1, -4, -5));
								add(new MansionDebris(200, -120, 'ceil', 1, 1, -4, 40));
		
								sShake += 5;
								FlxG.sound.play(Paths.sound('ascend'),_variables.svolume/100);
								boyfriend.playAnim('hit');
								godCutEnd = true;
								new FlxTimer().start(0.4, function(tmr6:FlxTimer)
								{
									godMoveGf = true;
									boyfriend.playAnim('hit');
								});
								new FlxTimer().start(1, function(tmr9:FlxTimer)
								{
									boyfriend.playAnim('scared', true);
								});
								new FlxTimer().start(2, function(tmr7:FlxTimer)
								{
									dad.playAnim('idle', true);
									FlxG.sound.play(Paths.sound('shagFly'),_variables.svolume/100);
									godMoveSh = true;
									new FlxTimer().start(1.5, function(tmr8:FlxTimer)
									{
										startCountdown();
									});
								});
							});
						});	
					});
				});
				new FlxTimer().start(0.001, function(shk:FlxTimer)
				{
					if (sShake > 0)
					{
						sShake -= 0.5;
						FlxG.camera.angle = FlxG.random.float(-sShake, sShake);
					}
					shk.reset(0.001);
				});
			}

		function trickyCutscene():Void // god this function is terrible
			{
				trace('starting cutscene');
	
				var playonce:Bool = false;
	
				
				trans = new FlxSprite(-400,-760);
				trans.frames = Paths.getSparrowAtlas('Jaws');
				trans.antialiasing = true;
	
				trans.animation.addByPrefix("Close","Jaws smol", 24, false);
				
				trace(trans.animation.frames);
	
				trans.setGraphicSize(Std.int(trans.width * 1.6));
	
				trans.scrollFactor.set();
	
				trace('added trancacscas ' + trans);
	
		
	
				var faded:Bool = false;
				var wat:Bool = false;
				var black:FlxSprite = new FlxSprite(-300, -120).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.fromRGB(19, 0, 0));
				black.scrollFactor.set();
				black.alpha = 0;
				var black3:FlxSprite = new FlxSprite(-300, -120).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.fromRGB(19, 0, 0));
				black3.scrollFactor.set();
				black3.alpha = 0;
				var red:FlxSprite = new FlxSprite(-300, -120).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.fromRGB(19, 0, 0));
				red.scrollFactor.set();
				red.alpha = 1;
				inCutscene = true;
				//camFollow.setPosition(bf.getMidpoint().x + 80, bf.getMidpoint().y + 200);
				dad.alpha = 0;
				gf.alpha = 0;
				remove(boyfriend);
				var nevada:FlxSprite = new FlxSprite(260,FlxG.height * 0.7);
				nevada.frames = Paths.getSparrowAtlas('somewhere'); // add animation from sparrow
				nevada.antialiasing = true;
				nevada.animation.addByPrefix('nevada', 'somewhere idfk', 24, false);
				var animation:FlxSprite = new FlxSprite(-50,200); // create the fuckin thing
				animation.frames = Paths.getSparrowAtlas('intro'); // add animation from sparrow
				animation.antialiasing = true;
				animation.animation.addByPrefix('fuckyou','Symbol', 24, false);
				animation.setGraphicSize(Std.int(animation.width * 1.2));
				nevada.setGraphicSize(Std.int(nevada.width * 0.5));
				add(animation); // add it to the scene
				
				// sounds
	
				var ground:FlxSound = new FlxSound().loadEmbedded(Paths.sound('ground'));
				var wind:FlxSound = new FlxSound().loadEmbedded(Paths.sound('wind'));
				var cloth:FlxSound = new FlxSound().loadEmbedded(Paths.sound('cloth'));
				var metal:FlxSound = new FlxSound().loadEmbedded(Paths.sound('metal'));
				var buildUp:FlxSound = new FlxSound().loadEmbedded(Paths.sound('trickyIsTriggered'));
	
				camHUD.visible = false;
				camHB.visible = false;
				
				add(boyfriend);
	
				add(red);
				add(black);
				add(black3);
	
				add(nevada);
	
				add(trans);
	
				trans.animation.play("Close",false,false,18);
				trans.animation.pause();
	
				new FlxTimer().start(0.01, function(tmr:FlxTimer)
					{
					if (!wat)
						{
							tmr.reset(1.5);
							wat = true;
						}
						else
						{
						if (wat && trans.animation.frameIndex == 18)
						{
							trans.animation.resume();
							trace('playing animation...');
						}
					if (trans.animation.finished)
					{
					trace('animation done lol');
					new FlxTimer().start(0.01, function(tmr:FlxTimer)
					{
	
							if (boyfriend.animation.finished && !bfScared)
								boyfriend.animation.play('idle');
							else if (boyfriend.animation.finished)
								boyfriend.animation.play('scared');
							if (nevada.animation.curAnim == null)
							{
								trace('NEVADA | ' + nevada);
								nevada.animation.play('nevada');
							}
							if (!nevada.animation.finished && nevada.animation.curAnim.name == 'nevada')
							{
								if (nevada.animation.frameIndex >= 41 && red.alpha != 0)
								{
									trace(red.alpha);
									red.alpha -= 0.1;
								}
								if (nevada.animation.frameIndex == 34)
									wind.fadeIn();
								tmr.reset(0.1);
							}
							if (animation.animation.curAnim == null && red.alpha == 0)
							{
								remove(red);
								trace('play tricky');
								animation.animation.play('fuckyou', false, false, 40);
							}
							if (!animation.animation.finished && animation.animation.curAnim.name == 'fuckyou' && red.alpha == 0 && !faded)
							{
								trace("animation loop");
								tmr.reset(0.01);
	
								// animation code is bad I hate this
								// :(
	
								
								switch(animation.animation.frameIndex) // THESE ARE THE SOUNDS NOT THE ACTUAL CAMERA MOVEMENT!!!!
								{
									case 73:
										ground.play();
									case 84:
										metal.play();
									case 170:
										if (!playonce)
										{
											resetSpookyText = false;
											createSpookyText('OMFG CLOWN!!!!', 260, FlxG.height * 0.9);
											playonce = true;
										}
										cloth.play();
									case 192:
										resetSpookyTextManual();
										if (tstatic.alpha != 0)
											manuallymanuallyresetspookytextmanual();
										buildUp.fadeIn();
									case 219:
										trace('reset thingy');
										buildUp.fadeOut();
								}
	
							
								// im sorry for making this code.
								// TODO: CLEAN THIS FUCKING UP (switch case it or smth)
	
								if (animation.animation.frameIndex == 190)
									bfScared = true;
	
								if (animation.animation.frameIndex >= 115 && animation.animation.frameIndex < 200)
								{
									camFollow.setPosition(dad.getMidpoint().x + 150, boyfriend.getMidpoint().y + 50);
									if (FlxG.camera.zoom < 1.1)
										FlxG.camera.zoom += 0.01;
									else
										FlxG.camera.zoom = 1.1;
								}
								else if (animation.animation.frameIndex > 200 && FlxG.camera.zoom != defaultCamZoom)
								{
									FlxG.camera.shake(0.01, 3);
									if (FlxG.camera.zoom < defaultCamZoom || camFollow.y < boyfriend.getMidpoint().y - 50)
										{
											FlxG.camera.zoom = defaultCamZoom;
											camFollow.y = boyfriend.getMidpoint().y - 50;
										}
									else
										{
											FlxG.camera.zoom -= 0.008;
											camFollow.y = dad.getMidpoint().y -= 1;
										}
								}
								if (animation.animation.frameIndex >= 235)
									faded = true;
							}
							else if (red.alpha == 0 && faded)
							{
								trace('red gay');
								// animation finished, start a dialog or start the countdown (should also probably fade into this, aka black fade in when the animation gets done and black fade out. Or just make the last frame tranisiton into the idle animation)
								if (black.alpha != 1)
								{
									if (tstatic.alpha != 0)
										manuallymanuallyresetspookytextmanual();
									black.alpha += 0.4;
									tmr.reset(0.1);
									trace('increase blackness lmao!!!');
								}
								else
								{
									if (black.alpha == 1 && black.visible)
									{
										black.visible = false;
										black3.alpha = 1;
										trace('transision ' + black.visible + ' ' + black3.alpha);
										remove(animation);
										dad.alpha = 1;
										// why did I write this comment? I'm so confused
										// shitty layering but ninja muffin can suck my dick like mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
										remove(red);
										remove(black);
										remove(black3);
										dad.alpha = 1;
										gf.alpha = 1;
										add(black);
										add(black3);
										remove(tstatic);
										add(tstatic);
										tmr.reset(0.3);
										FlxG.camera.stopFX();
										camHUD.visible = true;
										camHB.visible = true;
									}
									else if (black3.alpha != 0)
									{
										black3.alpha -= 0.1;
										tmr.reset(0.3);
										trace('decrease blackness lmao!!!');
									}
									else 
									{
										wind.fadeOut();
										startCountdown();
									}
								}
						}
					});
					}
					else
					{
						trace(trans.animation.frameIndex);
						if (trans.animation.frameIndex == 30)
							trans.alpha = 0;
						tmr.reset(0.1);
					}
					}
				});
			}

			function trickySecondCutscene():Void // why is this a second method? idk cry about it loL!!!!
				{
					var done:Bool = false;
		
					trace('starting cutscene');
		
					var black:FlxSprite = new FlxSprite(-300, -120).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.WHITE);
					black.scrollFactor.set();
					black.alpha = 0;
					
					var animation:FlxSprite = new FlxSprite(200,300); // create the fuckin thing
		
					animation.frames = Paths.getSparrowAtlas('trickman'); // add animation from sparrow
					animation.antialiasing = true;
					animation.animation.addByPrefix('cut1','Cutscene 1', 24, false);
					animation.animation.addByPrefix('cut2','Cutscene 2', 24, false);
					animation.animation.addByPrefix('cut3','Cutscene 3', 24, false);
					animation.animation.addByPrefix('cut4','Cutscene 4', 24, false);
					animation.animation.addByPrefix('pillar','Pillar Beam Tricky', 24, false);
					
					animation.setGraphicSize(Std.int(animation.width * 1.5));
		
					animation.alpha = 0;
		
					camFollow.setPosition(dad.getMidpoint().x + 300, boyfriend.getMidpoint().y - 200);
		
					inCutscene = true;
					startedCountdown = false;
					generatedMusic = false;
					canPause = false;
		
					FlxG.sound.music.volume = 0;
					vocals.volume = 0;
		
					var sounders:FlxSound = new FlxSound().loadEmbedded(Paths.sound('honkers'));
					var energy:FlxSound = new FlxSound().loadEmbedded(Paths.sound('energy shot'));
					var roar:FlxSound = new FlxSound().loadEmbedded(Paths.sound('sound_clown_roar'));
					var pillar:FlxSound = new FlxSound().loadEmbedded(Paths.sound('firepillar'));
		
					var fade:FlxSprite = new FlxSprite(-300, -120).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.fromRGB(19, 0, 0));
					fade.scrollFactor.set();
					fade.alpha = 0;
		
					var textFadeOut:FlxText = new FlxText(300,FlxG.height * 0.5,0,"TO BE CONTINUED");
					textFadeOut.setFormat("Impact", 128, FlxColor.RED);
		
					textFadeOut.alpha = 0;
		
					add(animation);
		
					add(black);
		
					add(textFadeOut);
		
					add(fade);
		
					var startFading:Bool = false;
					var varNumbaTwo:Bool = false;
					var fadeDone:Bool = false;
		
					sounders.fadeIn(30);
		
					new FlxTimer().start(0.01, function(tmr:FlxTimer)
						{
							if (fade.alpha != 1 && !varNumbaTwo)
							{
								camHUD.alpha -= 0.1;
								camHB.alpha -= 0.1;
								fade.alpha += 0.1;
								if (fade.alpha == 1)
								{
									// THIS IS WHERE WE LOAD SHIT UN-NOTICED
									varNumbaTwo = true;
		
									animation.alpha = 1;
									
									dad.alpha = 0;
								}
								tmr.reset(0.1);
							}
							else
							{
								fade.alpha -= 0.1;
								if (fade.alpha <= 0.5)
									fadeDone = true;
								tmr.reset(0.1);
							}
						});
		
					var roarPlayed:Bool = false;
		
					new FlxTimer().start(0.01, function(tmr:FlxTimer)
					{
						if (!fadeDone)
							tmr.reset(0.1)
						else
						{
							if (animation.animation == null || animation.animation.name == null)
							{
								trace('playin cut cuz its funny lol!!!');
								animation.animation.play("cut1");
								resetSpookyText = false;
								createSpookyText('YOU DO NOT KILL CLOWN', 260, FlxG.height * 0.9);
							}
		
							if (!animation.animation.finished)
							{
								tmr.reset(0.1);
								trace(animation.animation.name + ' - FI ' + animation.animation.frameIndex);
		
								switch(animation.animation.frameIndex)
								{
									case 104:
										if (animation.animation.name == 'cut1')
											resetSpookyTextManual();
								}
		
								if (animation.animation.name == 'pillar')
								{
									if (animation.animation.frameIndex >= 85) // why is this not in the switch case above? idk cry about it
										startFading = true;
									FlxG.camera.shake(0.05);
								}
							}
							else
							{
								trace('completed ' + animation.animation.name);
								resetSpookyTextManual();
								switch(animation.animation.name)
								{
									case 'cut1':
										animation.animation.play('cut2');
									case 'cut2':
										animation.animation.play('cut3');
										energy.play();
									case 'cut3':
										animation.animation.play('cut4');
										resetSpookyText = false;
										createSpookyText('CLOWN KILLS YOU!!!!!!', 260, FlxG.height * 0.9);
										animation.x -= 100;
									case 'cut4':
										resetSpookyTextManual();
										sounders.fadeOut();
										pillar.fadeIn(4);
										animation.animation.play('pillar');
										animation.y -= 670;
										animation.x -= 100;
								}
								tmr.reset(0.1);
							}
		
							if (startFading)
							{
								sounders.fadeOut();
								trace('do the fade out and the text');
								if (black.alpha != 1)
								{
									tmr.reset(0.1);
									black.alpha += 0.02;
		
									if (black.alpha >= 0.7 && !roarPlayed)
									{
										roar.play();
										roarPlayed = true;
									}
								}
								else if (done)
								{
									endSong();
									FlxG.camera.stopFX();
								}
								else
								{
									done = true;
									tmr.reset(5);
								}
							}
						}
					});
				}

			function doStopSign(sign:Int = 0, fuck:Bool = false)
				{
					trace('sign ' + sign);
					var daSign:FlxSprite = new FlxSprite(0,0);
					CachedFrames.cachedInstance.get('sign');
			
					daSign.frames = CachedFrames.cachedInstance.fromSparrow('sign', 'fourth/mech/Sign_Post_Mechanic');

					daSign.setGraphicSize(Std.int(daSign.width * 4));
					daSign.updateHitbox();
					daSign.setGraphicSize(Std.int(daSign.width * 0.67));

					daSign.cameras = [camHUD];
			
					switch(sign)
					{
						case 0:
							daSign.animation.addByPrefix('sign','Signature Stop Sign 1',24, false);
							daSign.x = FlxG.width - 650;
							daSign.angle = -90;
							daSign.y = -300;
						case 1:
							/*daSign.animation.addByPrefix('sign','Signature Stop Sign 2',20, false);
							daSign.x = FlxG.width - 670;
							daSign.angle = -90;*/ // this one just doesn't work???
						case 2:
							daSign.animation.addByPrefix('sign','Signature Stop Sign 3',24, false);
							daSign.x = FlxG.width - 780;
							daSign.angle = -90;
							if (_variables.scroll == "down")
								daSign.y = -395;
							else
								daSign.y = -980;
						case 3:
							daSign.animation.addByPrefix('sign','Signature Stop Sign 4',24, false);
							daSign.x = FlxG.width - 1070;
							daSign.angle = -90;
							daSign.y = -145;
					}
					add(daSign);
					daSign.flipX = fuck;
					daSign.animation.play('sign');
					daSign.animation.finishCallback = function(pog:String)
						{
							trace('ended sign');
							remove(daSign);
						}
				}
			
				var totalDamageTaken:Float = 0;
			
				var shouldBeDead:Bool = false;
			
				var interupt = false;
			
				// basic explanation of this is:
				// get the health to go to
				// tween the gremlin to the icon
				// play the grab animation and do some funny maths,
				// to figure out where to tween to.
				// lerp the health with the tween progress
				// if you loose any health, cancel the tween.
				// and fall off.
				// Once it finishes, fall off.
			
				function doGremlin(hpToTake:Int, duration:Int,persist:Bool = false)
				{
					interupt = false;
			
					grabbed = true;
					
					totalDamageTaken = 0;
			
					var gramlan:FlxSprite = new FlxSprite(0,0);
			
					gramlan.frames = CachedFrames.cachedInstance.fromSparrow('grem', 'fourth/mech/HP GREMLIN');
			
					gramlan.setGraphicSize(Std.int(gramlan.width * 0.76));
			
					gramlan.cameras = [camHUD];
			
					gramlan.x = iconP1.x;
					gramlan.y = healthBarBG.y - 325;
			
					gramlan.animation.addByIndices('come','HP Gremlin ANIMATION',[0,1], "", 24, false);
					gramlan.animation.addByIndices('grab','HP Gremlin ANIMATION',[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24], "", 24, false);
					gramlan.animation.addByIndices('hold','HP Gremlin ANIMATION',[25,26,27,28],"",24);
					gramlan.animation.addByIndices('release','HP Gremlin ANIMATION',[29,30,31,32,33],"",24,false);
			
					gramlan.antialiasing = true;
			
					add(gramlan);
			
					if(_variables.scroll == 'down'){
						gramlan.flipY = true;
						gramlan.y -= 150;
					}
					
					// over use of flxtween :)
			
					var startHealth = health;
					var toHealth = (hpToTake / 100) * startHealth; // simple math, convert it to a percentage then get the percentage of the health
			
					var perct = toHealth / 2 * 100;
			
					trace('start: $startHealth\nto: $toHealth\nwhich is prect: $perct');
			
					var onc:Bool = false;
			
					FlxG.sound.play(Paths.sound('fourth/GremlinWoosh'));
			
					gramlan.animation.play('come');
					new FlxTimer().start(0.14, function(tmr:FlxTimer) {
						gramlan.animation.play('grab');
						FlxTween.tween(gramlan,{x: iconP1.x - 140},1,{ease: FlxEase.elasticIn, onComplete: function(tween:FlxTween) {
							trace('I got em');
							gramlan.animation.play('hold');
							FlxTween.tween(gramlan,{
								x: (healthBar.x + 
								(healthBar.width * (FlxMath.remapToRange(perct, 0, 100, 100, 0) * 0.01) 
								- 26)) - 75}, duration,
							{
								onUpdate: function(tween:FlxTween) { 
									// lerp the health so it looks pog
									if (interupt && !onc && !persist)
									{
										onc = true;
										trace('oh shit');
										gramlan.animation.play('release');
										gramlan.animation.finishCallback = function(pog:String) { gramlan.alpha = 0;}
									}
									else if (!interupt || persist)
									{
										var pp = FlxMath.lerp(startHealth,toHealth, tween.percent);
										if (pp <= 0)
											pp = 0.1;
										health = pp;
									}
			
									if (shouldBeDead)
										health = 0;
								},
								onComplete: function(tween:FlxTween)
								{
									if (interupt && !persist)
									{
										remove(gramlan);
										grabbed = false;
									}
									else
									{
										trace('oh shit');
										gramlan.animation.play('release');
										if (persist && totalDamageTaken >= 0.7)
											health -= totalDamageTaken; // just a simple if you take a lot of damage wtih this, you'll loose probably.
										gramlan.animation.finishCallback = function(pog:String) { remove(gramlan);}
										grabbed = false;
									}
								}
							});
						}});
					});
				}
			
				var cloneOne:FlxSprite;
				var cloneTwo:FlxSprite;
			
				function doClone(side:Int)
				{
					switch(side)
					{
						case 0:
							if (cloneOne.alpha == 1)
								return;
							cloneOne.x = dad.x - 20;
							cloneOne.y = dad.y + 140;
							cloneOne.alpha = 1;
			
							cloneOne.animation.play('clone');
							cloneOne.animation.finishCallback = function(pog:String) {cloneOne.alpha = 0;}
						case 1:
							if (cloneTwo.alpha == 1)
								return;
							cloneTwo.x = dad.x + 390;
							cloneTwo.y = dad.y + 140;
							cloneTwo.alpha = 1;
			
							cloneTwo.animation.play('clone');
							cloneTwo.animation.finishCallback = function(pog:String) {cloneTwo.alpha = 0;}
					}
			
				}
		
	var sShake:Float = 0;
	var startTimer:FlxTimer;
	var perfectMode:Bool = false;
	var bfScared:Bool = false;
	var noticeB:Array<FlxText> = [];
	var nShadowB:Array<FlxText> = [];

	function startCountdown():Void
	{
		#if mobileC
		_hitbox.visible = true;
		#end

		inCutscene = false;

		if (_variables.botplay && Main.camhiddeninbotplay)
		{
			trace ('botplay is enabled and cam was hiden before');
			camNOTEHUD.visible = false;
			camNOTES.visible = false;
			camHUD.visible = false;
			camHB.visible = false;
		}

		if (gameplayArea != "Endless" || (gameplayArea == "Endless" && loops == 0))
		{
			hudArrows = [];
			if (_variables.scroll != 'left' && _variables.scroll != 'right')
				generateStaticArrows(0);
			generateStaticArrows(1);
			#if desktop
			if (FileSystem.exists('assets/data/' + SONG.song.toLowerCase() + '/scripts/chart.hx'))
			{
				modState.set("strum0", strumLineNotes.members[0]);
				modState.set("strum1", strumLineNotes.members[1]);
				modState.set("strum2", strumLineNotes.members[2]);
				modState.set("strum3", strumLineNotes.members[3]);
				modState.set("strum4", strumLineNotes.members[4]);
				modState.set("strum5", strumLineNotes.members[5]);
				modState.set("strum6", strumLineNotes.members[6]);
				modState.set("strum7", strumLineNotes.members[7]);
				hscript();
				if (FileSystem.exists('assets/data/' + SONG.song.toLowerCase() + '/scripts/start.hx'))
					loadStartScript();
				trace('SOME MODIFIERS ARE DISABLED! THEY WONT WORK PROPERLY WITH MODCHARTS');
			}
			#end
		}

		if (mania == 0)
		{
			trace ('4 Keys Mode');
		}
		else if (mania == 1)
		{
			trace ('6 Keys Mode');
		}
		else if (mania == 2)
		{
			trace ('9 Keys Mode');
		}
		else
		{
			trace ('Ay yo how many keys???!?!');
		}

		talking = false;
		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;

		if (mania == 1)
		{
			new FlxTimer().start(0.002, function(cbt:FlxTimer)
				{
					if (ctrTime == 0)
					{		
						var cText:Array<String> = [_keybind.l1Bind, _keybind.u1Bind, _keybind.r1Bind, _keybind.l2Bind, _keybind.d1Bind, _keybind.r2Bind];

						var nJx = 100;
						for (i in 0...6)
						{
							noticeB[i] = new FlxText(0, 0, 0, cText[i], 32);
							noticeB[i].x = FlxG.width * 0.5 + nJx*i + 35;
							noticeB[i].y = 100;
							if (_variables.scroll == "down")
							{
								noticeB[i].y = FlxG.height - 60;
								switch (i)
								{
									case 4:
										noticeB[i].y -= 160;
								}
							}
							noticeB[i].scrollFactor.set();
							//notice[i].alpha = 0;
	
							nShadowB[i] = new FlxText(0, 0, 0, cText[i], 32);
							nShadowB[i].x = noticeB[i].x + 4;
							nShadowB[i].y = noticeB[i].y + 4;
							nShadowB[i].scrollFactor.set();
	
							nShadowB[i].alpha = noticeB[i].alpha;
							nShadowB[i].color = 0x00000000;
	
							//notice.alpha = 0;
	
							add(nShadowB[i]);
							add(noticeB[i]);
						}
	
						
					}
					else
					{
						for (i in 0...6)
						{
							if (ctrTime < 600)
							{
								if (noticeB[i].alpha < 1)
								{
									noticeB[i].alpha += 0.02;
								}
							}
							else
							{
								noticeB[i].alpha -= 0.02;
							}
						}
					}
					for (i in 0...6)
					{
						nShadowB[i].alpha = noticeB[i].alpha;
					}
					ctrTime ++;
					cbt.reset(0.004);
				});
		}
		else if (mania == 2)
		{
			new FlxTimer().start(0.002, function(cbt:FlxTimer)
				{
					if (ctrTime == 0)
					{
						var cText:Array<String> = [_keybind.n0Bind, _keybind.n1Bind, _keybind.n2Bind, _keybind.n3Bind, _keybind.n4Bind, _keybind.n5Bind, _keybind.n6Bind, _keybind.n7Bind, _keybind.n8Bind];
						var nJx = 100;
						for (i in 0...9)
						{
							noticeB[i] = new FlxText(0, 0, 0, cText[i], 32);
							noticeB[i].x = FlxG.width * 0.5 + nJx*i + 45;
							noticeB[i].y = 20;
							if (_variables.scroll == "down")
							{
								noticeB[i].y = FlxG.height - 80;
								switch (i)
								{
									case 4:
										noticeB[i].y -= 160;
								}
							}
							noticeB[i].scrollFactor.set();
							//notice[i].alpha = 0;
	
							nShadowB[i] = new FlxText(0, 0, 0, cText[i], 32);
							nShadowB[i].x = noticeB[i].x + 4;
							nShadowB[i].y = noticeB[i].y + 4;
							nShadowB[i].scrollFactor.set();
	
							nShadowB[i].alpha = noticeB[i].alpha;
							nShadowB[i].color = 0x00000000;
	
							//notice.alpha = 0;
	
							add(nShadowB[i]);
							add(noticeB[i]);
						}
	
						
					}
					else
					{
						for (i in 0...9)
						{
							if (ctrTime < 600)
							{
								if (noticeB[i].alpha < 1)
								{
									noticeB[i].alpha += 0.02;
								}
							}
							else
							{
								noticeB[i].alpha -= 0.02;
							}
						}
					}
					for (i in 0...9)
					{
						nShadowB[i].alpha = noticeB[i].alpha;
					}
					ctrTime ++;
					cbt.reset(0.004);
				});
		}
		var swagCounter:Int = 0;

		startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			if (SONG.exDad) dad2.dance();
			dad.dance();
			gf.dance();
			if (!frozen)
			{
				if (SONG.exBF) boyfriend2.dance();
				boyfriend.dance();
				if (_modifiers.FrightSwitch)
					{
						if (_modifiers.Fright >= 50 && _modifiers.Fright < 100)
						{
							boyfriend.playAnim('scared');
							if (SONG.exBF) boyfriend2.playAnim('scared');
						}
						else if (_modifiers.Fright >= 100)
						{
							boyfriend.playAnim('worried');
							if (SONG.exBF) boyfriend2.playAnim('worried');
						}
					}
			}
			else
				boyfriend.playAnim('frozen');
				if (SONG.exBF) boyfriend2.playAnim('frozen');

			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ready', "set", "go"]);
			introAssets.set('school', [
				'weeb/pixelUI/ready-pixel',
				'weeb/pixelUI/set-pixel',
				'weeb/pixelUI/date-pixel'
			]);
			introAssets.set('saltyschool', [
				'weebsalty/pixelUI/ready-pixelsalty',
				'weebsalty/pixelUI/set-pixelsalty',
				'weebsalty/pixelUI/date-pixelsalty'
			]);

			var introAlts:Array<String> = introAssets.get('default');
			var altSuffix:String = "";

		//	for (value in introAssets.keys())
		//	{
			if (SONG.notestyle == 'pixel')
			{
				introAlts = introAssets.get('school');		
			}
			else if (SONG.notestyle == 'pixel' && curStage.startsWith('saltyschool'))
			{
				introAlts = introAssets.get('saltyschool');
			}
		//	}

		if (SONG.notestyle == 'pixel')
		{
			switch (_variables.annoncers)
			{
				default:
				altSuffix = 'pixel';
				case 'amor':
				altSuffix = 'amor-pixel';
				case 'ash':
				altSuffix = 'ash-pixel';
				case 'bluskys':
				altSuffix = 'bluskys-pixel';
				case 'bob':
				altSuffix = 'bob-pixel';
				case 'bosip':
				altSuffix = 'bosip-pixel';
				case 'cool':
				altSuffix = 'cool-pixel';
				case 'gloopy':
				altSuffix = 'gloopy-pixel';
				case 'jghost':
				altSuffix = 'jghost-pixel';
				case 'mini':
				altSuffix = 'mini-pixel';
				case 'ron':
				altSuffix = 'ron-pixel';
			}
			if (SONG.notestyle == 'pixel' && curStage.startsWith('saltyschool'))
			{
				altSuffix = 'pixel-salty';
			}
		}
		else
		{
			switch (_variables.annoncers)
			{
				default:
				altSuffix = 'default';			
				case 'amor':
				altSuffix = 'amor';
				case 'ash':
				altSuffix = 'ash';
				case 'bluskys':
				altSuffix = 'bluskys';
				case 'bob':
				altSuffix = 'bob';
				case 'bosip':
				altSuffix = 'bosip';
				case 'cool':
				altSuffix = 'cool';
				case 'gloopy':
				altSuffix = 'gloopy';
				case 'jghost':
				altSuffix = 'jghost';
				case 'mini':
				altSuffix = 'mini';
				case 'ron':
				altSuffix = 'ron';
			}
		}

			switch (swagCounter)
			{
				case 0:
					FlxG.sound.play(Paths.sound('countdowns/' + altSuffix + '/intro3'), 0.6 * _variables.svolume / 100);

					new FlxTimer().start(0.03, function(tmr:FlxTimer)
					{
						camHB.alpha += 1 / 6;
						camHUD.alpha += 1 / 6;
						camNOTES.alpha += 1 / 6;
						camSus.alpha += 1 / 6;
						camNOTEHUD.alpha += 1 / 6;
					}, 10);
				case 1:
					var ready:FlxSprite = new FlxSprite();
					ready.cameras = [camHUD];
					if (introAlts[0] == 'ready')
						ready.loadGraphic(Paths.image(introAlts[0]));
					else
						ready.loadGraphic(Paths.image(introAlts[0]));
					ready.scrollFactor.set();
					ready.updateHitbox();

					if (SONG.notestyle == 'pixel')
						ready.setGraphicSize(Std.int(ready.width * daPixelZoom));

					ready.screenCenter();
					add(ready);
					FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							ready.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('countdowns/' + altSuffix + '/intro2'), 0.6 * _variables.svolume / 100);
				case 2:
					var set:FlxSprite = new FlxSprite();
					set.cameras = [camHUD];
					if (introAlts[1] == 'set')
						set.loadGraphic(Paths.image(introAlts[1]));
					else
						set.loadGraphic(Paths.image(introAlts[1]));

					set.scrollFactor.set();

					if (SONG.notestyle == 'pixel')
						set.setGraphicSize(Std.int(set.width * daPixelZoom));

					set.screenCenter();
					add(set);
					FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							set.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('countdowns/' + altSuffix + '/intro1'), 0.6 * _variables.svolume / 100);
				case 3:
					var go:FlxSprite = new FlxSprite();
					go.cameras = [camHUD];
					if (introAlts[2] == 'go')
						go.loadGraphic(Paths.image(introAlts[2]));
					else
						go.loadGraphic(Paths.image(introAlts[2]));

					if (SONG.notestyle == 'pixel')
						go.setGraphicSize(Std.int(go.width * daPixelZoom));

					go.scrollFactor.set();

					go.updateHitbox();

					go.screenCenter();
					add(go);
					FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							go.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('countdowns/' + altSuffix + '/introGo'), 0.6 * _variables.svolume / 100);
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);

		if (SONG.song.toLowerCase() == 'expurgation') // start the grem time
		{
			new FlxTimer().start(25, function(tmr:FlxTimer) {
				if (curStep < 2400)
				{
					if (canPause && !paused && health >= 1.5 && !grabbed)
						doGremlin(40,3);
					trace('checka ' + health);
					tmr.reset(25);
				}
			});
		}
	}

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;
	var grabbed = false;

	var songStarted = false;

	function startSong():Void
	{
		if (useVideo)
			BackgroundVideo.get().resume();

		startingSong = false;
		songStarted = true;
		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;

		if (!paused)
			if (_modifiers.VibeSwitch)
			{
				switch (_modifiers.Vibe)
				{
					case 0.8:
						FlxG.sound.playMusic(Paths.instHIFI(PlayState.SONG.song), _variables.mvolume/100, false);
					default:
						FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), _variables.mvolume/100, false);
					case 1.2:
						FlxG.sound.playMusic(Paths.instLOFI(PlayState.SONG.song), _variables.mvolume/100, false);
				}
			}
			else
				FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), _variables.mvolume/100, false);

		if (SONG.song.toLowerCase().contains('madness') && gameplayArea == "Story")
			FlxG.sound.music.onComplete = trickySecondCutscene;
		else
			FlxG.sound.music.onComplete = endSong;

		vocals.play();

		if (_modifiers.OffbeatSwitch)
			vocals.time = Conductor.songPosition + (512 * _modifiers.Offbeat/100);

		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		if (_variables.songPosition) // I dont wanna talk about this code :(
			{
				remove(songPosBG);
				remove(songPosBar);
				remove(songName);

				songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
				if (_variables.scroll == "down")
					songPosBG.y = FlxG.height * 0.9 + 45; 
				songPosBG.screenCenter(X);
				songPosBG.scrollFactor.set();
				add(songPosBG);
				songPosBG.cameras = [camHUD];
				
				if (SONG.song.toLowerCase() == 'tutorial-bnb' && Main.exMode) {
					songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
					'songPositionBar', 0, (songLength * 0.44) - 1000);
				} else {
					songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
						'songPositionBar', 0, songLength - 1000);
				}
				songPosBar.numDivisions = 1000;
				songPosBar.scrollFactor.set();
				songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
				add(songPosBar);
				songPosBar.cameras = [camHUD];
	
				var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - 20,songPosBG.y,0,SONG.song, 16);
				if (_variables.scroll == "down")
					songName.y -= 3;
				songName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
				songName.scrollFactor.set();
				add(songName);
				songName.cameras = [camHUD];
			}

		// Song check real quick
		switch(curSong)
		{
			case 'Bopeebo' | 'Philly' | 'Blammed' | 'Cocoa' | 'Eggnog': allowedToHeadbang = true;
			default: allowedToHeadbang = false;
		}

		#if windows
		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText,SONG.song + " (" + storyDifficultyText + ")", iconRPC, true, songLength);
		#end
	}

	var debugNum:Int = 0;
	var stair:Int = 0;

	function endOrcutcene():Void
	{
		switch (SONG.song.toLowerCase())
		{
		//	case 'senpai':
		//		dialogue = CoolUtil.coolTextFile(Paths.txt(SONG.song.toLowerCase()+'/dialogue$dialogueSuffix'));
		//		dialogueEnding(doof);
			default:
				if (!RankingSubstate.inrankingsubstate)
				{
				openSubState(new RankingSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
				}
		}
	}

	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());

		var songData = SONG;

		Conductor.changeBPM(songData.bpm);

		if (_modifiers.VibeSwitch)
		{
			switch (_modifiers.Vibe)
			{
				case 0.6:
					Conductor.changeBPM(songData.bpm * 1.4);
				case 0.8:
					Conductor.changeBPM(songData.bpm * 1.2);
				case 1.2:
					Conductor.changeBPM(songData.bpm * 0.8);
				case 1.4:
					Conductor.changeBPM(songData.bpm * 0.64);
			}
		}

		curSong = songData.song;

		if (SONG.needsVoices)
			if (_modifiers.VibeSwitch)
				{
					switch (_modifiers.Vibe)
					{
					case 0.8:
						vocals = new FlxSound().loadEmbedded(Paths.voicesHIFI(PlayState.SONG.song));
					default:
						vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
					case 1.2:
						vocals = new FlxSound().loadEmbedded(Paths.voicesLOFI(PlayState.SONG.song));
					}
				}
			else
				vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		FlxG.sound.list.add(vocals);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped
		var random = null;
		for (section in noteData)
		{
			//some 5note changes
			var mn:Int = keyAmmo[mania]; //new var to determine max notes
			var dj:Int = Main.dataJump[mania];
			var msn:Int = dj * 6;
			var coolSection:Int = Std.int(section.lengthInSteps / 4);

			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0];
				if (daStrumTime < 0)
					daStrumTime = 0;
				var daNoteData:Int = Std.int(songNotes[1] % 5);

				var gottaHitNote:Bool = section.mustHitSection;

				if (Main.switchside)
				{
					gottaHitNote = !section.mustHitSection;
				}
				else
				{
					gottaHitNote = section.mustHitSection;
				}

				if (_modifiers.OffbeatSwitch)
				{
					offbeatValue = 512 * _modifiers.Offbeat/100;
				}

				if (_modifiers.VibeSwitch)
					{
						switch (_modifiers.Vibe)
						{
						case 0.8:
							daStrumTime = (daStrumTime + _variables.noteOffset + offbeatValue) * 0.8332; //somewhere around 0.832
						default:
							daStrumTime = daStrumTime + _variables.noteOffset + offbeatValue;
						case 1.2:
							daStrumTime = (daStrumTime + _variables.noteOffset + offbeatValue) * 1.25;
						}
					}
				else
					daStrumTime = daStrumTime + _variables.noteOffset + offbeatValue;

				if (songNotes[1] % (mn * 2) >= mn)
				{
					if (Main.switchside)
					{
						gottaHitNote = section.mustHitSection;
					}
					else
					{
						gottaHitNote = !section.mustHitSection;
					}		
				}

				switch (chartType)
				{
					case "standard":
					{
						if (Main.switchside)
						{
							daNoteData = mn - 1 - Std.int(songNotes[1] % mn);
						}
						else
						{
							daNoteData = Std.int(songNotes[1]);
						}
					}
					case "flip":
						//B-SIDE FLIP???? Rozebud be damned lmao 
						//litteraly had to manually flip this garbage ass shit :|
						//nvm lags too musch
						if (Main.switchside)
						{
							if (!gottaHitNote)
							{
								daNoteData = mn - 1 - Std.int(songNotes[1] % mn);	
							}
						}
						else
						{
							if (gottaHitNote)
							{
								daNoteData = mn - 1 - Std.int(songNotes[1] % mn);	
							}
						}					 
					case "chaos":
						if (mania == 0)
						{
							daNoteData = FlxG.random.int(0, msn);
						}
						else if (mania == 1)
						{
							daNoteData = FlxG.random.int(0, msn);
						}
						else if (mania == 2)
						{
							daNoteData = FlxG.random.int(0, msn);
						}
						
					case "onearrow":
						daNoteData = arrowLane;
					case "stair":
						daNoteData = stair % mn;
						stair++;
				}

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				switch (_variables.arrow)
				{
					case 'default':
					arrowextra = "";
					case 'tabi':
					arrowextra = "-tabi";
					case 'kapi':
					arrowextra = "-kapi";
					case 'neo':
					arrowextra = "-neo";
					case 'ddr':
					arrowextra = "-ddr";
				}
				switch (_variables.arrowDad)
				{
					case 'default':
					arrowextraDad = "";
					case 'tabi':
					arrowextraDad = "-tabi";
					case 'kapi':
					arrowextraDad = "-kapi";
					case 'neo':
					arrowextraDad = "-neo";
					case 'ddr':
					arrowextraDad = "-ddr";
				}

				var swagNote:Note;
				if (gottaHitNote){
					swagNote = new Note(daStrumTime, daNoteData, oldNote, false, arrowextra);
				}
				else {
					swagNote = new Note(daStrumTime, daNoteData, oldNote, false, arrowextraDad);
				}

				swagNote.sustainLength = songNotes[2];
				swagNote.scrollFactor.set(0, 0);
				swagNote.dType = section.dType;	
				swagNote.bType = section.bType;	

				if (_modifiers.WidenSwitch)
					swagNote.scale.x *= _modifiers.Widen / 100 + 1;
				if (_modifiers.StretchSwitch && !swagNote.isSustainNote)
					swagNote.scale.y *= _modifiers.Stretch / 100 + 1;

				var susLength:Float = swagNote.sustainLength;

				if (_modifiers.EelNotesSwitch)
					susLength += 10 * _modifiers.EelNotes;

				if (_modifiers.VibeSwitch)
				{
					switch (_modifiers.Vibe)
					{
						case 0.8:
							susLength = susLength / Conductor.stepCrochet * 0.8338 / speedNote; // somewhere around 0.832
						case 1.2:
							susLength = susLength / Conductor.stepCrochet * 1.25 / speedNote;
						default:
							susLength = susLength / Conductor.stepCrochet / speedNote;
					}
				}
				else
					susLength = susLength / Conductor.stepCrochet / speedNote;

				unspawnNotes.push(swagNote);

				for (susNote in 0...Math.floor(susLength))
				{
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

					var sustainNote:Note;
					if (gottaHitNote){
						sustainNote = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true, arrowextra);
					}
					else {
						sustainNote = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true, arrowextraDad);
					}
					sustainNote.scrollFactor.set();
					unspawnNotes.push(sustainNote);

					sustainNote.mustPress = gottaHitNote;

					if (sustainNote.mustPress && (_variables.scroll != 'left' && _variables.scroll != 'right'))
					{
						sustainNote.x += FlxG.width / 2; // general offset
					}

					if (_variables.scroll == 'left' || _variables.scroll == 'right')
					{
						sustainNote.x += FlxG.width / 4 + 50;
						if (!sustainNote.mustPress)
							sustainNote.alpha = 0.3;
					}
				}

				swagNote.mustPress = gottaHitNote;

				if (swagNote.mustPress && (_variables.scroll != 'left' && _variables.scroll != 'right'))
				{
					swagNote.x += FlxG.width / 2; // general offset
				}
				else
				{
				}

				var jackNote:Note;

				if (_modifiers.JacktasticSwitch)
				{
					for (i in 0...Std.int(_modifiers.Jacktastic))
					{
						if (gottaHitNote){
							jackNote = new Note(swagNote.strumTime + 70 * (i + 1), swagNote.noteData, oldNote, false, arrowextra);
						}
						else {
							jackNote = new Note(swagNote.strumTime + 70 * (i + 1), swagNote.noteData, oldNote, false, arrowextraDad);
						}
						
						jackNote.scrollFactor.set(0, 0);

						if (_modifiers.WidenSwitch)
							jackNote.scale.x *= _modifiers.Widen / 100 + 1;
						if (_modifiers.StretchSwitch)
							jackNote.scale.y *= _modifiers.Stretch / 100 + 1;

						unspawnNotes.push(jackNote);

						jackNote.mustPress = swagNote.mustPress;

						if (jackNote.mustPress && (_variables.scroll != 'left' && _variables.scroll != 'right'))
						{
							jackNote.x += FlxG.width / 2; // general offset
						}

						if (_variables.scroll == 'left' || _variables.scroll == 'right')
						{
							jackNote.x += FlxG.width / 4 + 50;
							if (!jackNote.mustPress)
								jackNote.alpha = 0.3;
						}
					}
				}

				if (_variables.scroll == 'left' || _variables.scroll == 'right')
				{
					swagNote.x += FlxG.width / 4 + 50;
					if (!swagNote.mustPress)
						swagNote.alpha = 0.3;
				}
			}
			daBeats += 1;
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);

		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	var noteOutput:Float = 0;

	var hudArrows:Array<FlxSprite>;
	var hudArrXPos:Array<Float>;
	var hudArrYPos:Array<Float>;
	private function generateStaticArrows(player:Int):Void
	{
		hudArrXPos = [];
		hudArrYPos = [];
		for (i in 0...keyAmmo[mania])
		{
			// FlxG.log.add(i);
			var babyArrow:FlxSkewedSprite = new FlxSkewedSprite(0, strumLine.y);
			hudArrows.push(babyArrow);

			if (_modifiers.FlippedNotes)
				noteOutput = Math.abs(3 - i);
			else
				noteOutput = Math.abs(i);

			switch (SONG.notestyle)
			{
				case 'pixel':
					if (player == 0){
						babyArrow.frames = Paths.getSparrowAtlas('weeb/pixelUI/arrows-pixels' + arrowextraDad);
					}
					else if (player == 1){
						babyArrow.frames = Paths.getSparrowAtlas('weeb/pixelUI/arrows-pixels' + arrowextra);
					}
					babyArrow.animation.addByPrefix('green', 'arrowUP');
					babyArrow.animation.addByPrefix('red', 'arrowRIGHT');
					babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
					babyArrow.animation.addByPrefix('purplel', 'arrowLEFT');

					babyArrow.setGraphicSize(Std.int(babyArrow.width * daPixelZoom * Note.pixelnoteScale));
					babyArrow.updateHitbox();
					babyArrow.antialiasing = false;

					
					var nSuf:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
					var pPre:Array<String> = ['left', 'down', 'up', 'right'];

					if (Main.switchside)
					{
						switch (mania)
						{
							case 0:
								nSuf = ['RIGHT', 'UP', 'DOWN', 'LEFT'];
								pPre = ['right', 'up', 'down', 'left'];
							case 1:
								nSuf = ['RIGHT', 'DOWN', 'LEFT', 'RIGHT', 'UP', 'LEFT'];
								pPre = ['dark', 'down', 'yel', 'right', 'up', 'left'];
							case 2:
								nSuf = ['RIGHT', 'UP', 'DOWN', 'LEFT', 'SPACE', 'RIGHT', 'UP', 'DOWN', 'LEFT'];
								pPre = ['dark', 'black', 'violet', 'yel', 'white', 'right', 'up', 'down', 'left'];
								babyArrow.x -= Note.tooMuch;
						}
					}
					else
					{
						switch (mania)
						{
							case 0:
								nSuf = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
								pPre = ['left', 'down', 'up', 'right'];
							case 1:
								nSuf = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
								pPre = ['left', 'up', 'right', 'yel', 'down', 'dark'];
							case 2:
								nSuf = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'SPACE', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
								pPre = ['left', 'down', 'up', 'right', 'white', 'yel', 'violet', 'black', 'dark'];
								babyArrow.x -= Note.tooMuch;
						}
					}
					
					babyArrow.x += Note.swagWidth * i;
					babyArrow.animation.addByPrefix('static', 'arrow' + nSuf[i]);
					babyArrow.animation.addByPrefix('pressed', pPre[i] + ' press', 24, false);
					babyArrow.animation.addByPrefix('confirm', pPre[i] + ' confirm', 24, false);
				default:
					if (player == 0){
						babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets' + arrowextraDad);
					}
					else if (player == 1){
						babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets' + arrowextra);
					}
					babyArrow.animation.addByPrefix('green', 'arrowUP');
					babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
					babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
					babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

					babyArrow.antialiasing = _variables.antialiasing;
					babyArrow.setGraphicSize(Std.int(babyArrow.width * Note.noteScale));

					var nSuf:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
					var pPre:Array<String> = ['left', 'down', 'up', 'right'];
					if (Main.switchside)
					{
						switch (mania)
						{
							case 0:
								nSuf = ['RIGHT', 'UP', 'DOWN', 'LEFT'];
								pPre = ['right', 'up', 'down', 'left'];
							case 1:
								nSuf = ['RIGHT', 'DOWN', 'LEFT', 'RIGHT', 'UP', 'LEFT'];
								pPre = ['dark', 'down', 'yel', 'right', 'up', 'left'];
							case 2:
								nSuf = ['RIGHT', 'UP', 'DOWN', 'LEFT', 'SPACE', 'RIGHT', 'UP', 'DOWN', 'LEFT'];
								pPre = ['dark', 'black', 'violet', 'yel', 'white', 'right', 'up', 'down', 'left'];
								babyArrow.x -= Note.tooMuch;
						}
					}
					else
					{
						switch (mania)
						{
							case 0:
								nSuf = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
								pPre = ['left', 'down', 'up', 'right'];
							case 1:
								nSuf = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
								pPre = ['left', 'up', 'right', 'yel', 'down', 'dark'];
							case 2:
								nSuf = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'SPACE', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
								pPre = ['left', 'down', 'up', 'right', 'white', 'yel', 'violet', 'black', 'dark'];
								babyArrow.x -= Note.tooMuch;
						}
					}
					babyArrow.x += Note.swagWidth * i;
					babyArrow.animation.addByPrefix('static', 'arrow' + nSuf[i]);
					babyArrow.animation.addByPrefix('pressed', pPre[i] + ' press', 24, false);
					babyArrow.animation.addByPrefix('confirm', pPre[i] + ' confirm', 24, false);
			}

			//switch shit
			if (Main.switchside)
			{
				babyArrow.flipX = true;

				if (_variables.scroll == "right")
					babyArrow.flipX = true;

				if (_modifiers.FlippedNotes)
				{
					babyArrow.flipX = !babyArrow.flipX;
					babyArrow.flipY = !babyArrow.flipY;
				}
			}

			if (_variables.scroll == "down")
				babyArrow.flipY = true;

			if (_variables.scroll == "right")
				babyArrow.flipX = true;

			if (_modifiers.FlippedNotes)
			{
				babyArrow.flipX = !babyArrow.flipX;
				babyArrow.flipY = !babyArrow.flipY;
			}

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			babyArrow.ID = i;
			babyArrow.cameras = [camNOTEHUD];

			switch (player)
			{
				case 0:
				{
					cpuStrums.add(babyArrow);
				}
				case 1:
				{			
					playerStrums.add(babyArrow);
				}
			}

			hudArrXPos.push(babyArrow.x);
			hudArrYPos.push(babyArrow.y);

			if (_variables.scroll == "left")
				babyArrow.angle += 90;
			else if (_variables.scroll == "right")
				babyArrow.angle += 90;

			babyArrow.animation.play('static');
			if (mania == 0)
			{
				babyArrow.x += 90;
			}
			else if (mania == 1)
			{
				babyArrow.x += 50;				
			}
			else if (mania == 2)
			{
				babyArrow.x += 50;
			}
		
			if (_variables.scroll != 'left' && _variables.scroll != 'right')
				babyArrow.x += ((FlxG.width / 2) * player);
			else
				babyArrow.x += FlxG.width / 4 + 50;

			strumLineNotes.add(babyArrow);		
		}
	}

	function tweenCamIn():Void
	{
		FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom + 0.3}, (Conductor.stepCrochet / 1000 * 4), {ease: FlxEase.quadInOut});
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			if (!startTimer.finished)
				startTimer.active = false;
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (!startTimer.finished)
				startTimer.active = true;
			paused = false;

			#if desktop
			if (startTimer.finished)
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC, true, songLength - Conductor.songPosition);
			}
			else
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC);
			}
			#end
		}

		super.closeSubState();
	}

	override public function onFocus():Void
		{
			#if desktop
			if (health > -0.1 && !paused)
			{
				if (Conductor.songPosition > 0.0)
				{
					DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC, true, songLength - Conductor.songPosition);
				}
				else
				{
					DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC);
				}
			}
			#end
	
			super.onFocus();
		}
	
	override public function onFocusLost():Void
		{
			#if desktop
			if (health > -0.00001 && !paused)
			{
				DiscordClient.changePresence(detailsPausedText, SONG.song + " (" + storyDifficultyText + ")", iconRPC);
			}
			#end
	
			super.onFocusLost();
		}

	function resyncVocals():Void
	{
		vocals.pause();

			FlxG.sound.music.play();
			Conductor.songPosition = FlxG.sound.music.time;
			if (_modifiers.OffbeatSwitch)
			{
				vocals.time = Conductor.songPosition + (512 * _modifiers.Offbeat / 100);
			}
			else
				vocals.time = Conductor.songPosition;

			vocals.play();
	}

	private var paused:Bool = false;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;

	function truncateFloat( number : Float, precision : Int): Float {
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round( num ) / Math.pow(10, precision);
		return num;
		}

		var spookyText:FlxText;
		var spookyRendered:Bool = false;
		var spookySteps:Int = 0;

		override public function update(elapsed:Float)
			{	
				switch (storyDifficulty)
				{
					case 0:
						Main.exMode = false;
						Main.god = false;
					case 1:
						Main.exMode = false;
						Main.god = false;
					case 2:
						Main.exMode = false;
						Main.god = false;
					case 3:
						Main.exMode = true;
						Main.god = false;
					case 4:
						Main.exMode = false;
						Main.god = true;
				}

				if (_variables.botplay)
				{
					cheated = true;
				}

				botPlay.visible = _variables.botplay;

				if (stuneffect)
				{				
					FlxG.cameras.shake(20/2000, 0.2);
					if (SONG.notestyle == 'pixel')
					{
						FlxG.sound.play(Paths.sound('stunsoundeffect-pixel'),_variables.svolume/50);
					}
					else
					{
						FlxG.sound.play(Paths.sound('stunsoundeffect'),_variables.svolume/50);
					}		
				}

				#if !debug
				perfectMode = false;
				#end

				if (useVideo && BackgroundVideo.get() != null && !stopUpdate)
				{
					if (BackgroundVideo.get().ended && !removedVideo)
					{
						remove(videoSprite);
						FlxG.stage.window.onFocusOut.remove(focusOut);
						FlxG.stage.window.onFocusIn.remove(focusIn);
						removedVideo = true;
						useVideo = false;
					}
				}
		
				if (startedCountdown)
				{
					if (_modifiers.EarthquakeSwitch)
						FlxG.cameras.shake(_modifiers.Earthquake / 2000, 0.2);
		
					if (_modifiers.LoveSwitch)
						health += _modifiers.Love / 600000;
		
					if (_modifiers.FrightSwitch)
						health -= _modifiers.Fright / 700000;
		
					if (_modifiers.PaparazziSwitch && paparazziInt == 0)
					{
						paparazziInt = 1;
						new FlxTimer().start(FlxG.random.float(2 / _modifiers.Paparazzi, 6 / _modifiers.Paparazzi), function(tmr:FlxTimer)
						{
							camHUD.flash(0xFFFFFFFF, FlxG.random.float(0.1, 0.3), null, true);
							FlxG.sound.play(Paths.sound('paparazzi'), FlxG.random.float(0.1, 0.3) * _variables.svolume / 100);
							paparazziInt = 0;
						});
					}
		
					if (_modifiers.SeasickSwitch)
					{
						FlxG.camera.angle += Math.sin(Conductor.songPosition * Conductor.bpm / 100 / 500) * (0.008 * _modifiers.Seasick);
						camHB.angle += Math.cos(Conductor.songPosition * Conductor.bpm / 100 / 500) * (0.008 * _modifiers.Seasick);
						camHUD.angle += Math.cos(Conductor.songPosition * Conductor.bpm / 100 / 500) * (0.008 * _modifiers.Seasick);
						camNOTES.angle += Math.cos(Conductor.songPosition * Conductor.bpm / 100 / 500) * (0.008 * _modifiers.Seasick);
						camSus.angle += Math.cos(Conductor.songPosition * Conductor.bpm / 100 / 500) * (0.008 * _modifiers.Seasick);
						camNOTEHUD.angle += Math.cos(Conductor.songPosition * Conductor.bpm / 100 / 500) * (0.008 * _modifiers.Seasick);
					}
		
					if (_modifiers.CameraSwitch)
					{
						FlxG.camera.angle += 0.01 * _modifiers.Camera;
						camHB.angle -= 0.01 * _modifiers.Camera;
						camHUD.angle -= 0.01 * _modifiers.Camera;
						camNOTES.angle -= 0.01 * _modifiers.Camera;
						camSus.angle -= 0.01 * _modifiers.Camera;
						camNOTEHUD.angle -= 0.01 * _modifiers.Camera;
					}
				}
		
				cameraX = camFollow.x;
				cameraY = camFollow.y;

				switch (curStage) {
					case 'ITB':
						for (i in 0...itbLights.members.length) {
							if (lightsTimer[i] == 0) {
								lightsTimer[i] = -1;
								FlxTween.tween(itbLights.members[i], {alpha: 1}, (Conductor.stepCrochet * 16 / 1000), {ease: FlxEase.quadOut, 
									onComplete: function(tween:FlxTween)
									{
										FlxTween.tween(itbLights.members[i], {alpha: 0}, (Conductor.stepCrochet * 16 / 1000), {ease: FlxEase.quadIn, 
											onComplete: function(tween:FlxTween)
											{
												var daRando = new FlxRandom();
												lightsTimer[i] = daRando.int(1000, 1500);
											}, 
										});
									}, 
								});
							} else
								lightsTimer[i]--;
						}
				}

				if (FlxG.keys.pressed.SHIFT && FlxG.keys.justPressed.ONE)
				{
					_variables.botplay = !_variables.botplay;
					botPlay.visible = _variables.botplay;
					if (!_variables.botplay)
					{
						camNOTEHUD.visible = true;
						camNOTES.visible = true;
						camHUD.visible = true;
						camHB.visible = true;
					}

					if (_variables.botplay && Main.camhiddeninbotplay)
					{
						trace ('botplay is enabled and cam was hiden before');
						camNOTEHUD.visible = false;
						camNOTES.visible = false;
						camHUD.visible = false;
						camHB.visible = false;
					}

					MainVariables.Save();
				}

				if (_variables.botplay && !FlxG.keys.pressed.SHIFT && FlxG.keys.justPressed.ONE)
				{
					camNOTEHUD.visible = !camNOTEHUD.visible;
					camNOTES.visible = !camNOTES.visible;
					camHUD.visible = !camHUD.visible;
					camHB.visible = !camHB.visible;
					Main.camhiddeninbotplay = !Main.camhiddeninbotplay;
				}

				if (FlxG.keys.pressed.SHIFT && FlxG.keys.justPressed.TWO)
				{
					_variables.cpustrums = !_variables.cpustrums;
					MainVariables.Save();
				}
		
				if (currentFrames == _variables.fps && _variables.nps)
					{
						for (i in 0...notesHitArray.length)
						{
							var cock:Date = notesHitArray[i];
							if (cock != null)
								if (cock.getTime() + 2000 < Date.now().getTime())
									notesHitArray.remove(cock);
						}
						nps = Math.floor(notesHitArray.length / 2);
						currentFrames = 0;
					}
					else if (currentFrames != _variables.fps)
						currentFrames++;
					else if (!_variables.nps)
						nps = 0; // shut up
		
				switch (curStage)
				{
					case 'philly' | 'phillyneo' | 'phillysalty':
						if (trainMoving)
						{
							trainFrameTiming += elapsed;
		
							if (trainFrameTiming >= 1 / 24)
							{
								updateTrainPos();
								trainFrameTiming = 0;
							}
						}
						// phillyCityLights.members[curLight].alpha -= (Conductor.crochet / 1000) * FlxG.elapsed;
					case 'tank':
						moveTank();
					case 'tankstress':
						moveTank();
					case 'shaggysky':
						var rotRate = curStep * 0.25;
						var rotRateSh = curStep / 9.5;
						var rotRateGf = curStep / 9.5 / 4;
						var derp = 12;
						if (!startedCountdown)
						{
							camFollow.x = boyfriend.x - 300;
							camFollow.y = boyfriend.y - 40;
							derp = 20;
						}

						if (godCutEnd)
						{
							if (curBeat < 32)
							{
								sh_r = 60;
							}
							else if ((curBeat >= 132 * 4) || (curBeat >= 42 * 4 && curBeat <= 50 * 4))
							{
								sh_r += (60 - sh_r) / 32;
							}
							else
							{
								sh_r = 600;
							}

							if ((curBeat >= 32 && curBeat < 48) || (curBeat >= 116 * 4 && curBeat < 132 * 4))
							{
								if (boyfriend.animation.curAnim.name.startsWith('idle'))
								{
									boyfriend.playAnim('scared', true);
								}
							}

							if (curBeat < 50*4)
							{
							}
							else if (curBeat < 66 * 4)
							{
								rotRateSh *= 1.2;
							}
							else if (curBeat < 116 * 4)
							{
							}
							else if (curBeat < 132 * 4)
							{
								rotRateSh *= 1.2;
							}
							var bf_toy = -2000 + Math.sin(rotRate) * 20;

							var sh_toy = -2450 + -Math.sin(rotRateSh * 2) * sh_r * 0.45;
							var sh_tox = -330 -Math.cos(rotRateSh) * sh_r;

							var gf_tox = 100 + Math.sin(rotRateGf) * 200;
							var gf_toy = -2000 -Math.sin(rotRateGf) * 80;

							if (godMoveBf)
							{
								boyfriend.y += (bf_toy - boyfriend.y) / derp;
								rock.x = boyfriend.x - 200;
								rock.y = boyfriend.y + 200;
								rock.alpha = 1;
							}

							if (godMoveSh)
							{
								dad.x += (sh_tox - dad.x) / 12;
								dad.y += (sh_toy - dad.y) / 12;
							}

							if (godMoveGf)
							{
								gf.x += (gf_tox - gf.x) / derp;
								gf.y += (gf_toy - gf.y) / derp;

								gf_rock.x = gf.x + 80;
								gf_rock.y = gf.y + 530;
								gf_rock.alpha = 1;
								if (!gf_launched)
								{
									gf.scrollFactor.set(0.8, 0.8);
									gf.setGraphicSize(Std.int(gf.width * 0.8));
									gf_launched = true;
								}
							}
						}
						if (!godCutEnd || !godMoveBf)
						{
							rock.alpha = 0;
						}
						if (!godMoveGf)
						{
							gf_rock.alpha = 0;
						}
				}
		
				if (fadeouthud)
				{
					new FlxTimer().start(0, function(tmr:FlxTimer)
					{
						camHB.alpha -= 1 / 10;
						camHUD.alpha -= 1 / 10;
						camNOTES.alpha -= 1 / 10;
						camSus.alpha -= 1 / 10;
						camNOTEHUD.alpha -= 1 / 10;
						camNOTEHUD.angle = 0;
					});
				}

				super.update(elapsed);

				scoreTxt.text = "Score: " + songScore;
				missTxt.text = "Misses: " + misses;
				accuracyTxt.text = "Accuracy: " + truncateFloat(accuracy, 2) + "%";
				npsTxt.text = "NPS: " + nps;

				if (misses == 0 && combo != 0)
				{
					comboTxt.text = "Full Combo: " + combo;
				}
				else
				{
					comboTxt.text = "Combo: " + combo;
				}
		
				var pauseBtt:Bool = FlxG.keys.justPressed.ENTER #if android || FlxG.android.justReleased.BACK #end;

				if (pauseBtt && startedCountdown && canPause)
				{
					persistentUpdate = false;
					persistentDraw = true;
					paused = true;
		
					// 1 / 1000 chance for Gitaroo Man easter egg
					if (FlxG.random.bool(0.1))
					{
						// gitaroo man easter egg
						FlxG.switchState(new GitarooPause());
					}
					else
					{
						openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
					}
					
					#if desktop
					DiscordClient.changePresence(detailsPausedText, SONG.song + " (" + storyDifficultyText + ")", iconRPC);
					#end
				}
		
				if (FlxG.keys.justPressed.SEVEN)
				{
					if (useVideo)
					{
						BackgroundVideo.get().stop();
						remove(videoSprite);
						#if sys
						FlxG.stage.window.onFocusOut.remove(focusOut);
						FlxG.stage.window.onFocusIn.remove(focusIn);
						#end
						removedVideo = true;
					}
					canDie = false;
					FlxG.switchState(new ChartingState());
		
					#if desktop
					DiscordClient.changePresence("Charting a song", null, null, true);
					#end
				}
		
				// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
				// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);
		
				//icon stuff
				iconP1.setGraphicSize(Std.int(FlxMath.lerp(iconP1.width, 150, zoomLerp/(_variables.fps/60))));				
				iconP2.setGraphicSize(Std.int(FlxMath.lerp(iconP2.width, 150, zoomLerp/(_variables.fps/60))));

				if(!Main.switchside && SONG.exDad || Main.switchside && SONG.exBF)
				{
					iconP3.setGraphicSize(Std.int(FlxMath.lerp(iconP3.width, 150, zoomLerp/(_variables.fps/60))));
					iconP3.updateHitbox();
				}

				if(!Main.switchside && SONG.exBF || Main.switchside && SONG.exDad)
				{
					iconP4.setGraphicSize(Std.int(FlxMath.lerp(iconP4.width, 150, zoomLerp/(_variables.fps/60))));
					iconP4.updateHitbox();
				}
		
				iconP1.updateHitbox();
				iconP2.updateHitbox();
		
				var iconOffset:Int = 26;

				if (!Main.switchside && SONG.exBF || Main.switchside && SONG.exDad)
				{
					iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
					iconP4.x = healthBar.x + 50 + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
				}
				else
				{
					iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
				}
		
				

				if (!Main.switchside && SONG.exDad || Main.switchside && SONG.exBF)
				{
					iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);
					iconP3.x = healthBar.x - 50 + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP3.width - iconOffset);
				}
				else
				{
					iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);
				}
		
				if (health > 2)
					health = 2;
		
				if (healthBar.percent < 20)
				{
					iconP1.animation.curAnim.curFrame = 1;
					if (!Main.switchside && SONG.exBF || Main.switchside && SONG.exDad)
					{
						iconP4.animation.curAnim.curFrame = 1;
					}
				}
				else if (healthBar.percent > 80)
				{
					iconP1.animation.curAnim.curFrame = 2;
					if (!Main.switchside && SONG.exBF || Main.switchside && SONG.exDad)
					{
						iconP4.animation.curAnim.curFrame = 2;
					}
				} 
				else
				{
					iconP1.animation.curAnim.curFrame = 0;
					if (!Main.switchside && SONG.exBF || Main.switchside && SONG.exDad)
					{
						iconP4.animation.curAnim.curFrame = 0;
					}
				}
		
				if (healthBar.percent > 80)
				{
					iconP2.animation.curAnim.curFrame = 1;
					if (!Main.switchside && SONG.exDad || Main.switchside && SONG.exBF)
					{
						iconP3.animation.curAnim.curFrame = 1;
					}
				}
				else if (healthBar.percent < 20)
				{
					iconP2.animation.curAnim.curFrame = 2;
					if (!Main.switchside && SONG.exDad || Main.switchside && SONG.exBF)
					{
						iconP3.animation.curAnim.curFrame = 2;
					}
				}
				else
				{
					iconP2.animation.curAnim.curFrame = 0;
					if (!Main.switchside && SONG.exDad || Main.switchside && SONG.exBF)
					{
						iconP3.animation.curAnim.curFrame = 0;
					}
				}
		
				/* if (FlxG.keys.justPressed.NINE)
					FlxG.switchState(new Charting()); */
		
				if (FlxG.keys.justPressed.EIGHT)
				{
					if (useVideo)
					{
						BackgroundVideo.get().stop();
						remove(videoSprite);
						FlxG.stage.window.onFocusOut.remove(focusOut);
						FlxG.stage.window.onFocusIn.remove(focusIn);
						removedVideo = true;
					}

					FlxG.switchState(new AnimationDebug(SONG.player2));
				}
		
				if (startingSong)
				{
					if (startedCountdown)
					{
						Conductor.songPosition += FlxG.elapsed * 1000;
						if (Conductor.songPosition >= 0)
							startSong();
					}
				}
				else
				{
					// Conductor.songPosition = FlxG.sound.music.time;
					Conductor.songPosition += FlxG.elapsed * 1000;
					songPositionBar = Conductor.songPosition;
		
					if (!paused)
					{
						songTime += FlxG.game.ticks - previousFrameTime;
						previousFrameTime = FlxG.game.ticks;
		
						// Interpolation type beat
						if (Conductor.lastSongPos != Conductor.songPosition)
						{
							songTime = (songTime + Conductor.songPosition) / 2;
							Conductor.lastSongPos = Conductor.songPosition;
							// Conductor.songPosition += FlxG.elapsed * 1000;
							// trace('MISSED FRAME');
						}
					}
		
					// Conductor.lastSongPos = FlxG.sound.music.time;
				}
		
				if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null)
					{
						// Make sure Girlfriend cheers only for certain songs
						if(allowedToHeadbang)
						{
							// Don't animate GF if something else is already animating her (eg. train passing)
							if(gf.animation.curAnim.name == 'danceLeft' || gf.animation.curAnim.name == 'danceRight' || gf.animation.curAnim.name == 'idle')
							{
								// Per song treatment since some songs will only have the 'Hey' at certain times
								switch(curSong)
								{
									case 'Philly':
									{
										// General duration of the song
										if(curBeat < 250)
										{
											// Beats to skip or to stop GF from cheering
											if(curBeat != 184 && curBeat != 216)
											{
												if(curBeat % 16 == 8)
												{
													// Just a garantee that it'll trigger just once
													if(!triggeredAlready)
													{
														gf.playAnim('cheer');
														triggeredAlready = true;
													}
												}else triggeredAlready = false;
											}
										}
									}
									case 'Bopeebo':
									{
										// Where it starts || where it ends
										if(curBeat > 5 && curBeat < 130)
										{
											if(curBeat % 8 == 7)
											{
												if(!triggeredAlready)
												{
													gf.playAnim('cheer');
													triggeredAlready = true;
												}
											}else triggeredAlready = false;
										}
									}
									case 'Blammed':
									{
										if(curBeat > 30 && curBeat < 190)
										{
											if(curBeat < 90 || curBeat > 128)
											{
												if(curBeat % 4 == 2)
												{
													if(!triggeredAlready)
													{
														gf.playAnim('cheer');
														triggeredAlready = true;
													}
												}else triggeredAlready = false;
											}
										}
									}
									case 'Cocoa':
									{
										if(curBeat < 170)
										{
											if(curBeat < 65 || curBeat > 130 && curBeat < 145)
											{
												if(curBeat % 16 == 15)
												{
													if(!triggeredAlready)
													{
														gf.playAnim('cheer');
														triggeredAlready = true;
													}
												}else triggeredAlready = false;
											}
										}
									}
									case 'Eggnog':
									{
										if(curBeat > 10 && curBeat != 111 && curBeat < 220)
										{
											if(curBeat % 8 == 7)
											{
												if(!triggeredAlready)
												{
													gf.playAnim('cheer');
													triggeredAlready = true;
												}
											}else triggeredAlready = false;
										}
									}
								}
							}
						}
					}
		
				if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null)
				{
					if (curBeat % 4 == 0)
					{
						// trace(PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection);
					}
		
						var dadmidpoint:FlxPoint = dad.getMidpoint();
						if (camFollow.x != dadmidpoint.x + 150 && !PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
							{
								if (curStage == 'nightbobandbosip') {
									for (i in coolGlowyLights) {
										i.flipX = false;
									}
									for (i in coolGlowyLightsMirror) {
										i.flipX = true;
									}	
								}

								camFollow.setPosition(dadmidpoint.x + 150, dadmidpoint.y - 100);
								// camFollow.setPosition(lucky.getMidpoint().x - 120, lucky.getMidpoint().y + 210);
				
								switch (dad.curCharacter)
								{
									case 'mom' | 'momb' | 'momb3' | 'momneo':
										camFollow.y = dadmidpoint.y;
									case 'senpai' | 'senpai-angry' | 'senpaib' | 'senpaib-angry' | 'senpaib3' | 'senpaib3-angry':
										camFollow.y = dadmidpoint.y - 430;
										camFollow.x = dadmidpoint.x - 100;
									case 'trickyH':
										camFollow.y = dadmidpoint.y - 800;
										camFollow.x = dadmidpoint.x - 600;
								}
								switch (curStage)
								{
									case 'curse':
										camFollow.y = dadmidpoint.y;
										camFollow.x = dadmidpoint.x + 530;
										FlxTween.tween(FlxG.camera, {zoom: 0.6}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
									case 'genocide':
										camFollow.y = dadmidpoint.y - 100;
										camFollow.x = dadmidpoint.x + 260;
										FlxTween.tween(FlxG.camera, {zoom: 0.8}, (Conductor.stepCrochet * 4 / 2000), {ease: FlxEase.elasticInOut});
									case 'diebobandbosip' | 'sunshitbobandbosip':
										camFollow.x = FlxMath.lerp(536.63, camFollow.x, 0.1);
										camFollow.y = FlxMath.lerp(449.94, camFollow.y, 0.1);
									case 'daybobandbosip':
										/*camFollow.x = 56.63 + dadCamOffset.x;
										camFollow.y = 449.94 + dadCamOffset.y;*/
										camFollow.x = FlxMath.lerp(536.63, camFollow.x, 0.1);
										camFollow.y = FlxMath.lerp(449.94, camFollow.y, 0.1);
									case 'sunsetbobandbosip':
										if (Main.exMode) {
											camFollow.x = FlxMath.lerp(536.63, camFollow.x, 0.1);
											camFollow.y = FlxMath.lerp(350.94, camFollow.y, 0.1);
										} else {
											camFollow.x = FlxMath.lerp(536.63, camFollow.x, 0.1);
											camFollow.y = FlxMath.lerp(300.94, camFollow.y, 0.1);
										}
									case 'nightbobandbosip':
										if (splitCamMode) {
											camFollow.x = 600.92;
											camFollow.y = 447.52;
										} else {
											camFollow.x = FlxMath.lerp(295.92, camFollow.x, 0.1);
											camFollow.y = FlxMath.lerp(447.52, camFollow.y, 0.1);
										}
									case 'ITB':
										camFollow.x = FlxMath.lerp(272.46, camFollow.x, 0.1);
										camFollow.y = FlxMath.lerp(420.96, camFollow.y, 0.1);
								}
				
								if (dad.curCharacter == 'mom')
									vocals.volume = _variables.vvolume/100;
				
								if (SONG.song.toLowerCase() == 'tutorial')
								{
									tweenCamIn();
								}
							}
							dadmidpoint.put();
			
						var bfmidpoint:FlxPoint = boyfriend.getMidpoint();
						if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && camFollow.x != bfmidpoint.x - 100)
							{
								if (curStage == 'nightbobandbosip') {
									for (i in coolGlowyLights) {
										i.flipX = true;
									}
									for (i in coolGlowyLightsMirror) {
										i.flipX = false;
									}
								}

								camFollow.setPosition(bfmidpoint.x - 100, bfmidpoint.y - 100);
								
								if (SONG.player1 == 'bf-pixel' || SONG.player1 == 'bfb-pixel' || SONG.player1 == 'bfb3-pixel' || SONG.player1 == 'salty-pixel')
								{
									camFollow.x = bfmidpoint.x - 200;
									camFollow.y = bfmidpoint.y - 200;
								}

								switch (curStage)
								{
									case 'curse':
										camFollow.setPosition(bfmidpoint.x - 530, bfmidpoint.y - 250);
										FlxTween.tween(FlxG.camera, {zoom: 0.55}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
									case 'genocide':
										camFollow.setPosition(bfmidpoint.x - 530, bfmidpoint.y - 250);
										FlxTween.tween(FlxG.camera, {zoom: 0.65}, (Conductor.stepCrochet * 4 / 2000), {ease: FlxEase.elasticInOut});
									case 'limo' | 'limob' | 'limob3' | 'limoneo' | 'limosalty':
										camFollow.x = bfmidpoint.x - 300;
									case 'mall' | 'mallb' | 'mallb3' | 'mallsalty':
										camFollow.y = bfmidpoint.y - 200;
									case 'daybobandbosip':	
										camFollow.x = FlxMath.lerp(788.96, camFollow.x, 0.1);
										if (SONG.player1 == 'worriedbob')
											camFollow.y = FlxMath.lerp(430.95, camFollow.y, 0.1);
										else
											camFollow.y = FlxMath.lerp(475.95, camFollow.y, 0.1);
									case 'diebobandbosip' | 'sunshitbobandbosip':
										camFollow.x = FlxMath.lerp(788.96, camFollow.x, 0.1);
										camFollow.y = FlxMath.lerp(475.95, camFollow.y, 0.1);
									case 'sunsetbobandbosip':
										camFollow.x = FlxMath.lerp(788.96, camFollow.x, 0.1);
										camFollow.y = FlxMath.lerp(475.95, camFollow.y, 0.1);
									case 'nightbobandbosip':
										if (splitCamMode) {
											camFollow.x = 600.92;
											camFollow.y = 447.52;
										} else {
											camFollow.x = FlxMath.lerp(790.36, camFollow.x, 0.1);
											camFollow.y = FlxMath.lerp(480.91, camFollow.y, 0.1);
										}
									case 'ITB':
										camFollow.x = FlxMath.lerp(626.31, camFollow.x, 0.1);
										camFollow.y = FlxMath.lerp(420.96, camFollow.y, 0.1);
								}
			
							if (SONG.song.toLowerCase() == 'tutorial')
							{
								FlxTween.tween(FlxG.camera, {zoom: 1}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.quadInOut});
							}
						}	
						bfmidpoint.put();
				}
				if (Main.exMode && SONG.song.toLowerCase() == 'split')
					camZooming = true;
				if (camZooming)
				{
					FlxG.camera.zoom = FlxMath.lerp(FlxG.camera.zoom, defaultCamZoom, zoomLerp / (_variables.fps / 60));
					camHUD.zoom = FlxMath.lerp(camHUD.zoom, 1, zoomLerp / (_variables.fps / 60));
					camHB.zoom = FlxMath.lerp(camHB.zoom, 1, zoomLerp / (_variables.fps / 60));
					camNOTES.zoom = FlxMath.lerp(camNOTES.zoom, 1, zoomLerp / (_variables.fps / 60));
					camSus.zoom = FlxMath.lerp(camSus.zoom, 1, zoomLerp / (_variables.fps / 60));
					camNOTEHUD.zoom = FlxMath.lerp(camNOTEHUD.zoom, 1, zoomLerp / (_variables.fps / 60));
				}
		
				FlxG.watch.addQuick("beatShit", curBeat);
				FlxG.watch.addQuick("stepShit", curStep);


			if (curStep == 60 && SONG.song == 'Ugh' && dad.curCharacter == 'tankman')
				{
					dad.playAnim('ugh', true);
				}
			if (curStep == 444 && SONG.song == 'Ugh' && dad.curCharacter == 'tankman')
			{
				dad.playAnim('ugh', true);
			}
			if (curStep == 525 && SONG.song == 'Ugh' && dad.curCharacter == 'tankman')
			{
				dad.playAnim('ugh', true);
			}
			if (curStep == 828 && SONG.song == 'Ugh' && dad.curCharacter == 'tankman')
			{
				dad.playAnim('ugh', true);
			}
			if (curStep == 736 && SONG.song == 'Stress' && dad.curCharacter == 'tankman')
			{
				dad.playAnim('good', true);
			}
			if (curStep == 567 && SONG.song == 'Glitcher' && curStage == 'basketballglitcher')
			{
				remove(dad);
				remove(boyfriend);
				dad = new Character(250, 250, 'hexViruswire');
				boyfriend = new Boyfriend(770, 450, 'bfwire');
				wire.visible = true;
				add(dad);
				add(boyfriend);
				
			}
			if (curSong.toLowerCase() == 'where-are-you')
				{
					switch (curBeat)
					{
						case 12:
							burst = new FlxSprite(-1110, 0);
						case 245:
							if (burst.y == 0)
							{
								FlxG.sound.play(Paths.sound('burst'));
								remove(burst);
								burst = new FlxSprite(dad.getMidpoint().x - 1000, dad.getMidpoint().y - 100);
								burst.frames = Paths.getSparrowAtlas('characters/shaggy');
								burst.animation.addByPrefix('burst', "burst", 30);
								burst.animation.play('burst');
								//burst.setGraphicSize(Std.int(burst.width * 1.5));
								burst.antialiasing = _variables.antialiasing;
								add(burst);
							}
		
							/*
							var bgLimo:FlxSprite = new FlxSprite(-200, 480);
							bgLimo.frames = Paths.getSparrowAtlas('limo/bgLimo');
							bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
							bgLimo.animation.play('drive');
							bgLimo.scrollFactor.set(0.4, 0.4);
							add(bgLimo);
							*/
							// FlxG.sound.music.stop();
							// FlxG.switchState(new TitleState());
						case 246:
							remove(burst);
					}
				}
			if (curSong.toLowerCase() == 'kaio-ken')
			{
				if (curBeat == 48 || curBeat == 144 || curBeat == 56 * 4 || curBeat == 84 * 4 || curBeat == 104 * 4)
				{
					remove(shaggyT);
					shaggyT = new FlxTrail(dad, null, 4, 1, 0.3, 0.005);
					add(shaggyT);
					shaggyT.delay = Std.int(Math.round(1 / (FlxG.elapsed / (1/60))));
				}
				else if (curBeat == 80 || curBeat == 192 || curBeat == 60 * 4 || curBeat == 96 * 4 || curBeat == 108 * 4)
				{
					remove(shaggyT);
				}
			}
			if (dad.curCharacter == 'garcellodead' && SONG.song.toLowerCase() == 'release')
				{
					if (curStep == 838)
					{
						dad.playAnim('garTightBars', true);
					}
				}
		
				if (dad.curCharacter == 'garcelloghosty' && SONG.song.toLowerCase() == 'fading')
				{
					if (curStep == 247)
					{
						dad.playAnim('garFarewell', true);
					}
				}
		
				if (dad.curCharacter == 'garcelloghosty' && SONG.song.toLowerCase() == 'fading')
				{
					if (curStep == 240)
					{
						new FlxTimer().start(0.1, function(tmr:FlxTimer)
						{
							dad.alpha -= 0.05;
							if (Main.switchside){
								iconP1.alpha -= 0.05;
							}
							else{
								iconP2.alpha -= 0.05;
							}			
		
							if (dad.alpha > 0)
							{
								tmr.reset(0.1);
							}
						});
					}
				}
				if (SONG.song.toLowerCase() == 'tutorial-bnb' && Main.exMode)
				{
					switch (curStep)
					{
						case 359:
						if (_variables.songPosition)
						{
							FlxTween.num(songPosBar.max, songLength - 1000, 1.3, {ease: FlxEase.cubeOut}, function (v:Float) {
								remove(songPosBar);
								songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
								'songPositionBar', 0, v);
								songPosBar.numDivisions = 1000;
								songPosBar.scrollFactor.set();
								songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
								songPosBar.cameras = [camHUD];
								add(songPosBar);
							});
						}
						dad.playAnim('spin', true);
						trace ('do a flip');
						case 368:
							songSpeedMultiplier += 0.4;
						case 384:
							camZooming = true;
							defaultCamZoom += 0.02;
						//	dadCamOffset.x = 60;
						//	dadCamOffset.y = -40;
						case 768:
							defaultCamZoom -= 0.02;
						//	dadCamOffset.x = 0;
						//	dadCamOffset.y = 0;
						case 777:
							dad.playAnim('alright', true);
					}
					
				}

				if (curStage.toLowerCase() == 'daybobandbosip' && SONG.song.toLowerCase() == 'jump-in' && Main.exMode)
				{
					switch (curStep)
					{
						case 7:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('daybobandbosip/PP_truck'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 69:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('daybobandbosip/PP_truck'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = -2000;
								daTrain.flipX = true;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: 2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 243:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('daybobandbosip/PP_truck'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 389:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('daybobandbosip/PP_truck'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 582:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('daybobandbosip/PP_truck'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = -2000;
								daTrain.flipX = true;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: 2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 650:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('daybobandbosip/PP_truck'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = -2000;
								daTrain.flipX = true;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: 2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 713:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('daybobandbosip/PP_truck'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 778:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('daybobandbosip/PP_truck'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = -2000;
								daTrain.flipX = true;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: 2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 827:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('daybobandbosip/PP_truck'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 843:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('daybobandbosip/PP_truck'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = -2000;
								daTrain.flipX = true;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: 2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 900:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('daybobandbosip/PP_truck'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
					}
				}

				if (curStage.toLowerCase() == 'sunsetbobandbosip' && SONG.song.toLowerCase() == 'swing' && Main.exMode)
				{
					switch (curStep)
					{
						case 42:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 248:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = -2000;
								daTrain.flipX = true;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: 2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 300:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 309:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = -2000;
								daTrain.flipX = true;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: 2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 448:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 521:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = -2000;
								daTrain.flipX = true;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: 2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 596:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 702:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = -2000;
								daTrain.flipX = true;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: 2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 822:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 869:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = -2000;
								daTrain.flipX = true;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: 2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 950:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 1082:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = -2000;
								daTrain.flipX = true;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: 2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 1146:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = -2000;
								daTrain.flipX = true;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: 2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});
						case 1219:
							var daTrain;
							daTrain = new FlxSprite(200, 200).loadGraphic(Paths.image('sunsetbobandbosip/CJ_car'));
							daTrain.scale.set(1.2, 1.2);
							daTrain.visible = false;
							add(daTrain);
							FlxG.sound.play(Paths.sound('carPass1'), 0.7);
							new FlxTimer().start(1.3, function(tmr:FlxTimer)
							{
								daTrain.x = 2000;
								daTrain.flipX = false;
								daTrain.visible = true;
								FlxTween.tween(daTrain, {x: -2000}, 0.18, {
									onComplete: function(twn:FlxTween) {
										remove(daTrain);
									}
								});
							});		
					}
				}

				if (SONG.song.toLowerCase() == 'split' && Main.exMode)
				{
					switch (curStep)
					{
						case 256:
							areYouReady.members[0].visible = true;
							nightbobandbosipLights.forEach(function(light:FlxSprite)
							{
								light.visible = false;
							});
							nightbobandbosipLights.members[0].visible = true;
							nightbobandbosipLights.members[0].alpha = 1;
							FlxTween.tween(nightbobandbosipLights.members[0], {alpha: 0}, 0.2, {
							});
						case 260:
							areYouReady.members[1].visible = true;
							nightbobandbosipLights.forEach(function(light:FlxSprite)
							{
								light.visible = false;
							});
							nightbobandbosipLights.members[0].visible = true;
							nightbobandbosipLights.members[0].alpha = 1;
							FlxTween.tween(nightbobandbosipLights.members[0], {alpha: 0}, 0.2, {
							});
						case 264:
							areYouReady.members[2].visible = true;
							nightbobandbosipLights.forEach(function(light:FlxSprite)
							{
								light.visible = false;
							});
							nightbobandbosipLights.members[0].visible = true;
							nightbobandbosipLights.members[0].alpha = 1;
							FlxTween.tween(nightbobandbosipLights.members[0], {alpha: 0}, 0.2, {});
						case 272:
							for (i in areYouReady) {
								i.visible = false;
							}
							splitSoftMode = !splitSoftMode;
						case 336 | 340 | 400 | 404 | 464 | 468:
							splitMode = !splitMode;
						case 528:
							FlxG.camera.zoom += 0.0030;
							camHB.zoom += 0.004;
							camHUD.zoom += 0.004;
							camNOTEHUD.zoom += 0.004;
							camNOTEHUD.zoom += 0.004;
							camSus.zoom += 0.004;
							splitSoftMode = !splitSoftMode;
						case 531 | 534 | 544 | 547 | 550 | 560 | 563 | 566 | 576 | 579 | 582 | 592 | 596 | 600 | 604 | 608 | 612 | 616 | 620 | 624 | 626 | 628 | 630 | 632 | 634 | 636 | 638:
							FlxG.camera.zoom += 0.0030;
							camHB.zoom += 0.004;
							camHUD.zoom += 0.004;
							camNOTEHUD.zoom += 0.004;
							camNOTEHUD.zoom += 0.004;
							camSus.zoom += 0.004;
						case 640:
							nightbobandbosipLights.forEach(function(light:FlxSprite)
							{
								light.visible = false;
							});
							nightbobandbosipLights.members[1].visible = true;
							nightbobandbosipLights.members[1].alpha = 1;
							FlxTween.tween(nightbobandbosipLights.members[1], {alpha: 0}, 0.2, {});
						case 656:
							splitMode = !splitMode;
						case 784 | 1040:
							camHUD.flash(FlxColor.WHITE, 0.7);
						case 1168:
							splitMode = !splitMode;
						case 1190 | 1194 | 1198 | 1222 | 1226 | 1230 | 1254 | 1258 | 1262:
							FlxG.camera.zoom += 0.0030;
							camHB.zoom += 0.04;
							camHUD.zoom += 0.04;
							camNOTEHUD.zoom += 0.04;
							camNOTEHUD.zoom += 0.04;
							camSus.zoom += 0.04;
							nightbobandbosipLights.forEach(function(light:FlxSprite)
							{
								light.visible = false;
							});
							nightbobandbosipLights.members[1].visible = true;
							nightbobandbosipLights.members[1].alpha = 1;
							FlxTween.tween(nightbobandbosipLights.members[1], {alpha: 0}, 0.2, {});
							splitSoftMode = !splitSoftMode;
						case 1192 | 1196 | 1200 | 1224 | 1228 | 1232 | 1256 | 1260 | 1264:
							splitSoftMode = !splitSoftMode;
						case 1288 | 1291 | 1294:
							FlxG.camera.zoom += 0.0030;
							camHB.zoom += 0.004;
							camHUD.zoom += 0.004;
							camNOTEHUD.zoom += 0.004;
							camNOTEHUD.zoom += 0.004;
							camSus.zoom += 0.004;
						case 1296:
							splitSoftMode = !splitSoftMode;
						case 1360 | 1364:
							splitMode = !splitMode;
						case 1424:
							splitCamMode = !splitCamMode;
						case 1551:
							splitExtraZoom = !splitExtraZoom;
							splitMode = !splitMode;
							splitSoftMode = !splitSoftMode;
						case 1556 | 1616 | 1620:
							splitExtraZoom = !splitExtraZoom;
						case 1680:
							splitCamMode = !splitCamMode;
							splitMode = !splitMode;
							splitSoftMode = !splitSoftMode;
						case 1728 | 1732 | 1736 | 1744 | 1748 | 1752 | 1755 | 1760 | 1764 | 1768 | 1772 | 1776 | 1778 | 1780 | 1782 | 1784 | 1785 | 1786 | 1787 | 1788 | 1789 | 1790 | 1791:
							FlxG.camera.zoom += 0.0030;
							camHB.zoom += 0.004;
							camHUD.zoom += 0.004;
							camNOTEHUD.zoom += 0.004;
							camNOTEHUD.zoom += 0.004;
							camSus.zoom += 0.004;
						case 1792:
							areYouReady.members[0].visible = true;
							nightbobandbosipLights.forEach(function(light:FlxSprite)
							{
								light.visible = false;
							});
							nightbobandbosipLights.members[0].visible = true;
							nightbobandbosipLights.members[0].alpha = 1;
							FlxTween.tween(nightbobandbosipLights.members[0], {alpha: 0}, 0.2, {
							});
							for (spr in areYouReady) {
								spr.color = FlxColor.RED;
							}
							coolerText = !coolerText;
						case 1796:
							areYouReady.members[1].visible = true;
							nightbobandbosipLights.forEach(function(light:FlxSprite)
							{
								light.visible = false;
							});
							nightbobandbosipLights.members[0].visible = true;
							nightbobandbosipLights.members[0].alpha = 1;
							FlxTween.tween(nightbobandbosipLights.members[0], {alpha: 0}, 0.2, {
							});
						case 1800:
							areYouReady.members[2].visible = true;
							nightbobandbosipLights.forEach(function(light:FlxSprite)
							{
								light.visible = false;
							});
							nightbobandbosipLights.members[0].visible = true;
							nightbobandbosipLights.members[0].alpha = 1;
							FlxTween.tween(nightbobandbosipLights.members[0], {alpha: 0}, 0.2, {});
						case 1808:
							for (i in areYouReady) {
								i.visible = false;
							}
							splitMode = !splitMode;
						case 1872 | 2000:
							camHUD.flash(FlxColor.WHITE, 0.7);
						case 2064:
							splitMode = !splitMode;
							dad.playAnim('drop', true);			
					}
				}

				if (SONG.song.toLowerCase() == 'jump-out')
				{
					switch (curStep)
					{
						case 78:
						for (i in SAD) {
							i.alpha = 0;
							if (SAD.members.indexOf(i) == SADorder) {
								i.alpha = 1;
							}
						}
						SADorder++;
						if (SADorder > 3)
							SADorder = 0;

						case 392:
						for (i in SAD) {
							i.alpha = 0;
							if (SAD.members.indexOf(i) == SADorder) {
								i.alpha = 1;
							}
						}
						SADorder++;
						if (SADorder > 3)
							SADorder = 0;

						case 396:
						for (i in SAD) {
							i.alpha = 0;
							if (SAD.members.indexOf(i) == SADorder) {
								i.alpha = 1;
							}
						}
						SADorder++;
						if (SADorder > 3)
							SADorder = 0;

						case 398:
						for (i in SAD) {
							i.alpha = 0;
							if (SAD.members.indexOf(i) == SADorder) {
								i.alpha = 1;
							}
						}
						SADorder++;
						if (SADorder > 3)
							SADorder = 0;

						case 406:
						for (i in SAD) {
							i.alpha = 0;
							if (SAD.members.indexOf(i) == SADorder) {
								i.alpha = 1;
							}
						}
						SADorder++;
						if (SADorder > 3)
							SADorder = 0;

						case 411:
						for (i in SAD) {
							i.alpha = 0;
							if (SAD.members.indexOf(i) == SADorder) {
								i.alpha = 1;
							}
						}
						SADorder++;
						if (SADorder > 3)
							SADorder = 0;

						case 562:
						changeBoyfriendCharacter('bfanders');																	

						case 592:
						changeBoyfriendCharacter('bf');	
						
						case 622:
						for (i in SAD) {
							i.alpha = 0;
							if (SAD.members.indexOf(i) == SADorder) {
								i.alpha = 1;
							}
						}
						SADorder++;
						if (SADorder > 3)
							SADorder = 0;

						case 845:
						bgbob.visible = true;
						groundbob.visible = true;

						gf.visible = false;
						defaultCamZoom = 0.9;
					//	backgroundVideo("assets/videos/TV static noise HD 1080p.webm");

						case 856:					
						if (useVideo)
						{
							BackgroundVideo.get().stop();
							FlxG.stage.window.onFocusOut.remove(focusOut);
							FlxG.stage.window.onFocusIn.remove(focusIn);
							PlayState.instance.remove(PlayState.instance.videoSprite);
							useVideo = false;
							trace ('dont crash pls');
						}
						
						case 920:
						changeDadCharacter('verb');
					}
				}

				//hardcoding

				if (curSong == 'Fresh')
				{
					switch (curBeat)
					{
						case 16:
							camZooming = true;
							gfSpeed = 2;
						case 48:
							gfSpeed = 1;
						case 80:
							gfSpeed = 2;
						case 112:
							gfSpeed = 1;
						case 163:
							// FlxG.sound.music.stop();
							// FlxG.switchState(new TitleState());
					}
				}
		
				if (curSong == 'Bopeebo')
				{
					switch (curBeat)
					{
						case 128, 129, 130:
							vocals.volume = 0;
							// FlxG.sound.music.stop();
							// FlxG.switchState(new PlayState());
					}
				}

				if (curSong.toLowerCase() == 'power-link')
				{
					switch (curBeat)
					{
						case 400:
							burst = new FlxSprite(-1110, 0);
						case 448:
							if (burst.y == 0)
							{
								FlxG.sound.play(Paths.sound('burst'));
								remove(burst);
								burst = new FlxSprite(boyfriend.getMidpoint().x - 600, boyfriend.getMidpoint().y - 300);
								burst.frames = Paths.getSparrowAtlas('shaggyred');
								burst.animation.addByPrefix('burst', "burst", 30);
								burst.animation.play('burst');
								//burst.setGraphicSize(Std.int(burst.width * 1.5));
								burst.antialiasing = true;
								add(burst);
							}
		
							/*
							var bgLimo:FlxSprite = new FlxSprite(-200, 480);
							bgLimo.frames = Paths.getSparrowAtlas('limo/bgLimo');
							bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
							bgLimo.animation.play('drive');
							bgLimo.scrollFactor.set(0.4, 0.4);
							add(bgLimo);
							*/
							// FlxG.sound.music.stop();
							// FlxG.switchState(new TitleState());
						case 450:
							remove(burst);
					}
				}
				// better streaming of shit
		
				// RESET = Quick Game Over Screen
				if (controls.RESET)
				{
					canDie = true;
					health = -10;
					trace("RESET = True");
				}
		
				if (controls.CHEAT)
				{
					health += 1;
					trace("User is cheating!");
				}
		
				if (health <= -0.00001 && canDie && !_modifiers.Practice && !ended)
				{
					lives -= 1;
		
					if (_modifiers.FreezeSwitch)
					{
						missCounter = 0;
						if (frozen)
							{
								FlxG.sound.play(Paths.sound('Ice_Shatter'), _variables.svolume/100);
								frozen = false;
								freezeIndicator.alpha = 0;
							}
					}
		
					if (lives <= 0)
					{
						boyfriend.stunned = true;
		
						persistentUpdate = false;
						persistentDraw = false;
						paused = true;
						canDie = false;
			
						vocals.stop();
						FlxG.sound.music.stop();
			
						if (Main.god)
						{
							FlxG.sound.play(Paths.sound('fnf_loss_sfx' + GameOverSubstate.stageSuffix ),_variables.svolume/100);
							FlxG.switchState(new PlayState());
						}
						else
						{
							openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
						}

						if (gameplayArea == "Endless" && !cheated)
							Highscore.saveEndlessScore(SONG.song.toLowerCase(), songScore);

						speed = 0;
						loops = 0;

						camHUD.angle = 0;
						camNOTES.angle = 0;
						camSus.angle = 0;
						camNOTEHUD.angle = 0;
						FlxG.camera.angle = 0;
		
					//	FlxG.game.scaleX = 1;
					//	FlxG.game.x = 0;
					//	FlxG.game.scaleY = 1;
					//	FlxG.game.y = 0;
			
						// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			
						#if desktop
						// Game Over doesn't get his own variable because it's only used here
						DiscordClient.changePresence("Aw man, I died at " + detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC);
						#end
					}
					else
					{
						if (lives > 0)
						{
							FlxG.camera.flash(0xFFFF0000, 0.3 * SONG.bpm/100);
							new FlxTimer().start(5 / 60, function(tmr:FlxTimer)
								{
									gf.playAnim('sad', true);
								});
							FlxG.sound.play(Paths.sound('missnote2'), _variables.svolume/100);
							health = 1/_modifiers.Lives * lives;
						}
					}
				}
		
				if (unspawnNotes[0] != null)
				{
					if (unspawnNotes[0].strumTime - Conductor.songPosition < 1500)
					{
						var dunceNote:Note = unspawnNotes[0];
						notes.add(dunceNote);
		
						var index:Int = unspawnNotes.indexOf(dunceNote);
						unspawnNotes.splice(index, 1);
					}
				}
		
				if (generatedMusic)
				{
					if (SAD != null) {
						for (i in SAD) {
							i.alpha = FlxMath.lerp(i.alpha, 0, 0.02);
							if (i.alpha < 0.1)
								i.alpha = 0;
						}
					}
					if (coolerText) {
						for (spr in areYouReady) {
							spr.color = FlxColor.fromHSL(spr.color.hue + 2, spr.color.saturation, 1, 1);
							if (spr.color.hue > 358)
								spr.color = FlxColor.fromHSL(0, spr.color.saturation, 1, 1);
						}
					}
					if (healthDraining && SONG.song.toLowerCase() == 'yap-squad') {
						health = FlxMath.lerp(health, healthDrainTarget, 0.2);
					}
					if (healthDrainTimer == 0) {
						healthDrainTimer = -1;
						healthDraining = false;
					} else {
						healthDrainTimer--;
					}

					notes.forEachAlive(function(daNote:Note)
					{
						var mn:Int = keyAmmo[mania]; //new var to determine max notes

						var arrowStrum = strumLineNotes.members[daNote.noteData % mn].y;
						daNote.scrollFactor.set();
						daNote.cameras = [camNOTES];

						if (daNote.y > camNOTES.height)
						{
							daNote.active = false;
							daNote.visible = false;
						}
						else
						{
							if (_modifiers.InvisibleNotes)
								daNote.visible = false;
							else
								daNote.visible = true;
		
							daNote.active = true;
						}
		
						if (_modifiers.NoteSpeedSwitch)
							speedNote = 1 + 1 * (_modifiers.NoteSpeed / 100);
		
						if (_modifiers.DrunkNotesSwitch)
							noteDrunk = _modifiers.DrunkNotes * 3;
		
						if (_modifiers.AccelNotesSwitch)
							noteAccel += _modifiers.AccelNotes * 0.0001;
		
						if (realSpeed < 1 || Math.isNaN(realSpeed))
						{
							realSpeed = SONG.speed;
						}
		
						if (!_modifiers.DrunkNotesSwitch || !_modifiers.AccelNotesSwitch || !_modifiers.NoteSpeedSwitch)
						{
							daNote.y = (arrowStrum - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(realSpeed, 2)));
						}
						else
						{
							daNote.y = ((arrowStrum
								- (Conductor.songPosition
									- daNote.strumTime
									+ noteAccel
									+ (_modifiers.DrunkNotes * Math.sin(Conductor.songPosition / 300)))) * (0.45 * FlxMath.roundDecimal(realSpeed, 2) * speedNote));
						}
		
						if (_modifiers.SnakeNotesSwitch && !daNote.isSustainNote)
							daNote.x += (_modifiers.SnakeNotes * 0.025) * Math.sin(Conductor.songPosition / 300);
		
						if ((_modifiers.ShortsightedSwitch
							&& daNote.y > FlxG.height - (FlxG.height - arrowStrum) * (_modifiers.Shortsighted / 100) - 11 * _modifiers.AccelNotes))
							daNote.alpha = 0;
						else if ((_modifiers.ShortsightedSwitch
							&& daNote.y <= FlxG.height - (FlxG.height - arrowStrum) * (_modifiers.Shortsighted / 100) - 11 * _modifiers.AccelNotes))
							daNote.alpha = FlxMath.lerp(daNote.alpha, 1, miscLerp / (_variables.fps / 60));
		
						if ((_modifiers.LongsightedSwitch
							&& daNote.y > arrowStrum + (FlxG.height - arrowStrum) * (_modifiers.Longsighted / 100) - 11 * _modifiers.AccelNotes))
							daNote.alpha = 1;
						else if ((_modifiers.LongsightedSwitch
							&& daNote.y <= arrowStrum + (FlxG.height - arrowStrum) * (_modifiers.Longsighted / 100) - 11 * _modifiers.AccelNotes))
							daNote.alpha = FlxMath.lerp(daNote.alpha, 0, miscLerp / (_variables.fps / 60));
		
						if (_modifiers.HyperNotesSwitch)
						{
							daNote.x += 0.25 * FlxG.random.int(Std.int(_modifiers.HyperNotes * -1), Std.int(_modifiers.HyperNotes));
							daNote.y += 0.25 * FlxG.random.int(Std.int(_modifiers.HyperNotes * -1), Std.int(_modifiers.HyperNotes));
						}
		
						// i am so fucking sorry for this if condition
						if (daNote.isSustainNote
							&& daNote.y + daNote.offset.y <= arrowStrum + Note.swagWidth / 2
							&& (!daNote.mustPress || (daNote.wasGoodHit || (daNote.prevNote.wasGoodHit && !daNote.canBeHit))))
						{
							var swagRect = new FlxRect(0, arrowStrum + Note.swagWidth / 2 - daNote.y, daNote.width * 2, daNote.height * 2);
							swagRect.y /= daNote.scale.y;
							swagRect.height -= swagRect.y;
		
							daNote.clipRect = swagRect;
						}
		
						if (_modifiers.FlippedNotes && !daNote.isSustainNote)
							{
								daNote.flipX = true;
								daNote.flipY = true;
							}
		
				//player 1 or dadcpu shit			
						if (!daNote.mustPress && daNote.wasGoodHit)
						{
							var sDir:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
							if (Main.switchside)
							{
								if (mania == 0)
								{
									sDir = ['RIGHT', 'UP', 'DOWN', 'LEFT'];
								}
								else if (mania == 1)
								{
									sDir = ['RIGHT', 'DOWN', 'LEFT', 'RIGHT', 'UP', 'LEFT'];
								}
								else if (mania == 2)
								{
									sDir = ['RIGHT', 'UP', 'DOWN', 'LEFT', 'UP', 'RIGHT', 'UP', 'DOWN', 'LEFT'];
								}
							}
							else
							{
								if (mania == 0)
								{
									sDir = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
								}
								else if (mania == 1)
								{
									sDir = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
								}
								else if (mania == 2)
								{
									sDir = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'UP', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
								}
							}

							if (SONG.song != 'Tutorial')
								camZooming = true;
		
							var altAnim:String = "";
							dad.altAnim = "";

							if(SONG.exDad)
							{
								dad2.altAnim = "";
							}
							
							var shaggysing:String = '';
							switch (SONG.player2)
							{
								case 'shaggy':
								{
									if (dad.powerup)
									{
									//	trace ('added "_s" to sing shit');
										shaggysing = '_s';
									}
								}
							}

							if (SONG.exDad)
							{
								switch (SONG.player2)
								{
									case 'shaggy':
									{
										if (dad2.powerup)
										{
										//	trace ('added "_s" to sing shit');
											shaggysing = '_s';
										}
									}
								}
							}
		
							if (SONG.notes[Math.floor(curStep / 16)] != null)
							{
								if (SONG.notes[Math.floor(curStep / 16)].altAnim)
								{
									altAnim = '-alt';

									if (SONG.song == 'Sky')
									{
										dad.altAnim = '-alt';
									}
								}
							}

							if (!Main.switchside)
							{
								if (SONG.exDad)
								{
									if (daNote.dType == 0)
									{ 
										dad2.playAnim('sing' + sDir[daNote.noteData] + shaggysing + altAnim, true);
										if (SONG.exDad) dad2.holdTimer = 0;
									}
									else if (daNote.dType == 1) 
									{
										dad.playAnim('sing' + sDir[daNote.noteData] + shaggysing + altAnim, true);
										dad.holdTimer = 0;
									}
									else if (daNote.dType == 2)
									{
										dad.playAnim('sing' + sDir[daNote.noteData] + shaggysing + altAnim, true);
										dad2.playAnim('sing' + sDir[daNote.noteData] + shaggysing + altAnim, true);
										dad.holdTimer = 0;
										if (SONG.exDad) dad2.holdTimer = 0;
									}			
								}
								else
								{
									dad.playAnim('sing' + sDir[daNote.noteData] + shaggysing + altAnim, true);
									if (curStage == 'nightbobandbosip') {
										pc.playAnim('sing' + sDir[daNote.noteData], true);
									}
									dad.holdTimer = 0;
									if (SONG.exDad) dad2.holdTimer = 0;
								}
							}
							else
							{
								if (SONG.exBF)
								{
									if (daNote.bType == 0)
									{
										boyfriend2.playAnim('sing' + sDir[daNote.noteData], true); 
										if (SONG.exBF) boyfriend2.holdTimer = 0;
									}
									else if (daNote.bType == 1) 
									{
										boyfriend.playAnim('sing' + sDir[daNote.noteData], true);
										boyfriend.holdTimer = 0;
									}
									else if (daNote.bType == 2)
									{
										boyfriend.playAnim('sing' + sDir[daNote.noteData], true);
										boyfriend2.playAnim('sing' + sDir[daNote.noteData], true);
										boyfriend.holdTimer = 0;
										if (SONG.exBF) boyfriend2.holdTimer = 0;
									}			
								}
								else
								{
									boyfriend.playAnim('sing' + sDir[daNote.noteData], true);
									boyfriend.holdTimer = 0;
									if (SONG.exBF) boyfriend2.holdTimer = 0;
								}
							}				
		
							if (!Main.switchside)
							{
								switch(dad.curCharacter)
									{
									case 'trickyMask': // 1% chance
										if (FlxG.random.bool(1) && !spookyRendered && !daNote.isSustainNote) // create spooky text :flushed:
											{
											
												createSpookyText(TrickyLinesSing[FlxG.random.int(0,TrickyLinesSing.length)]);
											
											}
									case 'tricky': // 20% chance
										if (FlxG.random.bool(20) && !spookyRendered && !daNote.isSustainNote) // create spooky text :flushed:
											{
											
												createSpookyText(TrickyLinesSing[FlxG.random.int(0,TrickyLinesSing.length)]);
											
											}
									case 'trickyH': // 45% chance
										if (FlxG.random.bool(45) && !spookyRendered && !daNote.isSustainNote) // create spooky text :flushed:
											{
											
												createSpookyText(TrickyLinesSing[FlxG.random.int(0,TrickyLinesSing.length)]);
										
											}
										FlxG.camera.shake(0.02,0.2);
									case 'exTricky': // 60% chance
										if (FlxG.random.bool(60) && !spookyRendered && !daNote.isSustainNote) // create spooky text :flushed:
											{
											
												createSpookyText(ExTrickyLinesSing[FlxG.random.int(0,ExTrickyLinesSing.length)]);
												
											}
									}
							}
		
								if (_variables.cpustrums)
								{
									cpuStrums.forEach(function(spr:FlxSkewedSprite)
									{
										if (Math.abs(daNote.noteData) == spr.ID)
										{
											spr.animation.play('confirm', true);
										}
										if (spr.animation.curAnim.name == 'confirm' && SONG.notestyle != 'pixel')
										{
											spr.centerOffsets();
											spr.offset.x -= 13;
											spr.offset.y -= 13;
										}
										else
											spr.centerOffsets();
									});
								}	

							if (SONG.needsVoices)
							{
								if (!ended)
									{
									vocals.volume = _variables.vvolume/100;
									}
									else
									{
									vocals.volume = 0;
									}
							}
		
							daNote.kill();
							notes.remove(daNote, true);
							daNote.destroy();
							
							if (_modifiers.MustDieSwitch)
								health -= _modifiers.MustDie / 7000;
						}
		
						// WIP interpolation shit? Need to fix the pause issue
						// daNote.y = (strumLine.y - (songTime - daNote.strumTime) * (0.45 * PlayState.SONG.speed));
		
						//miss shit ugh haha funny tankman no chicken joke :|
						if (daNote.y < (arrowStrum - 75) - 25 * (SONG.speed) - 70 * _modifiers.NoteSpeed - 1.5 * _modifiers.DrunkNotes - 11 * _modifiers.AccelNotes
							- 128 * Math.abs(_modifiers.Offbeat / 100))
						{
							if (daNote.isSustainNote && daNote.wasGoodHit)
							{
								daNote.kill();
								notes.remove(daNote, true);
								daNote.destroy();
							}
							else
							{
								if (startedCountdown && daNote.mustPress)
								{
									switch (daNote.noteType)
									{
										case 0:
										{
											interupt = true;
											if (_modifiers.HPLossSwitch)
												health -= 0.0475 * _modifiers.HPLoss;
											else
												health -= 0.0475;
					
											if (_modifiers.Perfect) // if perfect
												health = -10;

											if (Main.switchside)
											{
												if (mania == 0)
												{
												switch (daNote.noteData)
												{
													case 0:
														dad.playAnim('singRIGHTmiss', true);
													case 1:
														dad.playAnim('singUPmiss', true);
													case 2:
														dad.playAnim('singDOWNmiss', true);
													case 3:
														dad.playAnim('singLEFTmiss', true);
												}
												}
												else if (mania == 1)
												{
												switch (daNote.noteData)
												{
													case 0:
														dad.playAnim('singRIGHTmiss', true);
													case 1:
														dad.playAnim('singDOWNmiss', true);
													case 2:
														dad.playAnim('singLEFTmiss', true);
													case 3:
														dad.playAnim('singRIGHTmiss', true);
													case 4:
														dad.playAnim('singUPmiss', true);
													case 5:
														dad.playAnim('singLEFTmiss', true);
												}										
												}
												else if (mania == 2)
												{
												switch (daNote.noteData)
												{
													case 0:
														dad.playAnim('singRIGHTmiss', true);
													case 1:
														dad.playAnim('singUPmiss', true);
													case 2:
														dad.playAnim('singDOWNmiss', true);
													case 3:
														dad.playAnim('singLEFTmiss', true);
													case 4:
														dad.playAnim('singUPmiss', true);
													case 5:
														dad.playAnim('singRIGHTmiss', true);
													case 6:
														dad.playAnim('singUPmiss', true);
													case 7:
														dad.playAnim('singDOWNmiss', true);
													case 8:
														dad.playAnim('singLEFTmiss', true);
												}
												}
											}
											else
											{
												if (mania == 0)
												{
												switch (daNote.noteData)
												{
													case 0:
														boyfriend.playAnim('singLEFTmiss', true);
													case 1:
														boyfriend.playAnim('singDOWNmiss', true);
													case 2:
														boyfriend.playAnim('singUPmiss', true);
													case 3:
														boyfriend.playAnim('singRIGHTmiss', true);
												}
												}
												else if (mania == 1)
												{
												switch (daNote.noteData)
												{
													case 0:
														boyfriend.playAnim('singLEFTmiss', true);
													case 1:
														boyfriend.playAnim('singUPmiss', true);
													case 2:
														boyfriend.playAnim('singRIGHTmiss', true);
													case 3:
														boyfriend.playAnim('singLEFTmiss', true);
													case 4:
														boyfriend.playAnim('singDOWNmiss', true);
													case 5:
														boyfriend.playAnim('singRIGHTmiss', true);
												}										
												}
												else if (mania == 2)
												{
												switch (daNote.noteData)
												{
													case 0:
														boyfriend.playAnim('singLEFTmiss', true);
													case 1:
														boyfriend.playAnim('singDOWNmiss', true);
													case 2:
														boyfriend.playAnim('singUPmiss', true);
													case 3:
														boyfriend.playAnim('singRIGHTmiss', true);
													case 4:
														boyfriend.playAnim('singUPmiss', true);
													case 5:
														boyfriend.playAnim('singLEFTmiss', true);
													case 6:
														boyfriend.playAnim('singDOWNmiss', true);
													case 7:
														boyfriend.playAnim('singUPmiss', true);
													case 8:
														boyfriend.playAnim('singRIGHTmiss', true);
												}
												}
											}
											
											if (_variables.muteMiss)
												vocals.volume = 0;
											
											songScore -= Math.floor(10 + (_variables.comboP ? 0.3*combo : 0) * MenuModifiers.fakeMP);
				
											if ((daNote.isSustainNote && !daNote.wasGoodHit) || !daNote.isSustainNote)
												{
													updateAccuracy();
													misses ++;
													combo = 0;
												}
				
											if (!frozen && _modifiers.FreezeSwitch)
											{
												missCounter++;
												freezeIndicator.alpha = missCounter / (31 - _modifiers.Freeze);
											}
				
											if (_modifiers.FreezeSwitch && missCounter >= 31 - _modifiers.Freeze)
												freezeBF();

											trace ('basic ass note fuck you');
										}
										case 1:
										{
											trace ('chill its fire note');
										}
										case 2:
										{
											trace ('chill its halo note');
										}
										case 3:
										{
											interupt = true;
											health = -10;

											if (Main.switchside)
												{
													if (mania == 0)
													{
													switch (daNote.noteData)
													{
														case 0:
															dad.playAnim('singRIGHTmiss', true);
														case 1:
															dad.playAnim('singUPmiss', true);
														case 2:
															dad.playAnim('singDOWNmiss', true);
														case 3:
															dad.playAnim('singLEFTmiss', true);
													}
													}
													else if (mania == 1)
													{
													switch (daNote.noteData)
													{
														case 0:
															dad.playAnim('singRIGHTmiss', true);
														case 1:
															dad.playAnim('singDOWNmiss', true);
														case 2:
															dad.playAnim('singLEFTmiss', true);
														case 3:
															dad.playAnim('singRIGHTmiss', true);
														case 4:
															dad.playAnim('singUPmiss', true);
														case 5:
															dad.playAnim('singLEFTmiss', true);
													}										
													}
													else if (mania == 2)
													{
													switch (daNote.noteData)
													{
														case 0:
															dad.playAnim('singRIGHTmiss', true);
														case 1:
															dad.playAnim('singUPmiss', true);
														case 2:
															dad.playAnim('singDOWNmiss', true);
														case 3:
															dad.playAnim('singLEFTmiss', true);
														case 4:
															dad.playAnim('singUPmiss', true);
														case 5:
															dad.playAnim('singRIGHTmiss', true);
														case 6:
															dad.playAnim('singUPmiss', true);
														case 7:
															dad.playAnim('singDOWNmiss', true);
														case 8:
															dad.playAnim('singLEFTmiss', true);
													}
													}
												}
												else
												{
													if (mania == 0)
													{
													switch (daNote.noteData)
													{
														case 0:
															boyfriend.playAnim('singLEFTmiss', true);
														case 1:
															boyfriend.playAnim('singDOWNmiss', true);
														case 2:
															boyfriend.playAnim('singUPmiss', true);
														case 3:
															boyfriend.playAnim('singRIGHTmiss', true);
													}
													}
													else if (mania == 1)
													{
													switch (daNote.noteData)
													{
														case 0:
															boyfriend.playAnim('singLEFTmiss', true);
														case 1:
															boyfriend.playAnim('singUPmiss', true);
														case 2:
															boyfriend.playAnim('singRIGHTmiss', true);
														case 3:
															boyfriend.playAnim('singLEFTmiss', true);
														case 4:
															boyfriend.playAnim('singDOWNmiss', true);
														case 5:
															boyfriend.playAnim('singRIGHTmiss', true);
													}										
													}
													else if (mania == 2)
													{
													switch (daNote.noteData)
													{
														case 0:
															boyfriend.playAnim('singLEFTmiss', true);
														case 1:
															boyfriend.playAnim('singDOWNmiss', true);
														case 2:
															boyfriend.playAnim('singUPmiss', true);
														case 3:
															boyfriend.playAnim('singRIGHTmiss', true);
														case 4:
															boyfriend.playAnim('singUPmiss', true);
														case 5:
															boyfriend.playAnim('singLEFTmiss', true);
														case 6:
															boyfriend.playAnim('singDOWNmiss', true);
														case 7:
															boyfriend.playAnim('singUPmiss', true);
														case 8:
															boyfriend.playAnim('singRIGHTmiss', true);
													}
													}
												}

											if (_variables.muteMiss)
												vocals.volume = 0;
											
											songScore -= Math.floor(10 + (_variables.comboP ? 0.3*combo : 0) * MenuModifiers.fakeMP);
				
											if ((daNote.isSustainNote && !daNote.wasGoodHit) || !daNote.isSustainNote)
												{
													updateAccuracy();
													misses ++;
													combo = 0;
												}
				
											if (!frozen && _modifiers.FreezeSwitch)
											{
												missCounter++;
												freezeIndicator.alpha = missCounter / (31 - _modifiers.Freeze);
											}
				
											if (_modifiers.FreezeSwitch && missCounter >= 31 - _modifiers.Freeze)
												freezeBF();

											if (SONG.notestyle == 'pixel')
											{
												FlxG.sound.play(Paths.sound('knockoutDeathsound-pixel'),_variables.svolume/100);
											}
											else
											{
												FlxG.sound.play(Paths.sound('knockoutDeathsound'),_variables.svolume/100);
											}			

											trace ('your supposed to hit hd note');
										}
										case 4:
										{
											stuneffect = true;

											new FlxTimer().start(1, function(tmr:FlxTimer)
											{
												stuneffect = false;
												trace ('stop stun plz');
											});

											trace ('your supposed to hit stun note');
										}
										case 5:
										{
											trace ('chill its bad poison note');
										}
										case 6:
										{
											HealthDrain();

											if (Main.switchside)
												{
													if (mania == 0)
													{
													switch (daNote.noteData)
													{
														case 0:
															dad.playAnim('singRIGHTmiss', true);
														case 1:
															dad.playAnim('singUPmiss', true);
														case 2:
															dad.playAnim('singDOWNmiss', true);
														case 3:
															dad.playAnim('singLEFTmiss', true);
													}
													}
													else if (mania == 1)
													{
													switch (daNote.noteData)
													{
														case 0:
															dad.playAnim('singRIGHTmiss', true);
														case 1:
															dad.playAnim('singDOWNmiss', true);
														case 2:
															dad.playAnim('singLEFTmiss', true);
														case 3:
															dad.playAnim('singRIGHTmiss', true);
														case 4:
															dad.playAnim('singUPmiss', true);
														case 5:
															dad.playAnim('singLEFTmiss', true);
													}										
													}
													else if (mania == 2)
													{
													switch (daNote.noteData)
													{
														case 0:
															dad.playAnim('singRIGHTmiss', true);
														case 1:
															dad.playAnim('singUPmiss', true);
														case 2:
															dad.playAnim('singDOWNmiss', true);
														case 3:
															dad.playAnim('singLEFTmiss', true);
														case 4:
															dad.playAnim('singUPmiss', true);
														case 5:
															dad.playAnim('singRIGHTmiss', true);
														case 6:
															dad.playAnim('singUPmiss', true);
														case 7:
															dad.playAnim('singDOWNmiss', true);
														case 8:
															dad.playAnim('singLEFTmiss', true);
													}
													}
												}
											else
											{
												if (mania == 0)
												{
												switch (daNote.noteData)
												{
													case 0:
														boyfriend.playAnim('singLEFTmiss', true);
													case 1:
														boyfriend.playAnim('singDOWNmiss', true);
													case 2:
														boyfriend.playAnim('singUPmiss', true);
													case 3:
														boyfriend.playAnim('singRIGHTmiss', true);
												}
												}
												else if (mania == 1)
												{
												switch (daNote.noteData)
												{
													case 0:
														boyfriend.playAnim('singLEFTmiss', true);
													case 1:
														boyfriend.playAnim('singUPmiss', true);
													case 2:
														boyfriend.playAnim('singRIGHTmiss', true);
													case 3:
														boyfriend.playAnim('singLEFTmiss', true);
													case 4:
														boyfriend.playAnim('singDOWNmiss', true);
													case 5:
														boyfriend.playAnim('singRIGHTmiss', true);
												}										
												}
												else if (mania == 2)
												{
												switch (daNote.noteData)
												{
													case 0:
														boyfriend.playAnim('singLEFTmiss', true);
													case 1:
														boyfriend.playAnim('singDOWNmiss', true);
													case 2:
														boyfriend.playAnim('singUPmiss', true);
													case 3:
														boyfriend.playAnim('singRIGHTmiss', true);
													case 4:
														boyfriend.playAnim('singUPmiss', true);
													case 5:
														boyfriend.playAnim('singLEFTmiss', true);
													case 6:
														boyfriend.playAnim('singDOWNmiss', true);
													case 7:
														boyfriend.playAnim('singUPmiss', true);
													case 8:
														boyfriend.playAnim('singRIGHTmiss', true);
												}
												}
											}

												if (_variables.muteMiss)
													vocals.volume = 0;
												
												songScore -= Math.floor(10 + (_variables.comboP ? 0.3*combo : 0) * MenuModifiers.fakeMP);
					
												if ((daNote.isSustainNote && !daNote.wasGoodHit) || !daNote.isSustainNote)
													{
														updateAccuracy();
														misses ++;
														combo = 0;
													}

												if (SONG.notestyle == 'pixel')
												{
													FlxG.sound.play(Paths.sound('BoomCloud-pixel'),_variables.svolume/100);
												}
												else
												{
												FlxG.sound.play(Paths.sound('BoomCloud'),_variables.svolume/100);
												}

											trace ('your supposed to hit this good poison note');
										}
									}
								}
							}
		
							daNote.active = false;
							daNote.visible = false;
		
							daNote.kill();
							notes.remove(daNote, true);
							daNote.destroy();
						}
					});
				}

				if (!Main.switchside && dad.holdTimer > Conductor.stepCrochet * dad.dadVar * 0.001)
				{
					if (dad.animation.curAnim.name.startsWith('sing') && !dad.animation.curAnim.name.endsWith('miss'))
						{
							if (!frozen)
							{
								dad.dance();
							}
						}
				}
	
				if (SONG.exDad && !Main.switchside && dad2.holdTimer > Conductor.stepCrochet * dad2.dadVar * 0.001)
				{
					if (dad2.animation.curAnim.name.startsWith('sing') && !dad2.animation.curAnim.name.endsWith('miss'))
						{
							if (!frozen)
							{
								dad2.dance();
							}
						}
				}
	
				if (Main.switchside && boyfriend.holdTimer > Conductor.stepCrochet * boyfriend.dadVar * 0.001)
				{
					if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss' ))
						{
							if (!frozen)
							{
								boyfriend.dance();
								if (_modifiers.FrightSwitch)
								{
									if (_modifiers.Fright >= 50 && _modifiers.Fright < 100)
										boyfriend.playAnim('scared');
									else if (_modifiers.Fright >= 100)
										boyfriend.playAnim('worried');
								}
							}
							else
								boyfriend.playAnim('frozen');
						}
				}
	
				if (SONG.exBF && Main.switchside && boyfriend2.holdTimer > Conductor.stepCrochet * boyfriend2.dadVar * 0.001)
				{
					if (boyfriend2.animation.curAnim.name.startsWith('sing') && !boyfriend2.animation.curAnim.name.endsWith('miss'))
						{
							if (!frozen)
							{
								boyfriend2.dance();
							}
						}
				}
		
				hearts.forEach(function(heart:FlxSprite)
					{
						if (heart.ID > (lives - 1))
						{
							heart.angle = FlxMath.lerp(heart.angle, 30, miscLerp / (_variables.fps / 60));

							if (_variables.scroll == "up")
								heart.y = FlxMath.lerp(heart.y, FlxG.height + heart.height + 100, miscLerp / (_variables.fps / 60));
							else
								heart.y = FlxMath.lerp(heart.y, 0 - heart.height - 100, miscLerp / (_variables.fps / 60));

							if ((heart.y >= FlxG.height + heart.height && (_variables.scroll == "up"))
								|| (heart.y <= 0 - heart.height && (_variables.scroll == "down")))
								heart.kill();
						}
					});
		
					cpuStrums.forEach(function(spr:FlxSkewedSprite)
					{
						if (spr.animation.finished)
						{
							spr.animation.play('static');
							spr.centerOffsets();
						}
					});

				if (!inCutscene && !_variables.botplay)
					keyShit();
				else if (_variables.botplay)
					autoShit();
			}

		function createSpookyText(text:String, x:Float = -1111111111111, y:Float = -1111111111111):Void
			{
				spookySteps = curStep;
				spookyRendered = true;
				tstatic.alpha = 0.5;
				FlxG.sound.play(Paths.sound('staticSound'));
				spookyText = new FlxText((x == -1111111111111 ? FlxG.random.float(dad.x + 40,dad.x + 120) : x), (y == -1111111111111 ? FlxG.random.float(dad.y + 200, dad.y + 300) : y));
				spookyText.setFormat("Impact", 128, FlxColor.RED);
				if (curStage == 'nevadaSpook')
				{
					spookyText.size = 200;
					spookyText.x += 250;
				}
				spookyText.bold = true;
				spookyText.text = text;
				add(spookyText);
			}
		
			function endSong():Void
			{
				if (useVideo)
				{
					BackgroundVideo.get().stop();
					FlxG.stage.window.onFocusOut.remove(focusOut);
					FlxG.stage.window.onFocusIn.remove(focusIn);
					PlayState.instance.remove(PlayState.instance.videoSprite);
				}

				Main.skipDes = false;
				#if desktop
				iconRPC = "";
				#end
				mariohelping = false;
				Main.playedVidCut = false;
				trace ('game you can play vid again');
				canPause = false;
				FlxG.sound.music.volume = 0;
				vocals.volume = 0;
				FlxG.sound.music.stop();
				vocals.stop();
		
				if (gameplayArea != "Endless")
				{
					camHB.angle = 0;
					camHUD.angle = 0;
					camNOTES.angle = 0;
					camSus.angle = 0;
					camNOTEHUD.angle = 0;
		
					if (!cheated)
					{
						#if !switch
						Highscore.saveScore(SONG.song.toLowerCase(), songScore, storyDifficulty);
						#end
					}
				}
		
				canDie = false;
				ended = true;
		
				switch (gameplayArea)
				{
					case "Story":
						campaignScore += songScore;
		
						storyPlaylist.remove(storyPlaylist[0]);
		
						if (storyPlaylist.length <= 0)
						{
							transIn = FlxTransitionableState.defaultTransIn;
							transOut = FlxTransitionableState.defaultTransOut;
		
							// if ()
							MenuWeek.weekUnlocked[Std.int(Math.min(storyWeek + 1, MenuWeek.weekUnlocked.length - 1))] = true;
		
							if (!cheated)
							{
								Highscore.saveWeekScore(storyWeek, campaignScore, storyDifficulty);
							}
		
							FlxG.save.data.weekUnlocked = MenuWeek.weekUnlocked;
							FlxG.save.flush();
							
							fadeouthud = true;

							endOrcutcene();
						}
						else
						{
							if (SONG.song.toLowerCase() == 'eggnog')
							{
								var blackShit:FlxSprite = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
									-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
								blackShit.scrollFactor.set();
								add(blackShit);
								camHB.visible = false;
								camHUD.visible = false;
								camNOTES.visible = false;
		
								FlxG.sound.play(Paths.sound('Lights_Shut_off'), _variables.svolume/100);
							}
		
							FlxTransitionableState.skipNextTransIn = true;
							FlxTransitionableState.skipNextTransOut = true;
							prevCamFollow = camFollow;
							endOrcutcene();
						}
					case "Freeplay":

						fadeouthud = true;
						if (!RankingSubstate.inrankingsubstate)
						{
							openSubState(new RankingSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
						}
					case "Marathon":
						campaignScore += songScore;
						storyPlaylist.remove(storyPlaylist[0]);
						difficultyPlaylist.remove(difficultyPlaylist[0]);
		
						if (storyPlaylist.length <= 0)
						{
							fadeouthud = true;
							transIn = FlxTransitionableState.defaultTransIn;
							transOut = FlxTransitionableState.defaultTransOut;

							if (!cheated)
							{
								Highscore.saveMarathonScore(campaignScore);
							}
		
							MenuMusic.continueMenuMusic();
							FlxG.switchState(new MenuMarathon());
						}
						else
						{
							FlxTransitionableState.skipNextTransIn = true;
							FlxTransitionableState.skipNextTransOut = true;
							prevCamFollow = camFollow;
							
							var difficulty:String = "";

							if (difficultyPlaylist[0].contains('0'))
								difficulty = '-easy';

							if (difficultyPlaylist[0].contains('2'))
								difficulty = '-hard';

							if (difficultyPlaylist[0].contains('3'))
								difficulty = '-ex';

							if (difficultyPlaylist[0].contains('4'))
								difficulty = '-god';

							storyDifficulty = Std.parseInt(difficultyPlaylist[0]);

							trace('LOADING NEXT SONG');
							trace(PlayState.storyPlaylist[0].toLowerCase() + difficulty);

							PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + difficulty, PlayState.storyPlaylist[0]);
							FlxG.sound.music.stop();
							LoadingState.loadAndSwitchState(new PlayState());
						}
					case "Endless":
						loops++;

						if (speed < 8 && _endless.ramp)
							speed = SONG.speed + 0.15;

						FlxG.sound.music.stop();
						vocals.stop();

						#if desktop
						detailsText = "Endless: Loop "+ loops;
						DiscordClient.changePresence(detailsText, SONG.song, iconRPC, true);
						#end

						FlxG.sound.music.volume = _variables.mvolume/100;
						vocals.volume = _variables.vvolume/100;

						canPause = true;
						canDie = true;
						ended = false;

						if (storyDifficulty < 2 && loops % 8 == 0 && loops > 0 && _endless.ramp)
						{
							storyDifficulty++;

							var diffic:String = "";

							switch (storyDifficulty)
							{
								case 0:
									diffic = '-easy';
								case 2:
									diffic = '-hard';
								case 3:
									diffic = '-ex';
								case 4:
									diffic = '-god';
							}

							PlayState.SONG = Song.loadFromJson(SONG.song.toLowerCase() + diffic, SONG.song.toLowerCase());
						}

						SONG.speed = speed;

						Conductor.songPosition = -5000;
						generateSong(SONG.song);
						startCountdown();
					case "Charting":
						FlxG.switchState(new ChartingState());
				}
			}
		
			var endingSong:Bool = false;
		
			var hits:Array<Float> = [];
			var timeShown = 0;
			var currentTimingShown:FlxText = null;
		
	private function popUpScore(strumtime:Float, note:Note):Void
	{
				var noteDiff:Float = strumtime - Conductor.songPosition;
				// boyfriend.playAnim('hey');

				if (!ended)
				{
				vocals.volume = _variables.vvolume/100;
				}
		
				var placement:String = Std.string(combo);
		
				var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
				coolText.screenCenter();
				coolText.cameras = [camHUD];
				//
		
				var rating:FlxSprite = new FlxSprite();
				var timing:FlxSprite = new FlxSprite();
				var score:Int = 350;
		
				var daRating:String = "sick";
				var daTiming:String = "";
		
				//Sweet Math.abs
		
				if (Math.abs(noteDiff) > Conductor.safeZoneOffset * 0.9)
				{
					daRating = 'shit';
					score = 50;
					shits++;
				}
				else if (Math.abs(noteDiff) > Conductor.safeZoneOffset * 0.75)
				{
					daRating = 'bad';
					score = 100;
					bads++;
				}
				else if (Math.abs(noteDiff) > Conductor.safeZoneOffset * 0.2)
				{
					daRating = 'good';
					score = 200;
					goods++;
				}
		
				if (daRating == "sick")
				{
					sicks++;
				}
		
				if (noteDiff > Conductor.safeZoneOffset * 0.1)
					daTiming = "early";
				else if (noteDiff < Conductor.safeZoneOffset * -0.1)
					daTiming = "late";
		
				switch (_variables.accuracyType)
				{
					case 'simple':
						totalNotesHit += 1;
					case 'complex':
						if (noteDiff > Conductor.safeZoneOffset * Math.abs(0.1))
							totalNotesHit += 1 - Math.abs(noteDiff/200); //seems like the sweet spot
						else
							totalNotesHit += 1;  //this feels so much better than you think, and saves up code space
					case 'rating-based':
						switch (daRating)
						{
							case 'sick':
								totalNotesHit += 1;
							case 'good':
								totalNotesHit += 0.75;
							case 'bad':
								totalNotesHit += 0.5;
							case 'shit':
								totalNotesHit += 0.25;
						}
				}

				if (Math.abs(noteDiff) > Conductor.safeZoneOffset * 0.75 && _variables.lateD)
				{
					switch (daRating)
					{
						case 'bad':
							if (_modifiers.HPLossSwitch)
								health -= 0.06 * _modifiers.HPLoss;
							else
								health -= 0.06;
						case 'shit':
							if (_modifiers.HPLossSwitch)
								health -= 0.2 * _modifiers.HPLoss;
							else
								health -= 0.2;
					}
				}
		
				songScore += Math.floor((score + (_variables.comboP ? 2*combo : 0)) * MenuModifiers.fakeMP);
		
				/* if (combo > 60)
						daRating = 'sick';
					else if (combo > 12)
						daRating = 'good'
					else if (combo > 4)
						daRating = 'bad';
				 */
		
				var pixelShitPart1:String = "";
				var pixelShitPart2:String = '';
		
				if (SONG.notestyle == 'pixel')
				{
					pixelShitPart1 = 'weeb/pixelUI/';
					pixelShitPart2 = '-pixel';
				}
		
				rating.loadGraphic(Paths.image(pixelShitPart1 + daRating + pixelShitPart2));
				rating.screenCenter();
				rating.x = _variables.sickX;
				rating.y = _variables.sickY;
				rating.acceleration.y = 550;
				rating.velocity.y -= FlxG.random.int(140, 175);
				rating.velocity.x -= FlxG.random.int(0, 10);
				rating.cameras = [camHUD];
		
				timing.loadGraphic(Paths.image(pixelShitPart1 + daTiming + pixelShitPart2));
				timing.screenCenter();
				timing.x = rating.x - 80;
				timing.y = rating.y + 80;
				timing.acceleration.y = 550;
				timing.velocity.y -= FlxG.random.int(140, 175);
				timing.velocity.x -= FlxG.random.int(0, 10);
				timing.cameras = [camHUD];
		
				var comboSpr:FlxSprite = new FlxSprite();

				comboSpr.loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
				comboSpr.screenCenter();
				comboSpr.x = coolText.x;
				comboSpr.acceleration.y = 600;
				comboSpr.velocity.y -= 150;
				comboSpr.cameras = [camHUD];
		
				comboSpr.velocity.x += FlxG.random.int(1, 10);
		
				var msTiming = truncateFloat(noteDiff, 3);
		
				if (currentTimingShown != null)
					remove(currentTimingShown);
		
				currentTimingShown = new FlxText(0,0,0,"0ms");
				timeShown = 0;
		
				if (Math.abs(noteDiff) > Conductor.safeZoneOffset * 0.75)
					currentTimingShown.color = FlxColor.RED;
				else if (Math.abs(noteDiff) > Conductor.safeZoneOffset * 0.2)
					currentTimingShown.color = FlxColor.GREEN;
				else if (Math.abs(noteDiff) <= Conductor.safeZoneOffset * 0.2)
					currentTimingShown.color = FlxColor.CYAN;
		
				currentTimingShown.borderStyle = OUTLINE;
				currentTimingShown.borderSize = 1;
				currentTimingShown.borderColor = FlxColor.BLACK;
				currentTimingShown.text = msTiming + "ms";
				currentTimingShown.size = 20;
				currentTimingShown.screenCenter();
				currentTimingShown.x = rating.x + 90;
				currentTimingShown.y = rating.y + 100;
				currentTimingShown.acceleration.y = 600;
				currentTimingShown.velocity.y -= 150;
				comboSpr.velocity.x += FlxG.random.int(1, 10);
		
				if (currentTimingShown.alpha != 1)
					currentTimingShown.alpha = 1;
		
				currentTimingShown.cameras = [camHUD];
		
				if (_variables.ratingDisplay)
					add(rating);
		
				if (daTiming != "" && _variables.timingDisplay)
					add(timing);
		
				if (_variables.timingDisplay)
					add(currentTimingShown);
		
				if (SONG.notestyle == 'pixel')
				{
					rating.setGraphicSize(Std.int(rating.width * daPixelZoom * 0.7));
					comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * 0.7));
					timing.setGraphicSize(Std.int(timing.width * daPixelZoom * 0.7));
				}
				else
				{				
					rating.setGraphicSize(Std.int(rating.width * 0.7));
					rating.antialiasing = _variables.antialiasing;
					comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
					comboSpr.antialiasing = _variables.antialiasing;
					timing.setGraphicSize(Std.int(timing.width * 0.7));
					timing.antialiasing = _variables.antialiasing;
				}
		
				comboSpr.updateHitbox();
				rating.updateHitbox();
				timing.updateHitbox();

			var sploosh:FlxSprite = new FlxSprite(note.x, playerStrums.members[note.noteData].y);

			var splooshdata:Array<String> = ['0', '1', '2', '3'];

			if (Main.switchside)
			{
				switch (mania)
				{
					case 0:
						splooshdata = ['3', '2', '1', '0'];
					case 1:
						splooshdata = ['8', '1', '5', '3', '2', '0'];
					case 2:
						splooshdata = ['8', '7', '6', '5', '4', '3', '2', '1', '0'];
				}
			}
			else
			{
				switch (mania)
				{
					case 0:
						splooshdata = ['0', '1', '2', '3'];
					case 1:
						splooshdata = ['0', '2', '3', '5', '1', '8'];
					case 2:
						splooshdata = ['0', '1', '2', '3', '4', '5', '6', '7', '8'];
				}
			}
			
			if (!_modifiers.InvisibleNotes && _variables.noteSplashes)
			{
				if (SONG.notestyle == 'pixel')
				{
					sploosh.loadGraphic(Paths.image('weeb/pixelUI/noteSplashes-pixels'), true, 50, 50);
					sploosh.animation.add('splash 0 0', [0, 1, 2, 3], 24, false);
					sploosh.animation.add('splash 1 0', [4, 5, 6, 7], 24, false);
					sploosh.animation.add('splash 0 1', [8, 9, 10, 11], 24, false);
					sploosh.animation.add('splash 1 1', [12, 13, 14, 15], 24, false);
					sploosh.animation.add('splash 0 2', [16, 17, 18, 19], 24, false);
					sploosh.animation.add('splash 1 2', [20, 21, 22, 23], 24, false);
					sploosh.animation.add('splash 0 3', [24, 25, 26, 27], 24, false);
					sploosh.animation.add('splash 1 3', [28, 29, 30, 31], 24, false);
					sploosh.animation.add('splash 0 4', [32, 33, 34, 35], 24, false);
					sploosh.animation.add('splash 1 4', [36, 37, 38, 39], 24, false);
					if (daRating == 'sick')
					{
						sploosh.setGraphicSize(Std.int(sploosh.width * daPixelZoom));
						sploosh.updateHitbox();
						add(sploosh);
						sploosh.cameras = [camNOTEHUD];
						sploosh.animation.play('splash ' + FlxG.random.int(0, 1) + " " + splooshdata[note.noteData]);
						sploosh.alpha = 0.6;
						sploosh.offset.x += 90;
						sploosh.offset.y += 80;
						sploosh.animation.finishCallback = function(name) sploosh.kill();
					}
				}
				else
				{				
					var tex:flixel.graphics.frames.FlxAtlasFrames = Paths.getSparrowAtlas('noteSplashes');
					sploosh.frames = tex;
					sploosh.animation.addByPrefix('splash 0 0', 'note impact 1 purple', 24, false);
					sploosh.animation.addByPrefix('splash 0 1', 'note impact 1 blue', 24, false);
					sploosh.animation.addByPrefix('splash 0 2', 'note impact 1 green', 24, false);
					sploosh.animation.addByPrefix('splash 0 3', 'note impact 1 red', 24, false);
					sploosh.animation.addByPrefix('splash 0 4', 'note impact 1 white', 24, false);
					sploosh.animation.addByPrefix('splash 0 5', 'note impact 1 yellow', 24, false);
					sploosh.animation.addByPrefix('splash 0 6', 'note impact 1 violet', 24, false);
					sploosh.animation.addByPrefix('splash 0 7', 'note impact 1 black', 24, false);
					sploosh.animation.addByPrefix('splash 0 8', 'note impact 1 dark', 24, false);

					sploosh.animation.addByPrefix('splash 1 0', 'note impact 2 purple', 24, false);
					sploosh.animation.addByPrefix('splash 1 1', 'note impact 2 blue', 24, false);
					sploosh.animation.addByPrefix('splash 1 2', 'note impact 2 green', 24, false);
					sploosh.animation.addByPrefix('splash 1 3', 'note impact 2 red', 24, false);
					sploosh.animation.addByPrefix('splash 1 4', 'note impact 2 white', 24, false);
					sploosh.animation.addByPrefix('splash 1 5', 'note impact 2 yellow', 24, false);
					sploosh.animation.addByPrefix('splash 1 6', 'note impact 2 violet', 24, false);
					sploosh.animation.addByPrefix('splash 1 7', 'note impact 2 black', 24, false);
					sploosh.animation.addByPrefix('splash 1 8', 'note impact 2 dark', 24, false);
					
					if (daRating == 'sick')
					{
						add(sploosh);
						sploosh.cameras = [camNOTEHUD];
						sploosh.animation.play('splash ' + FlxG.random.int(0, 1) + " " + splooshdata[note.noteData]);
						sploosh.alpha = 0.6;
						sploosh.offset.x += 90;
						sploosh.offset.y += 80;
						sploosh.animation.finishCallback = function(name) sploosh.kill();
					}
				}
			}
		
				var seperatedScore:Array<Int> = [];
				
				var comboSplit:Array<String> = (combo + 1 + "").split('');
		
				for(i in 0...comboSplit.length)
				{
					var str:String = comboSplit[i];
					seperatedScore.push(Std.parseInt(str));
				}
		
				var daLoop:Int = 0;
				for (i in seperatedScore)
				{
					var numScore:FlxSprite = new FlxSprite();

					numScore.loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
					numScore.screenCenter();
					numScore.x = rating.x + (43 * daLoop) - 40;
					numScore.y = rating.y + 180;
					numScore.cameras = [camHUD];
		
					if (SONG.notestyle == 'pixel')
					{
						numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
					}
					else
					{
						numScore.antialiasing = _variables.antialiasing;
						numScore.setGraphicSize(Std.int(numScore.width * 0.5));
					}
					numScore.updateHitbox();
		
					numScore.acceleration.y = FlxG.random.int(200, 300);
					numScore.velocity.y -= FlxG.random.int(140, 160);
					numScore.velocity.x = FlxG.random.float(-5, 5);
		
					if (_variables.comboDisplay)
						add(numScore);
		
					FlxTween.tween(numScore, {alpha: 0}, 0.2, {
						onComplete: function(tween:FlxTween)
						{
							numScore.destroy();
						},
						startDelay: Conductor.crochet * 0.002
					});
		
					daLoop++;
				}
				/* 
					trace(combo);
					trace(seperatedScore);
				 */
		
				coolText.text = Std.string(seperatedScore);
				// add(coolText);
		
				FlxTween.tween(rating, {alpha: 0}, 0.2, {
					startDelay: Conductor.crochet * 0.001,
					onUpdate: function(tween:FlxTween)
					{
						if (currentTimingShown != null)
							currentTimingShown.alpha -= 0.02;
						timeShown++;
					}
				});
		
				FlxTween.tween(timing, {alpha: 0}, 0.2, {
					startDelay: Conductor.crochet * 0.001
				});
		
				FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
					onComplete: function(tween:FlxTween)
					{
						coolText.destroy();
						comboSpr.destroy();
						if (currentTimingShown != null && timeShown >= 10)
							{
								remove(currentTimingShown);
								currentTimingShown = null;
							}
						rating.destroy();
					},
					startDelay: Conductor.crochet * 0.001
				});
		
				curSection += 1;
	}

public function NearlyEquals(value1:Float, value2:Float, unimportantDifference:Float = 10):Bool
	{
		return Math.abs(FlxMath.roundDecimal(value1, 1) - FlxMath.roundDecimal(value2, 1)) < unimportantDifference;
	}

	var upHold:Bool = false;
	var downHold:Bool = false;
	var rightHold:Bool = false;
	var leftHold:Bool = false;	

	var l1Hold:Bool = false;
	var uHold:Bool = false;
	var r1Hold:Bool = false;
	var l2Hold:Bool = false;
	var dHold:Bool = false;
	var r2Hold:Bool = false;

	var n0Hold:Bool = false;
	var n1Hold:Bool = false;
	var n2Hold:Bool = false;
	var n3Hold:Bool = false;
	var n4Hold:Bool = false;
	var n5Hold:Bool = false;
	var n6Hold:Bool = false;
	var n7Hold:Bool = false;
	var n8Hold:Bool = false;

	private function autoShit():Void
	{
		if (!stuneffect)
		{
			var automn:Int = keyAmmo[mania]; //new var to determine max notes

			var ignorethisnote:Bool = false; //if bot should ignore that note

			playerStrums.forEach(function(spr:FlxSprite)
			{
				if (spr.animation.curAnim.name == 'confirm' && SONG.notestyle != 'pixel')
				{
					spr.centerOffsets();
					spr.offset.x -= 13;
					spr.offset.y -= 13;
	
					if (_variables.scroll == "left" || _variables.scroll == "right")
						spr.offset.x -= 50;
				}
				else
					spr.centerOffsets();
	
				if (spr.animation.curAnim.name == 'confirm' && spr.animation.curAnim.finished)
				{
					spr.animation.play('static');
					spr.centerOffsets();
				}
			});
	
			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.y < strumLineNotes.members[daNote.noteData].y)
				{
					switch (daNote.noteType)
					{
						case 0:
						{
							ignorethisnote = false;
						//	trace ('dont ignore regular note');
						}
						case 1:
						{
							ignorethisnote = true;
						//	trace ('please ignore fire note');
						}
						case 2:
						{
							ignorethisnote = true;
						//	trace ('please ignore halo note');
						}
						case 3:
						{
							ignorethisnote = false;
						//	trace ('dont ignore hd caution note');
						}
						case 4:
						{
							ignorethisnote = false;
						//	trace ('dont ignore stun note');
						}
						case 5:
						{
							ignorethisnote = true;
						//	trace ('please ignore bad poison note');
						}
						case 6:
						{
							ignorethisnote = false;
						//	trace ('dont ignore good poison note');
						}
					}

					// Force good note hit regardless if it's too late to hit it or not as a fail safe
					if (daNote.canBeHit && daNote.mustPress || daNote.tooLate && daNote.mustPress)
					{	
						if (!ignorethisnote)
						{
							goodNoteHit(daNote);

							if (Main.switchside)
							{
								if (SONG.exDad)
								{
									if (daNote.dType == 0)
									{ 
										if (SONG.exDad) dad2.holdTimer = 0;
									}
									else if (daNote.dType == 1) 
									{
										dad.holdTimer = 0;
									}
									else if (daNote.dType == 2)
									{
										dad.holdTimer = 0;
										if (SONG.exDad) dad2.holdTimer = 0;
									}			
								}
								else
								{
									dad.holdTimer = 0;
									if (SONG.exDad) dad2.holdTimer = 0;
								}
							}
							else
							{
								if (SONG.exBF)
								{
									if (daNote.bType == 0)
									{ 
										if (SONG.exBF) boyfriend2.holdTimer = 0;
									}
									else if (daNote.bType == 1) 
									{
										boyfriend.holdTimer = 0;
									}
									else if (daNote.bType == 2)
									{
										boyfriend.holdTimer = 0;
										if (SONG.exBF) boyfriend2.holdTimer = 0;
									}			
								}
								else
								{
									boyfriend.holdTimer = 0;
									if (SONG.exBF) boyfriend2.holdTimer = 0;
								}
							}
						}
					}
				}
			});
			if (Main.switchside && dad.holdTimer > Conductor.stepCrochet * dad.dadVar * 0.001)
			{
				if (dad.animation.curAnim.name.startsWith('sing') && !dad.animation.curAnim.name.endsWith('miss'))
					{
						if (!frozen)
						{
							dad.dance();
						}
					}
			}

			if (SONG.exDad && Main.switchside && dad2.holdTimer > Conductor.stepCrochet * dad2.dadVar * 0.001)
			{
				if (dad2.animation.curAnim.name.startsWith('sing') && !dad2.animation.curAnim.name.endsWith('miss'))
					{
						if (!frozen)
						{
							dad2.dance();
						}
					}
			}

			if (!Main.switchside && boyfriend.holdTimer > Conductor.stepCrochet * boyfriend.dadVar * 0.001)
			{
				if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss'))
					{
						if (!frozen)
						{
							boyfriend.dance();
							if (_modifiers.FrightSwitch)
							{
								if (_modifiers.Fright >= 50 && _modifiers.Fright < 100)
									boyfriend.playAnim('scared');
								else if (_modifiers.Fright >= 100)
									boyfriend.playAnim('worried');
							}
						}
						else
							boyfriend.playAnim('frozen');
					}
			}

			if (SONG.exBF && !Main.switchside && boyfriend2.holdTimer > Conductor.stepCrochet * boyfriend2.dadVar * 0.001)
			{
				if (boyfriend2.animation.curAnim.name.startsWith('sing') && !boyfriend2.animation.curAnim.name.endsWith('miss'))
					{
						if (!frozen)
						{
							boyfriend2.dance();
						}
					}
			}
		}		
	}

private function keyShit():Void
{
	if (!stuneffect)
	{
		#if !moblie
		var left = controls.LEFT;		
		var down = controls.DOWN;	
		var up = controls.UP;
		var right = controls.RIGHT;			

		var upP = controls.UP_P;
		var rightP = controls.RIGHT_P;
		var downP = controls.DOWN_P;
		var leftP = controls.LEFT_P;

		var upR = controls.UP_R;
		var rightR = controls.RIGHT_R;
		var downR = controls.DOWN_R;
		var leftR = controls.LEFT_R;

		var l1 = controls.L1;
		var	u = controls.U1;
		var	r1 = controls.R1;
		var	l2 = controls.L2;
		var	d = controls.D1;
		var	r2 = controls.R2;

		var l1P = controls.L1_P;
		var	uP = controls.U1_P;
		var	r1P = controls.R1_P;
		var	l2P = controls.L2_P;
		var	dP = controls.D1_P;
		var	r2P = controls.R2_P;

		var l1R = controls.L1_R;
		var	uR = controls.U1_R;
		var	r1R = controls.R1_R;
		var	l2R = controls.L2_R;
		var	dR = controls.D1_R;
		var	r2R = controls.R2_R;

		var n0 = controls.N0;
		var n1 = controls.N1;
		var n2 = controls.N2;
		var n3 = controls.N3;
		var n4 = controls.N4;
		var n5 = controls.N5;
		var n6 = controls.N6;
		var n7 = controls.N7;
		var n8 = controls.N8;

		var n0P = controls.N0_P;
		var n1P = controls.N1_P;
		var n2P = controls.N2_P;
		var n3P = controls.N3_P;
		var n4P = controls.N4_P;
		var n5P = controls.N5_P;
		var n6P = controls.N6_P;
		var n7P = controls.N7_P;
		var n8P = controls.N8_P;

		var n0R = controls.N0_R;
		var n1R = controls.N1_R;
		var n2R = controls.N2_R;
		var n3R = controls.N3_R;
		var n4R = controls.N4_R;
		var n5R = controls.N5_R;
		var n6R = controls.N6_R;
		var n7R = controls.N7_R;
		var n8R = controls.N8_R;

		if (Main.switchside)
		{		
			right = controls.LEFT;
			up = controls.DOWN;
			down = controls.UP;
			left = controls.RIGHT;

			upP = controls.DOWN_P;
			rightP = controls.LEFT_P;
			downP = controls.UP_P;
			leftP = controls.RIGHT_P;

			upR = controls.DOWN_R;
			rightR = controls.LEFT_R;
			downR = controls.UP_R;
			leftR = controls.RIGHT_R;

			r2 = controls.L1;
			d = controls.U1;
			l2 = controls.R1;
			r1 = controls.L2;
			u = controls.D1;
			l1 = controls.R2;

			r2P = controls.L1_P;
			dP = controls.U1_P;
			l2P = controls.R1_P;
			r1P = controls.L2_P;
			uP = controls.D1_P;
			l1P = controls.R2_P;

			r2R = controls.L1_R;
			dR = controls.U1_R;
			l2R = controls.R1_R;
			r1R = controls.L2_R;
			uR = controls.D1_R;
			l1R = controls.R2_R;
			n8 = controls.N0;
			n7 = controls.N1;
			n6 = controls.N2;
			n5 = controls.N3;
			n4 = controls.N4;
			n3 = controls.N5;
			n2 = controls.N6;
			n1 = controls.N7;
			n0 = controls.N8;

			n8P = controls.N0_P;
			n7P = controls.N1_P;
			n6P = controls.N2_P;
			n5P = controls.N3_P;
			n4P = controls.N4_P;
			n3P = controls.N5_P;
			n2P = controls.N6_P;
			n1P = controls.N7_P;
			n0P = controls.N8_P;

			n8R = controls.N0_R;
			n7R = controls.N1_R;
			n6R = controls.N2_R;
			n5R = controls.N3_R;
			n4R = controls.N4_R;
			n3R = controls.N5_R;
			n2R = controls.N6_R;
			n1R = controls.N7_R;
			n0R = controls.N8_R;			
		}
		#end
		#if mobile
		var upP = controls.UP_P || _hitbox.buttonUp.justPressed;
		var rightP = controls.RIGHT_P || _hitbox.buttonRight.justPressed;
		var downP = controls.DOWN_P ||_hitbox.buttonDown.justPressed;
		var leftP = controls.LEFT_P ||_hitbox.buttonLeft.justPressed;

		var up = controls.UP || _hitbox.buttonUp.pressed;
		var right = controls.RIGHT || _hitbox.buttonRight.pressed;
		var down = controls.DOWN || _hitbox.buttonDown.pressed;
		var left = controls.LEFT || _hitbox.buttonLeft.pressed;

		var upR = controls.UP_R || _hitbox.buttonUp.justReleased;
		var rightR = controls.RIGHT_R || _hitbox.buttonRight.justReleased;
		var downR = controls.DOWN_R || _hitbox.buttonDown.justReleased;
		var leftR = controls.LEFT_R || _hitbox.buttonLeft.justReleased;
		// ------------ six control -----------
		var l1 = controls.L1 || _hitbox.buttonLeft.pressed; // 3
		var u = controls.U1 || _hitbox.buttonDown.pressed; // 2
		var r1 = controls.R1 || _hitbox.buttonUp.pressed; // 1
		var l2 = controls.L2 || _hitbox.buttonRight.pressed; // 4
		var d = controls.D1 || _hitbox.buttonUp2.pressed; // 5
		var r2 = controls.R2 || _hitbox.buttonRight2.pressed; // 6

		var l1P = controls.L1_P || _hitbox.buttonLeft.justPressed;
		var uP = controls.U1_P || _hitbox.buttonDown.justPressed;
		var r1P = controls.R1_P || _hitbox.buttonUp.justPressed;
		var l2P = controls.L2_P || _hitbox.buttonRight.justPressed;
		var dP = controls.D1_P || _hitbox.buttonUp2.justPressed;
		var r2P = controls.R2_P || _hitbox.buttonRight2.justPressed;

		var l1R = controls.L1_R || _hitbox.buttonLeft.justReleased;
		var uR = controls.U1_R || _hitbox.buttonDown.justReleased;
		var r1R = controls.R1_R || _hitbox.buttonUp.justReleased;
		var l2R = controls.L2_R || _hitbox.buttonRight.justReleased;
		var dR = controls.D1_R || _hitbox.buttonUp2.justReleased;
		var r2R = controls.R2_R || _hitbox.buttonRight2.justReleased;
		// ---------- nine control ------------
		var n0 = controls.N0 || _hitbox.buttonLeft.pressed;
		var n1 = controls.N1 || _hitbox.buttonDown.pressed;
		var n2 = controls.N2 || _hitbox.buttonUp.pressed;
		var n3 = controls.N3 || _hitbox.buttonRight.pressed;
		var n4 = controls.N4 || _hitbox.buttonUp2.pressed;
		var n5 = controls.N5 || _hitbox.buttonRight2.pressed;
		var n6 = controls.N6 || _hitbox.buttonLeft2.pressed;
		var n7 = controls.N7 || _hitbox.buttonDown2.pressed;
		var n8 = controls.N8 || _hitbox.buttonLeft3.pressed;

		var n0P = controls.N0_P || _hitbox.buttonLeft.justPressed;
		var n1P = controls.N1_P || _hitbox.buttonDown.justPressed;
		var n2P = controls.N2_P || _hitbox.buttonUp.justPressed;
		var n3P = controls.N3_P || _hitbox.buttonRight.justPressed;
		var n4P = controls.N4_P || _hitbox.buttonUp2.justPressed;
		var n5P = controls.N5_P || _hitbox.buttonRight2.justPressed;
		var n6P = controls.N6_P || _hitbox.buttonLeft2.justPressed;
		var n7P = controls.N7_P || _hitbox.buttonDown2.justPressed;
		var n8P = controls.N8_P || _hitbox.buttonLeft3.justPressed;

		var n0R = controls.N0_R || _hitbox.buttonLeft.justReleased;
		var n1R = controls.N1_R || _hitbox.buttonDown.justReleased;
		var n2R = controls.N2_R || _hitbox.buttonUp.justReleased;
		var n3R = controls.N3_R || _hitbox.buttonRight.justReleased;
		var n4R = controls.N4_R || _hitbox.buttonUp2.justReleased;
		var n5R = controls.N5_R || _hitbox.buttonRight2.justReleased;
		var n6R = controls.N6_R || _hitbox.buttonLeft2.justReleased;
		var n7R = controls.N7_R || _hitbox.buttonDown2.justReleased;
		var n8R = controls.N8_R || _hitbox.buttonLeft3.justReleased;

		if (Main.switchside)
		{
			rightP = controls.LEFT_P ||_hitbox.buttonLeft.justPressed;	
			upP = controls.DOWN_P ||_hitbox.buttonDown.justPressed;	
			downP = controls.UP_P || _hitbox.buttonUp.justPressed;
			leftP = controls.RIGHT_P || _hitbox.buttonRight.justPressed;	
			
			right = controls.LEFT || _hitbox.buttonLeft.pressed;
			up = controls.DOWN || _hitbox.buttonDown.pressed;
			down = controls.UP || _hitbox.buttonUp.pressed;
			left = controls.RIGHT || _hitbox.buttonRight.pressed;
			
			rightR = controls.LEFT_R || _hitbox.buttonLeft.justReleased;
			upR = controls.DOWN_R || _hitbox.buttonDown.justReleased;
			downR = controls.UP_R || _hitbox.buttonUp.justReleased;
			leftR = controls.RIGHT_R || _hitbox.buttonRight.justReleased;		
			// ------------ six control -----------
			r2 = controls.L1 || _hitbox.buttonLeft.pressed; // 3
			d = controls.U1 || _hitbox.buttonDown.pressed; // 2
			l2 = controls.R1 || _hitbox.buttonUp.pressed; // 1
			r1 = controls.L2 || _hitbox.buttonRight.pressed; // 4
			u = controls.D1 || _hitbox.buttonUp2.pressed; // 5
			l1 = controls.R2 || _hitbox.buttonRight2.pressed; // 6

			r2P = controls.L1_P || _hitbox.buttonLeft.justPressed;
			dP = controls.U1_P || _hitbox.buttonDown.justPressed;
			l2P = controls.R1_P || _hitbox.buttonUp.justPressed;
			r1P = controls.L2_P || _hitbox.buttonRight.justPressed;
			uP = controls.D1_P || _hitbox.buttonUp2.justPressed;
			l1P = controls.R2_P || _hitbox.buttonRight2.justPressed;

			r2R = controls.L1_R || _hitbox.buttonLeft.justReleased;
			dR = controls.U1_R || _hitbox.buttonDown.justReleased;
			l2R = controls.R1_R || _hitbox.buttonUp.justReleased;
			r1R = controls.L2_R || _hitbox.buttonRight.justReleased;
			uR = controls.D1_R || _hitbox.buttonUp2.justReleased;
			l1R = controls.R2_R || _hitbox.buttonRight2.justReleased;
			// ---------- nine control ------------
			n8 = controls.N0 || _hitbox.buttonLeft.pressed;
			n7 = controls.N1 || _hitbox.buttonDown.pressed;
			n6 = controls.N2 || _hitbox.buttonUp.pressed;
			n5 = controls.N3 || _hitbox.buttonRight.pressed;
			n4 = controls.N4 || _hitbox.buttonUp2.pressed;
			n3 = controls.N5 || _hitbox.buttonRight2.pressed;
			n2 = controls.N6 || _hitbox.buttonLeft2.pressed;
			n1 = controls.N7 || _hitbox.buttonDown2.pressed;
			n0 = controls.N8 || _hitbox.buttonLeft3.pressed;

			n8P = controls.N0_P || _hitbox.buttonLeft.justPressed;
			n7P = controls.N1_P || _hitbox.buttonDown.justPressed;
			n6P = controls.N2_P || _hitbox.buttonUp.justPressed;
			n5P = controls.N3_P || _hitbox.buttonRight.justPressed;
			n4P = controls.N4_P || _hitbox.buttonUp2.justPressed;
			n3P = controls.N5_P || _hitbox.buttonRight2.justPressed;
			n2P = controls.N6_P || _hitbox.buttonLeft2.justPressed;
			n1P = controls.N7_P || _hitbox.buttonDown2.justPressed;
			n0P = controls.N8_P || _hitbox.buttonLeft3.justPressed;

			n8R = controls.N0_R || _hitbox.buttonLeft.justReleased;
			n7R = controls.N1_R || _hitbox.buttonDown.justReleased;
			n6R = controls.N2_R || _hitbox.buttonUp.justReleased;
			n5R = controls.N3_R || _hitbox.buttonRight.justReleased;
			n4R = controls.N4_R || _hitbox.buttonUp2.justReleased;
			n3R = controls.N5_R || _hitbox.buttonRight2.justReleased;
			n2R = controls.N6_R || _hitbox.buttonLeft2.justReleased;
			n1R = controls.N7_R || _hitbox.buttonDown2.justReleased;
			n0R = controls.N8_R || _hitbox.buttonLeft3.justReleased;
		}
		#end

		var controlArray:Array<Bool> = [leftP, downP, upP, rightP];

		// FlxG.watch.addQuick('asdfa', upP);
		var ankey = (upP || rightP || downP || leftP);
		if (mania == 0)
		{
			ankey = (upP || rightP || downP || leftP);
			controlArray = [leftP, downP, upP, rightP];
		}
		else if (mania == 1)
		{ 
			ankey = (l1P || uP || r1P || l2P || dP || r2P);
			controlArray = [l1P, uP, r1P, l2P, dP, r2P];
		}
		else if (mania == 2)
		{
			ankey = (n0P || n1P || n2P || n3P || n4P || n5P || n6P || n7P || n8P);
			controlArray = [n0P, n1P, n2P, n3P, n4P, n5P, n6P, n7P, n8P];
		}
		

		if (ankey && !boyfriend.stunned && generatedMusic && !frozen && !ended)
		{
			if (Main.switchside)
			{
				dad.holdTimer = 0;
				if (SONG.exDad) dad2.holdTimer = 0;
			}
			else if (!Main.switchside)
			{
				boyfriend.holdTimer = 0;
				if (SONG.exBF) boyfriend2.holdTimer = 0;
			}

			var possibleNotes:Array<Note> = [];

			var ignoreList:Array<Int> = [];

			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit)
				{
					// the sorting probably doesn't need to be in here? who cares lol
					possibleNotes.push(daNote);
					possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

					ignoreList.push(daNote.noteData);
				}
			});

			if (possibleNotes.length > 0)
			{
				var daNote = possibleNotes[0];

				if (perfectMode)
					noteCheck(true, daNote);

				// Jump notes
				if (possibleNotes.length >= 2)
				{
					if (possibleNotes[0].strumTime == possibleNotes[1].strumTime)
					{
						for (coolNote in possibleNotes)
						{
							if (controlArray[coolNote.noteData])
								goodNoteHit(coolNote);
							else
							{
								var inIgnoreList:Bool = false;
								for (shit in 0...ignoreList.length)
								{
									if (controlArray[ignoreList[shit]])
										inIgnoreList = true;
								}
								if (!inIgnoreList && _variables.spamPrevention)
									badNoteCheck();
							}
						}
					}
					else if (possibleNotes[0].noteData == possibleNotes[1].noteData)
					{
						noteCheck(controlArray[daNote.noteData], daNote);
					}
					else
					{
						for (coolNote in possibleNotes)
						{
							noteCheck(controlArray[coolNote.noteData], coolNote);
						}
					}
				}
				else // regular notes?
				{
					noteCheck(controlArray[daNote.noteData], daNote);
				}
				/* 
					if (controlArray[daNote.noteData])
						goodNoteHit(daNote);
				 */
				// trace(daNote.noteData);
				/* 
						switch (daNote.noteData)
						{
							case 2: // NOTES YOU JUST PRESSED
								if (upP || rightP || downP || leftP)
									noteCheck(upP, daNote);
							case 3:
								if (upP || rightP || downP || leftP)
									noteCheck(rightP, daNote);
							case 1:
								if (upP || rightP || downP || leftP)
									noteCheck(downP, daNote);
							case 0:
								if (upP || rightP || downP || leftP)
									noteCheck(leftP, daNote);
						}
					//this is already done in noteCheck / goodNoteHit
					if (daNote.wasGoodHit)
					{
						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}
				 */
			}
			else
			{
				if (_variables.spamPrevention)
					badNoteCheck();
			}
		}

		var condition = ((up || right || down || left) && generatedMusic || (upHold || downHold || leftHold || rightHold) && generatedMusic);
		if (mania == 1)
			{
				condition = ((l1 || u || r1 || l2 || d || r2) && generatedMusic || (l1Hold || uHold || r1Hold || l2Hold || dHold || r2Hold) && generatedMusic);
			}
		else if (mania == 2)
		{
			condition = ((n0 || n1 || n2 || n3 || n4 || n5 || n6 || n7 || n8) && generatedMusic || (n0Hold || n1Hold || n2Hold || n3Hold || n4Hold || n5Hold || n6Hold || n7Hold || n8Hold) && generatedMusic);
		}
			if (condition)
			{
				notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.canBeHit && daNote.mustPress && daNote.isSustainNote)
						{
							if (mania == 0)
							{
								switch (daNote.noteData)
								{
									// NOTES YOU ARE HOLDING
									case 2:
										if (up || upHold)
											goodNoteHit(daNote);
									case 3:
										if (right || rightHold)
											goodNoteHit(daNote);
									case 1:
										if (down || downHold)
											goodNoteHit(daNote);
									case 0:
										if (left || leftHold)
											goodNoteHit(daNote);
								}
							}
							else if (mania == 1)
							{
								switch (daNote.noteData)
								{
									// NOTES YOU ARE HOLDING
									case 0:
										if (l1 || l1Hold)
											goodNoteHit(daNote);
									case 1:
										if (u || uHold)
											goodNoteHit(daNote);
									case 2:
										if (r1 || r1Hold)
											goodNoteHit(daNote);
									case 3:
										if (l2 || l2Hold)
											goodNoteHit(daNote);
									case 4:
										if (d || dHold)
											goodNoteHit(daNote);
									case 5:
										if (r2 || r2Hold)
											goodNoteHit(daNote);
								}
							}
							else
							{
								switch (daNote.noteData)
								{
									// NOTES YOU ARE HOLDING
									case 0: if (n0 || n0Hold) goodNoteHit(daNote);
									case 1: if (n1 || n1Hold) goodNoteHit(daNote);
									case 2: if (n2 || n2Hold) goodNoteHit(daNote);
									case 3: if (n3 || n3Hold) goodNoteHit(daNote);
									case 4: if (n4 || n4Hold) goodNoteHit(daNote);
									case 5: if (n5 || n5Hold) goodNoteHit(daNote);
									case 6: if (n6 || n6Hold) goodNoteHit(daNote);
									case 7: if (n7 || n7Hold) goodNoteHit(daNote);
									case 8: if (n8 || n8Hold) goodNoteHit(daNote);
								}
							}
						}
					});
			}

			if (Main.switchside && dad.holdTimer > Conductor.stepCrochet * dad.dadVar * 0.001 && !up && !down && !right && !left)
			{
				if (dad.animation.curAnim.name.startsWith('sing') && !dad.animation.curAnim.name.endsWith('miss'))
					{
						if (!frozen)
						{
							dad.dance();
						}
					}
			}

			if (SONG.exDad && Main.switchside && dad2.holdTimer > Conductor.stepCrochet * dad2.dadVar * 0.001 && !up && !down && !right && !left)
			{
				if (dad2.animation.curAnim.name.startsWith('sing') && !dad2.animation.curAnim.name.endsWith('miss'))
					{
						if (!frozen)
						{
							dad2.dance();
						}
					}
			}

			if (!Main.switchside && boyfriend.holdTimer > Conductor.stepCrochet * boyfriend.dadVar * 0.001 && !up && !down && !right && !left)
			{
				if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss'))
					{
						if (!frozen)
						{
							boyfriend.dance();
							if (_modifiers.FrightSwitch)
							{
								if (_modifiers.Fright >= 50 && _modifiers.Fright < 100)
									boyfriend.playAnim('scared');
								else if (_modifiers.Fright >= 100)
									boyfriend.playAnim('worried');
							}
						}
						else
							boyfriend.playAnim('frozen');
					}
			}

			if (SONG.exBF && !Main.switchside && boyfriend2.holdTimer > Conductor.stepCrochet * boyfriend2.dadVar * 0.001 && !up && !down && !right && !left)
			{
				if (boyfriend2.animation.curAnim.name.startsWith('sing') && !boyfriend2.animation.curAnim.name.endsWith('miss'))
					{
						if (!frozen)
						{
							boyfriend2.dance();
						}
					}
			}

		playerStrums.forEach(function(spr:FlxSkewedSprite)
			{
				if (mania == 0)
				{
					switch (spr.ID)
					{
						case 2:
							if (upP && spr.animation.curAnim.name != 'confirm')
							{
								spr.animation.play('pressed');
								trace('play');
							}
							if (upR)
							{
								spr.animation.play('static');
							}
						case 3:
							if (rightP && spr.animation.curAnim.name != 'confirm')
								spr.animation.play('pressed');
							if (rightR)
							{
								spr.animation.play('static');
							}
						case 1:
							if (downP && spr.animation.curAnim.name != 'confirm')
								spr.animation.play('pressed');
							if (downR)
							{
								spr.animation.play('static');
							}
						case 0:
							if (leftP && spr.animation.curAnim.name != 'confirm')
								spr.animation.play('pressed');
							if (leftR)
							{
								spr.animation.play('static');
							}
					}
				}
				else if (mania == 1)
				{
					switch (spr.ID)
					{
						case 0:
							if (l1P && spr.animation.curAnim.name != 'confirm')
							{
								spr.animation.play('pressed');
								trace('play');
							}
							if (l1R)
							{
								spr.animation.play('static');
							}
						case 1:
							if (uP && spr.animation.curAnim.name != 'confirm')
								spr.animation.play('pressed');
							if (uR)
							{
								spr.animation.play('static');
							}
						case 2:
							if (r1P && spr.animation.curAnim.name != 'confirm')
								spr.animation.play('pressed');
							if (r1R)
							{
								spr.animation.play('static');
							}
						case 3:
							if (l2P && spr.animation.curAnim.name != 'confirm')
								spr.animation.play('pressed');
							if (l2R)
							{
								spr.animation.play('static');
							}
						case 4:
							if (dP && spr.animation.curAnim.name != 'confirm')
								spr.animation.play('pressed');
							if (dR)
							{
								spr.animation.play('static');
							}
						case 5:
							if (r2P && spr.animation.curAnim.name != 'confirm')
								spr.animation.play('pressed');
							if (r2R)
							{
								spr.animation.play('static');
							}
					}
				}
				else if (mania == 2)
				{
					switch (spr.ID)
					{
						case 0:
							if (n0P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
							if (n0R) spr.animation.play('static');
						case 1:
							if (n1P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
							if (n1R) spr.animation.play('static');
						case 2:
							if (n2P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
							if (n2R) spr.animation.play('static');
						case 3:
							if (n3P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
							if (n3R) spr.animation.play('static');
						case 4:
							if (n4P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
							if (n4R) spr.animation.play('static');
						case 5:
							if (n5P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
							if (n5R) spr.animation.play('static');
						case 6:
							if (n6P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
							if (n6R) spr.animation.play('static');
						case 7:
							if (n7P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
							if (n7R) spr.animation.play('static');
						case 8:
							if (n8P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
							if (n8R) spr.animation.play('static');
					}
				}
				
				if (spr.animation.curAnim.name == 'confirm' && SONG.notestyle != 'pixel')
				{
					spr.centerOffsets();
					spr.offset.x -= 13;
					spr.offset.y -= 13;
	
					if (_variables.scroll == "left" || _variables.scroll == "right")
						spr.offset.x -= 50;
				}
				else
					spr.centerOffsets();
			});
	}
}

	//miss shit ugh haha funny tankman no chicken joke :|
	function noteMiss(direction:Int = 1):Void
	{
		if (!boyfriend.stunned)
		{
			interupt = true;
			if (_modifiers.HPLossSwitch)
				health -= 0.04 * _modifiers.HPLoss;
			else
				health -= 0.04;

			if (_modifiers.Perfect) // if perfect
				health = -10;

			if (combo > 5 && gf.animOffsets.exists('sad'))
			{
				gf.playAnim('sad');
			}

			misses++;

			if (!frozen && _modifiers.FreezeSwitch)
				{
					missCounter++;
					freezeIndicator.alpha = missCounter / (31 - _modifiers.Freeze);
				}

			songScore -= Math.floor(10 + (_variables.comboP ? 0.3*combo : 0) * MenuModifiers.fakeMP);

			combo = 0;
			updateAccuracy();

			FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2)*_variables.svolume/100);
			// FlxG.sound.play(Paths.sound('missnote1'), 1, false);
			// FlxG.log.add('played imss note');
			if (dad.curCharacter.toLowerCase().contains("tricky") && FlxG.random.bool(dad.curCharacter == "tricky" ? 10 : 4) && !spookyRendered && curStage == "nevada") // create spooky text :flushed:
				createSpookyText(TrickyLinesMiss[FlxG.random.int(0,TrickyLinesMiss.length)]);

			boyfriend.stunned = true;

			// get stunned for 5 seconds
			new FlxTimer().start(5 / 60, function(tmr:FlxTimer)
			{
				boyfriend.stunned = false;
			});

				if (Main.switchside)
				{
					switch (direction)
					{
						case 0:
							dad.playAnim('singLEFTmiss', true);
						case 1:
							dad.playAnim('singDOWNmiss', true);
						case 2:
							dad.playAnim('singUPmiss', true);
						case 3:
							dad.playAnim('singRIGHTmiss', true);
						case 4:
							dad.playAnim('singDOWNmiss', true);
						case 5:
							dad.playAnim('singRIGHTmiss', true);
						case 6:
							dad.playAnim('singDOWNmiss', true);
						case 7:
							dad.playAnim('singUPmiss', true);
						case 8:
							dad.playAnim('singRIGHTmiss', true);
					}
				}
				else 
				{
					switch (direction)
					{
						case 0:
							boyfriend.playAnim('singLEFTmiss', true);
						case 1:
							boyfriend.playAnim('singDOWNmiss', true);
						case 2:
							boyfriend.playAnim('singUPmiss', true);
						case 3:
							boyfriend.playAnim('singRIGHTmiss', true);
						case 4:
							boyfriend.playAnim('singDOWNmiss', true);
						case 5:
							boyfriend.playAnim('singRIGHTmiss', true);
						case 6:
							boyfriend.playAnim('singDOWNmiss', true);
						case 7:
							boyfriend.playAnim('singUPmiss', true);
						case 8:
							boyfriend.playAnim('singRIGHTmiss', true);
					}
				}
				

			if (_modifiers.FreezeSwitch && missCounter >= 31 - _modifiers.Freeze)
				freezeBF();
		}
	}

	function freezeBF():Void
	{
		frozen = true;
		missCounter = 0;
		FlxG.sound.play(Paths.sound('Ice_Appear'), _variables.svolume/100);
		boyfriend.playAnim('frozen', true);
		freezeIndicator.alpha = 1;
		new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				missCounter = 0;
				freezeIndicator.alpha = 0;
				FlxG.sound.play(Paths.sound('Ice_Shatter'), _variables.svolume/100);
				frozen = false;
				boyfriend.playAnim('idle', true);
					if (_modifiers.FrightSwitch)
					{
						if (_modifiers.Fright >= 50 && _modifiers.Fright < 100)
							boyfriend.playAnim('scared', true);
						else if (_modifiers.Fright >= 100)
							boyfriend.playAnim('worried', true);
					}
			});
	}

	function badNoteCheck()
	{
		// just double pasting this shit cuz fuk u
		// REDO THIS SYSTEM!
		var doNothing:Bool = false;
		var upP = controls.UP_P;
		var rightP = controls.RIGHT_P;
		var downP = controls.DOWN_P;
		var leftP = controls.LEFT_P;

		var l1P = controls.L1_P;
		var uP = controls.U1_P;
		var r1P = controls.R1_P;
		var l2P = controls.L2_P;
		var dP = controls.D1_P;
		var r2P = controls.R2_P;

		var n0P = controls.N0_P;
		var n1P = controls.N1_P;
		var n2P = controls.N2_P;
		var n3P = controls.N3_P;
		var n4P = controls.N4_P;
		var n5P = controls.N5_P;
		var n6P = controls.N6_P;
		var n7P = controls.N7_P;
		var n8P = controls.N8_P;

		notes.forEachAlive(function(daNote:Note)
		{
			if (daNote.canBeHit)
				doNothing = true;
		});
		if (mania == 0)
		{
			if (!doNothing)
			{
			Note.setCanMiss(0, true);
			Note.setCanMiss(1, true);
			Note.setCanMiss(2, true);
			Note.setCanMiss(3, true);
			}
		}
		else if (mania == 1)
		{
			if (!doNothing)
			{
			Note.setCanMiss(0, true);
			Note.setCanMiss(1, true);
			Note.setCanMiss(2, true);
			Note.setCanMiss(3, true);
			Note.setCanMiss(4, true);
			Note.setCanMiss(5, true);
			}
		}
		else
		{
			if (!doNothing)
			{
			Note.setCanMiss(0, true);
			Note.setCanMiss(1, true);
			Note.setCanMiss(2, true);
			Note.setCanMiss(3, true);
			Note.setCanMiss(4, true);
			Note.setCanMiss(5, true);
			Note.setCanMiss(6, true);
			Note.setCanMiss(7, true);
			Note.setCanMiss(8, true);
			}
		}
		
		if (mania == 0)
		{
			if (leftP)
				noteMiss(0);
			if (upP)
				noteMiss(2);
			if (rightP)
				noteMiss(3);
			if (downP)
				noteMiss(1);
		}
		else if (mania == 1)
		{
			if (l1P)
				noteMiss(0);
			else if (uP)
				noteMiss(1);
			else if (r1P)
				noteMiss(2);
			else if (l2P)
				noteMiss(3);
			else if (dP)
				noteMiss(4);
			else if (r2P)
				noteMiss(5);
		}
		else
		{
			if (n0P) noteMiss(0);
			if (n1P) noteMiss(1);
			if (n2P) noteMiss(2);
			if (n3P) noteMiss(3);
			if (n4P) noteMiss(4);
			if (n5P) noteMiss(5);
			if (n6P) noteMiss(6);
			if (n7P) noteMiss(7);
			if (n8P) noteMiss(8);
		}
		updateAccuracy();
	}

	function noteCheck(keyP:Bool, note:Note):Void
	{
		if (keyP)
			goodNoteHit(note);
		else
		{
			if (_variables.spamPrevention)
				badNoteCheck();
		}
	}

	function goodNoteHit(note:Note):Void
	{
		if (!note.wasGoodHit)
		{
			//miss shit ugh haha funny tankman no chicken joke :|
			switch (note.noteType)
			{
				default:
				{
					var altAnim:String = "";
					dad.altAnim = "";
					
					var shaggysing:String = '';
					switch (SONG.player2)
					{
						case 'shaggy':
						{
							if (dad.powerup)
							{
							//	trace ('added "_s" to sing shit');
								shaggysing = '_s';
							}
						}
					}

					if (SONG.notes[Math.floor(curStep / 16)] != null)
					{
						if (SONG.notes[Math.floor(curStep / 16)].altAnim)
						{
							altAnim = '-alt';

							if (SONG.song == 'Sky')
							{
								dad.altAnim = '-alt';
							}
						}
					}

					if (!note.isSustainNote)
					{
						if (_variables.hitsound.toLowerCase() != 'none')
							FlxG.sound.play(Paths.sound('hitsounds/' + _variables.hitsound), _variables.hvolume / 100);
	
						if (_variables.nps)
							notesHitArray.push(Date.now());
						
						popUpScore(note.strumTime, note);
						combo += 1;
					}
		
					if (note.isSustainNote)
						totalNotesHit += 1;

					if (note.noteData >= 0)
					{
						if (_modifiers.HPGainSwitch)
							health += 0.023 * _modifiers.HPGain;
						else
							health += 0.023;
					}
					else
					{
						if (_modifiers.HPGainSwitch)
							health += 0.004 * _modifiers.HPGain;
						else
							health += 0.004;
					}

					if (note.noteType == 4)
					{
						if (SONG.notestyle == 'pixel')
						{
							FlxG.sound.play(Paths.sound('lasersound-pixel'),_variables.svolume/100);
						}
						else
						{
						FlxG.sound.play(Paths.sound('lasersound'),_variables.svolume/100);
						}
					}
		
					var sDir:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];

					if (Main.switchside)
					{
						if (mania == 0)
						{
							sDir = ['RIGHT', 'UP', 'DOWN', 'LEFT'];
						}
						else if (mania == 1)
						{
							sDir = ['RIGHT', 'DOWN', 'LEFT', 'RIGHT', 'UP', 'LEFT'];
						}
						else if (mania == 2)
						{
							sDir = ['RIGHT', 'UP', 'DOWN', 'LEFT', 'UP', 'RIGHT', 'UP', 'DOWN', 'LEFT'];
						}
					}
					else
					{
						if (mania == 0)
						{
							sDir = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
						}
						else if (mania == 1)
						{
							sDir = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
						}
						else if (mania == 2)
						{
							sDir = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'UP', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
						}
					}
					

					if (Main.switchside)
					{
						if (SONG.exDad)
						{
							if (note.dType == 0)
							{ 
								dad2.playAnim('sing' + sDir[note.noteData] + shaggysing + altAnim, true);
								if (SONG.exDad) dad2.holdTimer = 0;
							}
							else if (note.dType == 1) 
							{
								dad.playAnim('sing' + sDir[note.noteData] + shaggysing + altAnim, true);
								dad.holdTimer = 0;
							}
							else if (note.dType == 2)
							{
								dad.playAnim('sing' + sDir[note.noteData] + shaggysing + altAnim, true);
								dad2.playAnim('sing' + sDir[note.noteData] + shaggysing + altAnim, true);
								dad.holdTimer = 0;
								if (SONG.exDad) dad2.holdTimer = 0;
							}			
						}
						else
						{
							dad.playAnim('sing' + sDir[note.noteData] + shaggysing + altAnim, true);
							if (curStage == 'nightbobandbosip') {
								pc.playAnim('sing' + sDir[note.noteData], true);
							}
							dad.holdTimer = 0;
							if (SONG.exDad) dad2.holdTimer = 0;
						}
					}
					else
					{
						if (SONG.exBF)
						{
							if (note.bType == 0)
							{
								boyfriend2.playAnim('sing' + sDir[note.noteData], true); 
								if (SONG.exBF) boyfriend2.holdTimer = 0;
							}
							else if (note.bType == 1) 
							{
								boyfriend.playAnim('sing' + sDir[note.noteData], true);
								boyfriend.holdTimer = 0;
							}
							else if (note.bType == 2)
							{
								boyfriend.playAnim('sing' + sDir[note.noteData], true);
								boyfriend2.playAnim('sing' + sDir[note.noteData], true);
								boyfriend.holdTimer = 0;
								if (SONG.exBF) boyfriend2.holdTimer = 0;
							}			
						}
						else
						{
							boyfriend.playAnim('sing' + sDir[note.noteData], true);
							boyfriend.holdTimer = 0;
							if (SONG.exBF) boyfriend2.holdTimer = 0;
						}
					}
					
					if (Main.switchside)
					{
						switch(dad.curCharacter)
							{
							case 'trickyMask': // 1% chance
								if (FlxG.random.bool(1) && !spookyRendered && !note.isSustainNote) // create spooky text :flushed:
									{
									
										createSpookyText(TrickyLinesSing[FlxG.random.int(0,TrickyLinesSing.length)]);
									
									}
							case 'tricky': // 20% chance
								if (FlxG.random.bool(20) && !spookyRendered && !note.isSustainNote) // create spooky text :flushed:
									{
									
										createSpookyText(TrickyLinesSing[FlxG.random.int(0,TrickyLinesSing.length)]);
									
									}
							case 'trickyH': // 45% chance
								if (FlxG.random.bool(45) && !spookyRendered && !note.isSustainNote) // create spooky text :flushed:
									{
									
										createSpookyText(TrickyLinesSing[FlxG.random.int(0,TrickyLinesSing.length)]);
								
									}
								FlxG.camera.shake(0.02,0.2);
							case 'exTricky': // 60% chance
								if (FlxG.random.bool(60) && !spookyRendered && !note.isSustainNote) // create spooky text :flushed:
									{
									
										createSpookyText(ExTrickyLinesSing[FlxG.random.int(0,ExTrickyLinesSing.length)]);
										
									}
							}
					}
		
					playerStrums.forEach(function(spr:FlxSkewedSprite)
					{
						if (Math.abs(note.noteData) == spr.ID)
						{
							spr.animation.play('confirm', true);
						}
					});
		
					note.wasGoodHit = true;

					if (!ended)
					{
					vocals.volume = _variables.vvolume/100;
					}
					else
					{
					vocals.volume = 0;
					}
		
					if (!note.isSustainNote)
					{
						note.kill();
						notes.remove(note, true);
						note.destroy();
					}
		
					missCounter = 0;
					freezeIndicator.alpha = 0;
		
					updateAccuracy();
				}
				case 1:
				{
					health -= 0.80;
					interupt = true;
					if (!note.isSustainNote)
					{
						note.kill();
						notes.remove(note, true);
						note.destroy();
					}

					playerStrums.forEach(function(spr:FlxSkewedSprite)
						{
							if (Math.abs(note.noteData) == spr.ID)
							{
								spr.animation.play('confirm', true);
							}
						});

					if (health < 0)
					{
						if (SONG.notestyle == 'pixel')
						{
							FlxG.sound.play(Paths.sound('trickydiesound-pixel'),_variables.svolume/100);
						}
						else
						{
							FlxG.sound.play(Paths.sound('trickydiesound'),_variables.svolume/100);
						}
					}

					if (SONG.notestyle == 'pixel')
					{
						FlxG.sound.play(Paths.sound('firenotehitSound-pixel'),_variables.svolume/100);
					}
					else
					{
						FlxG.sound.play(Paths.sound('firenotehitSound'),_variables.svolume/100);
					}			

					trace ('hit fire note dumdum');
				}
				case 2:
				{
					health = -10;
					interupt = true;
					if (!note.isSustainNote)
					{
						note.kill();
						notes.remove(note, true);
						note.destroy();
					}

					playerStrums.forEach(function(spr:FlxSkewedSprite)
					{
						if (Math.abs(note.noteData) == spr.ID)
						{
							spr.animation.play('confirm', true);
						}
					});

					if (health < 0)
					{
						if (SONG.notestyle == 'pixel')
						{
							FlxG.sound.play(Paths.sound('trickydiesound-pixel'),_variables.svolume/100);
						}
						else
						{
							FlxG.sound.play(Paths.sound('trickydiesound'),_variables.svolume/100);
						}
					}

					trace ('hit halo note bruhhhhhhhhh');
				}
				case 5:
				{
					HealthDrain();	
						
					if (SONG.notestyle == 'pixel')
					{
						FlxG.sound.play(Paths.sound('BoomCloud-pixel'),_variables.svolume/100);
					}
					else
					{
					FlxG.sound.play(Paths.sound('BoomCloud'),_variables.svolume/100);
					}

					if (!note.isSustainNote)
					{
						note.kill();
						notes.remove(note, true);
						note.destroy();
					}

					playerStrums.forEach(function(spr:FlxSkewedSprite)
					{
						if (Math.abs(note.noteData) == spr.ID)
						{
							spr.animation.play('confirm', true);
						}
					});
				}
			}
		}
	}

	function moveTank()
	{
		if(!inCutscene)
		{
			tankAngle += FlxG.elapsed * tankSpeed;
			tankRolling.angle = tankAngle - 90 + 15;
			tankRolling.x = tankX + 1500 * Math.cos(Math.PI / 180 * (1 * tankAngle + 180));
			tankRolling.y = 1300 + 1100 * Math.sin(Math.PI / 180 * (1 * tankAngle + 180));
		}
	}

	var fastCarCanDrive:Bool = true;

	function resetFastCar():Void
	{
		fastCar.x = -12600;
		fastCar.y = FlxG.random.int(140, 250);
		fastCar.velocity.x = 0;
		fastCarCanDrive = true;
	}

	function fastCarDrive()
	{
		FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

		fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
		fastCarCanDrive = false;
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			resetFastCar();
		});
	}

	var isbobmad:Bool = true;
	var appearscreen:Bool = true;
	function shakescreen()
	{
		new FlxTimer().start(0.01, function(tmr:FlxTimer)
		{
			Lib.application.window.move(Lib.application.window.x + FlxG.random.int( -10, 10),Lib.application.window.y + FlxG.random.int( -8, 8));
		}, 50);
	}
	function HealthDrain():Void
	{
		FlxG.sound.play(Paths.sound("BoomCloud"), 1);
		boyfriend.playAnim("hit", true);
		FlxG.camera.zoom -= 0.02;
		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			boyfriend.playAnim("idle", true);
		});
		new FlxTimer().start(0.01, function(tmr:FlxTimer)
		{
			health -= 0.005;
		}, 300);
	}
	function resetBobismad():Void
	{
		camHUD.visible = true;
		camNOTEHUD.visible = true;
		camNOTES.visible = true;
		camSus.visible = true;
		camHB.visible = true;
		bobsound.pause();
		bobmadshake.visible = false;
		bobsound.volume = 0;
		isbobmad = true;
	}
	function InvisibleNotes()
	{
		FlxG.sound.play(Paths.sound('Meow'));
		for (note in playerStrums)
			{
				note.visible = false;
			}
		for (note in strumLineNotes)
			{
				note.visible = false;
			}
	}
	function VisibleNotes()
	{
		FlxG.sound.play(Paths.sound('woeM'));
		for (note in playerStrums)
			{
				note.visible = true;
			}
		for (note in strumLineNotes)
			{
				note.visible = true;
			}
	}

	function Bobismad()
	{
		camHUD.visible = false;
		camNOTEHUD.visible = false;
		camNOTES.visible = false;
		camSus.visible = false;
		camHB.visible = false;
		bobmadshake.visible = false;
		bobsound.play();
		bobsound.volume = 1;
		isbobmad = false;
		shakescreen();
		new FlxTimer().start(0.5 , function(tmr:FlxTimer)
		{
			resetBobismad();
		});
	}

	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;

	function trainStart():Void
	{
		trainMoving = true;
		if (!trainSound.playing)
			trainSound.play(true);
	}

	var startedMoving:Bool = false;

	function updateTrainPos():Void
	{
		if (trainSound.time >= 4700)
		{
			startedMoving = true;
			gf.playAnim('hairBlow');
		}

		if (startedMoving)
		{
			phillyTrain.x -= 400;

			if (phillyTrain.x < -2000 && !trainFinishing)
			{
				phillyTrain.x = -1150;
				trainCars -= 1;

				if (trainCars <= 0)
					trainFinishing = true;
			}

			if (phillyTrain.x < -4000 && trainFinishing)
				trainReset();
		}
	}

	function trainReset():Void
	{
		gf.playAnim('hairFall');
		phillyTrain.x = FlxG.width + 200;
		trainMoving = false;
		// trainSound.stop();
		// trainSound.time = 0;
		trainCars = 8;
		trainFinishing = false;
		startedMoving = false;
	}

	function lightningStrikeShit():Void
	{
		FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
		halloweenBG.animation.play('lightning');

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);

		boyfriend.playAnim('scared', true);
		gf.playAnim('scared', true);
	}

	var resetSpookyText:Bool = true;

	function resetSpookyTextManual():Void
	{
		trace('reset spooky');
		spookySteps = curStep;
		spookyRendered = true;
		tstatic.alpha = 0.5;
		FlxG.sound.play(Paths.sound('staticSound'));
		resetSpookyText = true;
	}

	function manuallymanuallyresetspookytextmanual()
	{
		remove(spookyText);
		spookyRendered = false;
		tstatic.alpha = 0;
	}

	var stepOfLast = 0;

	override function stepHit()
	{
		super.stepHit();
		if (FlxG.sound.music.time > Conductor.songPosition + 20 || FlxG.sound.music.time < Conductor.songPosition - 20)
		{
			resyncVocals();
		}

		if (!Main.exMode) {
			if (curSong.toLowerCase() == 'split' && curStep == 124 && camZooming || curSong.toLowerCase() == 'split' && curStep == 126 && camZooming || curSong.toLowerCase() == 'split' && curStep == 1144 && camZooming || curSong.toLowerCase() == 'split' && curStep == 1147 && camZooming || curSong.toLowerCase() == 'split' && curStep == 1150 && camZooming)
			{
		
				FlxG.camera.zoom += 0.05;
				camHB.zoom += 0.01;
				camHUD.zoom += 0.01;
				camNOTEHUD.zoom += 0.01;
				camNOTES.zoom += 0.01;
				camSus.zoom += 0.01;
			}
		}

		// Animations for Vs impostor
		if (curStep == 1802 && curSong == 'Sussus-Moogus')
            {
                gf.playAnim('dead', false);

            }
		if (curStep == 1794 && curSong == 'Sussus-Moogus')
            {
                dad.playAnim('shoot1', false);
            }
		if (curStep == 1620 && curSong == 'Sabotage')
            {
				FlxG.sound.play(Paths.soundRandom('gunshot', 0, 15));
                dad.playAnim('shoot2', false);
            }
		if (curStep == 1640 && curSong == 'Sabotage')
            {
                boyfriend.playAnim('scaredamong', false);
            }
		if (curStep == 1647 && curSong == 'Sabotage')
            {
                boyfriend.playAnim('deadamong', false);
			}
		if (curStep == 1647 && curSong == 'Sabotage')
			{
					boyfriend.playAnim('deadamong', false);
			}
        if (curStep == 2048 && curSong == 'Meltdown')
            {
                boyfriend.playAnim('hey', false);

            }
		if (curStep == 1812 && curSong == 'Sussus-Moogus')
            {
                dad.playAnim('idle', true);
			}

		// EX TRICKY HARD CODED EVENTS

		if (curStage == 'auditorHell' && curStep != stepOfLast)
			{
				switch(curStep)
				{
					case 384:
						doStopSign(0);
					case 511:
						doStopSign(2);
						doStopSign(0);
					case 610:
						doStopSign(3);
					case 720:
						doStopSign(2);
					case 991:
						doStopSign(3);
					case 1184:
						doStopSign(2);
					case 1218:
						doStopSign(0);
					case 1235:
						doStopSign(0, true);
					case 1200:
						doStopSign(3);
					case 1328:
						doStopSign(0, true);
						doStopSign(2);
					case 1439:
						doStopSign(3, true);
					case 1567:
						doStopSign(0);
					case 1584:
						doStopSign(0, true);
					case 1600:
						doStopSign(2);
					case 1706:
						doStopSign(3);
					case 1917:
						doStopSign(0);
					case 1923:
						doStopSign(0, true);
					case 1927:
						doStopSign(0);
					case 1932:
						doStopSign(0, true);
					case 2032:
						doStopSign(2);
						doStopSign(0);
					case 2036:
						doStopSign(0, true);
					case 2162:
						doStopSign(2);
						doStopSign(3);
					case 2193:
						doStopSign(0);
					case 2202:
						doStopSign(0,true);
					case 2239:
						doStopSign(2,true);
					case 2258:
						doStopSign(0, true);
					case 2304:
						doStopSign(0, true);
						doStopSign(0);	
					case 2326:
						doStopSign(0, true);
					case 2336:
						doStopSign(3);
					case 2447:
						doStopSign(2);
						doStopSign(0, true);
						doStopSign(0);	
					case 2480:
						doStopSign(0, true);
						doStopSign(0);	
					case 2512:
						doStopSign(2);
						doStopSign(0, true);
						doStopSign(0);
					case 2544:
						doStopSign(0, true);
						doStopSign(0);	
					case 2575:
						doStopSign(2);
						doStopSign(0, true);
						doStopSign(0);
					case 2608:
						doStopSign(0, true);
						doStopSign(0);	
					case 2604:
						doStopSign(0, true);
					case 2655:
						doGremlin(20,13,true);
				}
				stepOfLast = curStep;
			}
	
			if (spookyRendered && spookySteps + 3 < curStep)
			{
				if (resetSpookyText)
				{
					remove(spookyText);
					spookyRendered = false;
				}
				tstatic.alpha = 0;
				if (curStage == 'auditorHell')
					tstatic.alpha = 0.1;
			}
			if(curStage.toLowerCase() == 'tankstress')
				{
		
					
		
		
					//RIGHT
		
					if (curStep == 2 || 
						curStep == 3 || 
						curStep == 5 || 
						curStep == 9 || 
						curStep == 10 || 
						curStep == 16 || 
						curStep == 22 || 
						curStep == 25 || 
						curStep == 26 || 
						curStep == 34 || 
						curStep == 35 || 
						curStep == 37 || 
						curStep == 41 || 
						curStep == 42 || 
						curStep == 48 || 
						curStep == 54 || 
						curStep == 57 || 
						curStep == 58 || 
						curStep == 66 || 
						curStep == 67 || 
						curStep == 69 || 
						curStep == 73 || 
						curStep == 74 || 
						curStep == 80 || 
						curStep == 86 || 
						curStep == 89 || 
						curStep == 90 || 
						curStep == 98 || 
						curStep == 99 || 
						curStep == 101 || 
						curStep == 105 ||
						 curStep == 106 || 
						 curStep == 112 || 
						 curStep == 118 || 
						 curStep == 121 || 
						 curStep == 122 || 
						 curStep == 253 || 
						 curStep == 260 || 
						 curStep == 268 || 
						 curStep == 280 || 
						 curStep == 284 || 
						 curStep == 292 || 
						 curStep == 300 || 
						 curStep == 312 || 
						 curStep == 316 || 
						 curStep == 317 || 
						 curStep == 318 || 
						 curStep == 320 || 
						 curStep == 332 || 
						 curStep == 336 || 
						 curStep == 344 || 
						 curStep == 358 || 
						 curStep == 360 || 
						 curStep == 362 || 
						 curStep == 364 || 
						 curStep == 372 || 
						 curStep == 376 || 
						 curStep == 388 || 
						 curStep == 396 || 
						 curStep == 404 || 
						 curStep == 408 || 
						 curStep == 412 || 
						 curStep == 420 || 
						 curStep == 428 || 
						 curStep == 436 || 
						 curStep == 440 || 
						 curStep == 444 || 
						 curStep == 452 || 
						 curStep == 456 || 
						 curStep == 460 || 
						 curStep == 468 || 
						 curStep == 472 || 
						 curStep == 476 || 
						 curStep == 484 || 
						 curStep == 488 || 
						 curStep == 492 || 
						 curStep == 508 || 
						 curStep == 509 || 
						 curStep == 510 || 
						 curStep == 516 || 
						 curStep == 520 || 
						 curStep == 524 || 
						 curStep == 532 || 
						 curStep == 540 || 
						 curStep == 552 || 
						 curStep == 556 || 
						 curStep == 564 || 
						 curStep == 568 || 
						 curStep == 572 || 
						 curStep == 580 || 
						 curStep == 584 || 
						 curStep == 588 || 
						 curStep == 596 || 
						 curStep == 604 || 
						 curStep == 612 || 
						 curStep == 616 || 
						 curStep == 620 || 
						 curStep == 636 || 
						 curStep == 637 || 
						 curStep == 638 || 
						 curStep == 642 || 
						 curStep == 643 || 
						 curStep == 645 || 
						 curStep == 649 || 
						 curStep == 650 || 
						 curStep == 656 || 
						 curStep == 662 || 
						 curStep == 665 || 
						 curStep == 666 || 
						 curStep == 674 || 
						 curStep == 675 || 
						 curStep == 677 || 
						 curStep == 681 || 
						 curStep == 682 || 
						 curStep == 688 || 
						 curStep == 694 || 
						 curStep == 697 || 
						 curStep == 698 || 
						 curStep == 706 || 
						 curStep == 707 || 
						 curStep == 709 || 
						 curStep == 713 || 
						 curStep == 714 || 
						 curStep == 720 || 
						 curStep == 726 || 
						 curStep == 729 || 
						 curStep == 730 || 
						 curStep == 738 || 
						 curStep == 739 || 
						 curStep == 741 || 
						 curStep == 745 || 
						 curStep == 746 || 
						 curStep == 753 || 
						 curStep == 758 || 
						 curStep == 761 || 
						 curStep == 762 || 
						 curStep == 768 || 
						 curStep == 788 || 
						 curStep == 792 || 
						 curStep == 796 || 
						 curStep == 800 || 
						 curStep == 820 || 
						 curStep == 824 || 
						 curStep == 828 || 
						 curStep == 829 || 
						 curStep == 830 || 
						 curStep == 832 || 
						 curStep == 852 || 
						 curStep == 856 || 
						 curStep == 860 || 
						 curStep == 861 || 
						 curStep == 862 || 
						 curStep == 864 || 
						 curStep == 865 || 
						 curStep == 866 || 
						 curStep == 884 || 
						 curStep == 885 || 
						 curStep == 886 || 
						 curStep == 887 || 
						 curStep == 892 || 
						 curStep == 900 || 
						 curStep == 912 || 
						 curStep == 916 || 
						 curStep == 924 || 
						 curStep == 926 || 
						 curStep == 936 || 
						 curStep == 948 || 
						 curStep == 958 || 
						 curStep == 962 || 
						 curStep == 966 || 
						 curStep == 970 || 
						 curStep == 974 || 
						 curStep == 976 || 
						 curStep == 980 || 
						 curStep == 984 || 
						 curStep == 988 || 
						 curStep == 990 || 
						 curStep == 1000 || 
						 curStep == 1004 || 
						 curStep == 1006 || 
						 curStep == 1008 || 
						 curStep == 1012 || 
						 curStep == 1019 || 
						 curStep == 1028 || 
						 curStep == 1036 || 
						 curStep == 1044 || 
						 curStep == 1052|| 
						 curStep == 1060 || 
						 curStep == 1068 || 
						 curStep == 1076 || 
						 curStep == 1084 || 
						 curStep == 1092 || 
						 curStep == 1100 || 
						 curStep == 1108 || 
						 curStep == 1116 || 
						 curStep == 1124 || 
						 curStep == 1132 || 
						 curStep == 1148 || 
						 curStep == 1149 || 
						 curStep == 1150 || 
						 curStep == 1156 || 
						 curStep == 1160 || 
						 curStep == 1164 || 
						 curStep == 1172 || 
						 curStep == 1180 || 
						 curStep == 1188 || 
						 curStep == 1192 || 
						 curStep == 1196 || 
						 curStep == 1204 || 
						 curStep == 1208 || 
						 curStep == 1212 || 
						 curStep == 1220 || 
						 curStep == 1224 || 
						 curStep == 1228 || 
						 curStep == 1236 || 
						 curStep == 1244 || 
						 curStep == 1252 || 
						 curStep == 1256 || 
						 curStep == 1260 || 
						 curStep == 1276 || 
						 curStep == 1296 || 
						 curStep == 1300 || 
						 curStep == 1304 || 
						 curStep == 1308 || 
						 curStep == 1320 || 
						 curStep == 1324 || 
						 curStep == 1328 || 
						 curStep == 1332 || 
						 curStep == 1340 || 
						 curStep == 1352 || 
						 curStep == 1358 || 
						 curStep == 1364 || 
						 curStep == 1372 || 
						 curStep == 1374 || 
						 curStep == 1378 || 
						 curStep == 1388 || 
						 curStep == 1392 || 
						 curStep == 1400 || 
						 curStep == 1401 || 
						 curStep == 1405 || 
						 curStep == 1410 || 
						 curStep == 1411 || 
						 curStep == 1413 || 
						 curStep == 1417 || 
						 curStep == 1418 || 
						 curStep == 1424 || 
						 curStep == 1430 || 
						 curStep == 1433 || 
						 curStep == 1434)
						 
					{
						gf.playAnim('shoot' + FlxG.random.int(1, 2), true);
						
						var tankmanRunner:TankmenBG = new TankmenBG();
						
						
						
						
						
					}
		
					//LEFT
					if (curStep == 0 || 
						curStep == 7 || 
						curStep == 12 || 
						curStep == 14 || 
						curStep == 15 || 
						curStep == 18 || 
						curStep == 19 || 
						curStep == 24 || 
						curStep == 28 || 
						curStep == 32 || 
						curStep == 39 || 
						curStep == 44 || 
						curStep == 46 || 
						curStep == 47 || 
						curStep == 50 || 
						curStep == 51 || 
						curStep == 56 || 
						curStep == 60 || 
						curStep == 61 || 
						curStep == 62 || 
						curStep == 64 || 
						curStep == 71 || 
						curStep == 76 || 
						curStep == 78 || 
						curStep == 79 || 
						curStep == 82 || 
						curStep == 83 || 
						curStep == 88 || 
						curStep == 92 || 
						curStep == 96 || 
						curStep == 103 ||
						 curStep == 108 || 
						 curStep == 110 || 
						 curStep == 111 || 
						 curStep == 114 || 
						 curStep == 115 || 
						 curStep == 120 || 
						 curStep == 124 || 
						 curStep == 252 || 
						 curStep == 254 || 
						 curStep == 256 || 
						 curStep == 264 || 
						 curStep == 272 || 
						 curStep == 276 || 
						 curStep == 288 || 
						 curStep == 296 || 
						 curStep == 304 || 
						 curStep == 308 || 
						 curStep == 324 || 
						 curStep == 328 || 
						 curStep == 340 || 
						 curStep == 348 || 
						 curStep == 352 || 
						 curStep == 354 || 
						 curStep == 356 || 
						 curStep == 366 || 
						 curStep == 368 || 
						 curStep == 378 || 
						 curStep == 384 || 
						 curStep == 392 || 
						 curStep == 394 || 
						 curStep == 400 || 
						 curStep == 410 || 
						 curStep == 416 || 
						 curStep == 424 || 
						 curStep == 426 || 
						 curStep == 432 || 
						 curStep == 442 || 
						 curStep == 448 || 
						 curStep == 458 || 
						 curStep == 464 || 
						 curStep == 474 || 
						 curStep == 480 || 
						 curStep == 490 || 
						 curStep == 496 || 
						 curStep == 500 || 
						 curStep == 504 || 
						 curStep == 506 || 
						 curStep == 512 || 
						 curStep == 522 || 
						 curStep == 528 || 
						 curStep == 536 || 
						 curStep == 538 || 
						 curStep == 544 || 
						 curStep == 554 || 
						 curStep == 560 || 
						 curStep == 570 || 
						 curStep == 576 || 
						 curStep == 586 || 
						 curStep == 592 || 
						 curStep == 600 || 
						 curStep == 602 || 
						 curStep == 608 || 
						 curStep == 618 || 
						 curStep == 624 || 
						 curStep == 628 || 
						 curStep == 632 || 
						 curStep == 634 || 
						 curStep == 640 || 
						 curStep == 647 || 
						 curStep == 652 || 
						 curStep == 654 || 
						 curStep == 655 || 
						 curStep == 658 || 
						 curStep == 659 || 
						 curStep == 664 || 
						 curStep == 668 || 
						 curStep == 672 || 
						 curStep == 679 || 
						 curStep == 684 || 
						 curStep == 686 || 
						 curStep == 687 || 
						 curStep == 690 || 
						 curStep == 691 || 
						 curStep == 696 || 
						 curStep == 700 || 
						 curStep == 701 || 
						 curStep == 702 || 
						 curStep == 704 || 
						 curStep == 711 || 
						 curStep == 716 || 
						 curStep == 718 || 
						 curStep == 719 || 
						 curStep == 722 || 
						 curStep == 723 || 
						 curStep == 728 || 
						 curStep == 732 || 
						 curStep == 736 || 
						 curStep == 743 || 
						 curStep == 748 || 
						 curStep == 750 || 
						 curStep == 751 || 
						 curStep == 754 || 
						 curStep == 755 || 
						 curStep == 760 || 
						 curStep == 764 || 
						 curStep == 772 || 
						 curStep == 776 || 
						 curStep == 780 || 
						 curStep == 784 || 
						 curStep == 804 || 
						 curStep == 808 || 
						 curStep == 812 || 
						 curStep == 816 || 
						 curStep == 836 || 
						 curStep == 840 || 
						 curStep == 844 || 
						 curStep == 848 || 
						 curStep == 868 || 
						 curStep == 869 || 
						 curStep == 870 || 
						 curStep == 872 || 
						 curStep == 873 || 
						 curStep == 874 || 
						 curStep == 876 || 
						 curStep == 877 || 
						 curStep == 878 || 
						 curStep == 880 || 
						 curStep == 881 || 
						 curStep == 882 || 
						 curStep == 883 || 
						 curStep == 888 || 
						 curStep == 889 || 
						 curStep == 890 || 
						 curStep == 891 || 
						 curStep == 896 || 
						 curStep == 904 || 
						 curStep == 908 || 
						 curStep == 920 || 
						 curStep == 928 || 
						 curStep == 932 || 
						 curStep == 940 || 
						 curStep == 944 || 
						 curStep == 951 || 
						 curStep == 952 || 
						 curStep == 953 || 
						 curStep == 955 || 
						 curStep == 960 || 
						 curStep == 964 || 
						 curStep == 968 || 
						 curStep == 972 || 
						 curStep == 978 || 
						 curStep == 982 || 
						 curStep == 986 || 
						 curStep == 992 || 
						 curStep == 994 || 
						 curStep == 996 || 
						 curStep == 1016 || 
						 curStep == 1017 || 
						 curStep == 1021 || 
						 curStep == 1024 || 
						 curStep == 1034 || 
						 curStep == 1040 || 
						 curStep == 1050 || 
						 curStep == 1056 || 
						 curStep == 1066 || 
						 curStep == 1072 || 
						 curStep == 1082 || 
						 curStep == 1088 || 
						 curStep == 1098 || 
						 curStep == 1104 || 
						 curStep == 1114 || 
						 curStep == 1120 || 
						 curStep == 1130 || 
						 curStep == 1136 || 
						 curStep == 1140 || 
						 curStep == 1144 || 
						 curStep == 1146 || 
						 curStep == 1152 || 
						 curStep == 1162 || 
						 curStep == 1168 || 
						 curStep == 1176 || 
						 curStep == 1178 || 
						 curStep == 1184 || 
						 curStep == 1194 || 
						 curStep == 1200 || 
						 curStep == 1210 || 
						 curStep == 1216 || 
						 curStep == 1226 || 
						 curStep == 1232 || 
						 curStep == 1240 || 
						 curStep == 1242 || 
						 curStep == 1248 || 
						 curStep == 1258 || 
						 curStep == 1264 || 
						 curStep == 1268 || 
						 curStep == 1272 || 
						 curStep == 1280 || 
						 curStep == 1284 || 
						 curStep == 1288 || 
						 curStep == 1292 || 
						 curStep == 1312 || 
						 curStep == 1314 || 
						 curStep == 1316 || 
						 curStep == 1336 || 
						 curStep == 1344 || 
						 curStep == 1356 || 
						 curStep == 1360 || 
						 curStep == 1368 || 
						 curStep == 1376 || 
						 curStep == 1380 || 
						 curStep == 1384 || 
						 curStep == 1396 || 
						 curStep == 1404 || 
						 curStep == 1408 || 
						 curStep == 1415 || 
						 curStep == 1420 || 
						 curStep == 1422 || 
						 curStep == 1423 || 
						 curStep == 1426 || 
						 curStep == 1427 || 
						 curStep == 1432 || 
						 curStep == 1436 || 
						 curStep == 1437 || 
						 curStep == 1438)
					{
						gf.playAnim('shoot' + FlxG.random.int(3, 4), true);
						
		
							
						
						
						
						
					}
		
		
		
					//Left spawn
		
					if (curStep == 2 || 
						
						curStep == 9 || 
						
						curStep == 22 || 
						
						curStep == 34 || 
						
						curStep == 41 || 
						
						curStep == 54 || 
						
						curStep == 66 || 
						 
						curStep == 73 || 
						
						curStep == 86 || 
						
						curStep == 98 || 
						
						curStep == 105 ||
						  
						 curStep == 118 || 
						 
						 curStep == 253 || 
						  
						 curStep == 280 || 
						 
						 curStep == 300 || 
						 
						 curStep == 317 || 
						  
						 curStep == 332 || 
						  
						 curStep == 358 || 
						  
						 curStep == 364 || 
						  
						 curStep == 388 || 
						 
						 curStep == 408 || 
						  
						 curStep == 428 || 
						  
						 curStep == 444 || 
						  
						 curStep == 460 || 
						 
						 curStep == 476 || 
						 
						 curStep == 492 || 
						  
						 curStep == 510 || 
						 
						 curStep == 524 || 
						  
						 curStep == 552 || 
						 
						 curStep == 568 || 
						  
						 curStep == 584 || 
						  
						 curStep == 604 || 
						 
						 curStep == 620 || 
						 
						 curStep == 638 || 
						 
						 curStep == 645 || 
						  
						 curStep == 656 || 
						 
						 curStep == 666 || 
						  
						 curStep == 677 || 
						  
						 curStep == 688 || 
						 
						 curStep == 698 || 
						  
						 curStep == 709 || 
						 
						 curStep == 720 || 
						  
						 curStep == 730 || 
						 
						 curStep == 741 || 
						  
						 curStep == 753 || 
						 
						 curStep == 762 || 
						 
						 curStep == 792 || 
						 
						 curStep == 820 || 
						  
						 curStep == 829 || 
						 
						 curStep == 852 || 
						  
						 curStep == 861 || 
						 
						 curStep == 865 || 
						 
						 curStep == 885 || 
						 
						 curStep == 892 || 
						  
						 curStep == 916 || 
						  
						 curStep == 936 || 
						 
						 curStep == 962 || 
						 
						 curStep == 974 || 
						 
						 curStep == 984 || 
						 
						 curStep == 1000 || 
						 
						 curStep == 1008 || 
						  
						 curStep == 1028 || 
						 
						 curStep == 1052|| 
						 
						 curStep == 1076 || 
						 
						 curStep == 1100 || 
						  
						 curStep == 1124 || 
						  
						 curStep == 1149 || 
						 
						 curStep == 1160 || 
						 
						 curStep == 1180 
						  
						 
						 )
						 
					{
						
						
						var tankmanRunner:TankmenBG = new TankmenBG();
						tankmanRunner.resetShit(FlxG.random.int(630, 730) * -1, 265, true, 1, 1.5);
		
						tankmanRun.add(tankmanRunner);
						
						
						
						
					}
		
					//Right spawn
					if (curStep == 0 || 
						
						curStep == 14 || 
						
						curStep == 19 || 
						
						curStep == 32 || 
						
						curStep == 46 || 
						
						curStep == 51 || 
						
						curStep == 61 || 
						 
						curStep == 71 || 
						
						curStep == 79 || 
						
						curStep == 88 || 
						
						curStep == 103 ||
						  
						 curStep == 111 || 
						 
						 curStep == 120 || 
						 
						 curStep == 254 || 
						 
						 curStep == 272 || 
						 
						 curStep == 296 || 
						  
						 curStep == 324 || 
						 
						 curStep == 348 || 
						 
						 curStep == 356 || 
						 
						 curStep == 378 || 
						  
						 curStep == 394 || 
						 
						 curStep == 416 || 
						  
						 curStep == 432 || 
						 
						 curStep == 458 || 
						 
						 curStep == 480 || 
						 
						 curStep == 500 || 
						 
						 curStep == 512 || 
						 
						 curStep == 536 || 
						 
						 curStep == 554 || 
						  
						 curStep == 576 || 
						 
						 curStep == 600 || 
						 
						 curStep == 618 || 
						  
						 curStep == 632 || 
						 
						 curStep == 647 || 
						 
						 curStep == 655 || 
						 
						 curStep == 664 || 
						 
						 curStep == 679 || 
						 
						 curStep == 687 || 
						 
						 curStep == 696 || 
						 
						 curStep == 702 || 
						 
						 curStep == 716 || 
						 
						 curStep == 722 || 
						 
						 curStep == 732 || 
						 
						 curStep == 748 || 
						 
						 curStep == 754 || 
						 
						 curStep == 764 || 
						 
						 curStep == 780 || 
						 
						 curStep == 808 || 
						 
						 curStep == 836 || 
						 
						 curStep == 848 || 
						 
						 curStep == 870 || 
						 
						 curStep == 874 || 
						 
						 curStep == 878 || 
						 
						 curStep == 882 || 
						 
						 curStep == 889 || 
						 
						 curStep == 896 || 
						 
						 curStep == 920 || 
						 
						 curStep == 940 || 
						 
						 curStep == 952 || 
						 
						 curStep == 960 || 
						 
						 curStep == 972 || 
						 
						 curStep == 986 || 
						 
						 curStep == 996 || 
						 
						 curStep == 1021 || 
						 
						 curStep == 1040 || 
						 
						 curStep == 1066 || 
						 
						 curStep == 1088 || 
						 
						 curStep == 1114 || 
						 
						 curStep == 1136 || 
						 
						 curStep == 1146 || 
						 
						 curStep == 1168 || 
						 
						 curStep == 1184
						
						 
						 )
					{
						
						
		
							
						var tankmanRunner:TankmenBG = new TankmenBG();
						tankmanRunner.resetShit(FlxG.random.int(1500, 1700) * 1, 285, false, 1, 1.5);
						tankmanRun.add(tankmanRunner);
						
						
						
					}
				}
	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;
	var lastBeatT:Int = 0;
	var lastBeatDadT:Int = 0;
	var beatOfFuck:Int = 0;

	function bgFlash():Void
	{
		//oops im stupid so commented out the tweening version
		//flashSprite.alpha = 0;
		//FlxTween.tween(flashSprite.alpha, 0.4, 0.15);
		trace('BG FLASH FUNNY');
		flashSprite.alpha = 0.4;
	}

	public function focusOut()
	{
		if (paused)
			return;
		persistentUpdate = false;
		persistentDraw = true;
		paused = true;

		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.pause();
			vocals.pause();
		}

		openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
	}

	public function focusIn()
	{
		// nada
	}

	public function backgroundVideo(source:String) // for background videos
	{
		#if desktop
		useVideo = true;

		FlxG.stage.window.onFocusOut.add(focusOut);
		FlxG.stage.window.onFocusIn.add(focusIn);

		var ourSource:String = "assets/videos/DO NOT DELETE OR GAME WILL CRASH/dontDelete.webm";
		//WebmPlayer.SKIP_STEP_LIMIT = 90;
		var str1:String = "WEBM SHIT";
		webmHandler = new WebmHandler();
		webmHandler.source(ourSource);
		webmHandler.makePlayer();
		webmHandler.webm.name = str1;

		BackgroundVideo.setWebm(webmHandler);

		BackgroundVideo.get().source(source);
		BackgroundVideo.get().clearPause();
		if (BackgroundVideo.isWebm)
		{
			BackgroundVideo.get().updatePlayer();
		}
		BackgroundVideo.get().show();

		if (BackgroundVideo.isWebm)
		{
			BackgroundVideo.get().restart();
		}
		else
		{
			BackgroundVideo.get().play();
		}

		var data = webmHandler.webm.bitmapData;

		videoSprite = new FlxSprite(0, 0).loadGraphic(data);

		//videoSprite.setGraphicSize(Std.int(videoSprite.width * 1.2));
		videoSprite.scrollFactor.set();
		videoSprite.cameras = [camHUD];
		remove(gf);
		remove(boyfriend);
		remove(dad);
		add(videoSprite);
		add(gf);
		add(boyfriend);
		add(dad);

		trace('poggers');

		if (!songStarted)
			webmHandler.pause();
		else
			webmHandler.resume();
		#end
	}

	public function makeBackgroundTheVideo(source:String) // for background videos
	{
		#if desktop
		useVideo = true;

		FlxG.stage.window.onFocusOut.add(focusOut);
		FlxG.stage.window.onFocusIn.add(focusIn);

		var ourSource:String = "assets/videos/DO NOT DELETE OR GAME WILL CRASH/dontDelete.webm";
		//WebmPlayer.SKIP_STEP_LIMIT = 90;
		var str1:String = "WEBM SHIT";
		webmHandler = new WebmHandler();
		webmHandler.source(ourSource);
		webmHandler.makePlayer();
		webmHandler.webm.name = str1;

		BackgroundVideo.setWebm(webmHandler);

		BackgroundVideo.get().source(source);
		BackgroundVideo.get().clearPause();
		if (BackgroundVideo.isWebm)
		{
			BackgroundVideo.get().updatePlayer();
		}
		BackgroundVideo.get().show();

		if (BackgroundVideo.isWebm)
		{
			BackgroundVideo.get().restart();
		}
		else
		{
			BackgroundVideo.get().play();
		}

		var data = webmHandler.webm.bitmapData;

		videoSprite = new FlxSprite(0, 0).loadGraphic(data);

		videoSprite.setGraphicSize(Std.int(videoSprite.width * 1.4));
		videoSprite.scrollFactor.set();
		//videoSprite.cameras = [camHUD];
		remove(gf);
		remove(boyfriend);
		remove(dad);
		add(videoSprite);
		add(gf);
		add(boyfriend);
		add(dad);

		trace('poggers');

		if (!songStarted)
			webmHandler.pause();
		else
			webmHandler.resume();
		#end
	}

	override function beatHit()
	{
		super.beatHit();

		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, FlxSort.DESCENDING);
		}

		if (curStage == 'nevadaSpook')
			hank.animation.play('dance');

		if (curStage == 'auditorHell')
		{
			if (curBeat % 8 == 4 && beatOfFuck != curBeat)
			{
				beatOfFuck = curBeat;
				doClone(FlxG.random.int(0,1));
			}
		}

		if(curStage == 'meltdown')
			{
				crowd.dance();
			}

		var sussusBeats = [94, 95, 288, 296, 304, 312, 318, 319];
		var saboBeats = [16, 24, 32, 40, 48, 56, 62, 63, 272, 280, 288, 296, 302, 303, 376, 384, 892];
		var meltBeats = [0, 16, 32, 48, 64, 72, 80, 88, 96, 104, 112, 120, 126, 127, 200, 208, 216, 224, 232, 240, 248, 256, 272, 288, 304, 320, 336, 352, 368, 382, 464, 480, 496, 512];
		var _b = 0;
		//FlxG.watch.addQuick("Flash Timer", _cb); debug stuff

		add(flashSprite);
		flashSprite.alpha = 0;
		flashSprite.scrollFactor.set(0, 0);

		if(curSong == 'Sussus-Moogus') // sussus flashes
		{
			
			if(curBeat == 97 || curBeat == 192 || curBeat == 320)
				_cb = 1;
				if(curBeat > 98 && curBeat < 160 || curBeat > 192 && curBeat < 224 || curBeat > 320 && curBeat < 382 || curBeat == 98 || curBeat == 160 || curBeat == 192 || curBeat == 224 || curBeat == 320 || curBeat == 382)
				{
					_cb++;
					if(_cb == 2)
					{
						bgFlash();
						_cb = 0;
					}
				}
			while(_b < sussusBeats.length) {
			var susflash = sussusBeats[_b];
				++_b;
				if(curBeat == susflash)
				{
					bgFlash();
				}
			}
		}
		if(curSong == 'Sabotage') // sabotage flashes
		{
			while(_b < saboBeats.length) {
				var sabflash = saboBeats[_b];
					++_b;
					if(curBeat == sabflash)
					{
						bgFlash();
					}
				}

				if(curBeat == 63 || curBeat == 304)
					_cb = 3;
				if(curBeat > 64 && curBeat < 124 || curBeat > 304 && curBeat < 370 || curBeat == 64 || curBeat == 124 || curBeat == 304 || curBeat == 370)
				{
					_cb++;
					if(_cb == 4)
					{
						bgFlash();
						_cb = 0;
					}
				}
		}
		if (curSong == 'Meltdown') // meltdown flashes
		{
			while(_b < meltBeats.length) {
				var meltflash = meltBeats[_b];
				++_b;
				if(curBeat == meltflash)
				{
					bgFlash();
				}
			}
			if(curBeat == 127)
				_cb = 3;
			if(curBeat == 382)
				_cb = 1;
			if(curBeat > 128 && curBeat < 192 || curBeat > 382 && curBeat < 448 || curBeat == 128 || curBeat == 192 || curBeat == 382 || curBeat == 448)
			{
				_cb++;
				if(_cb == 4)
				{
					bgFlash();
					_cb = 0;
				}
			}
		}
		//bobandbosip
		if (curBeat % 2 == 0) {
			if (curStage == 'ITB'){
				switch (SONG.song.toLowerCase()) {
					case 'intertwined':
						mini.animation.play('idle', true);
						mordecai.animation.play('idle', true);
						thirdBop.animation.play('idle', true);
					case 'yap-squad':
						mini.animation.play('idle', true);
						mordecai.animation.play('idle', true);
					case 'conscience':
						mordecai.animation.play('idle', true);
				}
			}
		}
		if (curStage == 'nightbobandbosip') {
			mini.animation.play('idle', true);
		}
		if (curStage == 'sunsetbobandbosip') {
			mini.animation.play('idle', true);
			mordecai.animation.play('idle', true);
		}
		if (curStage == 'daybobandbosip') {
			mini.animation.play('idle', true);
			if (stopWalkTimer == 0) {
				if (walkingRight)
					mordecai.flipX = false;
				else
					mordecai.flipX = true;
				if (walked)
					mordecai.animation.play('walk1');
				else
					mordecai.animation.play('walk2');
				if (walkingRight)
					mordecai.x += 10;
				else
					mordecai.x -= 10;
				walked = !walked;
				trace(mordecai.x);
				if (mordecai.x == 480 && walkingRight) { 
					stopWalkTimer = 10;
					walkingRight = false;
				} else if (mordecai.x == -80 && !walkingRight) { 
					stopWalkTimer = 8;
					walkingRight = true;
				}
			} else 
				stopWalkTimer--;
		}

		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				if (_modifiers.VibeSwitch)
				{
					switch (_modifiers.Vibe)
					{
					case 0.6:
						Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm * 1.4); // :(
					case 0.8:
						Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm * 1.2); // :(
					case 1.2:
						Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm * 0.7); // :(
					case 1.4:
						Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm * 0.64); // :(
					}
				}
				else
					Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);

				FlxG.log.add('CHANGED BPM!');
			}
			// else
			// Conductor.changeBPM(SONG.bpm);
			// Dad doesnt interupt his own notes
			if (SONG.notes[Math.floor(curStep / 16)].mustHitSection)
			{
				//nada
			}
		}
		// FlxG.log.add('change bpm' + SONG.notes[Std.int(curStep / 16)].changeBPM);
		wiggleShit.update(Conductor.crochet);

		// HARDCODING FOR MILF ZOOMS!
		if (curSong.toLowerCase() == 'milf' && curBeat >= 168 && curBeat < 200 && camZooming && FlxG.camera.zoom < 1.35)
		{
			FlxG.camera.zoom += 0.015;
			camHB.zoom += 0.03;
			camHUD.zoom += 0.03;
			camNOTES.zoom += 0.03;
			camSus.zoom += 0.03;
			camNOTEHUD.zoom += 0.03;
		}

		if (splitCamMode) {
			defaultCamZoom = 0.65;
			if (splitExtraZoom)
				defaultCamZoom = 0.75;
		}

		if (splitMode) {
			if (curStage.toLowerCase() == 'nightbobandbosip')
			{
				for (spr in theEntireFuckingStage) {
					spr.color = FlxColor.fromHSL(spr.color.hue, spr.color.saturation, 0.7, 1);
				}
			}

			nightbobandbosipLights.forEach(function(light:FlxSprite)
			{
				light.visible = false;
			});

			coolGlowyLights.forEach(function(light:FlxSprite)
			{
				light.visible = false;
			});

			coolGlowyLightsMirror.forEach(function(light:FlxSprite)
			{
				light.visible = false;
			});

			curLight++;
			if (curLight > nightbobandbosipLights.length - 1)
				curLight = 0;

			nightbobandbosipLights.members[curLight].visible = true;
			nightbobandbosipLights.members[curLight].alpha = 1;

			coolGlowyLights.members[curLight].visible = true;
			coolGlowyLights.members[curLight].alpha = 0.8;

			FlxTween.tween(nightbobandbosipLights.members[curLight], {alpha: 0}, 0.3, {
			});
			FlxTween.tween(coolGlowyLights.members[curLight], {alpha: 0}, 0.3, {
			});
			if (!splitCamMode)
				defaultCamZoom = 0.9;
			else {
				coolGlowyLightsMirror.members[curLight].visible = true;
				coolGlowyLightsMirror.members[curLight].alpha = 0.8;
				FlxTween.tween(coolGlowyLightsMirror.members[curLight], {alpha: 0}, 0.3, {
				});
			}
			FlxG.camera.zoom += 0.030;
			camHB.zoom += 0.04;
			camHUD.zoom += 0.04;
			camNOTEHUD.zoom += 0.04;
			camNOTES.zoom += 0.04;
			camSus.zoom += 0.04;
		} else if (!splitSoftMode && SONG.song.toLowerCase() == 'split' && Main.exMode) {
			if (curStage.toLowerCase() == 'nightbobandbosip')
			{	
				if (theEntireFuckingStage.members[0].color.lightness < 1) {
					for (spr in theEntireFuckingStage) {
						spr.color = FlxColor.fromHSL(spr.color.hue, spr.color.saturation, 1, 1);
					}				
				}
			}
			defaultCamZoom = 0.75;	
		}
		
		if (splitSoftMode && curStage.toLowerCase() == 'nightbobandbosip') {
			if (curStage.toLowerCase() == 'nightbobandbosip')
			{
				for (spr in theEntireFuckingStage) {
					spr.color = FlxColor.fromHSL(spr.color.hue, spr.color.saturation, 0.8, 1);
				}
			}
			if (curBeat % 2 == 0) {
				nightbobandbosipLights.forEach(function(light:FlxSprite)
				{
					light.visible = false;
				});

				curLight++;
				if (curLight > nightbobandbosipLights.length - 1)
					curLight = 0;

				nightbobandbosipLights.members[curLight].visible = true;
				nightbobandbosipLights.members[curLight].alpha = 0.8;

				FlxTween.tween(nightbobandbosipLights.members[curLight], {alpha: 0}, 0.3, {
				});
			}
			defaultCamZoom = 0.75;
			FlxG.camera.zoom += 0.030;
			camHB.zoom += 0.04;
			camHUD.zoom += 0.04;
			camNOTEHUD.zoom += 0.04;
			camNOTES.zoom += 0.04;
			camSus.zoom += 0.04;
		} else if (!splitMode && curStage.toLowerCase() == 'nightbobandbosip' && SONG.song.toLowerCase() == 'split' && Main.exMode) {
			if (theEntireFuckingStage.members[0].color.lightness < 1) {
				for (spr in theEntireFuckingStage) {
					spr.color = FlxColor.fromHSL(spr.color.hue, spr.color.saturation, 1, 1);
				}
			}
		}

		if (!Main.exMode) {
			if (curSong.toLowerCase() == 'split' && curBeat == 188) //|| curSong.toLowerCase() == 'split' && curBeat == 190)
			{
				nightbobandbosipLights.forEach(function(light:FlxSprite)
				{
					light.visible = false;
				});

				curLight++;
				if (curLight > nightbobandbosipLights.length - 1)
					curLight = 0;

				nightbobandbosipLights.members[curLight].visible = true;
				nightbobandbosipLights.members[curLight].alpha = 1;
				FlxTween.tween(nightbobandbosipLights.members[curLight], {alpha: 0}, 0.2, {
				});
				if (curStage.toLowerCase() == 'nightbobandbosip')
				{
					for (spr in theEntireFuckingStage) {
						spr.color = FlxColor.fromHSL(spr.color.hue, spr.color.saturation, 0.9, 1);
					}
				}
			}
			if (curSong.toLowerCase() == 'split' && curBeat >= 192 && curBeat < 256 && camZooming && FlxG.camera.zoom < 1.35)
			{
				if (curStage.toLowerCase() == 'nightbobandbosip')
				{
					for (spr in theEntireFuckingStage) {
						spr.color = FlxColor.fromHSL(spr.color.hue, spr.color.saturation, 0.7, 1);
					}
				}
				nightbobandbosipLights.forEach(function(light:FlxSprite)
				{
					light.visible = false;
				});

				curLight++;
				if (curLight > nightbobandbosipLights.length - 1)
					curLight = 0;

				nightbobandbosipLights.members[curLight].visible = true;
				nightbobandbosipLights.members[curLight].alpha = 1;
				FlxTween.tween(nightbobandbosipLights.members[curLight], {alpha: 0}, 0.3, {
				});
		
				FlxG.camera.zoom += 0.030;
				camHB.zoom += 0.04;
				camHUD.zoom += 0.04;
			}
			if (curSong.toLowerCase() == 'split' && curBeat >= 32 && curBeat < 160 && camZooming && FlxG.camera.zoom < 1.35 && curBeat != 95 || curSong.toLowerCase() == 'split' && curBeat >= 288 && curBeat < 316 && camZooming && FlxG.camera.zoom < 1.35 || curSong.toLowerCase() == 'split' && curBeat >= 352 && curBeat < 385 && camZooming && FlxG.camera.zoom < 1.35)
			{
				FlxG.camera.zoom += 0.015;
				camHB.zoom += 0.03;
				camHUD.zoom += 0.03;
			}
			if (curSong.toLowerCase() == 'split' && curStage.toLowerCase() == 'nightbobandbosip' && curBeat == 256)
			{
				for (spr in theEntireFuckingStage) {
					spr.color = FlxColor.fromHSL(spr.color.hue, spr.color.saturation, 1, 1);
				}
			}
		}
		if (!Main.exMode) {
			if (curStage.toLowerCase() == 'daybobandbosip' && curSong.toLowerCase() == 'jump-in' && curBeat == 4 || curStage.toLowerCase() == 'sunsetbobandbosip' && curSong.toLowerCase() == 'swing' && curBeat == 64 || curStage.toLowerCase() == 'sunsetbobandbosip' && curSong.toLowerCase() == 'swing' && curBeat == 224)
			{
				FlxG.sound.play(Paths.sound('carPass1'), 0.7);
				new FlxTimer().start(1.3, function(tmr:FlxTimer)
				{
					phillyTrain.x = 2000;
					phillyTrain.flipX = false;
					phillyTrain.visible = true;
					FlxTween.tween(phillyTrain, {x: -2000}, 0.18, {
						onComplete: function(twn:FlxTween) {
							phillyTrain.visible = false;
						}
					});
				});
				
			}
			if (curStage.toLowerCase() == 'daybobandbosip' && curSong.toLowerCase() == 'jump-in' && curBeat == 68 || curStage.toLowerCase() == 'sunsetbobandbosip' && curSong.toLowerCase() == 'swing' && curBeat == 144)
			{
				FlxG.sound.play(Paths.sound('carPass1'), 0.7);
				new FlxTimer().start(1.3, function(tmr:FlxTimer)
				{
					phillyTrain.x = -2000;
					phillyTrain.flipX = true;
					phillyTrain.visible = true;
					FlxTween.tween(phillyTrain, {x: 2000}, 0.18, {
						onComplete: function(twn:FlxTween) {
							phillyTrain.visible = false;
						}
					});
				});
				
			}
		}

		if (curSong.toLowerCase() == 'onslaught' && curBeat >= 0 && curBeat < 64 && camZooming && FlxG.camera.zoom < 1.35)
			{
				FlxG.camera.zoom += 0.015;
				camHB.zoom += 0.03;
				camHUD.zoom += 0.03;
				camNOTES.zoom += 0.03;
				camSus.zoom += 0.03;
				camNOTEHUD.zoom += 0.03;
			}
			else if (curSong.toLowerCase() == 'onslaught' && curBeat >= 96 && curBeat < 224 && camZooming && FlxG.camera.zoom < 1.35)
			{
				FlxG.camera.zoom += 0.015;
				camHB.zoom += 0.03;
				camHUD.zoom += 0.03;
				camNOTES.zoom += 0.03;
				camSus.zoom += 0.03;
				camNOTEHUD.zoom += 0.03;
			}
			else if (curSong.toLowerCase() == 'onslaught' && curBeat >= 240 && curBeat < 352 && camZooming && FlxG.camera.zoom < 1.35)
			{
				FlxG.camera.zoom += 0.015;
				camHB.zoom += 0.03;
				camHUD.zoom += 0.03;
				camNOTES.zoom += 0.03;
				camSus.zoom += 0.03;
				camNOTEHUD.zoom += 0.03;
			}

		if (camZooming && FlxG.camera.zoom < 1.35 && curBeat % 4 == 0)
		{
			FlxG.camera.zoom += 0.015;
			camHB.zoom += 0.03;
			camHUD.zoom += 0.03;
			camNOTES.zoom += 0.03;
			camSus.zoom += 0.03;
			camNOTEHUD.zoom += 0.03;
		}

		iconP1.setGraphicSize(Std.int(iconP1.width + 30));
		iconP2.setGraphicSize(Std.int(iconP2.width + 30));

		if (!Main.switchside && SONG.exDad || Main.switchside && SONG.exBF)
		iconP3.setGraphicSize(Std.int(iconP3.width + 30));

		if (!Main.switchside && SONG.exBF || Main.switchside && SONG.exDad)
		iconP4.setGraphicSize(Std.int(iconP4.width + 30));

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		if (!Main.switchside && SONG.exDad || Main.switchside && SONG.exBF)
		iconP3.updateHitbox();

		if (!Main.switchside && SONG.exBF || Main.switchside && SONG.exDad)
		iconP4.updateHitbox();

		if (curBeat == 2 && curSong == 'Ron')
		{
			var bruh:FlxSprite = new FlxSprite();
			bruh.loadGraphic(Paths.image('bob/longbob'));
			bruh.antialiasing = true;
			bruh.active = false;
			bruh.scrollFactor.set();
			bruh.screenCenter();
			add(bruh);
			FlxTween.tween(bruh, {alpha: 0},1, {
				ease: FlxEase.cubeInOut,
				onComplete: function(twn:FlxTween)
				{
					bruh.destroy();
				}
			});
		}
		if (curSong == 'Ron')
		{
			if (curBeat == 7)
			{
				FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut,});
				dad.playAnim('cheer', true);
			}
			else if (curBeat == 119)
			{
				FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut,});
				dad.playAnim('cheer', true);
			}
			else if (curBeat == 215)
			{
				FlxG.camera.follow(dad, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
				FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut,});
				dad.playAnim('cheer', true);
			}
			else
			{
				FlxG.camera.follow(camFollow, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
			}
		}
		if (curBeat % gfSpeed == 0 && curSong == 'run' && !FlxG.save.data.shakingscreen)
		{
			camHUD.shake(0.02, 0.2);
			FlxG.camera.shake(0.005, 0.2);
			//FlxTween.tween(camHUD, {angle: 0},0.5, {ease: FlxEase.elasticOut});
		}

		if (curBeat % gfSpeed == 0)
		{	
			if (curStage == "theShift") shiftbg.animation.play("bop");
			if (curStage == "theManifest"){
				shiftbg.animation.play("bop");
				floor.animation.play("bop");
			}
			
		}
		//doesnt inturupt sing and mid song animations

		if (curBeat % gfSpeed == 0)
		{
			if (gf.animation.curAnim.name.startsWith('idle') || gf.animation.curAnim.name.startsWith('dance'))
			{
				gf.dance();
			}			
		}
		
		if (boyfriend.animation.curAnim.name.startsWith('idle') || boyfriend.animation.curAnim.name.startsWith('dance'))
		{
			boyfriend.dance();
		}

		if (SONG.exBF && boyfriend2.animation.curAnim.name.startsWith('idle') || SONG.exBF && boyfriend2.animation.curAnim.name.startsWith('dance'))
		{
			boyfriend2.dance();
		}

		if (dad.animation.curAnim.name.startsWith('idle') || dad.animation.curAnim.name.startsWith('dance'))
		{
			dad.dance();
			if (curStage == 'nightbobandbosip') {
				pc.animation.play('idle');
			}
		}

		if (SONG.exDad && dad2.animation.curAnim.name.startsWith('idle') || SONG.exDad && dad2.animation.curAnim.name.startsWith('dance'))
		{
			dad2.dance();
			if (curStage == 'nightbobandbosip') {
				pc.animation.play('idle');
			}
		}
		//

		if (curBeat % 8 == 7 && curSong == 'Bopeebo')
		{
			boyfriend.playAnim('hey', true);
		}

		if (curBeat % 8 == 7 && curSong == 'Daddys-Girl')
		{
			boyfriend.playAnim('hey', true);
		}

		if (curBeat % 16 == 15 && SONG.song == 'Tutorial' && dad.curCharacter == 'gf' && curBeat > 16 && curBeat < 48)
		{
			boyfriend.playAnim('hey', true);
			dad.playAnim('cheer', true);
		}

		if (curBeat == 223 && curSong == 'wind-up')
		{
			boyfriend.playAnim('hit', true);
		}

		if (curBeat == 32 && curSong == 'king-hit')
		{
			dad.playAnim('snap', true);
		} 

		if (curBeat == 32 && curSong == 'king-hit-fefe')
		{
			dad.playAnim('troll', true);
		} 

		if (curBeat == 30 && SONG.song.toLowerCase() == 'tutorial-bnb' && dad.curCharacter == 'gf' || curBeat == 46 && SONG.song.toLowerCase() == 'tutorial-bnb' && dad.curCharacter == 'gf' )
		{
			dad.playAnim('cheer', true);
		}

		if (curBeat == 283 && curSong == 'Nyaw')
			{
				boyfriend.playAnim('hey', true);
			}
			if (curBeat == 434 && curSong == 'Nyaw')
			{
				dad.playAnim('stare', true);
					new FlxTimer().start(1.1, function(tmr:FlxTimer)
					{
					var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
					black.scrollFactor.set();
					add(black);
					});
			}
			if (curBeat == 31 && curSong == 'Nyaw')
			{
				dad.playAnim('meow', true);
			}
			if (curBeat == 135 && curSong == 'Nyaw')
			{
				dad.playAnim('meow', true);
			}
			if (curBeat == 363 && curSong == 'Nyaw')
			{
				dad.playAnim('meow', true);
			}
			if (curBeat == 203 && curSong == 'Nyaw')
			{
				dad.playAnim('meow', true);
			}
			if (curBeat % 2 == 0 && curStage == 'stagekapi4')
			{
				bottomBoppers.animation.play('bop', true);
			}
			if (curBeat % 2 == 0 && curStage == 'stagekapi3')
			{
				littleGuys.animation.play('bop', true);
			}
			if (curBeat % 2 == 0 && curStage == 'stagekapi2')
			{
				littleGuys.animation.play('bop', true);
			}
			if (curBeat % 2 == 1 && curStage == 'stagekapi4')
			{
				upperBoppers.animation.play('bop', true);
			}
			if (curBeat % 2 == 1 && curStage == 'stagekapi3')
			{
				upperBoppers.animation.play('bop', true);
			}
			if (curSong.toLowerCase() == 'nyaw' && camZooming && FlxG.camera.zoom < 1.35 && curBeat % 1 == 0 && curBeat != 283 && curBeat != 282)
			{
				if (curStage.startsWith('stagekapi'))
				{
						kapiLights.forEach(function(light:FlxSprite)
						{
							light.visible = false;
						});
	
						curLight = FlxG.random.int(0, kapiLights.length - 1);
	
						kapiLights.members[curLight].visible = true;
						// kapiLights.members[curLight].alpha = 1;
				}
				FlxG.camera.zoom += 0.02;
				camHB.zoom += 0.022;
				camHUD.zoom += 0.022;
				camNOTES.zoom += 0.022;
				camSus.zoom += 0.022;
				camNOTEHUD.zoom += 0.022;
			}

				if (curSong.toLowerCase() == 'king-hit' && curBeat == 31)
				{
					FlxTween.tween(FlxG.camera, {zoom: 1}, .5, {
										ease: FlxEase.quadInOut,
							});
				}
				
				if (curSong.toLowerCase() == 'wind-up' && curBeat == 222)
				{
					FlxTween.tween(FlxG.camera, {zoom: 1}, .5, {
										ease: FlxEase.quadInOut,
							});
				}
		
				if (curSong.toLowerCase() == 'king-hit-fefe' && curBeat == 31)
				{
					FlxTween.tween(FlxG.camera, {zoom: 1}, .5, {
										ease: FlxEase.quadInOut,
							});
				}

				if (curSong.toLowerCase() == 'nyaw' && curBeat == 282)
				{
					FlxTween.tween(FlxG.camera, {zoom: 1}, .5, {
										ease: FlxEase.quadInOut,
							});
				}
				if (curSong.toLowerCase() == 'hairball' && camZooming && FlxG.camera.zoom < 1.35 && curBeat % 1 == 0)
				{
					FlxG.camera.zoom += 0.017;
					camHB.zoom += 0.02;
					camHUD.zoom += 0.02;
					camNOTES.zoom += 0.2;
					camSus.zoom += 0.02;
					camNOTEHUD.zoom += 0.02;
				}
				if (curStage == 'stagekapi3' && curBeat % 1 == 0)
				{
					kapiLights.forEach(function(light:FlxSprite)
					{
						light.visible = false;
					});

					curLight = FlxG.random.int(0, kapiLights.length - 1);

					kapiLights.members[curLight].visible = true;
					// kapiLights.members[curLight].alpha = 1;
				}
				if (curStage == 'stagekapi2' && curBeat % 1 == 0)
				{
					kapiLights.forEach(function(light:FlxSprite)
					{
						light.visible = false;
					});

					curLight = FlxG.random.int(0, kapiLights.length - 1);

					kapiLights.members[curLight].visible = true;
					// kapiLights.members[curLight].alpha = 1;
				}
				if (curStage == 'stagekapi' && curBeat % 2 == 0)
				{
					kapiLights.forEach(function(light:FlxSprite)
					{
						light.visible = false;
					});

					curLight = FlxG.random.int(0, kapiLights.length - 1);

					kapiLights.members[curLight].visible = true;
					// kapiLights.members[curLight].alpha = 1;
				}
				if (curSong.toLowerCase() == 'beathoven' && camZooming && FlxG.camera.zoom < 1.35 && curBeat % 2 == 0)
				{
					FlxG.camera.zoom += 0.014;
					camHB.zoom += 0.015;
					camHUD.zoom += 0.015;
					camNOTES.zoom += 0.015;
					camSus.zoom += 0.015;
					camNOTEHUD.zoom += 0.015;
				}
				if (curSong.toLowerCase() == 'wocky' && camZooming && FlxG.camera.zoom < 1.35 && curBeat % 2 == 0)
				{
					FlxG.camera.zoom += 0.016;
					camHB.zoom += 0.015;
					camHUD.zoom += 0.015;
					camNOTES.zoom += 0.015;
					camSus.zoom += 0.015;
					camNOTEHUD.zoom += 0.015;
				}

				if (curSong.toLowerCase() == 'sky')
				{
					switch(curBeat)
					{
						case 30,31,62,63:
							dad.playAnim('oh');
						case 126,127,190,191:
							dad.playAnim('grr');
						case 254,255,270,271:
							dad.playAnim('huh');
						case 286,287:
							dad.playAnim('ugh');
					}
				}
				if (curSong.toLowerCase() == 'onslaught' && curBeat >= 128 && curBeat <= 352)
				{
					var amount = curBeat/20;
					if (FlxG.random.bool(amount) && appearscreen)
					{
						var randomthing:FlxSprite = new FlxSprite(FlxG.random.int(300, 1077), FlxG.random.int(0, 622));
						FlxG.sound.play(Paths.sound("pop_up"), 1);
						randomthing.loadGraphic(Paths.image('bob/PopUps/popup' + FlxG.random.int(1,11)));
						randomthing.updateHitbox();
						randomthing.alpha = 0;
						randomthing.antialiasing = true;
						add(randomthing);
						randomthing.cameras = [camHUD];
						appearscreen = false;
						if (storyDifficulty == 0)
						{
							FlxTween.tween(randomthing, {width: 1, alpha: 0.5}, 0.2, {ease: FlxEase.sineOut});
						}
						else
						{
							FlxTween.tween(randomthing, {width: 1, alpha: 1}, 0.2, {ease: FlxEase.sineOut});
						}
						new FlxTimer().start(1.5 , function(tmr:FlxTimer)
						{
							appearscreen = true;
						});
						new FlxTimer().start(2 , function(tmr:FlxTimer)
						{
							remove(randomthing);
						});
					}
				}
				if (curSong.toLowerCase() == 'little-man' && curBeat == 1397 )
				{
					changeDadCharacter('pizza');
				}
				if (curSong.toLowerCase() == 'little-man' && curBeat == 1497 )
				{
					changeDadCharacter('little-man');
				}
				if (curSong.toLowerCase() == 'little-man' && curBeat == 1844 )
				{
					changeDadCharacter('tankman');
					dad.x -= 124;
					dad.y -= 644;
					dad.y += 268;
					dad.x -= 27;
				}
				if (curSong.toLowerCase() == 'little-man' && curBeat == 1900 )
				{
					spotifyad();
				}
				if (curSong.toLowerCase() == 'trouble' && curBeat == 504 )
				{
					BobIngameTransform();
				}
				if (curSong.toLowerCase() == 'onslaught' && curBeat == 96 )
				{
					InvisibleNotes();
				}
				if (curSong.toLowerCase() == 'onslaught' && curBeat == 128 )
				{
					windowX = Lib.application.window.x;
					windowY = Lib.application.window.y;
					IsNoteSpinning = true;
					VisibleNotes();
				}
				if (curSong.toLowerCase() == 'onslaught' && curBeat == 240 )
				{
					InvisibleNotes();
				}
				if (curSong.toLowerCase() == 'onslaught' && curBeat == 352 )
				{
					IsNoteSpinning = false;
					WindowGoBack();
					VisibleNotes();
				}

		switch (curStage)
		{
			case 'school':
				bgGirls.dance();

			case 'mall' | 'mallb' | 'mallsalty':
				upperBoppers.animation.play('bop', true);
				bottomBoppers.animation.play('bop', true);
				santa.animation.play('idle', true);

			case 'limo' | 'limosalty':
				grpLimoDancers.forEach(function(dancer:BackgroundDancer)
				{
					dancer.dance();
				});

				if (FlxG.random.bool(10) && fastCarCanDrive)
					fastCarDrive();
			case "philly" | "phillyneo" | "phillysalty":
				if (!trainMoving)
					trainCooldown += 1;

				if (curBeat % 4 == 0)
				{
					phillyCityLights.forEach(function(light:FlxSprite)
					{
						light.visible = false;
					});

					curLight = FlxG.random.int(0, phillyCityLights.length - 1);

					phillyCityLights.members[curLight].visible = true;
					// phillyCityLights.members[curLight].alpha = 1;
				}

				if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
				{
					trainCooldown = FlxG.random.int(-4, 0);
					trainStart();
				}

			case "tankstress":
			if(curBeat % 2 == 0){
				tankWatchtower.animation.play('idle', true);
				tank0.animation.play('idle', true);
				tank1.animation.play('idle', true);
				tank2.animation.play('idle', true);
				tank3.animation.play('idle', true);
				tank4.animation.play('idle', true);
				tank5.animation.play('idle', true);
			}

			case "tank":
			if(curBeat % 2 == 0){
				tankWatchtower.animation.play('idle', true);
				tank0.animation.play('idle', true);
				tank1.animation.play('idle', true);
				tank2.animation.play('idle', true);
				tank3.animation.play('idle', true);
				tank4.animation.play('idle', true);
				tank5.animation.play('idle', true);
			}
			case 'allycrazy':
				ballisticbg.animation.play('gameButMove', true);
			case 'maze' | 'mazeb':
				mazebg.animation.play('move', false);
			case 'spookyneo':
				leftboom.animation.play('boom', true);
				rightboom.animation.play('boom', true);
			case 'shaggysky':
				var rotRate = curStep * 0.25;
				var rotRateSh = curStep / 9.5;
				var rotRateGf = curStep / 9.5 / 4;
				var derp = 12;
				if (!startedCountdown)
				{
					camFollow.x = boyfriend.x - 300;
					camFollow.y = boyfriend.y - 40;
					derp = 20;
				}

				if (godCutEnd)
				{
					if (curBeat < 32)
					{
						sh_r = 60;
					}
					else if ((curBeat >= 132 * 4) || (curBeat >= 42 * 4 && curBeat <= 50 * 4))
					{
						sh_r += (60 - sh_r) / 32;
					}
					else
					{
						sh_r = 600;
					}

					if ((curBeat >= 32 && curBeat < 48) || (curBeat >= 116 * 4 && curBeat < 132 * 4))
					{
						if (boyfriend.animation.curAnim.name.startsWith('idle'))
						{
							boyfriend.playAnim('scared', true);
						}
					}

					if (curBeat < 50*4)
					{
					}
					else if (curBeat < 66 * 4)
					{
						rotRateSh *= 1.2;
					}
					else if (curBeat < 116 * 4)
					{
					}
					else if (curBeat < 132 * 4)
					{
						rotRateSh *= 1.2;
					}
					var bf_toy = -2000 + Math.sin(rotRate) * 20;

					var sh_toy = -2450 + -Math.sin(rotRateSh * 2) * sh_r * 0.45;
					var sh_tox = -330 -Math.cos(rotRateSh) * sh_r;

					var gf_tox = 100 + Math.sin(rotRateGf) * 200;
					var gf_toy = -2000 -Math.sin(rotRateGf) * 80;

					if (godMoveBf)
					{
						boyfriend.y += (bf_toy - boyfriend.y) / derp;
						rock.x = boyfriend.x - 200;
						rock.y = boyfriend.y + 200;
						rock.alpha = 1;
					}

					if (godMoveSh)
					{
						dad.x += (sh_tox - dad.x) / 12;
						dad.y += (sh_toy - dad.y) / 12;
					}

					if (godMoveGf)
					{
						gf.x += (gf_tox - gf.x) / derp;
						gf.y += (gf_toy - gf.y) / derp;

						gf_rock.x = gf.x + 80;
						gf_rock.y = gf.y + 530;
						gf_rock.alpha = 1;
						if (!gf_launched)
						{
							gf.scrollFactor.set(0.8, 0.8);
							gf.setGraphicSize(Std.int(gf.width * 0.8));
							gf_launched = true;
						}
					}
				}
				if (!godCutEnd || !godMoveBf)
				{
					rock.alpha = 0;
				}
				if (!godMoveGf)
				{
					gf_rock.alpha = 0;
				}

			case 'swordarena':
			bgBoppers.animation.play('bop', true);
			case 'concert':
			crowdmiku.animation.play('bop', true);
			case 'pillars':
			{
			speaker.animation.play('bop');
			}

			case 'hellstage':			
				if (FlxG.random.bool(10) && isbobmad && curSong.toLowerCase() == 'run')
					Bobismad();
		}

		if (isHalloween && FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
		{
			lightningStrikeShit();
		}
	}

	function BobIngameTransform()
	{
		dad.playAnim('Transform', true);
		FlxG.sound.play(Paths.sound('bobSpooky'));
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		new FlxTimer().start(1.7, function(tmr:FlxTimer)
		{
			add(black);
			FlxG.camera.fade(FlxColor.WHITE, 0.1, true);
		});

	}
	function spotifyad()
		{
			var thx:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('littleman/spotifyad'));
			thx.updateHitbox();
			thx.scrollFactor.set(0, 0);
			thx.antialiasing = true;
			FlxG.camera.fade(FlxColor.BLACK, 1, false, function()
			{
				add(thx);
				FlxG.camera.fade(FlxColor.BLACK, 1, true);
			}, true);
		}
	function WindowGoBack()
	{
		new FlxTimer().start(0.01, function(tmr:FlxTimer)
		{
			var xLerp:Float = FlxMath.lerp(windowX, Lib.application.window.x, 0.95);
			var yLerp:Float = FlxMath.lerp(windowY, Lib.application.window.y, 0.95);
			Lib.application.window.move(Std.int(xLerp),Std.int(yLerp));
		}, 20);
	}

	function changeDadCharacter(id:String)
	{				
		var olddadx = dad.x;
		var olddady = dad.y;
		remove(dad);
		dad = new Character(olddadx, olddady, id);
		add(dad);

		switch (Main.switchside)
		{ 
			case true:
			remove(iconP1);
			iconP1 = new HealthIcon(id, true);
			iconP1.y = healthBar.y - (iconP1.height / 2);
			iconP1.cameras = [camHB];
			add(iconP1);
			case false:
			remove(iconP2);
			iconP2 = new HealthIcon(id, false);
			iconP2.y = healthBar.y - (iconP2.height / 2);
			iconP2.cameras = [camHB];
			add(iconP2);
			#if windows
			iconRPC = id;
			#end
		}
	}

	function changeBoyfriendCharacter(id:String)
	{				
		var oldbfx = boyfriend.x;
		var oldbfy = boyfriend.y;
		remove(boyfriend);
		boyfriend = new Boyfriend(oldbfx, oldbfy, id);
		add(boyfriend);

		switch (Main.switchside)
		{ 
			case false:
			remove(iconP1);
			iconP1 = new HealthIcon(id, true);
			iconP1.y = healthBar.y - (iconP1.height / 2);
			iconP1.cameras = [camHB];
			add(iconP1);
			case true:
			remove(iconP2);
			iconP2 = new HealthIcon(id, false);
			iconP2.y = healthBar.y - (iconP2.height / 2);
			iconP2.cameras = [camHB];
			add(iconP2);
			#if windows
			iconRPC = id;
			#end
		}
	}

	public function hscript()
		{
			#if desktop
			if (FileSystem.exists('assets/data/' + SONG.song.toLowerCase() + '/scripts/chart.hx'))
			{
				// sets most of the variables
				modState.set("FlxSprite", flixel.FlxSprite);
				modState.set("FlxTimer", FlxTimer);
				modState.set("File", sys.io.File);
				modState.set("fs", FileSystem);
				modState.set("Math", Math);
				modState.set("Std", Std);
				modState.set("FlxTween", FlxTween);
				modState.set("FlxText", FlxText);
				modState.set("camera", FlxG.camera);
				modState.set("hud", camHUD);
				modState.set("hud", camHB);
				modState.set("noteCamera", camNOTES);
				modState.set("sustainCamera", camSus);
				modState.set("noteHudCam", camNOTEHUD);
				modState.set("gf", gf);
				modState.set("dad", dad);
				modState.set("boyfriend", boyfriend);
				modState.set("beatHit", beatHit);
				modState.set("stepHit", stepHit);
				modState.set("add", addObject);
				// beat shit
				modState.set("step", curStep);
				modState.set("beat", curBeat);
	
				notes.forEachAlive(function(daNote:Note)
				{
					for (i in 0...keyAmmo[mania])
					{
						if (daNote.noteData == i)
							modState.set("note" + i, daNote);
					}
	
					modState.set("allNotes", daNote);
				});
			}
			#end
		}

	public function loadScript()
	{
		#if desktop
		modState.executeString(File.getContent('assets/data/' + SONG.song.toLowerCase() + '/scripts/chart.hx'));
		#end
	}

	public function loadStartScript()
	{
		#if desktop
		modState.executeString(File.getContent('assets/data/' + SONG.song.toLowerCase() + '/scripts/start.hx'));
		#end
	}

	public function hscriptBeat()
	{
		#if desktop
		if (FileSystem.exists('assets/data/' + SONG.song.toLowerCase() + '/scripts/chart.hx'))
		{
		}
		#end
	}
	public function addObject(object:flixel.FlxBasic) // fallback
	{
		add(object);
	}

	var curLight:Int = 0;
	var scoob:Character;
	var cs_time:Int = 0;
	var cs_wait:Bool = false;
	var cs_zoom:Float = 1;
	var cs_slash_dim:FlxSprite;
	var cs_sfx:FlxSound;
	var cs_mus:FlxSound;
	var sh_body:FlxSprite;
	var sh_head:FlxSprite;
	var cs_cam:FlxObject;
	var cs_black:FlxSprite;
	var sh_ang:FlxSprite;
	var sh_ang_eyes:FlxSprite;
	var cs_bg:FlxSprite;
	var nex:Float = 1;

	public function ssCutscene()
	{
		cs_cam = new FlxObject(0, 0, 1, 1);
		cs_cam.x = 605;
		cs_cam.y = 410;
		add(cs_cam);
		remove(camFollow);
		camFollow.destroy();
		FlxG.camera.follow(cs_cam, LOCKON, 0.01);

		new FlxTimer().start(0.002, function(tmr:FlxTimer)
		{
			switch (cs_time)
			{
				case 1:
					cs_zoom = 0.65;
				case 25:
					//scoob = new Character(1700, 290, 'scooby', false);
					scoob.playAnim('walk', true);
					scoob.x = 1700;
					scoob.y = 290;
					scoob.playAnim('walk');
				case 240:
					scoob.playAnim('idle', true);
				case 340:
					burstRelease(dad.getMidpoint().x, dad.getMidpoint().y);

					dad.powerup = false;
					dad.playAnim('idle', true);
				case 390:
					remove(burst);
				case 420:
					if (!cs_wait)
					{
						//schoolIntro(doof);
						cs_wait = true;
						cs_reset = true;

						cs_mus = FlxG.sound.load(Paths.sound('cs_happy'));
						cs_mus.play();
						cs_mus.looped = true;
					}
				case 540:
					scoob.playAnim('scare', true);
					cs_mus.fadeOut(2, 0);
				case 900:
					FlxG.sound.play(Paths.sound('blur'));
					scoob.playAnim('blur', true);
					scoob.x -= 200;
					scoob.y += 100;
					scoob.angle = 23;
					dad.playAnim('catch', true);
				case 903:
					scoob.x = -4000;
					scoob.angle = 0;
				case 940:
					dad.playAnim('hold', true);
					cs_sfx = FlxG.sound.load(Paths.sound('scared'));
					cs_sfx.play();
					cs_sfx.looped = true;
				case 1200:
					if (!cs_wait)
					{
						//schoolIntro(doof);
						cs_wait = true;
						cs_reset = true;

						cs_mus.stop();
						cs_mus = FlxG.sound.load(Paths.sound('cs_drums'));
						cs_mus.play();
						cs_mus.looped = true;
					}
				case 1201:
					cs_sfx.stop();
					cs_mus.stop();
					FlxG.sound.play(Paths.sound('counter_back'));
					cs_slash_dim = new FlxSprite(-500, -400).makeGraphic(FlxG.width * 4, FlxG.height * 4, FlxColor.WHITE);
					cs_slash_dim.scrollFactor.set();
					add(cs_slash_dim);
					dad.playAnim('h_half', true);
					gf.playAnim('kill', true);
					scoob.playAnim('half', true);
					scoob.x += 4100;
					scoob.y -= 150;

					scoob.x -= 90;
					scoob.y -= 252;
				case 1700:
					scoob.playAnim('fall', true);
					cs_cam.x -= 150;
				case 1740:
					FlxG.sound.play(Paths.sound('body_fall'));
				case 2000:
					if (!cs_wait)
					{
						gf.playAnim('danceRight', true);
						//schoolIntro(doof);
						cs_wait = true;
						cs_reset = true;
					}
				case 2150:
					dad.playAnim('fall', true);
				case 2180:
					FlxG.sound.play(Paths.sound('shaggy_kneel'));
				case 2245:
					FlxG.sound.play(Paths.sound('body_fall'));
				case 2280:
					dad.playAnim('kneel', true);
					sh_head = new FlxSprite(440, 100);
					sh_head.y = 100 + FlxG.random.int(-0, 0);
					sh_head.frames = Paths.getSparrowAtlas('bshaggy');
					sh_head.animation.addByPrefix('idle', "bshaggy_head_still", 30);
					sh_head.animation.addByPrefix('turn', "bshaggy_head_transform", 30);
					sh_head.animation.addByPrefix('idle2', "bsh_head2_still", 30);
					sh_head.animation.play('turn');
					sh_head.animation.play('idle');
					sh_head.antialiasing = _variables.antialiasing;

					sh_ang = new FlxSprite(0, 0);
					sh_ang.frames = Paths.getSparrowAtlas('bshaggy');
					sh_ang.animation.addByPrefix('idle', "bsh_angry", 30);
					sh_ang.animation.play('idle');
					sh_ang.antialiasing = _variables.antialiasing;

					sh_ang_eyes = new FlxSprite(0, 0);
					sh_ang_eyes.frames = Paths.getSparrowAtlas('bshaggy');
					sh_ang_eyes.animation.addByPrefix('stare', "bsh_eyes", 30);
					sh_ang_eyes.animation.play('stare');
					sh_ang_eyes.antialiasing = _variables.antialiasing;

					cs_bg = new FlxSprite(-500, -80);
					cs_bg.frames = Paths.getSparrowAtlas('cs_bg');
					cs_bg.animation.addByPrefix('back', "cs_back_bg", 30);
					cs_bg.animation.addByPrefix('stare', "cs_bg", 30);
					cs_bg.animation.play('back');
					cs_bg.antialiasing = _variables.antialiasing;
					cs_bg.setGraphicSize(Std.int(cs_bg.width * 1.1));

					cs_sfx = FlxG.sound.load(Paths.sound('powerup'));
				case 2500:
					add(cs_bg);
					add(sh_head);

					sh_body = new FlxSprite(200, 250);
					sh_body.frames = Paths.getSparrowAtlas('bshaggy');
					sh_body.animation.addByPrefix('idle', "bshaggy_body_still", 30);
					sh_body.animation.play('idle');
					sh_body.antialiasing = _variables.antialiasing;
					add(sh_body);

					cs_mus = FlxG.sound.load(Paths.sound('cs_cagaste'));
					cs_mus.looped = false;
					cs_mus.play();
					cs_cam.x += 150;
					FlxG.camera.follow(cs_cam, LOCKON, 1);
				case 3100:
					burstRelease(1000, 300);
				case 3580:
					burstRelease(1000, 300);
					cs_sfx.play();
					cs_sfx.looped = false;
					FlxG.camera.angle = 10;
				case 4000:
					burstRelease(1000, 300);
					cs_sfx.play();
					FlxG.camera.angle = -20;
					sh_head.animation.play('turn');
					sh_head.offset.set(0, 60);

					cs_sfx = FlxG.sound.load(Paths.sound('charge'));
					cs_sfx.play();
					cs_sfx.looped = true;
				case 4003:
					cs_mus.play(true, 12286 - 337);
				case 4065:
					sh_head.animation.play('idle2');
				case 4550:
					remove(sh_head);
					remove(sh_body);
					cs_sfx.stop();


					sh_ang.x = -140;
					sh_ang.y = -5;

					sh_ang_eyes.x = 688;
					sh_ang_eyes.y = 225;

					add(sh_ang);
					add(sh_ang_eyes);

					cs_bg.animation.play('stare');

					cs_black = new FlxSprite(-500, -400).makeGraphic(FlxG.width * 4, FlxG.height * 4, FlxColor.BLACK);
					cs_black.scrollFactor.set();
					add(cs_black);

					cs_mus.play(true, 16388);
				case 6000:
					cs_black.alpha = 2;
					cs_mus.stop();
				case 6100:
					endSong();
			}
			if (cs_time >= 25 && cs_time <= 240)
			{
				scoob.x -= 6;
				scoob.playAnim('walk');
			}
			if (cs_time > 240 && cs_time < 540)
			{
				scoob.playAnim('idle');
			}
			if (cs_time > 940 && cs_time < 1201)
			{
				dad.playAnim('hold');
			}
			if (cs_time > 1201 && cs_time < 2500)
			{
				cs_slash_dim.alpha -= 0.003;
			}
			if (cs_time >= 2500 && cs_time < 4550)
			{
				cs_zoom += 0.0001;
			}
			if (cs_time >= 5120 && cs_time <= 6000)
			{
				cs_black.alpha -= 0.0015;
			}
			if (cs_time >= 3580 && cs_time < 4000)
			{
				sh_head.y = 100 + FlxG.random.int(-5, 5);
			}
			if (cs_time >= 4000 && cs_time <= 4548)
			{
				sh_head.x = 440 + FlxG.random.int(-10, 10);
				sh_body.x = 200 + FlxG.random.int(-5, 5);
			}

			if (cs_time == 3400 || cs_time == 3450 || cs_time == 3500 || cs_time == 3525 || cs_time == 3550 || cs_time == 3560 || cs_time == 3570)
			{
				burstRelease(1000, 300);
			}

			FlxG.camera.zoom += (cs_zoom - FlxG.camera.zoom) / 12;
			FlxG.camera.angle += (0 - FlxG.camera.angle) / 12;
			if (!cs_wait)
			{
				cs_time ++;
			}
			tmr.reset(0.002);
		});
	}

	var toDfS:Float = 1;
	public function finalCutscene()
	{
		cs_zoom = defaultCamZoom;
		cs_cam = new FlxObject(0, 0, 1, 1);
		camFollow.setPosition(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);
		cs_cam.x = camFollow.x;
		cs_cam.y = camFollow.y;
		add(cs_cam);
		remove(camFollow);
		camFollow.destroy();
		FlxG.camera.follow(cs_cam, LOCKON, 0.01);

		new FlxTimer().start(0.002, function(tmr:FlxTimer)
		{
			switch (cs_time)
			{
				case 200:
					cs_cam.x -= 500;
					cs_cam.y -= 200;
				case 400:
					dad.playAnim('smile');
				case 500:
					if (!cs_wait)
					{
						//schoolIntro(doof);
						cs_wait = true;
						cs_reset = true;
					}
				case 700:
					godCutEnd = false;
					FlxG.sound.play(Paths.sound('burst'));
					dad.playAnim('stand', true);
					dad.x = 100;
					dad.y = 100;
					boyfriend.x = 770;
					boyfriend.y = 450;
					gf.x = 400;
					gf.y = 130;
					gf.scrollFactor.set(0.95, 0.95);
					gf.setGraphicSize(Std.int(gf.width));
					cs_cam.y = boyfriend.y;
					cs_cam.x += 100;
					cs_zoom = 0.8;
					FlxG.camera.zoom = cs_zoom;
					scoob.x = dad.x - 400;
					scoob.y = 290;
					scoob.flipX = true;
					remove(shaggyT);
					FlxG.camera.follow(cs_cam, LOCKON, 1);
				case 800:
					if (!cs_wait)
					{
						//schoolIntro(doof);
						cs_wait = true;
						cs_reset = true;

						cs_mus = FlxG.sound.load(Paths.sound('cs_finale'));
						cs_mus.looped = true;
						cs_mus.play();
					}
				case 840:
					FlxG.sound.play(Paths.sound('exit'));
					doorFrame.alpha = 1;
					doorFrame.x -= 90;
					doorFrame.y -= 130;
					toDfS = 700;
				case 1150:
					if (!cs_wait)
					{
						//schoolIntro(doof);
						cs_wait = true;
						cs_reset = true;
					}
				case 1400:
					FlxG.sound.play(Paths.sound('exit'));
					toDfS = 1;
				case 1645:
					cs_black = new FlxSprite(-500, -400).makeGraphic(FlxG.width * 4, FlxG.height * 4, FlxColor.BLACK);
					cs_black.scrollFactor.set();
					cs_black.alpha = 0;
					add(cs_black);
					cs_wait = true;
					cs_time ++;
				case -1:
					if (!cs_wait)
					{
						//schoolIntro(doof);
						cs_wait = true;
						cs_reset = true;
					}
				case 1651:
					endSong();
			}
			if (cs_time > 700)
			{
				scoob.playAnim('idle');
			}
			if (cs_time > 1150)
			{
				scoob.alpha -= 0.004;
				dad.alpha -= 0.004;
			}
			FlxG.camera.zoom += (cs_zoom - FlxG.camera.zoom) / 12;
			if (!cs_wait)
			{
				cs_time ++;
			}

			dfS += (toDfS - dfS) / 18;
			doorFrame.setGraphicSize(Std.int(dfS));
			tmr.reset(0.002);
		});
	}
	public function burstRelease(bX:Float, bY:Float)
		{
			FlxG.sound.play(Paths.sound('burst'),_variables.svolume/100);
			remove(burst);
			burst = new FlxSprite(bX - 1000, bY - 100);
			burst.frames = Paths.getSparrowAtlas('shaggy');
			burst.animation.addByPrefix('burst', "burst", 30);
			burst.animation.play('burst');
			//burst.setGraphicSize(Std.int(burst.width * 1.5));
			burst.antialiasing = _variables.antialiasing;
			add(burst);
			new FlxTimer().start(0.5, function(rem:FlxTimer)
			{
				remove(burst);
			});
		}
}