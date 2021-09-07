package;

//// Code created by Rozebud for FPS Plus (thanks rozebud)
/// modified by KadeDev for use in Kade Engine/Tricky
// modified even more by realDunkin for fnfmegapack

import flixel.util.FlxAxes;
import flixel.FlxSubState;
import flixel.input.FlxInput;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import lime.utils.Assets;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.input.FlxKeyManager;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxGradient;
import MainVariables._keybind;
import MainVariables._variables;

using StringTools;

class KeyBindMenu extends MusicBeatSubstate
{
    var keyTextDisplay:FlxText;
    var keyWarning:FlxText;
    var warningTween:FlxTween;
    var keyText:Array<String>;
    var defaultKeys:Array<String>;
    var curSelected:Int = 0;

    var keys:Array<String>;

    var tempKey:String = "";
    var blacklist:Array<String> = ["ESCAPE", "ENTER", "BACKSPACE", "SPACE"];

    var blackBox:FlxSprite;
    var infoText:FlxText;
    var numkeyText:FlxText;

    var state:String = "select";

    var curSavekey:Int = 0;
    var curkeysectionSelected:Int = 0;

	override function create()
	{	
		persistentUpdate = persistentDraw = true;

        keyTextDisplay = new FlxText(-10, -260, 1280, "", 72);
		keyTextDisplay.scrollFactor.set(0, 0);
		keyTextDisplay.setFormat("VCR OSD Mono", 40, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		keyTextDisplay.borderSize = 2;
		keyTextDisplay.borderQuality = 3;

        blackBox = new FlxSprite(0,0).makeGraphic(FlxG.width,FlxG.height,FlxColor.BLACK);
        blackBox.setGraphicSize(Std.int(blackBox.width * 100));
        add(blackBox);

        infoText = new FlxText(-10, 640, 1280, "(Escape to save, backspace to leave without saving)", 72);
		infoText.scrollFactor.set(0, 0);
		infoText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		infoText.borderSize = 2;
		infoText.borderQuality = 3;
        infoText.alpha = 0;
        infoText.screenCenter(FlxAxes.X);
        add(infoText);

        numkeyText = new FlxText(-10, 600, 1280, "< Editing : 4 Key Mode >", 72);
		numkeyText.scrollFactor.set(0, 0);
		numkeyText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		numkeyText.borderSize = 2;
		numkeyText.borderQuality = 3;
        numkeyText.alpha = 0;
        numkeyText.screenCenter(FlxAxes.X);
        add(numkeyText);
        add(keyTextDisplay);

        blackBox.alpha = 0;
        keyTextDisplay.alpha = 0;

        FlxTween.tween(keyTextDisplay, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(infoText, {alpha: 1}, 1.4, {ease: FlxEase.expoInOut});
        FlxTween.tween(numkeyText, {alpha: 1}, 1.4, {ease: FlxEase.expoInOut});
        FlxTween.tween(blackBox, {alpha: 0.7}, 1, {ease: FlxEase.expoInOut});

        changeKeymenu();
        textUpdate(); 

		super.create();

        #if mobileC
        addVirtualPad(FULL, A_B);
        _virtualpad.cameras = cameras;
        #end
	}

	override function update(elapsed:Float)
	{
        switch(state){
            case "select":
                if (controls.UP_P)
				{
					MenuMusic.ScrollSound();
					changeItem(-1);
				}

				if (controls.DOWN_P)
				{
					MenuMusic.ScrollSound();
					changeItem(1);
				}

                if (controls.LEFT_P)
                {
                    changeKeymenu(-1);
                }

                if (controls.RIGHT_P)
                {
                    changeKeymenu(1);
                }

                if (controls.ACCEPT){
                    MenuMusic.ScrollSound();
                    state = "input";
                }
                else if(FlxG.keys.justPressed.ESCAPE){
                    quit();
                    MenuMusic.ConfirmSound();
                }
				else if (controls.BACK){
                    reset();
                    FlxG.sound.play(Paths.sound('cancelMenu'), _variables.svolume/100);
                }

            case "input":
                tempKey = keys[curSelected];
                keys[curSelected] = "?";
                textUpdate();
                state = "waiting";

            case "waiting":
                if(controls.BACK){
                    keys[curSelected] = tempKey;
                    state = "select";
                    FlxG.sound.play(Paths.sound('cancelMenu'), _variables.svolume/100);
                }
                else if(controls.ACCEPT){
                    addKey(defaultKeys[curSelected]);
                    save();
                    state = "select";
                    FlxG.sound.play(Paths.sound('cancelMenu'), _variables.svolume/100);
                }
                else if(FlxG.keys.justPressed.ANY){
                    addKey(FlxG.keys.getIsDown()[0].ID.toString());
                    save();
                    state = "select";
                    MenuMusic.ConfirmSound();
                }


            case "exiting":


            default:
                state = "select";

        }

        if(FlxG.keys.justPressed.ANY)
        {
			textUpdate();
        }

		super.update(elapsed);
		
	}

    function changeKeymenu(_amountkeysection:Int = 0)
    {
        curkeysectionSelected += _amountkeysection;
                
        if (curkeysectionSelected < 0)
			curkeysectionSelected = 2;
		if (curkeysectionSelected > 2)
			curkeysectionSelected = 0;

        switch (curkeysectionSelected)
        {
            case 0:
            curSavekey = 0;
            numkeyText.text = "< Editing : 4 Key Mode >";
            keyText = ["LEFT", "DOWN", "UP", "RIGHT"];
            defaultKeys = ["A", "S", "W", "D"];
            keys = [
                _keybind.leftBind,
                _keybind.downBind,
                _keybind.upBind,
                _keybind.rightBind
                ];
            case 1:          
            curSavekey = 1;
            numkeyText.text = "< Editing : 6 Key Mode >";
            keyText = ["LEFT 1", "UP", "RIGHT 1", "LEFT 2", "DOWN", "RIGHT 2"];
            defaultKeys = ["A", "S", "D", "LEFT", "DOWN", "RIGHT"];
            keys = [
                _keybind.l1Bind,
                _keybind.u1Bind,
                _keybind.r1Bind,
                _keybind.l2Bind,
                _keybind.d1Bind,
                _keybind.r2Bind
                ];
            case 2:    
            curSavekey = 2;
            numkeyText.text = "< Editing : 9 Key Mode >";
            keyText = ["LEFT 1", "DOWN 1", "UP 1", "RIGHT 1", "MIDDLE", "LEFT 2", "DOWN 2", "UP 2", "RIGHT 2"];
            defaultKeys = ["A", "S", "D", "F", "SPACE", "H", "J", "K", "L"];
            keys = [
                _keybind.n0Bind,
                _keybind.n1Bind,
                _keybind.n2Bind,
                _keybind.n3Bind,
                _keybind.n4Bind,
                _keybind.n5Bind,
                _keybind.n6Bind,
                _keybind.n7Bind,
                _keybind.n8Bind
                ];
        }
        curSelected = 0;
        textUpdate();
    }

    function textUpdate()
    {
        keyTextDisplay.text = "\n\n";

        for(i in 0...keyText.length){

            var textStart = (i == curSelected) ? "> " : "  ";
            keyTextDisplay.text += textStart + keyText[i] + ": " + ((keys[i] + "\n"));

        }

        keyTextDisplay.screenCenter();
    }

    function save()
    {
        switch (curSavekey)
        {
            case 0:
            _keybind.leftBind = keys[0];
            _keybind.downBind = keys[1];
            _keybind.upBind = keys[2];
            _keybind.rightBind = keys[3];     
            case 1:
            _keybind.l1Bind = keys[0];
            _keybind.u1Bind = keys[1];
            _keybind.r1Bind = keys[2];
            _keybind.l2Bind = keys[3];
            _keybind.d1Bind = keys[4];
            _keybind.r2Bind = keys[5];
            case 2:
            _keybind.n0Bind = keys[0];
            _keybind.n1Bind = keys[1];
            _keybind.n2Bind = keys[2];
            _keybind.n3Bind = keys[3];
            _keybind.n4Bind = keys[4];
            _keybind.n5Bind = keys[5];
            _keybind.n6Bind = keys[6];
            _keybind.n7Bind = keys[7];
            _keybind.n8Bind = keys[8];
        }
        
        MainVariables.SaveCustomBinds();
    }

    function reset(){

        for(i in 0...keyText.length){
            keys[i] = defaultKeys[i];
        }
        quit();

    }

    function quit(){
        SettingsState.mobilecontrolshown = false;
        state = "exiting";

        save();

        

        FlxTween.tween(keyTextDisplay, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(blackBox, {alpha: 0}, 1.1, {ease: FlxEase.expoInOut, onComplete: function(flx:FlxTween){close();}});
        FlxTween.tween(infoText, {alpha: 0}, 1, {ease: FlxEase.expoInOut});

        close();
        FlxG.resetState();
    }


	function addKey(r:String){

        var shouldReturn:Bool = true;

        var notAllowed:Array<String> = [];

        for(x in blacklist){notAllowed.push(x);}

        trace(notAllowed);

        if(shouldReturn){
            keys[curSelected] = r;
            MenuMusic.ScrollSound();
        }
        else{
            keys[curSelected] = tempKey;
            MenuMusic.ScrollSound();
            keyWarning.alpha = 1;
            warningTween.cancel();
            warningTween = FlxTween.tween(keyWarning, {alpha: 0}, 0.5, {ease: FlxEase.circOut, startDelay: 2});
        }

	}

    function changeItem(_amount:Int = 0)
    {
        curSelected += _amount;
                
        if (curSelected > keyText.length - 1)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = keyText.length - 1;
    }
}
