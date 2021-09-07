package;

import openfl.Lib;
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
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import MainVariables._variables;
import flixel.tweens.FlxEase;

using StringTools;

class PAGE3settings extends MusicBeatSubstate
{

    var menuItems:FlxTypedGroup<FlxSprite>;
    var optionShit:Array<String> = ['page', 'scrollpos', 'cpustrums', 'arrowskin', 'arrowskindad', 'annoncers', 'antialiasing', 'iconZoom', 'cameraZoom', 'cameraSpeed', #if !mobile 'rainbow',#end 'score', 'misses', 'accuracy', 'nps', 'rating', 'timing', 'combo', 'songPos'];

    private var grpSongs:FlxTypedGroup<Alphabet>;
    var selectedSomethin:Bool = false;
    var curSelected:Int = 0;
    var camFollow:FlxObject;

    var ResultText:FlxText = new FlxText(20, 69, FlxG.width, "", 48);
    var ExplainText:FlxText = new FlxText(20, 69, FlxG.width/2, "", 48);

    var pause:Int = 0;

    var camLerp:Float = 0.32;
    var srl:Int;
    var as:Int;
    var asdad:Int;
    var anc:Int;

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

        FlxG.camera.follow(camFollow, null, camLerp);

        #if desktop
			DiscordClient.changePresence("Settings page: GFX", null);
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
                switch (_variables.arrow)
                {
                    case 'default':
                        as = 0;
                    case 'tabi':
                        as = 1;
                    case 'kapi':
                        as = 2;
                    case 'neo':
                        as = 3;
                    case 'ddr':
                        as = 4;
                }
                switch (_variables.arrowDad)
                {
                    case 'default':
                        asdad = 0;
                    case 'tabi':
                        asdad = 1;
                    case 'kapi':
                        asdad = 2;
                    case 'neo':
                        asdad = 3;
                    case 'ddr':
                        asdad = 4;
                }
                switch (_variables.scroll)
                {
                    case 'up':
                        srl = 0;
                    case 'down':
                        srl = 1;
                    case 'left':
                        srl = 2;
                    case 'right':
                        srl = 3;
                }
                switch (_variables.annoncers)
                {
                    case 'default':
                        anc = 0;
                    case 'amor':
                        anc = 1;
                    case 'ash':
                        anc = 2;
                    case 'bluskys':
                        anc = 3;
                    case 'bob':
                        anc = 4;
                    case 'bosip':
                        anc = 5;
                    case 'cool':
                        anc = 6;
                    case 'gloopy':
                        anc = 7;
                    case 'jghost':
                        anc = 8;
                    case 'mini':
                        anc = 9;
                    case 'ron':
                        anc = 10;
                }
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
                case "arrowskin":
                    ResultText.text = Std.string(_variables.arrow).toUpperCase();
                    ExplainText.text = "ARROW SKIN:\nChanges the way notes look.";
                case "arrowskindad":
                    ResultText.text = Std.string(_variables.arrowDad).toUpperCase();
                    ExplainText.text = "OPPONENT ARROW SKIN:\nChanges the way the opponents notes look.";
                case "cpustrums":
                    ResultText.text = Std.string(_variables.cpustrums).toUpperCase();
                    ExplainText.text = "CPU STRUMS:\nChanges if the opponents arrows light up when a note is hit.";
                case "scrollpos":
                    ResultText.text = Std.string(_variables.scroll).toUpperCase();
                    ExplainText.text = "SCROLL POSITION:\nChanges where the note come from.";
                case "antialiasing":
                    ResultText.text = Std.string(_variables.antialiasing).toUpperCase();
                    ExplainText.text = "ANTIALIASING:\nIf turned off makes everything look weird, but increses performance.";
                case "annoncers":
                    ResultText.text = Std.string(_variables.annoncers).toUpperCase();
                    ExplainText.text = "ANNONCERS:\nChanges the countdown noise.";
                case "score":
                    ResultText.text = Std.string(_variables.scoreDisplay).toUpperCase();
                    ExplainText.text = "SCORE DISPLAY:\nSet your score display visible or invisible.";
                case "misses":
                    ResultText.text = Std.string(_variables.missesDisplay).toUpperCase();
                    ExplainText.text = "MISS COUNTER:\nSet your miss counter visible or invisible.";
                case "accuracy":
                    ResultText.text = Std.string(_variables.accuracyDisplay).toUpperCase();
                    ExplainText.text = "ACCURACY DISPLAY:\nSet your accuracy display visible or invisible.";
                case "page":
                    ResultText.text = "GFX";
                    ExplainText.text = "Previous Page: SFX \nNext Page: GAMEPLAY";
                case "rating":
                    ResultText.text = Std.string(_variables.ratingDisplay).toUpperCase();
                    ExplainText.text = "RATING DISPLAY:\nSet your rating display of your note hits visible or invisible.";
                case "combo":
                    ResultText.text = Std.string(_variables.comboDisplay).toUpperCase();
                    ExplainText.text = "COMBO COUNTER:\nSet your combo counter of hit notes visible or invisible.";
                case "timing":
                    ResultText.text = Std.string(_variables.timingDisplay).toUpperCase();
                    ExplainText.text = "TIMING DISPLAY:\nSet your timing display of your note hits visible or invisible.";
                case "iconZoom":
                    ResultText.text = _variables.iconZoom+"x";
                    ExplainText.text = "ICON ZOOM:\nChange how zoomed in character icons become after a beat. The more, the bigger zoom.";
                case "cameraZoom":
                    ResultText.text = _variables.cameraZoom+"x";
                    ExplainText.text = "CAMERA ZOOM:\nChange how zoomed in the camera becomes after a beat. The more, the bigger zoom.";
                case "cameraSpeed":
                    ResultText.text = _variables.cameraSpeed+"x";
                    ExplainText.text = "CAMERA SPEED:\nChange how fast should the camera go to follow a character. The more, the faster camera goes.";
                case "songPos":
                    ResultText.text = Std.string(_variables.songPosition).toUpperCase();
                    ExplainText.text = "SONG POSITION DISPLAY:\nSet your song position display visible or invisible.";
                case "nps":
                    ResultText.text = Std.string(_variables.nps).toUpperCase();
                    ExplainText.text = "NOTES PER SECOND DISPLAY:\nSet your display of notes pressed per second visible or invisible.";
                case "rainbow":
                    ResultText.text = Std.string(_variables.rainbow).toUpperCase();
                    ExplainText.text = "RAINBOW FPS:\nMake your PFS counter all rainbow.";
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
                                openSubState(new PAGE4settings());
                            else
                                openSubState(new PAGE2settings());
                        });
                case "arrowskin":
                    as += Change;
                    if (as > 4)
                        as = 0;
                    if (as < 0)
                        as = 4;
                    switch (as)
                    {
                        case 0:
                            _variables.arrow = 'default';
                        case 1:
                            _variables.arrow = 'tabi';
                        case 2:
                            _variables.arrow = 'kapi';
                        case 3:
                            _variables.arrow = 'neo';
                        case 4:
                            _variables.arrow = 'ddr';
                    }   
                case "arrowskindad":
                    asdad += Change;
                    if (asdad > 4)
                        asdad = 0;
                    if (asdad < 0)
                        asdad = 4;
                    switch (asdad)
                    {
                        case 0:
                            _variables.arrowDad = 'default';
                        case 1:
                            _variables.arrowDad = 'tabi';
                        case 2:
                            _variables.arrowDad = 'kapi';
                        case 3:
                            _variables.arrowDad = 'neo';
                        case 4:
                            _variables.arrowDad = 'ddr';
                    }     

                case "cpustrums":
                    _variables.cpustrums = !_variables.cpustrums;
        
                    MenuMusic.ScrollSound();

                case "scrollpos":
                    srl += Change;
                    if (srl > 3)
                        srl = 0;
                    if (srl < 0)
                        srl = 3;
                    switch (srl)
                    {
                        case 0:
                            _variables.scroll = 'up';
                        case 1:
                            _variables.scroll = 'down';
                        case 2:
                            _variables.scroll = 'left';
                        case 3:
                            _variables.scroll = 'right';
                    }
                case "annoncers":
                    anc += Change;
                    if (anc > 10)
                        anc = 0;
                    if (anc < 0)
                        anc = 10;
                    switch (anc)
                    {
                        case 0:
                            _variables.annoncers = 'default';
                        case 1:
                            _variables.annoncers = 'amor';
                        case 2:
                            _variables.annoncers = 'ash';
                        case 3:
                            _variables.annoncers = 'bluskys';
                        case 4:
                            _variables.annoncers = 'bob';
                        case 5:
                            _variables.annoncers = 'bosip';
                        case 6:
                            _variables.annoncers = 'cool';
                        case 7:
                            _variables.annoncers = 'gloopy';
                        case 8:
                            _variables.annoncers = 'jghost';
                        case 9:
                            _variables.annoncers = 'mini';
                        case 10:
                            _variables.annoncers = 'ron';
                    }
                case "score":
                    _variables.scoreDisplay = !_variables.scoreDisplay;
        
                    MenuMusic.ScrollSound();

                case "antialiasing":
                    _variables.antialiasing = !_variables.antialiasing;
        
                    MenuMusic.ScrollSound();

                case "misses":
                    _variables.missesDisplay = !_variables.missesDisplay;
            
                    MenuMusic.ScrollSound();

                case "songPos":
                    _variables.songPosition = !_variables.songPosition;
                
                    MenuMusic.ScrollSound();

                case "accuracy":
                    _variables.accuracyDisplay = !_variables.accuracyDisplay;
            
                    MenuMusic.ScrollSound();

                case "rainbow":
                    _variables.rainbow = !_variables.rainbow;
                    
                    if (!_variables.rainbow)
                        (cast (Lib.current.getChildAt(0), Main)).changeColor(0xFFFFFFFF);
                
                    MenuMusic.ScrollSound();

                case "rating":
                    _variables.ratingDisplay = !_variables.ratingDisplay;
            
                    MenuMusic.ScrollSound();

                case "timing":
                    _variables.timingDisplay = !_variables.timingDisplay;
                
                    MenuMusic.ScrollSound();

                case "combo":
                    _variables.comboDisplay = !_variables.comboDisplay;
                
                    MenuMusic.ScrollSound();

                case "nps":
                    _variables.nps = !_variables.nps;
                    
                    MenuMusic.ScrollSound();

                case "iconZoom":
                    _variables.iconZoom += Change/4;
                    if (_variables.iconZoom < 0)
                        _variables.iconZoom = 0;
    
                    MenuMusic.ScrollSound();

                case "cameraZoom":
                    _variables.cameraZoom += Change/4;
                    if (_variables.cameraZoom < 0)
                        _variables.cameraZoom = 0;
        
                    MenuMusic.ScrollSound();

                case "cameraSpeed":
                    _variables.cameraSpeed += Change/10;
                    if (_variables.cameraSpeed < 0.1)
                        _variables.cameraSpeed = 0.1;
            
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