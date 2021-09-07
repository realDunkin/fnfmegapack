package;
import openfl.display.FPS;
import lime.utils.Assets;
import haxe.Json;
import openfl.events.IOErrorEvent;
import openfl.events.Event;
import openfl.net.FileReference;
import flixel.FlxG;
import haxe.io.Path;
import openfl.filters.ColorMatrixFilter;
import openfl.filters.BitmapFilter;

typedef Variables =
{
    var resolution:Float;
    var fullscreen:Bool;
    var fps:Int;
    var mvolume:Int;
    var svolume:Int;
    var vvolume:Int;
    var hvolume:Int;
    var scoreDisplay:Bool;
    var missesDisplay:Bool;
    var accuracyDisplay:Bool;
    var noteOffset:Int;
    var spamPrevention:Bool;
    var firstTime:Bool;
    var accuracyType:String;
    var combotextDisplay:Bool;
    var ratingDisplay:Bool;
    var timingDisplay:Bool;
    var comboDisplay:Bool;
    var iconZoom:Float;
    var cameraZoom:Float;
    var cameraSpeed:Float;
    var filter:String;
    var brightness:Int;
    var gamma:Float;
    var muteMiss:Bool;
    var scroll:String;
    var songPosition:Bool;
    var nps:Bool;
    var fpsCounter:Bool;
    var comboP:Bool;
    var memory:Bool;
    var cutscene:Bool;
    var music:String;
    var watermark:Bool;
    var rainbow:Bool;
    var lateD:Bool;
    var sickX:Float;
    var sickY:Float;
    var antialiasing:Bool;
    var cpustrums:Bool;
    var pausemusic:String;
    var scrollsound:String;
    var hitsound:String;
    var arrow:String;
    var arrowDad:String;
    var noteSplashes:Bool;
    var botplay:Bool;
    var annoncers:String;
}

typedef CustomKeyBinds =
{
    var leftBind:String;
    var downBind:String;
    var upBind:String;
    var rightBind:String;

    var l1Bind:String;
    var u1Bind:String;
    var r1Bind:String;
    var l2Bind:String;
    var d1Bind:String;
    var r2Bind:String;

    var n0Bind:String;
    var n1Bind:String;
    var n2Bind:String;
    var n3Bind:String;
    var n4Bind:String;
    var n5Bind:String;
    var n6Bind:String;
    var n7Bind:String;
    var n8Bind:String;
}

class MainVariables
{
    public static var _variables:Variables;

    public static var _keybind:CustomKeyBinds;

    public static var filters:Array<BitmapFilter> = [];
    public static var matrix:Array<Float>;

    public static function FTSave():Void
    {
        _variables.firstTime = false;
        Save();
    }

    public static function Save():Void
    {
        FlxG.save.data._variables = _variables;
        FlxG.save.flush();
        trace ('Saved Settings!');
    }

    public static function SaveCustomBinds():Void
    {
        FlxG.save.data._keybind = _keybind;
        FlxG.save.flush();
        trace ('Saved Custom Binds!');
    }

    public static function ResetCustomBinds():Void
    {
        _keybind = {
            upBind: "W",
            leftBind: "A",
            downBind: "S",
            rightBind: "D",

            l1Bind: "A",
            u1Bind: "S",
            r1Bind: "D",
            l2Bind: "LEFT",
            d1Bind: "DOWN",
            r2Bind: "RIGHT",

            n0Bind: "A",
            n1Bind: "S",
            n2Bind: "D",
            n3Bind: "F",
            n4Bind: "SPACE",
            n5Bind: "H",
            n6Bind: "J",
            n7Bind: "K",
            n8Bind: "L"
        };

        SaveCustomBinds();
    }

    public static function DeleteSave():Void
    {
        _variables = {
            resolution: 1,
            fullscreen: false,
            fps: 60,
            mvolume: 100,
            svolume: 100,
            vvolume: 100,
            hvolume: 100,
            scoreDisplay: true,
            missesDisplay: true,
            accuracyDisplay: true,
            combotextDisplay: true,
            noteOffset: 0,
            spamPrevention: false,
            firstTime: true,
            accuracyType: 'complex',
            ratingDisplay: true,
            timingDisplay: true,
            comboDisplay: true,
            iconZoom: 1,
            cameraZoom: 1,
            cameraSpeed: 1,
            filter: 'none',
            brightness: 0,
            gamma: 1,
            muteMiss: true,
            fpsCounter: true,
            songPosition: true,
            nps: true,
            comboP: true,
            memory: true,
            cutscene: true,
            music: "default",
            watermark: false,
            rainbow: false,
            lateD: false,
            sickX: 650,
            sickY: 320,
            //up to do in week 7 update
            scroll: 'up',
            antialiasing: true,
            cpustrums: false,
            pausemusic: "default",
            scrollsound: "default",
            hitsound: "none",
            arrow: "default",
            arrowDad: "default",
            noteSplashes: true,
            botplay: false,
            annoncers: "default"
        };

        Save();
    }

