package;

import haxe.Json;
import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.util.FlxGradient;
#if desktop
import Discord.DiscordClient;
#end
#if sys
import sys.io.File;
import sys.FileSystem;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.addons.display.FlxBackdrop;
import MainVariables._variables;
import ModifierVariables._modifiers;

using StringTools;

typedef MarathonVars = {
    var songNames:Array<String>;
    var songDifficulties:Array<String>;
}

class MenuMarathon extends MusicBeatState
{
    public static var _marathon:MarathonVars;

    public static var bg:FlxSprite = new FlxSprite(-89).loadGraphic(Paths.image(''));
	var checker:FlxBackdrop = new FlxBackdrop(Paths.image('Mara_Checker'), 0.2, 0.2, true, true);
	var gradientBar:FlxSprite = new FlxSprite(0,0).makeGraphic(FlxG.width, 300, 0xFFAA00AA);
	var side:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('Mara_Bottom'));

    public static var curSelected:Int = 0;
    var camLerp:Float = 0.1;
    var selectable:Bool = false;

    public static var substated:Bool = false;
    public static var no:Bool = false;

    var songs:Array<SongTitles> = [];
    var difficulties:Array<Int> = [0,1,2,3,4];

    public static var curDifficulty:Int = 1;

	var scoreText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
    var sprDifficulty:FlxSprite;

    public static var showMobileControls:Bool = false;

    override function create()
    {
        substated = false;

        loadCurrent();

        FlxG.game.scaleX = 1;
		FlxG.game.x = 0;
		FlxG.game.scaleY = 1;
		FlxG.game.y = 0;

        no = false;

        transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

        var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));

		for (i in 0...initSonglist.length)
		{
			var data:Array<String> = initSonglist[i].split(':');
			songs.push(new SongTitles(data[0]));
		}

        MenuMusic.switchimage();
		bg = MenuMusic.bg;
		if (_variables.music != "neo"){bg.color = 0xFFe470d8;}   
        bg.scrollFactor.x = 0;
        bg.scrollFactor.y = 0.03;
        bg.setGraphicSize(Std.int(bg.width * 1.1));
        bg.updateHitbox();
        bg.screenCenter();
		add(bg);

		gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), 512, [0x00ff0000, 0x55FFFFFF, 0xAAFFFFFF], 1, 90, true); 
		gradientBar.y = FlxG.height - gradientBar.height;
		add(gradientBar);
		gradientBar.scrollFactor.set(0, 0);

		add(checker);
		checker.scrollFactor.set(0.07, 0.07);

        grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

        for (i in 0...songs.length)
            {
                var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
                songText.itemType = "Vertical";
                songText.targetY = i;
                grpSongs.add(songText);
    
                // songText.x += 40;
                // DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
                // songText.screenCenter(X);
            }

		side.scrollFactor.x = 0;
		side.scrollFactor.y = 0;
		side.antialiasing = true;
		side.screenCenter();
		add(side);

		side.y = FlxG.height;
		FlxTween.tween(side, {y:FlxG.height-side.height}, 0.6, {ease: FlxEase.quartInOut});

		FlxTween.tween(bg, { alpha:1}, 0.8, { ease: FlxEase.quartInOut});
		FlxG.camera.zoom = 0.6;
		FlxG.camera.alpha = 0;
		FlxTween.tween(FlxG.camera, { zoom:1, alpha:1}, 0.7, { ease: FlxEase.quartInOut});

        var diffTex = Paths.getSparrowAtlas('difficulties');
		sprDifficulty = new FlxSprite(130, 0);
		sprDifficulty.frames = diffTex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.addByPrefix('expert', 'EXPERT');
        sprDifficulty.animation.addByPrefix('insane', 'INSANE');
		sprDifficulty.animation.play('easy');
		sprDifficulty.screenCenter(X);
		sprDifficulty.y = FlxG.height - sprDifficulty.height - 8;
		add(sprDifficulty);

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		scoreText.alignment = CENTER;
		scoreText.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		scoreText.screenCenter(X);
		scoreText.y = sprDifficulty.y - 38;
		add(scoreText);

        FlxTween.tween(scoreText, { alpha:1}, 0.5, { ease: FlxEase.quartInOut});
		FlxTween.tween(sprDifficulty, { alpha:1}, 0.5, { ease: FlxEase.quartInOut});

		changeSelection();
		changeDiff();

		new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				selectable = true;
			});

            if (!FlxG.sound.music.playing)
                {
                    MenuMusic.continueMenuMusic();
                }

        #if mobileC
		addVirtualPad(FULL, A_B_SHIFT);
        _virtualpad.cameras = cameras;
		#end

        super.create();

        #if desktop
			DiscordClient.changePresence("Selecting anything for a marathon.", null);
		#end
    }

    override function update(elapsed:Float)
    {
        updateDifficultyList();

        if (showMobileControls)
        {
            new FlxTimer().start(0, function(tmr:FlxTimer)
                {                    
                    #if mobileC
                    addVirtualPad(FULL, A_B_SHIFT);
                    _virtualpad.cameras = cameras;
                    #end
                    showMobileControls = false;
                });
        }

        checker.x -= -0.67/(_variables.fps/60);
		checker.y -= 0.2/(_variables.fps/60);

        super.update(elapsed);

		if (FlxG.sound.music.volume < 0.7*_variables.mvolume/100)
		{
			FlxG.sound.music.volume += 0.5*_variables.mvolume/100 * FlxG.elapsed;
		}

        lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5/(_variables.fps/60)));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "PERSONAL BEST:" + lerpScore;

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
        var up = controls.UP;
		var down = controls.DOWN;
		var accepted = controls.ACCEPT;
        var back = controls.BACK;
        var shift = controls.SHIFT;

        if (!substated && selectable)
            {
                if (upP || shift && up)
                    changeSelection(-1);
                if (downP || shift && down)
                    changeSelection(1);
    
                if (controls.LEFT_P)
                    changeDiff(-1);
                if (controls.RIGHT_P)
                    changeDiff(1);
    
                if (back)
                {
                    substated = true;

                    FlxG.sound.play(Paths.sound('cancelMenu'), _variables.svolume / 100);
    
                    #if mobile
                    remove(_virtualpad);
                    #end
                    FlxG.state.openSubState(new Marathon_Substate());
                }

                if (accepted)
                {
                    PlayState.difficultyPlaylist.push(Std.string(difficulties[curDifficulty]));
                    PlayState.storyPlaylist.push(Std.string(songs[curSelected].songName.toLowerCase()));

                    MenuMusic.ConfirmSound();
                    saveCurrent();
                }
            }
        scoreText.x = FlxG.width/2 - scoreText.width/2;

        if (no)
        {
            bg.kill();
            side.kill();
            gradientBar.kill();
            checker.kill();
            sprDifficulty.kill();
            scoreText.kill();
            grpSongs.clear();
        }
    }

    function updateDifficultyList():Void
    {
        switch (songs[curSelected].songName.toLowerCase())
        {
            default:
                difficulties = [0,1,2];
            case 'tutorial-bnb':
                difficulties = [0,1,2,3];
            case 'jump-in':
                difficulties = [0,1,2,3];
            case 'swing':
                difficulties = [0,1,2,3];
            case 'split': 
                difficulties = [0,1,2,3];
            case 'final-destination':
                difficulties = [0,1,2,4];
        }

        if (curDifficulty > difficulties.length - 1)
            curDifficulty = 0;
        if (curDifficulty < 0)
            curDifficulty = difficulties.length - 1;

        switch (difficulties[curDifficulty])
        {
            case 0:			
                sprDifficulty.animation.play('easy');
            case 1:
                sprDifficulty.animation.play('normal');
            case 2:
                sprDifficulty.animation.play('hard');
            case 3:
                sprDifficulty.animation.play('expert');
            case 4:
                sprDifficulty.animation.play('insane');
        }
    }

    function changeDiff(change:Int = 0)
        {
            curDifficulty += change;
    
            if (curDifficulty > difficulties.length - 1)
                curDifficulty = 0;
            if (curDifficulty < 0)
                curDifficulty = difficulties.length - 1;
    
            #if !switch
                intendedScore = Std.int(FlxG.save.data.marathonScore);
            #end
    
            switch (difficulties[curDifficulty])
            {
                case 0:			
                    sprDifficulty.animation.play('easy');
                case 1:
                    sprDifficulty.animation.play('normal');
                case 2:
                    sprDifficulty.animation.play('hard');
                case 3:
                    sprDifficulty.animation.play('expert');
                case 4:
                    sprDifficulty.animation.play('insane');
            }
    
            sprDifficulty.alpha = 0;
    
            sprDifficulty.y = FlxG.height - sprDifficulty.height - 38;
            FlxTween.tween(sprDifficulty, {y: FlxG.height - sprDifficulty.height - 8, alpha: 1}, 0.04);
            sprDifficulty.x = FlxG.width/2 - sprDifficulty.width/2;
        }
    
        function changeSelection(change:Int = 0)
        {
    
            // NGio.logEvent('Fresh');
            MenuMusic.ScrollSound();
    
            curSelected += change;
    
            if (curSelected < 0)
                curSelected = songs.length - 1;
            if (curSelected >= songs.length)
                curSelected = 0;
    
            // selector.y = (70 * curSelected) + 30;
    
            #if !switch
                intendedScore = Std.int(FlxG.save.data.marathonScore);
            #end
    
            var bullShit:Int = 0;
    
            for (item in grpSongs.members)
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

    public static function loadCurrent()
    {
        FlxG.save.bind('save', "Funkin Megapack");
        _marathon = FlxG.save.data._marathon;

        if (FlxG.save.data._marathon == null)
        {
            trace ('Error loading Marathon List!');
            _marathon = {
                songDifficulties: [],
                songNames: []
            }

            saveCurrent();
            loadCurrent();
        }
        else
        {
            _marathon = FlxG.save.data._marathon;
    
            PlayState.difficultyPlaylist = _marathon.songDifficulties;
            PlayState.storyPlaylist = _marathon.songNames;
            trace ('Loaded Marathon List!');
        }
    }

    public static function saveCurrent()
    {
        _marathon = {
            songDifficulties: PlayState.difficultyPlaylist,
            songNames: PlayState.storyPlaylist
        }
        
        FlxG.save.data._marathon = _marathon;
        FlxG.save.flush();
        trace ('Saved Marathon List!');
    }
}

class SongTitles
{
	public var songName:String = "";

	public function new(song:String)
	{
		this.songName = song;
	}
}