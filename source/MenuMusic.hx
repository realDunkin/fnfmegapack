package;

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
import flixel.system.FlxSound;

class MenuMusic
{
    //the reason i made this so its easier to add things since its a global thing
    public static var bg:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image(''));
    public static var mus:Int;
    public static var paumus:Int;
    public static var srlsnd:Int;
    public static var hit:Int;
    public static var musmax:Int = 17;
    public static var paumusmax:Int = 6;
    public static var srlsndmax:Int = 4;
    public static var hitmax:Int = 23;

    public static function musicUpdate():Void
        {
            switch (_variables.music)
            {
                case 'classic':
                    mus = 0;
                case 'default':
                    mus = 1;
                case 'b-sides':
                    mus = 2;
                case 'B3':
                    mus = 3;
                case 'neo':
                    mus = 4;
                case 'hex':
                    mus = 6;
                case 'tricky':
                    mus = 6;
                case 'matt':
                    mus = 7;
                case 'wiik3':
                    mus = 8;
                case 'imposter':
                    mus = 9;
                case 'cyrix':
                    mus = 10;
                case 'x-event':
                    mus = 11;
                case 'a.g.o.t.i':
                    mus = 12;
                case 'salty':
                    mus = 13;
                case 'bob and bosip':
                    mus = 14;
                case 'old bob and bosip':
                    mus = 15;
                case 'desktop':
                    mus = 16;
                case 'kade engine':
                    mus = 17;
            }
        }
    public static function pausemusicUpdate():Void
    {
        switch (_variables.pausemusic)
        {
            case 'default':
                paumus = 0;
            case 'b-sides':
                paumus = 1;
            case 'B3':
                paumus = 2;
            case 'neo':
                paumus = 3;
            case 'a.g.o.t.i':
                paumus = 4;
            case 'salty':
                paumus = 5;
            case 'bob and bosip':
                paumus = 6;
        }
    }

    public static function scrollsoundUpdate():Void
    {
        switch (_variables.scrollsound)
        {
            case 'classic':
                srlsnd = 0;
            case 'default':
                srlsnd = 1;
            case 'B3':
                srlsnd = 2;
            case 'neo':
                srlsnd = 3;
            case 'a.g.o.t.i':
                srlsnd = 4;
        }
    }

    public static function hitsoundUpdate():Void
    {
        switch (_variables.hitsound)
        {
            case 'none':
                hit = 0;
            case 'absorb':
                hit = 1;
            case 'audience':
                hit = 2;
            case 'beep':
                hit = 3;
            case 'beep 2':
                hit = 4;
            case 'bells':
                hit = 5;
            case 'bells 2':
                hit = 6;
            case 'bongo':
                hit = 7;
            case 'clank':
                hit = 8;
            case 'clank 2':
                hit = 9;
            case 'clap':
                hit = 10;
            case 'clap 2':
                hit = 11;
            case 'clap 3':
                hit = 12;
            case 'cymbal':
                hit = 13;
            case 'drum':
                hit = 14;
            case 'echoclap':
                hit = 15;
            case 'golf hit':
                hit = 16;
            case 'hi-hat':
                hit = 17;
            case 'key jinglling':
                hit = 18;
            case 'osu':
                hit = 19;
            case 'shot':
                hit = 20;
            case 'snare':
                hit = 21;
            case 'switch':
                hit = 22;
            case 'wood':
                hit = 23;
        }
    }

    public static function switchMusic():Void
        {
            switch (PAGE2settings.mus)
            {
                case 1:
                    _variables.music = 'default';
                    FlxG.sound.playMusic(Paths.music('freakyMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 0:
                    _variables.music = 'classic';
                    FlxG.sound.playMusic(Paths.music('funkyMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(140);
                case 2:
                    _variables.music = 'b-sides';
                    FlxG.sound.playMusic(Paths.music('bsideMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 3: 
                    _variables.music = 'B3';
                    FlxG.sound.playMusic(Paths.music('b3Menu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 4:
                    _variables.music = 'neo';
                    FlxG.sound.playMusic(Paths.music('neoMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 5:
                    _variables.music = 'hex';
                    FlxG.sound.playMusic(Paths.music('hexMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 6:
                    _variables.music = 'tricky';
                    FlxG.sound.playMusic(Paths.musicRandom('trickymenu/nexus_', 1, 10), _variables.mvolume/100);
                    Conductor.changeBPM(90);
                case 7:
                    _variables.music = 'matt';
                    FlxG.sound.playMusic(Paths.music('mattMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 8:
                    _variables.music = 'wiik3';
                    FlxG.sound.playMusic(Paths.music('wiik3Menu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 9:
                    _variables.music = 'imposter';
                    FlxG.sound.playMusic(Paths.music('susMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 10:
                    _variables.music = 'cyrix';
                    FlxG.sound.playMusic(Paths.music('cyrixMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 11:
                    _variables.music = 'x-event';
                    FlxG.sound.playMusic(Paths.music('truce'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 12:
                    _variables.music = 'a.g.o.t.i';
                    FlxG.sound.playMusic(Paths.music('agotiMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 13:
                    _variables.music = 'salty';
                    FlxG.sound.playMusic(Paths.music('saltyMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 14:
                    _variables.music = 'bob and bosip';
                    FlxG.sound.playMusic(Paths.music('bobandbosipMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(120);
                case 15:
                    _variables.music = 'old bob and bosip';
                    FlxG.sound.playMusic(Paths.music('oldbobandbosipMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 16:
                    _variables.music = 'desktop';
                    FlxG.sound.playMusic(Paths.music('desktop'), _variables.mvolume/100);
                    Conductor.changeBPM(90);
                case 17:
                    _variables.music = 'kade engine';
                    FlxG.sound.playMusic(Paths.music('kadeMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
            }
        }
    public static function switchPauseMusic():Void
        {
            switch (PAGE2settings.paumus)
            {
                case 0:
                    _variables.pausemusic = 'default';
                case 1:
                    _variables.pausemusic = 'b-sides';
                case 2: 
                    _variables.pausemusic = 'B3';
                case 3:
                    _variables.pausemusic = 'neo';
                case 4:
                    _variables.pausemusic = 'a.g.o.t.i';
                case 5:
                    _variables.pausemusic = 'salty';
                case 6:
                    _variables.pausemusic = 'bob and bosip';
            }
        }
    public static function switchScrollSound():Void
        {
            switch (PAGE2settings.srlsnd)
            {
                case 0:
                    _variables.scrollsound = 'classic';
                case 1:
                    _variables.scrollsound = 'default';
                case 2: 
                    _variables.scrollsound = 'B3';
                case 3:
                    _variables.scrollsound = 'neo';
                case 4:
                    _variables.scrollsound = 'a.g.o.t.i';
            }
        }
    public static function switchHitSound():Void
        {
            switch (PAGE2settings.hit)
            {
                case 0:
                    _variables.hitsound = 'none';
                case 1:
                    _variables.hitsound = 'absorb';
                case 2: 
                    _variables.hitsound = 'audience';
                case 3:
                    _variables.hitsound = 'beep';
                case 4:
                    _variables.hitsound = 'beep 2';
                case 5:
                    _variables.hitsound = 'bells';
                case 6:
                    _variables.hitsound = 'bells 2';
                case 7:
                    _variables.hitsound = 'bongo';
                case 8:
                    _variables.hitsound = 'clank';
                case 9:
                    _variables.hitsound = 'clank 2';
                case 10:
                    _variables.hitsound = 'clap';
                case 11:
                    _variables.hitsound = 'clap 2';
                case 12:
                    _variables.hitsound = 'clap 3';
                case 13:
                    _variables.hitsound = 'cymbal';
                case 14:
                    _variables.hitsound = 'drum';
                case 15:
                    _variables.hitsound = 'echoclap';
                case 16:
                    _variables.hitsound = 'golf hit';
                case 17:
                    _variables.hitsound = 'hi-hat';
                case 18:
                    _variables.hitsound = 'key jinglling';
                case 19:
                    _variables.hitsound = 'osu';
                case 20:
                    _variables.hitsound = 'shot';
                case 21:
                    _variables.hitsound = 'snare';
                case 22:
                    _variables.hitsound = 'switch';
                case 23:
                    _variables.hitsound = 'wood';
            }
        }
    public static function ScrollSound():Void
        {
            switch (_variables.scrollsound)
            {
                default:
                    FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume/100);
                case 'B3':
                    FlxG.sound.play(Paths.sound('scrollMenub3'), _variables.svolume/100);
                case 'neo':
                    FlxG.sound.play(Paths.sound('scrollMenuneo'), _variables.svolume/100);
                case 'a.g.o.t.i':
                    FlxG.sound.play(Paths.sound('scrollMenuagoti'), _variables.svolume/100);
            }
        }
    public static function ConfirmSound():Void
        {
            switch (_variables.scrollsound)
            {
                default:
                    FlxG.sound.play(Paths.sound('confirmMenu'), _variables.svolume/100);
                case 'B3':
                    FlxG.sound.play(Paths.sound('confirmMenub3'), _variables.svolume/100);
                case 'neo':
                    FlxG.sound.play(Paths.sound('confirmMenuneo'), _variables.svolume/100);
                case 'a.g.o.t.i':
                    FlxG.sound.play(Paths.sound('confirmMenuagoti'), _variables.svolume/100);
            }
        }
    public static function PlayConfirmSound():Void
        {
            switch (_variables.scrollsound)
            {
                default:
                    FlxG.sound.play(Paths.sound('confirmMenu'), _variables.svolume/100);
                case 'classic':
                    FlxG.sound.play(Paths.sound('titleShoot'), _variables.svolume/100);
                case 'B3':
                    FlxG.sound.play(Paths.sound('confirmMenub3'), _variables.svolume/100);
                case 'neo':
                    FlxG.sound.play(Paths.sound('confirmMenuneo'), _variables.svolume/100);
                case 'a.g.o.t.i':
                    FlxG.sound.play(Paths.sound('confirmMenuagoti'), _variables.svolume/100);
            }
        }
    public static function startMenuMusic():Void
        {
            switch (_variables.music)
			{
                default:
					FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
					Conductor.changeBPM(102);
				case 'default':
					FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
					Conductor.changeBPM(102);
				case 'classic':
					FlxG.sound.playMusic(Paths.music('funkyMenu'), 0);
					Conductor.changeBPM(140);
				case 'b-sides':
					FlxG.sound.playMusic(Paths.music('bsideMenu'), 0);
					Conductor.changeBPM(102);
				case 'B3':
					FlxG.sound.playMusic(Paths.music('b3Menu'), 0);
					Conductor.changeBPM(102);
				case 'neo':
					FlxG.sound.playMusic(Paths.music('neoMenu'), 0);
					Conductor.changeBPM(95);
				case 'tricky':
					FlxG.sound.playMusic(Paths.music('trickymenu/Tiky_Demce'), 0);
					Conductor.changeBPM(139);
				case 'matt':
					FlxG.sound.playMusic(Paths.music('mattMenu'), 0);
					Conductor.changeBPM(102);
                case 'wiik3':
					FlxG.sound.playMusic(Paths.music('wiik3Menu'), 0);
					Conductor.changeBPM(102);
                case 'hex':
                    FlxG.sound.playMusic(Paths.music('hexMenu'), 0);
                    Conductor.changeBPM(102);
                case 'imposter':
					FlxG.sound.playMusic(Paths.music('susMenu'), 0);
					Conductor.changeBPM(102);
                case 'cyrix':
                    FlxG.sound.playMusic(Paths.music('cyrixMenu'), 0);
                    Conductor.changeBPM(102);
                case 'x-event':
                    FlxG.sound.playMusic(Paths.music('truce'), 0);
                    Conductor.changeBPM(102);
                case 'a.g.o.t.i':
                    FlxG.sound.playMusic(Paths.music('agotiMenu'), 0);
                    Conductor.changeBPM(102);
                case 'salty':
                    FlxG.sound.playMusic(Paths.music('saltyMenu'), 0);
                    Conductor.changeBPM(102);
                case 'bob and bosip':
                    FlxG.sound.playMusic(Paths.music('bobandbosipMenu'), 0);
                    Conductor.changeBPM(120);
                case 'old bob and bosip':
                    FlxG.sound.playMusic(Paths.music('oldbobandbosipMenu'), 0);
                    Conductor.changeBPM(102);
                case 'desktop':
                    FlxG.sound.playMusic(Paths.music('desktop'), 0);
                    Conductor.changeBPM(90);
                case 'kade engine':
                    FlxG.sound.playMusic(Paths.music('kadeMenu'), 0);
                    Conductor.changeBPM(102);
			}
        }
    public static function continueMenuMusic():Void
        {
            switch (_variables.music)
            {
                default:
                    FlxG.sound.playMusic(Paths.music('freakyMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'default':
                    FlxG.sound.playMusic(Paths.music('freakyMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'classic':
                    FlxG.sound.playMusic(Paths.music('funkyMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(140);
                case 'b-sides':
                    FlxG.sound.playMusic(Paths.music('bsideMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'B3':
                    FlxG.sound.playMusic(Paths.music('b3Menu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'neo':
                    FlxG.sound.playMusic(Paths.music('neoMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(95);
                case 'tricky':
                    FlxG.sound.playMusic(Paths.musicRandom('trickymenu/nexus_', 1, 10), _variables.mvolume/100);
                    Conductor.changeBPM(90);
                case 'matt':
                    FlxG.sound.playMusic(Paths.music('mattMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'wiik3':
                    FlxG.sound.playMusic(Paths.music('wiik3Menu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'hex':
                    FlxG.sound.playMusic(Paths.music('hexMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'imposter':
                    FlxG.sound.playMusic(Paths.music('susMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'cyrix':
                    FlxG.sound.playMusic(Paths.music('cyrixMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'x-event':
                    FlxG.sound.playMusic(Paths.music('truce'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'a.g.o.t.i':
                    FlxG.sound.playMusic(Paths.music('agotiMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'salty':
                    FlxG.sound.playMusic(Paths.music('saltyMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'bob and bosip':
                    FlxG.sound.playMusic(Paths.music('bobandbosipMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(120);
                case 'old bob and bosip':
                    FlxG.sound.playMusic(Paths.music('oldbobandbosipMenu'), _variables.mvolume/100);
                    Conductor.changeBPM(102);
                case 'desktop':
                    FlxG.sound.playMusic(Paths.music('desktop'), _variables.mvolume/200);
                    Conductor.changeBPM(90);
                case 'kade engine':
                    FlxG.sound.playMusic(Paths.music('kadeMenu'), _variables.mvolume/200);
                    Conductor.changeBPM(102);
            }
        }
    public static function PauseMusic():Void
        {
            switch (_variables.pausemusic)
            {
                default:
                    PauseSubState.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
                case 'b-sides':
                    PauseSubState.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfastb'), true, true);
                case 'B3':
                    PauseSubState.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfastb3'), true, true);
                case 'neo':
                    PauseSubState.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfastneo'), true, true);
                case 'a.g.o.t.i':
                    PauseSubState.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfastagoti'), true, true);
                case 'salty':
                    PauseSubState.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfastsalty'), true, true);
                case 'bob and bosip':
                    PauseSubState.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfastbobandbosip'), true, true);
            }
        }
    public static function RankMusic():Void
        {
            switch (_variables.pausemusic)
            {
                default:
                    RankingSubstate.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
                case 'b-sides':
                    RankingSubstate.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfastb'), true, true);
                case 'B3':
                    RankingSubstate.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfastb3'), true, true);
                case 'neo':
                    RankingSubstate.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfastneo'), true, true);
                case 'a.g.o.t.i':
                    RankingSubstate.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfastagoti'), true, true);
                case 'salty':
                    RankingSubstate.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfastsalty'), true, true);
                case 'bob and bosip':
                    RankingSubstate.pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfastbobandbosip'), true, true);
            }
        }
//Here are where the bg changes lmao
    public static function switchimage():Void
    {
        switch (_variables.music)
        {
            default:
                bg = new FlxSprite(0).loadGraphic(Paths.image('MenuBGs/funkin'));
            case 'neo':
                bg = new FlxSprite(0).loadGraphic(Paths.image('MenuBGs/neo'));
            case 'tricky':
                bg = new FlxSprite(0).loadGraphic(Paths.image('MenuBGs/tricky'));
            case 'matt':
                bg = new FlxSprite(0).loadGraphic(Paths.image('MenuBGs/matt'));
            case 'hex':
                bg = new FlxSprite(0).loadGraphic(Paths.image('MenuBGs/hex'));
            case 'imposter':
                bg = new FlxSprite(0).loadGraphic(Paths.image('MenuBGs/imposter'));
            case 'cyrix':
                bg = new FlxSprite(0).loadGraphic(Paths.image('MenuBGs/cyrix'));
            case 'x-event':
                bg = new FlxSprite(0).loadGraphic(Paths.image('MenuBGs/x-event'));
            case 'a.g.o.t.i':
                bg = new FlxSprite(0).loadGraphic(Paths.image('MenuBGs/agoti'));
            case 'salty':
                bg = new FlxSprite(0).loadGraphic(Paths.image('MenuBGs/salty'));
        }
    }
}