    public static function Load():Void
    {   
        FlxG.save.bind('save', "Funkin Megapack");

        if (FlxG.save.data._variables == null)
        {
            trace ('Error loading shit');
            _variables = {
                resolution: 1,
                fullscreen: false,
                fps: 60,
                mvolume: 100,
                svolume: 100,
                vvolume: 100,
                hvolume: 100,
                scoreDisplay: true,
                missesDisplay: true,
                accuracyDisplay: true,
                combotextDisplay: true,
                noteOffset: 0,
                spamPrevention: false,
                firstTime: true,
                accuracyType: 'complex',
                ratingDisplay: true,
                timingDisplay: true,
                comboDisplay: true,
                iconZoom: 1,
                cameraZoom: 1,
                cameraSpeed: 1,
                filter: 'none',
                brightness: 0,
                gamma: 1,
                muteMiss: true,
                fpsCounter: true,
                songPosition: true,
                nps: true,
                comboP: true,
                memory: true,
                cutscene: true,
                music: "default",
                watermark: false,
                rainbow: false,
                lateD: false,
                sickX: 650,
                sickY: 320,
                //up to do in week 7 update
                scroll: 'up',
                antialiasing: true,
                cpustrums: false,
                pausemusic: "default",
                scrollsound: "default",
                hitsound: "none",
                arrow: "default",
                arrowDad: "default",
                noteSplashes: true,
                botplay: false,
                annoncers: "default"
            };
            Save();
            Load();
            trace (_variables);
        }
        else
        {
            _variables = FlxG.save.data._variables;
            trace ('Loaded Shit!');
            trace (_variables);
            
            #if !mobile
            FlxG.drawFramerate = _variables.fps;
            FlxG.updateFramerate = _variables.fps;
            FlxG.resizeWindow(Math.round(FlxG.width*_variables.resolution), Math.round(FlxG.height*_variables.resolution));      
            Main.toggleFPS(_variables.fpsCounter);
            Main.toggleMem(_variables.memory);         
            trace ('not mobile dw');
            #end
            FlxG.fullscreen = _variables.fullscreen;
            Main.watermark.visible = _variables.watermark;

            UpdateColors();
        }     
    }

    public static function LoadCustomBinds():Void
    {
        FlxG.save.bind('save', "Funkin Megapack");

        if (FlxG.save.data._keybind == null)
        {
            trace ('Error loading binds');
            _keybind = {
                upBind: "W",
                leftBind: "A",
                downBind: "S",
                rightBind: "D",

                l1Bind: "A",
                u1Bind: "S",
                r1Bind: "D",
                l2Bind: "LEFT",
                d1Bind: "DOWN",
                r2Bind: "RIGHT",

                n0Bind: "A",
                n1Bind: "S",
                n2Bind: "D",
                n3Bind: "F",
                n4Bind: "SPACE",
                n5Bind: "H",
                n6Bind: "J",
                n7Bind: "K",
                n8Bind: "L"
            };
            SaveCustomBinds();
            LoadCustomBinds();
            trace (_keybind);
        }
        else
        {
            _keybind = FlxG.save.data._keybind;
            
            if (_keybind.upBind == null){
                _keybind.upBind = "W";
            }
            if (_keybind.downBind == null){
                _keybind.downBind = "S";
            }   
            if (_keybind.leftBind == null){
                _keybind.leftBind = "A";
            }
            if (_keybind.rightBind == null){
                _keybind.rightBind = "D";
            }

            if (_keybind.l1Bind == null){
                _keybind.l1Bind = "A";
            }
            if (_keybind.u1Bind == null){
                _keybind.u1Bind = "S";
            }   
            if (_keybind.r1Bind == null){
                _keybind.r1Bind = "D";
            }
            if (_keybind.l2Bind == null){
                _keybind.l2Bind = "LEFT";
            }
            if (_keybind.d1Bind == null){
                _keybind.d1Bind = "DOWN";
            }   
            if (_keybind.r2Bind == null){
                _keybind.r2Bind = "RIGHT";
            }

            if (_keybind.n0Bind == null){
                _keybind.n0Bind = "A";
            }
            if (_keybind.n1Bind == null){
                _keybind.n1Bind = "S";
            }   
            if (_keybind.n2Bind == null){
                _keybind.n2Bind = "D";
            }
            if (_keybind.n3Bind == null){
                _keybind.n3Bind = "F";
            }
            if (_keybind.n4Bind == null){
                _keybind.n4Bind = "SPACE";
            }   
            if (_keybind.n5Bind == null){
                _keybind.n5Bind = "H";
            }
            if (_keybind.n6Bind == null){
                _keybind.n6Bind = "J";
            }   
            if (_keybind.n7Bind == null){
                _keybind.n7Bind = "K";
            }
            if (_keybind.n8Bind == null){
                _keybind.n8Bind = "L";
            }

            SaveCustomBinds();
            trace ('Loaded Binds!');
            trace (_keybind);
        }
    }

