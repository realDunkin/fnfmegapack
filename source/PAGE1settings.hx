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
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import MainVariables._variables;
import flixel.tweens.FlxEase;

using StringTools;

class PAGE1settings extends MusicBeatSubstate
{

    var menuItems:FlxTypedGroup<FlxSprite>;
    var optionShit:Array<String> = ['page', 'keybind', #if !mobile 'resolution',#end 'fullscreen', #if !mobile 'fpsCounter', 'memory',#end 'fps', 'brightness', 'gamma', 'filter', 'watermark'];

    private var grpSongs:FlxTypedGroup<Alphabet>;
    var selectedSomethin:Bool = false;
    var curSelected:Int = 0;
    var camFollow:FlxObject;

    var ResultText:FlxText = new FlxText(20, 69, FlxG.width, "", 48);
    var ExplainText:FlxText = new FlxText(20, 69, FlxG.width/2, "", 48);

    var fil:Int = 0;

    var cs:Int = 0;

    var camLerp:Float = 0.32;

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

        FlxG.camera.follow(camFollow, null, camLerp);

        #if desktop
			DiscordClient.changePresence("Settings page: General", null);
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
            switch (_variables.filter)
            {
                case 'none':
                    fil = 0;
                case 'tritanopia':
                    fil = 1;
                case 'protanopia':
                    fil = 2;
                case 'deutranopia':
                    fil = 3;
                case 'virtual boy':
                    fil = 4;
                case 'gameboy':
                    fil = 5;
                case 'downer':
                    fil = 6;
                case 'grayscale':
                    fil = 7;
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
                        changeStuff(-1);
                    }
        
                    if (controls.RIGHT_P || controls.SHIFT && controls.RIGHT)
                    {
                        changeStuff(1);
                    }
                    
                    if (controls.ACCEPT)
                    {
                        switch (optionShit[curSelected])
                        {
                            case "keybind":
                            {
                                FlxG.state.openSubState(new KeyBindMenu());
                                selectedSomethin = true;      
                            } 
                        }
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
                case "keybind":
                    ResultText.text = "CUSTOM KEYBINDS";
                    ExplainText.text = "KEYBINDS:\nPress ENTER to change keybinds.";
                case "resolution":
                    ResultText.text = FlxG.width*_variables.resolution+"x"+FlxG.height*_variables.resolution;
                    ExplainText.text = "RESOLUTION:\nChange the resolution of your game.";
                case "fullscreen":
                    ResultText.text = Std.string(_variables.fullscreen).toUpperCase();
                    ExplainText.text = "FULLSCREEN:\nMake your game stretch to your entire screen.";
                case "fpsCounter":
                    ResultText.text = Std.string(_variables.fpsCounter).toUpperCase();
                    ExplainText.text = "FPS COUNTER:\nToggle your FPS counter on or off.";
                case "fps":
                    ResultText.text = _variables.fps+" FPS";
                    ExplainText.text = "FPS CAP:\nChange your FPS cap when you want some smoother footage.";
                case "page":
                    ResultText.text = "GENERAL";
                    ExplainText.text = "Previous Page: CLEAR \nNext Page: SFX";
                case "filter":
                    ResultText.text = _variables.filter;
                    ExplainText.text = "FILTER: \nChange how colors of the game work, either for fun or if you're colorblind.";
                case "brightness":
                    ResultText.text = _variables.brightness/2+"%";
                    ExplainText.text = "BRIGHTNESS: \nChange how bright your game looks.";
                case "gamma":
                    ResultText.text = _variables.gamma/1*100+"%";
                    ExplainText.text = "GAMMA: \nChange how vibrant your game looks.";
                case "memory":
                    ResultText.text = Std.string(_variables.memory).toUpperCase();
                    ExplainText.text = "MEMORY: \nSee how your memory's acting in game.";
                case "watermark":
                    ResultText.text = Std.string(_variables.watermark).toUpperCase();
                    ExplainText.text = "WATERMARK: \nSwitch your watermark on or off.";
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

	function changeStuff(Change:Int = 0)
		{
			switch (optionShit[curSelected])
			{
				case "resolution":
					_variables.resolution += Change/2;
					if (_variables.resolution < 1)
						_variables.resolution = 1;

                    MenuMusic.ScrollSound();

                    FlxG.resizeWindow(Math.round(FlxG.width*_variables.resolution), Math.round(FlxG.height*_variables.resolution));

                    FlxG.fullscreen = false;
                    FlxG.fullscreen = _variables.fullscreen;
                case "fullscreen":
                    _variables.fullscreen = !_variables.fullscreen;

                    MenuMusic.ScrollSound();

                    FlxG.fullscreen = _variables.fullscreen;
                case "fpsCounter":
                    _variables.fpsCounter = !_variables.fpsCounter;
    
                    MenuMusic.ScrollSound();

                    Main.toggleFPS(_variables.fpsCounter);
                case "memory":
                    _variables.memory = !_variables.memory;

                    MenuMusic.ScrollSound();

                    Main.toggleMem(_variables.memory);
                case "watermark":
                    _variables.watermark = !_variables.watermark;
            
                    MenuMusic.ScrollSound();

                    Main.watermark.visible = _variables.watermark;
                case "fps":
                    #if sys
                    _variables.fps += 10*Change;
                    if (_variables.fps < 60)
                        _variables.fps = 60;
                    if (_variables.fps > 480)
                        _variables.fps = 480;
                    #end
                    #if !sys
                    _variables.fps += 10*Change;
                    if (_variables.fps < 30)
                        _variables.fps = 30;
                    if (_variables.fps > 140)
                        _variables.fps = 140;
                    #end
    
                    MenuMusic.ScrollSound();

                    new FlxTimer().start(0.1, function(tmr:FlxTimer)
                        {
                            FlxG.drawFramerate = _variables.fps;
                            FlxG.updateFramerate = _variables.fps;
                        }); // it was prone to skip certain values so I had to put it in a timer
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
                                openSubState(new PAGE2settings());
                            else
                                openSubState(new PAGE6settings());
                        });
                    case "filter":
                        fil += Change;
                        if (fil > 7)
                            fil = 0;
                        if (fil < 0)
                            fil = 7;
        
                        switch (fil)
                        {
                            case 0:
                                _variables.filter = 'none';
                            case 1:
                                _variables.filter = 'tritanopia';
                            case 2:
                                _variables.filter = 'protanopia';
                            case 3:
                                _variables.filter = 'deutranopia';
                            case 4:
                                _variables.filter = 'virtual boy';
                            case 5:
                                _variables.filter = 'gameboy';
                            case 6:
                                _variables.filter = 'downer';
                            case 7:
                                _variables.filter = 'grayscale';
                        }
        
                        MenuMusic.ScrollSound();

                        MainVariables.UpdateColors();
                    case "brightness":
                        _variables.brightness += Change*10;
                        if (_variables.brightness < -200)
                            _variables.brightness = -200;
                        if (_variables.brightness > 200)
                            _variables.brightness = 200;
            
                        MenuMusic.ScrollSound();

                        MainVariables.UpdateColors();
                    case "gamma":
                        _variables.gamma += Change/10;
                        if (_variables.gamma < 0.1)
                            _variables.gamma = 0.1;
                        if (_variables.gamma > 5)
                            _variables.gamma = 5;
                
                        MenuMusic.ScrollSound();
                        MainVariables.UpdateColors();
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