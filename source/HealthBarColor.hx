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

class HealthBarColor
{
    public static function ColorChange():Void
    {
        // healthBar
        switch (PlayState.SONG.player1)
        {
            case 'mario':
            PlayState.player1hb = 0xFFb54a5c;
            case 'gf':
            PlayState.player1hb = 0xFFed1818;
            case 'gf-car':
            PlayState.player1hb = 0xFFed1818;
            case 'gf-christmas':
            PlayState.player1hb = 0xFFed1818;
            case 'gf-pixel':
            PlayState.player1hb = 0xFFed1818;
            case 'dad':
            PlayState.player1hb = 0xFF9600db;
            case 'bf':
            PlayState.player1hb = 0xFF19dbed;
            case 'bf-christmas':
            PlayState.player1hb = 0xFF19dbed;
            case 'bf-car':
            PlayState.player1hb = 0xFF19dbed;
            case 'bf-pixel':
            PlayState.player1hb = 0xFF19dbed;
            case 'spooky':
            PlayState.player1hb = 0xFFffc180;
            case 'monster':
            PlayState.player1hb = 0xFFfff700;
            case 'monster-christmas':
            PlayState.player1hb = 0xFFfff700;
            case 'pico':
            PlayState.player1hb = 0xFF00ed14;
            case 'mom':
            PlayState.player1hb = 0xFFed00ca;
            case 'mom-car':
            PlayState.player1hb = 0xFFed00ca;
            case 'parents-christmas':
            PlayState.player1hb = 0xFFff00ea;
            case 'senpai':
            PlayState.player1hb = 0xFFffc76e;
            case 'senpai-angry':
            PlayState.player1hb = 0xFFffc76e;
            case 'spirit':
            PlayState.player1hb = 0xFFff2617;
            case 'tankman':
            PlayState.player1hb = 0xFF252626;
            case 'bf-holding-gf':
            PlayState.player1hb = 0xFF19dbed;
            case 'bfb':
            PlayState.player1hb = 0xFFff4de1;
            case 'bfb-car':
            PlayState.player1hb = 0xFFff4de1;
            case 'bfb-christmas':
            PlayState.player1hb = 0xFFff4de1;
            case 'bfb-pixel':
            PlayState.player1hb = 0xFFff4de1;
            case 'gfb':
            PlayState.player1hb = 0xFFbf2aa6;
            case 'gfb-car':
            PlayState.player1hb = 0xFFbf2aa6;
            case 'gfb-christmas':
            PlayState.player1hb = 0xFFbf2aa6;
            case 'gfb-pixel':
            PlayState.player1hb = 0xFFbf2aa6;
            case 'dadb':
            PlayState.player1hb = 0xFFffcff7;
            case 'spookyb':
            PlayState.player1hb = 0xFFffc180;
            case 'picob':
            PlayState.player1hb = 0xFF9b8fc9;
            case 'momb':
            PlayState.player1hb = 0xFFffcff7;
            case 'momb-car':
            PlayState.player1hb = 0xFFffcff7;
            case 'parentsb-christmas':
            PlayState.player1hb = 0xFFffcff7;
            case 'monsterb-christmas':
            PlayState.player1hb = 0xFF78ff88;
            case 'senpaib':
            PlayState.player1hb = 0xFFf7f7f7;
            case 'senpaib-angry':
            PlayState.player1hb = 0xFFf7f7f7;
            case 'spiritb':
            PlayState.player1hb = 0xFF66ccff;
            case 'bfb3':
            PlayState.player1hb = 0xFF45CC45;
            case 'bfb3-car':
            PlayState.player1hb = 0xFF45CC45;
            case 'bfb3-christmas':
            PlayState.player1hb = 0xFF45CC45;
            case 'bfb3-pixel':
            PlayState.player1hb = 0xFF30CC30;
            case 'gfb3':
            PlayState.player1hb = 0xFFDC96FF;
            case 'dadb3':
            PlayState.player1hb = 0xFFCCCCCC;
            case 'spookyb3':
            PlayState.player1hb = 0xFF1a334d;
            case 'picob3':
            PlayState.player1hb = 0xFFB22727;
            case 'momb3':
            PlayState.player1hb = 0xFFCC63CC;
            case 'momb3-car':
            PlayState.player1hb = 0xFFCC63CC;
            case 'parentsb3-christmas':
            PlayState.player1hb = 0xFFcc8bcc;
            case 'monsterb3-christmas':
            PlayState.player1hb = 0xFF662222;
            case 'senpaib3':
            PlayState.player1hb = 0xFF212121;
            case 'senpaib3-angry':
            PlayState.player1hb = 0xFF212121;
            case 'spiritb3':
            PlayState.player1hb = 0xFF2A52B7;
            case 'bfneo':
            PlayState.player1hb = 0xFF5EFF59;
            case 'bfneo-car':
            PlayState.player1hb = 0xFF5EFF59;
            case 'bfneo-christmas':
            PlayState.player1hb = 0xFF5EFF59;
            case 'gfneo':
            PlayState.player1hb = 0xFF702E61;
            case 'dadneo':
            PlayState.player1hb = 0xFF569ABC;
            case 'spookyneo':
            PlayState.player1hb = 0xFF6a6a9a;
            case 'piconeo':
            PlayState.player1hb = 0xFFD664B7;
            case 'momneo':
            PlayState.player1hb = 0xFF5399BC;
            case 'momneo-car':
            PlayState.player1hb = 0xFF5399BC;
            case 'whitty':
            PlayState.player1hb = 0xFF141414;
            case 'whittycrazy':
            PlayState.player1hb = 0xFFff0000;
            case 'nomongus':
            PlayState.player1hb = 0xFFffcb82;
            case 'bfmongus':
            PlayState.player1hb = 0xFF00b7ff;
            case 'gfsunset':
            PlayState.player1hb = 0xFFed1818;
            case 'gfnight':
            PlayState.player1hb = 0xFFed1818;
            case 'gfglitcher':
            PlayState.player1hb = 0xFFed1818;
            case 'bfsunset':
            PlayState.player1hb = 0xFF19dbed;
            case 'bfnight':
            PlayState.player1hb = 0xFF19dbed;
            case 'bfglitcher':
            PlayState.player1hb = 0xFF19dbed;
            case 'hex':
            PlayState.player1hb = 0xFF8c8c8c;
            case 'hexsunset':
            PlayState.player1hb = 0xFF8c8c8c;
            case 'hexnight':
            PlayState.player1hb = 0xFF8c8c8c;
            case 'hexVirus':
            PlayState.player1hb = 0xFF8c8c8c;
            case 'shaggy':
            PlayState.player1hb = 0xFF1e7002;
            case 'pshaggy':
            PlayState.player1hb = 0xFF440270;
            case 'bfmii':
            PlayState.player1hb = 0xFF19dbed;
            case 'matt':
            PlayState.player1hb = 0xFFff9900;
            case 'mattmad':
            PlayState.player1hb = 0xFFff9900;
            case 'garcello':
            PlayState.player1hb = 0xFF00f78c;
            case 'garcellotired':
            PlayState.player1hb = 0xFF00f78c;
            case 'garcellodead':
            PlayState.player1hb = 0xFFccffe9;
            case 'garcelloghosty':
            PlayState.player1hb = 0xFFccffe9;
            case 'bf-tabi-crazy':
            PlayState.player1hb = 0xFF19dbed;
            case 'bf-tabi':
            PlayState.player1hb = 0xFF19dbed;
            case 'tabi':
            PlayState.player1hb = 0xFFffc38f;
            case 'tabi-crazy':
            PlayState.player1hb = 0xFFffa769;
            case 'tricky':
            PlayState.player1hb = 0xFF325E4A;
            case 'trickyMask':
            PlayState.player1hb = 0xFF325E4A;
            case 'trickyH':
            PlayState.player1hb = 0xFFB5B5B5;
            case 'exTricky':
            PlayState.player1hb = 0xFFFF4130;
            case 'bf-hell':
            PlayState.player1hb = 0xFF19dbed;
            case 'bf-sus':
            PlayState.player1hb = 0xFF19dbed;
            case 'bfghost':
            PlayState.player1hb = 0xFF19dbed;
            case 'impostor':
            PlayState.player1hb = 0xFFFF4F4F;
            case 'impostor2':
            PlayState.player1hb = 0xFFFF4F4F;
            case 'cyrix':
            PlayState.player1hb = 0xFFC6C6C6;
            case 'cyrix-nervous':
            PlayState.player1hb = 0xFFC6C6C6;
            case 'cyrix-crazy':
            PlayState.player1hb = 0xFFC6C6C6;
            case 'zardy':
            PlayState.player1hb = 0xFFB78356;
            case 'zardyb':
            PlayState.player1hb = 0xFFC95C22;
            case 'bf-kapi':
            PlayState.player1hb = 0xFF19dbed;
            case 'kapi':
            PlayState.player1hb = 0xFF85829B;
            case 'kapimad':
            PlayState.player1hb = 0xFF85829B;
            case 'miku':
            PlayState.player1hb = 0xFF56FFFC;
            case 'miku-mad':
            PlayState.player1hb = 0xFF56FFFC;
            case 'agoti':
            PlayState.player1hb = 0xFFB7333A;
            case 'agoti-micless':
            PlayState.player1hb = 0xFFB7333A;
            case 'salty':
            PlayState.player1hb = 0xFFFF0000;
            case 'salty-car':
            PlayState.player1hb = 0xFFFF0000;
            case 'salty-christmas':
            PlayState.player1hb = 0xFFFF0000;
            case 'itsumi':
            PlayState.player1hb = 0xFFFFFFFF;
            case 'dadexe':
            PlayState.player1hb = 0xFF434141;
            case 'ghostngirl':
            PlayState.player1hb = 0xFFFF99FF;
            case 'opheebop':
            PlayState.player1hb = 0xFF000000;
            case 'connor':
            PlayState.player1hb = 0xFF3366FF;
            case 'momexe':
            PlayState.player1hb = 0xFFFB95A9;
            case 'momexe-car':
            PlayState.player1hb = 0xFFFB95A9;
            case 'opheebop-christmas':
            PlayState.player1hb = 0xFF000000;
            case 'the-manager':
            PlayState.player1hb = 0xFF0066CC;
            case 'salty-pixel':
            PlayState.player1hb = 0xFFFFFFFF;
            case 'glitch':
            PlayState.player1hb = 0xFF404040;
            case 'glitchy':
            PlayState.player1hb = 0xFF404040;
            case 'glitchhead':
            PlayState.player1hb = 0xFF404040;
            case 'sky':
            PlayState.player1hb = 0xFFA37ECC;
            case 'sky-annoyed':
            PlayState.player1hb = 0xFFA37ECC;
            case 'sky-mad':
            PlayState.player1hb = 0xFF000000;
            case 'shaggyred':
            PlayState.player1hb = 0xFF1e7002;
            case 'mattblue':
            PlayState.player1hb = 0xFFff9900;
            case 'gameandwatch':
            PlayState.player1hb = 0xFF3F3F3F;
            case 'bf-night':
            PlayState.player1hb = 0xFF19dbed;
            case 'bob':
            PlayState.player1hb = 0xFFF2E44B;
            case 'bosip':
            PlayState.player1hb = 0xFFF2E44B;
            case 'amor':
            PlayState.player1hb = 0xFF5680FF;
            case 'bf-ex':
            PlayState.player1hb = 0xFF2C65AA;
            case 'bf-night-ex':
            PlayState.player1hb = 0xFF2C65AA;
            case 'bobex':
            PlayState.player1hb = 0xFF424242;
            case 'bosipex':
            PlayState.player1hb = 0xFF424242;
            case 'amorex':
            PlayState.player1hb = 0xFFEFDB67;
            case 'gf-ex':
            PlayState.player1hb = 0xFF7F2C65;
            default:
            PlayState.player1hb = 0xFFffffff;
        }
        
        switch (PlayState.SONG.player2)
        {
            case 'mario':
            PlayState.player2hb = 0xFFb54a5c;
            case 'gf':
            PlayState.player2hb = 0xFFed1818;
            case 'gf-car':
            PlayState.player2hb = 0xFFed1818;
            case 'gf-christmas':
            PlayState.player2hb = 0xFFed1818;
            case 'gf-pixel':
            PlayState.player2hb = 0xFFed1818;
            case 'dad':
            PlayState.player2hb = 0xFF9600db;
            case 'bf':
            PlayState.player2hb = 0xFF19dbed;
            case 'bf-christmas':
            PlayState.player2hb = 0xFF19dbed;
            case 'bf-car':
            PlayState.player2hb = 0xFF19dbed;
            case 'bf-pixel':
            PlayState.player2hb = 0xFF19dbed;
            case 'spooky':
            PlayState.player2hb = 0xFFffc180;
            case 'monster':
            PlayState.player2hb = 0xFFfff700;
            case 'monster-christmas':
            PlayState.player2hb = 0xFFfff700;
            case 'pico':
            PlayState.player2hb = 0xFF00ed14;
            case 'mom':
            PlayState.player2hb = 0xFFed00ca;
            case 'mom-car':
            PlayState.player2hb = 0xFFed00ca;
            case 'parents-christmas':
            PlayState.player2hb = 0xFFff00ea;
            case 'senpai':
            PlayState.player2hb = 0xFFffc76e;
            case 'senpai-angry':
            PlayState.player2hb = 0xFFffc76e;
            case 'spirit':
            PlayState.player2hb = 0xFFff2617;
            case 'tankman':
            PlayState.player2hb = 0xFF252626;
            case 'bf-holding-gf':
            PlayState.player2hb = 0xFF19dbed;
            case 'bfb':
            PlayState.player2hb = 0xFFff4de1;
            case 'bfb-car':
            PlayState.player2hb = 0xFFff4de1;
            case 'bfb-christmas':
            PlayState.player2hb = 0xFFff4de1;
            case 'bfb-pixel':
            PlayState.player2hb = 0xFFff4de1;
            case 'gfb':
            PlayState.player2hb = 0xFFbf2aa6;
            case 'gfb-car':
            PlayState.player2hb = 0xFFbf2aa6;
            case 'gfb-christmas':
            PlayState.player2hb = 0xFFbf2aa6;
            case 'gfb-pixel':
            PlayState.player2hb = 0xFFbf2aa6;
            case 'dadb':
            PlayState.player2hb = 0xFFffcff7;
            case 'spookyb':
            PlayState.player2hb = 0xFFffc180;
            case 'picob':
            PlayState.player2hb = 0xFF9b8fc9;
            case 'momb':
            PlayState.player2hb = 0xFFffcff7;
            case 'momb-car':
            PlayState.player2hb = 0xFFffcff7;
            case 'parentsb-christmas':
            PlayState.player2hb = 0xFFffcff7;
            case 'monsterb-christmas':
            PlayState.player2hb = 0xFF78ff88;
            case 'senpaib':
            PlayState.player2hb = 0xFFf7f7f7;
            case 'senpaib-angry':
            PlayState.player2hb = 0xFFf7f7f7;
            case 'spiritb':
            PlayState.player2hb = 0xFF66ccff;
            case 'bfb3':
            PlayState.player2hb = 0xFF45CC45;
            case 'bfb3-car':
            PlayState.player2hb = 0xFF45CC45;
            case 'bfb3-christmas':
            PlayState.player2hb = 0xFF45CC45;
            case 'bfb3-pixel':
            PlayState.player2hb = 0xFF30CC30;
            case 'gfb3':
            PlayState.player2hb = 0xFFDC96FF;
            case 'dadb3':
            PlayState.player2hb = 0xFFCCCCCC;
            case 'spookyb3':
            PlayState.player2hb = 0xFF1a334d;
            case 'picob3':
            PlayState.player2hb = 0xFFB22727;
            case 'momb3':
            PlayState.player2hb = 0xFFCC63CC;
            case 'momb3-car':
            PlayState.player2hb = 0xFFCC63CC;
            case 'parentsb3-christmas':
            PlayState.player2hb = 0xFFcc8bcc;
            case 'monsterb3-christmas':
            PlayState.player2hb = 0xFF662222;
            case 'senpaib3':
            PlayState.player2hb = 0xFF212121;
            case 'senpaib3-angry':
            PlayState.player2hb = 0xFF212121;
            case 'spiritb3':
            PlayState.player2hb = 0xFF2A52B7;
            case 'bfneo':
            PlayState.player2hb = 0xFF5EFF59;
            case 'bfneo-car':
            PlayState.player2hb = 0xFF5EFF59;
            case 'bfneo-christmas':
            PlayState.player2hb = 0xFF5EFF59;
            case 'gfneo':
            PlayState.player2hb = 0xFF702E61;
            case 'dadneo':
            PlayState.player2hb = 0xFF569ABC;
            case 'spookyneo':
            PlayState.player2hb = 0xFF6a6a9a;
            case 'piconeo':
            PlayState.player2hb = 0xFFD664B7;
            case 'momneo':
            PlayState.player2hb = 0xFF5399BC;
            case 'momneo-car':
            PlayState.player2hb = 0xFF5399BC;
            case 'whitty':
            PlayState.player2hb = 0xFF141414;
            case 'whittycrazy':
            PlayState.player2hb = 0xFFff0000;
            case 'nomongus':
            PlayState.player2hb = 0xFFffcb82;
            case 'bfmongus':
            PlayState.player2hb = 0xFF00b7ff;
            case 'gfsunset':
            PlayState.player2hb = 0xFFed1818;
            case 'gfnight':
            PlayState.player2hb = 0xFFed1818;
            case 'gfglitcher':
            PlayState.player2hb = 0xFFed1818;
            case 'bfsunset':
            PlayState.player2hb = 0xFF19dbed;
            case 'bfnight':
            PlayState.player2hb = 0xFF19dbed;
            case 'bfglitcher':
            PlayState.player2hb = 0xFF19dbed;
            case 'hex':
            PlayState.player2hb = 0xFF8c8c8c;
            case 'hexsunset':
            PlayState.player2hb = 0xFF8c8c8c;
            case 'hexnight':
            PlayState.player2hb = 0xFF8c8c8c;
            case 'hexVirus':
            PlayState.player2hb = 0xFF8c8c8c;
            case 'shaggy':
            PlayState.player2hb = 0xFF1e7002;
            case 'pshaggy':
            PlayState.player2hb = 0xFF440270;
            case 'bfmii':
            PlayState.player2hb = 0xFF19dbed;
            case 'matt':
            PlayState.player2hb = 0xFFff9900;
            case 'mattmad':
            PlayState.player2hb = 0xFFff9900;
            case 'garcello':
            PlayState.player2hb = 0xFF00f78c;
            case 'garcellotired':
            PlayState.player2hb = 0xFF00f78c;
            case 'garcellodead':
            PlayState.player2hb = 0xFFccffe9;
            case 'garcelloghosty':
            PlayState.player2hb = 0xFFccffe9;
            case 'bf-tabi-crazy':
            PlayState.player2hb = 0xFF19dbed;
            case 'bf-tabi':
            PlayState.player2hb = 0xFF19dbed;
            case 'tabi':
            PlayState.player2hb = 0xFFffc38f;
            case 'tabi-crazy':
            PlayState.player2hb = 0xFFffa769;
            case 'tricky':
            PlayState.player2hb = 0xFF325E4A;
            case 'trickyMask':
            PlayState.player2hb = 0xFF325E4A;
            case 'trickyH':
            PlayState.player2hb = 0xFFB5B5B5;
            case 'exTricky':
            PlayState.player2hb = 0xFFFF4130;
            case 'bf-hell':
            PlayState.player2hb = 0xFF19dbed;
            case 'bfghost':
            PlayState.player2hb = 0xFF19dbed;
            case 'bf-sus':
            PlayState.player1hb = 0xFF19dbed;
            case 'impostor':
            PlayState.player2hb = 0xFFFF4F4F;
            case 'impostor2':
            PlayState.player2hb = 0xFFFF4F4F;
            case 'cyrix':
            PlayState.player2hb = 0xFFC6C6C6;
            case 'cyrix-nervous':
            PlayState.player2hb = 0xFFC6C6C6;
            case 'cyrix-crazy':
            PlayState.player2hb = 0xFFC6C6C6;
            case 'zardy':
            PlayState.player2hb = 0xFFB78356;
            case 'zardyb':
            PlayState.player2hb = 0xFFC95C22;
            case 'bf-kapi':
            PlayState.player1hb = 0xFF19dbed;
            case 'kapi':
            PlayState.player2hb = 0xFF85829B;
            case 'kapimad':
            PlayState.player2hb = 0xFF85829B;
            case 'miku':
            PlayState.player2hb = 0xFF56FFFC;
            case 'miku-mad':
            PlayState.player2hb = 0xFF56FFFC;
            case 'agoti':
            PlayState.player2hb = 0xFFB7333A;
            case 'agoti-micless':
            PlayState.player2hb = 0xFFB7333A;
            case 'salty':
            PlayState.player2hb = 0xFFFF0000;
            case 'salty-car':
            PlayState.player2hb = 0xFFFF0000;
            case 'salty-christmas':
            PlayState.player2hb = 0xFFFF0000;
            case 'itsumi':
            PlayState.player2hb = 0xFFFFFFFF;
            case 'dadexe':
            PlayState.player2hb = 0xFF434141;
            case 'ghostngirl':
            PlayState.player2hb = 0xFFFF99FF;
            case 'opheebop':
            PlayState.player2hb = 0xFF000000;
            case 'connor':
            PlayState.player2hb = 0xFF3366FF;
            case 'momexe':
            PlayState.player2hb = 0xFFFB95A9;
            case 'momexe-car':
            PlayState.player2hb = 0xFFFB95A9;
            case 'opheebop-christmas':
            PlayState.player2hb = 0xFF000000;
            case 'the-manager':
            PlayState.player2hb = 0xFF0066CC;
            case 'salty-pixel':
            PlayState.player2hb = 0xFFFFFFFF;
            case 'glitch':
            PlayState.player2hb = 0xFF404040;
            case 'glitchy':
            PlayState.player2hb = 0xFF404040;
            case 'glitchhead':
            PlayState.player2hb = 0xFF404040;
            case 'sky':
            PlayState.player2hb = 0xFFA37ECC;
            case 'sky-annoyed':
            PlayState.player2hb = 0xFFA37ECC;
            case 'sky-mad':
            PlayState.player2hb = 0xFF000000;
            case 'shaggyred':
            PlayState.player2hb = 0xFF1e7002;
            case 'mattblue':
            PlayState.player2hb = 0xFFff9900;
            case 'gameandwatch':
            PlayState.player2hb = 0xFF3F3F3F;
            case 'bf-night':
            PlayState.player2hb = 0xFF19dbed;
            case 'bob':
            PlayState.player2hb = 0xFFF2E44B;
            case 'bosip':
            PlayState.player2hb = 0xFFF2E44B;
            case 'amor':
            PlayState.player2hb = 0xFF5680FF;
            case 'bf-ex':
            PlayState.player2hb = 0xFF2C65AA;
            case 'bf-night-ex':
            PlayState.player2hb = 0xFF2C65AA;
            case 'bobex':
            PlayState.player2hb = 0xFF424242;
            case 'bosipex':
            PlayState.player2hb = 0xFF424242;
            case 'amorex':
            PlayState.player2hb = 0xFFEFDB67;
            case 'gf-ex':
            PlayState.player2hb = 0xFF7F2C65;
            default:
            PlayState.player2hb = 0xFFffffff;    
        }       
    }
}