    public static function UpdateColors():Void
    {
        filters = [];
        
        switch (_variables.filter)
        {
            case 'none':
                matrix = [
                    1 * _variables.gamma, 0, 0, 0, _variables.brightness,
                    0, 1 * _variables.gamma, 0, 0, _variables.brightness,
                    0, 0, 1 * _variables.gamma, 0, _variables.brightness,
                    0, 0, 0, 1, 0,
                ];
            case 'tritanopia':
                matrix = [
                    0.20 * _variables.gamma, 0.99 * _variables.gamma, -.19 * _variables.gamma, 0, _variables.brightness,
                    0.16 * _variables.gamma, 0.79 * _variables.gamma, 0.04 * _variables.gamma, 0, _variables.brightness,
                    0.01 * _variables.gamma, -.01 * _variables.gamma,    1 * _variables.gamma, 0, _variables.brightness,
                       0,    0,    0, 1, 0,
                ];
            case 'protanopia':
                matrix = [
                    0.20 * _variables.gamma, 0.99 * _variables.gamma, -.19 * _variables.gamma, 0, _variables.brightness,
                    0.16 * _variables.gamma, 0.79 * _variables.gamma, 0.04 * _variables.gamma, 0, _variables.brightness,
                    0.01 * _variables.gamma, -.01 * _variables.gamma,    1 * _variables.gamma, 0, _variables.brightness,
                       0,    0,    0, 1, 0,
                ];
            case 'deutranopia':
                matrix = [
                    0.43 * _variables.gamma, 0.72 * _variables.gamma, -.15 * _variables.gamma, 0, _variables.brightness,
                    0.34 * _variables.gamma, 0.57 * _variables.gamma, 0.09 * _variables.gamma, 0, _variables.brightness,
                    -.02 * _variables.gamma, 0.03 * _variables.gamma,    1 * _variables.gamma, 0, _variables.brightness,
                       0,    0,    0, 1, 0,
                ];
            case 'virtual boy':
                matrix = [
                    0.9 * _variables.gamma, 0, 0, 0, _variables.brightness,
                    0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0,
                    0, 0, 0, 1, 0,
                ];
            case 'gameboy':
                matrix = [
                    0, 0, 0, 0, 0,
                    0, 1.5 * _variables.gamma, 0, 0, _variables.brightness,
                    0, 0, 0, 0, 0,
                    0, 0, 0, 1, 0,
                ];
            case 'downer':
                matrix = [
                    0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0,
                    0, 0, 1.5 * _variables.gamma, 0, _variables.brightness,
                    0, 0, 0, 1, 0,
                ];
            case 'grayscale':
                matrix = [
                    .3 * _variables.gamma, .3 * _variables.gamma, .3 * _variables.gamma, 0,  _variables.brightness,
                    .3 * _variables.gamma, .3 * _variables.gamma, .3 * _variables.gamma, 0, _variables.brightness,
                    .3 * _variables.gamma, .3 * _variables.gamma, .3 * _variables.gamma, 0, _variables.brightness,
                    0, 0, 0, 1, 0,
                ];
        }

        filters.push(new ColorMatrixFilter(matrix));
        FlxG.game.filtersEnabled = true;
        FlxG.game.setFilters(filters);
    }
}