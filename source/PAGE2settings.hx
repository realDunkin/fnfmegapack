package;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxSubState;
import flixel.util.FlxGradient;
import flixel.text.FlxText;
import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import MainVariables._variables;
import MenuMusic;
import flixel.tweens.FlxEase;

using StringTools;

class PAGE2settings extends MusicBeatSubstate
{

    var menuItems:FlxTypedGroup<FlxSprite>;
    var optionShit:Array<String> = ['page', 'mvolume', 'svolume', 'vvolume', 'hitsound', 'hvolume', 'music', 'pausemusic', 'uisound', 'muteMiss'];

    private var grpSongs:FlxTypedGroup<Alphabet>;
    var selectedSomethin:Bool = false;
    var curSelected:Int = 0;
    var camFollow:FlxObject;

    var ResultText:FlxText = new FlxText(20, 69, FlxG.width, "", 48);
    var ExplainText:FlxText = new FlxText(20, 69, FlxG.width/2, "", 48);

    var pause:Int = 0;

    var camLerp:Float = 0.32;
    public static var mus:Int;
    public static var paumus:Int;
    public static var srlsnd:Int;
    public static var hit:Int;

    public function new()
    {
        super();

        persistentDraw = persistentUpdate = true;
        destroySubStates = false;

        menuItems = new FlxTypedGroup<FlxSprite>();
        add(menuItems);
        
		var tex = Paths.getSparrowAtlas('Options_Buttons');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(800, 30 + (i * 160));
			menuItem.frames = tex;
            menuItem.animation.addByPrefix('idle', optionShit[i] + " idle", 24, true);
            menuItem.animation.addByPrefix('select', optionShit[i] + " select", 24, true);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
            menuItem.antialiasing = true;
            menuItem.scrollFactor.x = 0;
            menuItem.scrollFactor.y = 1;

            menuItem.x = 2000;
            FlxTween.tween(menuItem, { x: 800}, 0.15, { ease: FlxEase.expoInOut });
        }

        camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);
        
        changeItem();

        createResults();

        updateResults();
        
        mus = MenuMusic.mus;
        paumus = MenuMusic.paumus;
        srlsnd = MenuMusic.srlsnd;
        hit = MenuMusic.hit;

        FlxG.camera.follow(camFollow, null, camLerp);

        #if desktop
			DiscordClient.changePresence("Settings page: SFX", null);
		#end
    }

    function createResults():Void
        {
            add(ResultText);
            ResultText.scrollFactor.x = 0;
            ResultText.scrollFactor.y = 0;
            ResultText.setFormat("VCR OSD Mono", 48, FlxColor.WHITE, CENTER);
            ResultText.x = -400;
            ResultText.y = 350;
            ResultText.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
            ResultText.alpha = 0;
            FlxTween.tween(ResultText, { alpha: 1}, 0.15, { ease: FlxEase.expoInOut });
    
            add(ExplainText);
            ExplainText.scrollFactor.x = 0;
            ExplainText.scrollFactor.y = 0;
            ExplainText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER);
            ExplainText.alignment = LEFT;
            ExplainText.x = 20;
            ExplainText.y = 624;
            ExplainText.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
            ExplainText.alpha = 0;
            FlxTween.tween(ExplainText, { alpha: 1}, 0.15, { ease: FlxEase.expoInOut });
        }

    function updateResults():Void
        {
            MenuMusic.musicUpdate();
            MenuMusic.pausemusicUpdate();
            MenuMusic.scrollsoundUpdate();
            MenuMusic.hitsoundUpdate();
        }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (!selectedSomethin)
            {
                if (controls.UP_P || controls.SHIFT && controls.UP)
                {
                    MenuMusic.ScrollSound();
                    changeItem(-1);
                }
    
                if (controls.DOWN_P || controls.SHIFT && controls.DOWN)
                {
                    MenuMusic.ScrollSound();
                    changeItem(1);
                }
        
            if (controls.LEFT_P || controls.SHIFT && controls.LEFT)
                {
                    changePress(-1);
                }
    
            if (controls.RIGHT_P || controls.SHIFT && controls.RIGHT)
                {
                    changePress(1);
                }

            if (!controls.SHIFT && controls.LEFT || controls.SHIFT && controls.LEFT_P)
                {
                    changeHold(-1);
                }
        
            if (!controls.SHIFT && controls.RIGHT || controls.SHIFT && controls.RIGHT_P)
                {
                    changeHold(1);
                }
            
                if (controls.BACK)
                    {
                        FlxG.sound.play(Paths.sound('cancelMenu'), _variables.svolume/100);
                        selectedSomethin = true;

                        #if desktop
                            DiscordClient.changePresence("Back to the main menu I go!", null);
                        #end

                        menuItems.forEach(function(spr:FlxSprite)
                            {
                                spr.animation.play('idle');
                                FlxTween.tween(spr, { x: -1000}, 0.15, { ease: FlxEase.expoIn });
                            });
                        
                        FlxTween.tween(FlxG.camera, { zoom: 7}, 0.5, { ease: FlxEase.expoIn, startDelay: 0.2 });
                        FlxTween.tween(ResultText, { alpha: 0}, 0.15, { ease: FlxEase.expoIn });
                        FlxTween.tween(ExplainText, { alpha: 0}, 0.15, { ease: FlxEase.expoIn });

                        new FlxTimer().start(0.3, function(tmr:FlxTimer)
                            {
                                FlxG.switchState(new MainMenuState());
                            });
                    }
                }
        
        switch (optionShit[curSelected])
        {
            case "mvolume":
                ResultText.text = _variables.mvolume+"%";
                ExplainText.text = "MUSIC VOLUME:\nChange the volume of your music.";
            case "svolume":
                ResultText.text = _variables.svolume+"%";
                ExplainText.text = "SOUND VOLUME:\nChange the volume of some ambience and other sounds.";
            case "vvolume":
                ResultText.text = _variables.vvolume+"%";
                ExplainText.text = "VOCAL VOLUME:\nChange the volume of vocals heard in songs.";
            case "page":
                ResultText.text = "SFX";
                ExplainText.text = "Previous Page: GENERAL \nNext Page: GFX";
            case "muteMiss":
                ResultText.text = Std.string(_variables.muteMiss).toUpperCase();
                ExplainText.text = "MUTE ON MISS:\nMute vocals when you miss a note.";
            case "music":
                ResultText.text = Std.string(_variables.music).toUpperCase();
                ExplainText.text = "MENU MUSIC:\nChange your very own menu music.";
            case "pausemusic":
                ResultText.text = Std.string(_variables.pausemusic).toUpperCase();
                ExplainText.text = "PAUSE MUSIC:\nChange your very own pause music.";
            case "uisound":
                ResultText.text = Std.string(_variables.scrollsound).toUpperCase();
                ExplainText.text = "UI NOISE:\nChange the menu ui sound effects.";
            case "hvolume":
                ResultText.text = _variables.hvolume + "%";
                ExplainText.text = "HITSOUND VOLUME:\nChange the volume of note hitsounds.";
            case "hitsound":
                ResultText.text = Std.string(_variables.hitsound).toUpperCase();
                ExplainText.text = "HITSOUND:\nChange what sound you want to play when you hit a note to get you into rhythm.";
        }

        menuItems.forEach(function(spr:FlxSprite)
            {
                spr.scale.set(FlxMath.lerp(spr.scale.x, 0.8, camLerp/(_variables.fps/60)), FlxMath.lerp(spr.scale.y, 0.8, 0.4/(_variables.fps/60)));
                
                if (spr.ID == curSelected)
                {
                    camFollow.y = FlxMath.lerp(camFollow.y, spr.getGraphicMidpoint().y, camLerp/(_variables.fps/60));
                    camFollow.x = spr.getGraphicMidpoint().x;
                    spr.scale.set(FlxMath.lerp(spr.scale.x, 1.1, camLerp/(_variables.fps/60)), FlxMath.lerp(spr.scale.y, 1.1, 0.4/(_variables.fps/60)));
                }

                spr.updateHitbox();
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
        }

	function changePress(Change:Int = 0)
		{
			switch (optionShit[curSelected])
			{
                case "muteMiss":
                    _variables.muteMiss = !_variables.muteMiss;
        
                    MenuMusic.ScrollSound();
                case 'page':
                    SettingsState.page += Change;
                    MenuMusic.ScrollSound();
                    selectedSomethin = true;
        
                    menuItems.forEach(function(spr:FlxSprite)
                        {
                            spr.animation.play('idle');
                            FlxTween.tween(spr, { x: -1000}, 0.15, { ease: FlxEase.expoIn });
                        });

                    FlxTween.tween(ResultText, { alpha: 0}, 0.15, { ease: FlxEase.expoIn });
                    FlxTween.tween(ExplainText, { alpha: 0}, 0.15, { ease: FlxEase.expoIn });
    
                    new FlxTimer().start(0.2, function(tmr:FlxTimer)
                        {
                            if (Change == 1)
                                openSubState(new PAGE3settings());
                            else
                                openSubState(new PAGE1settings());
                        });
                case "music":
                    mus += Change;
                    if (mus > MenuMusic.musmax)
                        mus = 0;
                    if (mus < 0)
                        mus = MenuMusic.musmax;
                    MenuMusic.switchMusic();
                case "pausemusic":
                    paumus += Change;
                    if (paumus > MenuMusic.paumusmax)
                        paumus = 0;
                    if (paumus < 0)
                        paumus = MenuMusic.paumusmax;
                    MenuMusic.switchPauseMusic();
                case "uisound":
                    srlsnd += Change;
                    if (srlsnd > MenuMusic.srlsndmax)
                        srlsnd = 0;
                    if (srlsnd < 0)
                        srlsnd = MenuMusic.srlsndmax;
                    MenuMusic.switchScrollSound();
                    MenuMusic.ScrollSound();
                case "hitsound":
                    hit += Change;
                    if (hit > MenuMusic.hitmax)
                        hit = 0;
                    if (hit < 0)
                        hit = MenuMusic.hitmax;
        
                    MenuMusic.switchHitSound();

                    trace (_variables.hitsound);

                    if (_variables.hitsound.toLowerCase() != 'none')
                        FlxG.sound.play(Paths.sound('hitsounds/' + _variables.hitsound), _variables.hvolume/100);
			}

            new FlxTimer().start(0.2, function(tmr:FlxTimer)
                {
                    MainVariables.Save();
                });
		}
    
        function changeHold(Change:Int = 0)
            {
                switch (optionShit[curSelected])
                {
                    case "mvolume":
                        _variables.mvolume += Change;
                        if (_variables.mvolume < 0)
                            _variables.mvolume = 0;
                        if (_variables.mvolume > 100)
                            _variables.mvolume = 100;
        
                        MenuMusic.ScrollSound();
                        FlxG.sound.music.volume = _variables.mvolume/100;
                    case "svolume":
                        _variables.svolume += Change;
                        if (_variables.svolume < 0)
                            _variables.svolume = 0;
                        if (_variables.svolume > 100)
                            _variables.svolume = 100;
            
                        MenuMusic.ScrollSound();
                    case "vvolume":
                        _variables.vvolume += Change;
                        if (_variables.vvolume < 0)
                            _variables.vvolume = 0;
                        if (_variables.vvolume > 100)
                            _variables.vvolume = 100;
                
                        MenuMusic.ScrollSound();

                    case "hvolume":
				        _variables.hvolume += Change;
                        if (_variables.hvolume < 0)
                            _variables.hvolume = 0;
                        if (_variables.hvolume > 100)
                            _variables.hvolume = 100;

                        MenuMusic.ScrollSound();
                }
    
                new FlxTimer().start(0.2, function(tmr:FlxTimer)
                    {
                        MainVariables.Save();
                    });
            }

    override function openSubState(SubState:FlxSubState)
        {
            super.openSubState(SubState);
        }
}