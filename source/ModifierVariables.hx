package;

import haxe.Json;
import flixel.FlxG;

typedef ModiVariables =
{
    var Practice:Bool;
    var SingleDigits:Bool;
    var Perfect:Bool;
    var ShittyEnding:Bool;
    var BadTrip:Bool;
    var TruePerfect:Bool;
    var LivesSwitch:Bool;
    var Lives:Float;
    var BrightnessSwitch:Bool;
    var Brightness:Float;
    var HPGainSwitch:Bool;
    var HPGain:Float;
    var HPLossSwitch:Bool;
    var HPLoss:Float;
    var StartHealthSwitch:Bool;
    var StartHealth:Float;
    var Enigma:Bool;
    var VibeSwitch:Bool;
    var Vibe:Float;
    var OffbeatSwitch:Bool;
    var Offbeat:Float;
    var HitZonesSwitch:Bool;
    var HitZones:Float;
    var NoteSpeedSwitch:Bool;
    var NoteSpeed:Float;
    var InvisibleNotes:Bool;
    var SnakeNotesSwitch:Bool;
    var SnakeNotes:Float;
    var DrunkNotesSwitch:Bool;
    var DrunkNotes:Float;
    var AccelNotesSwitch:Bool;
    var AccelNotes:Float;
    var ShortsightedSwitch:Bool;
    var Shortsighted:Float;
    var LongsightedSwitch:Bool;
    var Longsighted:Float;
    var FlippedNotes:Bool;
    var HyperNotesSwitch:Bool;
    var HyperNotes:Float;
    var EelNotesSwitch:Bool;
    var EelNotes:Float;
    var StretchSwitch:Bool;
    var Stretch:Float;
    var WidenSwitch:Bool;
    var Widen:Float;
    var SeasickSwitch:Bool;
    var Seasick:Float;
    var UpsideDown:Bool;
    var Mirror:Bool;
    var CameraSwitch:Bool;
    var Camera:Float;
    var EarthquakeSwitch:Bool;
    var Earthquake:Float;
    var LoveSwitch:Bool;
    var Love:Float;
    var FrightSwitch:Bool;
    var Fright:Float;
    var MustDieSwitch:Bool;
    var MustDie:Float;
    var FreezeSwitch:Bool;
    var Freeze:Float;
    var PaparazziSwitch:Bool;
    var Paparazzi:Float;
    var JacktasticSwitch:Bool;
    var Jacktastic:Float;
}

class ModifierVariables
{
    public static var _modifiers:ModiVariables;

    public static function updateModifiers():Void
    {
        _modifiers = {
            Practice: MenuModifiers.modifierList[0].value,

            SingleDigits: MenuModifiers.modifierList[1].value,

            Perfect: MenuModifiers.modifierList[2].value,

            ShittyEnding: MenuModifiers.modifierList[3].value,

            BadTrip: MenuModifiers.modifierList[4].value,

            TruePerfect: MenuModifiers.modifierList[5].value,

            Lives: MenuModifiers.modifierList[6].curValue,
            LivesSwitch: MenuModifiers.modifierList[6].value,

            Brightness: MenuModifiers.modifierList[7].curValue,
            BrightnessSwitch: MenuModifiers.modifierList[7].value,

            HPGain: MenuModifiers.modifierList[8].curValue,
            HPGainSwitch: MenuModifiers.modifierList[8].value,

            HPLoss: MenuModifiers.modifierList[9].curValue,
            HPLossSwitch: MenuModifiers.modifierList[9].value,

            StartHealth: MenuModifiers.modifierList[10].curValue,
            StartHealthSwitch: MenuModifiers.modifierList[10].value,

            Enigma: MenuModifiers.modifierList[11].value,

            Vibe: MenuModifiers.modifierList[12].curValue,
            VibeSwitch: MenuModifiers.modifierList[12].value,

            Offbeat: MenuModifiers.modifierList[13].curValue,
            OffbeatSwitch: MenuModifiers.modifierList[13].value,

            HitZones: MenuModifiers.modifierList[14].curValue,
            HitZonesSwitch: MenuModifiers.modifierList[14].value,

            NoteSpeed: MenuModifiers.modifierList[15].curValue,
            NoteSpeedSwitch: MenuModifiers.modifierList[15].value,

            InvisibleNotes: MenuModifiers.modifierList[16].value,

            SnakeNotes: MenuModifiers.modifierList[17].curValue,
            SnakeNotesSwitch: MenuModifiers.modifierList[17].value,

            DrunkNotes: MenuModifiers.modifierList[18].curValue,
            DrunkNotesSwitch: MenuModifiers.modifierList[18].value,

            AccelNotes: MenuModifiers.modifierList[19].curValue,
            AccelNotesSwitch: MenuModifiers.modifierList[19].value,

            Shortsighted: MenuModifiers.modifierList[20].curValue,
            ShortsightedSwitch: MenuModifiers.modifierList[20].value,

            Longsighted: MenuModifiers.modifierList[21].curValue,
            LongsightedSwitch: MenuModifiers.modifierList[21].value,

            FlippedNotes: MenuModifiers.modifierList[22].value,

            HyperNotes: MenuModifiers.modifierList[23].curValue,
            HyperNotesSwitch: MenuModifiers.modifierList[23].value,

            EelNotes: MenuModifiers.modifierList[24].curValue,
            EelNotesSwitch: MenuModifiers.modifierList[24].value,

            Stretch: MenuModifiers.modifierList[25].curValue,
            StretchSwitch: MenuModifiers.modifierList[25].value,

            Widen: MenuModifiers.modifierList[26].curValue,
            WidenSwitch: MenuModifiers.modifierList[26].value,

            Jacktastic: MenuModifiers.modifierList[27].curValue,
            JacktasticSwitch: MenuModifiers.modifierList[27].value,

            Seasick: MenuModifiers.modifierList[28].curValue,
            SeasickSwitch: MenuModifiers.modifierList[28].value,

            UpsideDown: MenuModifiers.modifierList[29].value,

            Mirror: MenuModifiers.modifierList[30].value,

            Camera: MenuModifiers.modifierList[31].curValue,
            CameraSwitch: MenuModifiers.modifierList[31].value,

            Earthquake: MenuModifiers.modifierList[32].curValue,
            EarthquakeSwitch: MenuModifiers.modifierList[32].value,

            Love: MenuModifiers.modifierList[33].curValue,
            LoveSwitch: MenuModifiers.modifierList[33].value,

            Fright: MenuModifiers.modifierList[34].curValue,
            FrightSwitch: MenuModifiers.modifierList[34].value,

            MustDie: MenuModifiers.modifierList[35].curValue,
            MustDieSwitch: MenuModifiers.modifierList[35].value,

            Freeze: MenuModifiers.modifierList[36].curValue,
            FreezeSwitch: MenuModifiers.modifierList[36].value,

            Paparazzi: MenuModifiers.modifierList[37].curValue,
            PaparazziSwitch: MenuModifiers.modifierList[37].value
        };
    }

    public static function saveCurrent():Void
    {
        replaceValues();       
        FlxG.save.data._modifiers = _modifiers;
        FlxG.save.flush();
        trace ('Saved Settings!');
    }

    public static function loadCurrent():Void
    {
        FlxG.save.bind('save', "Funkin Megapack");
        if (FlxG.save.data._modifiers == null)
        {
            trace ('Error loading modifiers');
            modifierSetup();
            saveCurrent();
            loadCurrent();
        }
        else
        {
            _modifiers = FlxG.save.data._modifiers;
            trace ('Loaded Modifiers!');
            replaceValues();
        }

    }

    public static function replaceValues():Void
    {
        MenuModifiers.modifierList[0].value = _modifiers.Practice;

        MenuModifiers.modifierList[1].value = _modifiers.SingleDigits;

        MenuModifiers.modifierList[2].value = _modifiers.Perfect;

        MenuModifiers.modifierList[3].value = _modifiers.ShittyEnding;

        MenuModifiers.modifierList[4].value = _modifiers.BadTrip;

        MenuModifiers.modifierList[5].value = _modifiers.TruePerfect;

        MenuModifiers.modifierList[6].curValue = _modifiers.Lives;
        MenuModifiers.modifierList[6].value = _modifiers.LivesSwitch;

        MenuModifiers.modifierList[7].curValue = _modifiers.Brightness;
        MenuModifiers.modifierList[7].value = _modifiers.BrightnessSwitch;

        MenuModifiers.modifierList[8].curValue = _modifiers.HPGain;
        MenuModifiers.modifierList[8].value = _modifiers.HPGainSwitch;

        MenuModifiers.modifierList[9].curValue = _modifiers.HPLoss;
        MenuModifiers.modifierList[9].value = _modifiers.HPLossSwitch;

        MenuModifiers.modifierList[10].curValue = _modifiers.StartHealth;
        MenuModifiers.modifierList[10].value = _modifiers.StartHealthSwitch;
        
        MenuModifiers.modifierList[11].value = _modifiers.Enigma;

        MenuModifiers.modifierList[12].curValue = _modifiers.Vibe;
        MenuModifiers.modifierList[12].value = _modifiers.VibeSwitch;

        MenuModifiers.modifierList[13].curValue = _modifiers.Offbeat;
        MenuModifiers.modifierList[13].value = _modifiers.OffbeatSwitch;

        MenuModifiers.modifierList[14].curValue = _modifiers.HitZones;
        MenuModifiers.modifierList[14].value = _modifiers.HitZonesSwitch;

        MenuModifiers.modifierList[15].curValue = _modifiers.NoteSpeed;
        MenuModifiers.modifierList[15].value = _modifiers.NoteSpeedSwitch;

        MenuModifiers.modifierList[16].value = _modifiers.InvisibleNotes;

        MenuModifiers.modifierList[17].curValue = _modifiers.SnakeNotes;
        MenuModifiers.modifierList[17].value = _modifiers.SnakeNotesSwitch;

        MenuModifiers.modifierList[18].curValue = _modifiers.DrunkNotes;
        MenuModifiers.modifierList[18].value = _modifiers.DrunkNotesSwitch;

        MenuModifiers.modifierList[19].curValue = _modifiers.AccelNotes;
        MenuModifiers.modifierList[19].value = _modifiers.AccelNotesSwitch;

        MenuModifiers.modifierList[20].curValue = _modifiers.Shortsighted;
        MenuModifiers.modifierList[20].value = _modifiers.ShortsightedSwitch;

        MenuModifiers.modifierList[21].curValue = _modifiers.Longsighted;
        MenuModifiers.modifierList[21].value = _modifiers.LongsightedSwitch;

        MenuModifiers.modifierList[22].value = _modifiers.FlippedNotes;

        MenuModifiers.modifierList[23].curValue = _modifiers.HyperNotes;
        MenuModifiers.modifierList[23].value = _modifiers.HyperNotesSwitch;

        MenuModifiers.modifierList[24].curValue = _modifiers.EelNotes;
        MenuModifiers.modifierList[24].value = _modifiers.EelNotesSwitch;

        MenuModifiers.modifierList[25].curValue = _modifiers.Stretch;
        MenuModifiers.modifierList[25].value = _modifiers.StretchSwitch;

        MenuModifiers.modifierList[26].curValue = _modifiers.Widen;
        MenuModifiers.modifierList[26].value = _modifiers.WidenSwitch;

        MenuModifiers.modifierList[27].curValue = _modifiers.Jacktastic;
        MenuModifiers.modifierList[27].value = _modifiers.JacktasticSwitch;

        MenuModifiers.modifierList[28].curValue = _modifiers.Seasick;
        MenuModifiers.modifierList[28].value = _modifiers.SeasickSwitch;

        MenuModifiers.modifierList[29].value = _modifiers.UpsideDown;

        MenuModifiers.modifierList[30].value = _modifiers.Mirror;

        MenuModifiers.modifierList[31].curValue = _modifiers.Camera;
        MenuModifiers.modifierList[31].value = _modifiers.CameraSwitch;

        MenuModifiers.modifierList[32].curValue = _modifiers.Earthquake;
        MenuModifiers.modifierList[32].value = _modifiers.EarthquakeSwitch;

        MenuModifiers.modifierList[33].curValue = _modifiers.Love;
        MenuModifiers.modifierList[33].value = _modifiers.LoveSwitch;

        MenuModifiers.modifierList[34].curValue = _modifiers.Fright;
        MenuModifiers.modifierList[34].value = _modifiers.FrightSwitch;

        MenuModifiers.modifierList[35].curValue = _modifiers.MustDie;
        MenuModifiers.modifierList[35].value = _modifiers.MustDieSwitch;

        MenuModifiers.modifierList[36].curValue = _modifiers.Freeze;
        MenuModifiers.modifierList[36].value = _modifiers.FreezeSwitch;

        MenuModifiers.modifierList[37].curValue = _modifiers.Paparazzi;
        MenuModifiers.modifierList[37].value = _modifiers.PaparazziSwitch;
    }

    public static function nullify():Void
    {
        for (i in MenuModifiers.modifierList) {
            i.value = false;

            if (i.type == 'number') {
                i.curValue = i.offAt;
            }
        }
    }

    public static function modifierSetup():Void
    {
        MenuModifiers.modifierList = [
            {name: 'Practice', value: false, conflicts: [1,2,3,4,5,6,8,9,10,32,33], multi: 0, realmulti: 0, equation: 'times', abs: false,  revAtLow: false, type: 'switch', minValue: 0, maxValue: 0, curValue: 0, offAt: 0, addChange: 0, string: '', explanation: "Baby mode initiate. Practice your songs however you want, you won't be dying anytime soon. Sets score rate all the way to 0. Can be switched on or off."},
            {name: 'Single Digits (SDCB)', value: false, conflicts: [0,2,3,4,5,8,9,10,11,24,32,33,34], multi: 1.5, realmulti: 0, equation: 'times', abs: false,  revAtLow: false, type: 'switch', minValue: 0, maxValue: 0, curValue: 0, offAt: 0, addChange: 0, string: '', explanation: "You can count the amount of misses on your hand. Miss 10 times and it's over for you. Multiplies score by 1.5. Can be switched on or off."},
            {name: 'Perfect (FC)', value: false, conflicts: [0,1,3,4,5,8,9,10,11,24,32,33,34], multi: 3, realmulti: 0, equation: 'times', abs: false,  revAtLow: false, type: 'switch', minValue: 0, maxValue: 0, curValue: 0, offAt: 0, addChange: 0, string: '', explanation: "You have quite a thing to deal with today. Miss only once and it's game over for you. Multiplies score by 3. Can be switched on or off."},
            {name: 'Shitty Ending (AFC)', value: false, conflicts: [0,1,2,4,5,8,9,10,11,24,32,33,34], multi: 5, realmulti: 0, equation: 'times', abs: false,  revAtLow: false, type: 'switch', minValue: 0, maxValue: 0, curValue: 0, offAt: 0, addChange: 0, string: '', explanation: "Well this will result in a trip to the toilet. Score one shit rating and it's over. Multiplies score by 5. Can be switched on or off."},
            {name: 'Bad Trip (GFC)', value: false, conflicts: [0,1,2,3,5,8,9,10,11,24,32,33,34], multi: 7, realmulti: 0, equation: 'times', abs: false,  revAtLow: false, type: 'switch', minValue: 0, maxValue: 0, curValue: 0, offAt: 0, addChange: 0, string: '', explanation: "Locomotion issues. I get it. Score one bad rating and it's over. Multiplies score by 7. Can be switched on or off."},
            {name: 'True Perfect (MFC)', value: false, conflicts: [0,1,2,3,4,8,9,10,11,24,32,33,34], multi: 9, realmulti: 0, equation: 'times', abs: false,  revAtLow: false, type: 'switch', minValue: 0, maxValue: 0, curValue: 0, offAt: 0, addChange: 0, string: '', explanation: "Good luck. Seriously, you need it. Score one good rating and it's over. Multiplies score by 9. Can be switched on or off."},
            {name: 'Lives', value: false, conflicts: [0], multi: 0.6, realmulti: 0, equation: 'division', abs: false,  revAtLow: false, type: 'number', minValue: 1, maxValue: 15, curValue: 1, offAt: 1, addChange: 1, string: '\nHEART(S)', explanation: "Set how many lives you can give yourself to save your butt from death itself. The higher, the more lives you have. Score divides by 0.6 per amount of hearts. Can be changed numerically."},
            {name: 'Brightness', value: false, conflicts: [], multi: 0.005, realmulti: 0, equation: '', abs: true,  revAtLow: false, type: 'number', minValue: -100, maxValue: 100, curValue: 0, offAt: 0, addChange: 5, string: '%\nBRIGHTNESS', explanation: "Did you do anything to the lights? Set how bright or dark the game is. Positive values are brighter, negative - darker. Adds 0.025 to the score rate with 5% or -5% of brightness. Can be changed numerically."},
            {name: 'HP Gain', value: false, conflicts: [0,1,2,3,4,5], multi: -0.2, realmulti: 0, equation: '', abs: false,  revAtLow: true, type: 'number', minValue: 0, maxValue: 10, curValue: 1, offAt: 1, addChange: 0.5, string: 'x\nHEALTH GAIN', explanation: "Nice health boost, my guy. Set how fast you can regain your health. The highter, the faster you can regenerate. You can even not do that at all. Subtracts 0.1 to the score rate with each amount. Can be changed numerically."},
            {name: 'HP Loss', value: false, conflicts: [0,1,2,3,4,5], multi: 0.2, realmulti: 0, equation: '', abs: false,  revAtLow: true, type: 'number', minValue: 0, maxValue: 10, curValue: 1, offAt: 1, addChange: 0.5, string: 'x\nHEALTH LOSS', explanation: "Why are you bruising so hard? Set how fast you can lose your health, or not lose any at all. The higher, the faster you can lose health. Adds 0.1 to the score rate with each amount. Can be changed numerically."},
            {name: 'Start Health', value: false, conflicts: [0,1,2,3,4,5], multi: -0.0025, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: -100, maxValue: 100, curValue: 0, offAt: 0, addChange: 5, string: '%\nMORE START\nHEALTH', explanation: "How much slapping did you get before going here? Set how high your heal should be at the start. The higher, the higher. Adds 0.0125 to the score rate with each amount. Can be changed numerically."},
            {name: 'Enigma', value: false, conflicts: [1,2,3,4,5], multi: 0.3, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'switch', minValue: 0, maxValue: 0, curValue: 0, offAt: 0, addChange: 0, string: '', explanation: "Your vision is blind, woooow. You won't be able to see your mistakes. Set if you want your health to be invisible. Adds 0.3 to the score rate. Can be switched on or off."},
            {name: 'Vibe', value: false, conflicts: [], multi: -0.9, realmulti: 0, equation: '', abs: false,  revAtLow: true, type: 'number', minValue: 0.8, maxValue: 1.2, curValue: 1, offAt: 1, addChange: 0.2, string: 'x\nTHE VIBE', explanation: "Are you up for a vibin' time? Set if you want to listen to speedy hi-fi classic, or vibin' lo-fi. 1 is classic, 1.2 is lofi and 0.8 is hifi music. Can be changed numberically."},
            {name: 'Offbeat', value: false, conflicts: [], multi: 0.001, realmulti: 0, equation: '', abs: true,  revAtLow: false, type: 'number', minValue: -1000, maxValue: 1000, curValue: 0, offAt: 0, addChange: 10, string: '%\nMORE NOTE\nOFFSET', explanation: "Cut the music! CUT!! Set how late or early should notes go. Higher is later. It affects vocals as well. Adds 0.1 to the score rate with each amount, even on negative aomunts. Can be changed numerically. WARNING: YOU CAN BLUE BALL IF YOU GET TOO LOW OF A NEGATIVE VALUE."},
            {name: 'Hit Zones', value: false, conflicts: [], multi: -0.08, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: -8, maxValue: 30, curValue: 0, offAt: 0, addChange: 1, string: '\nMORE SAFE\nFRAMES', explanation: "We're expecting perfection from you today. Choose how strict or lean you have to hit notes at. The higher, the leaner. The lowest negative value is very strict. Subtracts 0.8 to the multiplier with each amount. Can be changed numerically."},
            {name: 'Note Speed', value: false, conflicts: [], multi: 0.0125, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: -90, maxValue: 400, curValue: 0, offAt: 0, addChange: 2, string: '%\nMORE NOTE\nSPEED', explanation: "How speed are you gonna be? Change how fast notes have to go. The higher, the faster, and works on negatives. Adds 0.025 to the multiplier with each amount. Can be changed numerically. WARNING: YOU CAN BLUE BALL IF YOU GET TOO HIGH OF A VALUE."},
            {name: 'Invisible Notes', value: false, conflicts: [17, 18, 19], multi: 2.5, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'switch', minValue: 0, maxValue: 0, curValue: 0, offAt: 0, addChange: 0, string: '', explanation: "Today we're relying on memory. Switch notes visible or invisible. Adds 2.5 to the score rate. Can be switched on or off."},
            {name: 'Snake Notes', value: false, conflicts: [16], multi: 0.003, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 300, curValue: 0, offAt: 0, addChange: 5, string: '%\nOF SNAKE\nMOVES', explanation: "Ayyyy. I guess we're becoming snakes today. Set how much should notes swing left and right. The higher, the more they swing. Adds 0.015 to the score rate with each amount. Can be changed numerically."},
            {name: 'Drunk Notes', value: false, conflicts: [16], multi: 0.003, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 300, curValue: 0, offAt: 0, addChange: 5, string: '%\nOF DRUNK\nMOVES', explanation: "Ohhh. What the funk did you drink? Set how much notes should swing up and down. The higher, the more they swing. Adds 0.015 to the score rate with each amount. Can be changed numerically."},
            {name: 'Accelerating Notes', value: false, conflicts: [16], multi: 0.0045, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 300, curValue: 0, offAt: 0, addChange: 5, string: '%\nOF SPEED\nACCELERATION', explanation: "How do you wanna drive? Set how fast should notes accelerate from 0 to 100, either real quick or slow. The higher, the faster. Adds 0.0225 to the score rate with each amount. Can be changed numerically. WARNING: DANGEROUS TO USE AT HIGH VALUES."},
            {name: 'Shortsighted', value: false, conflicts: [16, 21], multi: 0.0045, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 100, curValue: 0, offAt: 0, addChange: 2, string: '%\nOF SCREEN\nHEIGHT', explanation: "Just go to an oculist. Change how far you can see notes in the first place. The higher, they appear from longer distances. Adds 0.009 to the score rate with each amount. Can be changed numerically."},
            {name: 'Longsighted', value: false, conflicts: [16, 20], multi: 0.0045, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 100, curValue: 0, offAt: 0, addChange: 2, string: '%\nOF SCREEN\nHEIGHT', explanation: "You need some glasses. Change the distance of when notes can disappear. The higher, the notes disappear from a shorter distance. Adds 0.009 to the score rate with each amount. Can be changed numerically."},
            {name: 'Flipped Notes', value: false, conflicts: [16], multi: 0.5, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'switch', minValue: 0, maxValue: 0, curValue: 0, offAt: 0, addChange: 0, string: '', explanation: "Oooh no. All around your head. Flip how your notes look. Left is right, up is down. Adds 0.5 to the score rate. Can be switched on or off."},
            {name: 'Hyper Notes', value: false, conflicts: [], multi: 0.009, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 300, curValue: 0, offAt: 0, addChange: 5, string: '%\nOF SUGAR\nRUSH', explanation: "...How much sugar did you eat? Come on... Give your notes a bit of sugar rush and shake them as much as possible. The higher, the more shaking. Adds 0.045 to the score rate with each amount. Can be changed numerically. WARNING: REALLY DIFFICULT AT HIGH VALUES."},
            {name: 'Eel Notes', value: false, conflicts: [1,2,3,4,5], multi: 0.01, realmulti: 0, equation: 'times', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 100, curValue: 0, offAt: 0, addChange: 10, string: '%\nOF EXTRA\nLENGTH', explanation: "Too many eels. Choose how long you want notes to be. The higher, the longer. Can be changed numerically. WARNING: TOO MUCH MIGHT CAUSE NOTES TO NOT RENDER PROPERLY AT POINTS BECAUSE OF THERE BEING TOO MANY OF THEM. USE AT YOUR RISK. TIP: You can hold to possibly win."},
            {name: 'Stretch Up', value: false, conflicts: [], multi: 0.001, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 400, curValue: 0, offAt: 0, addChange: 5, string: '%\nMORE\nSTRETCHED\n', explanation: "Tall notes are so funny, hahaha... *sarcasm* How tall notes should be? The higher the taller. Add 0.01 to the score multiplier. Can be changed numerically."},
            {name: 'Widen Up', value: false, conflicts: [], multi: 0.001, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 400, curValue: 0, offAt: 0, addChange: 5, string: '%\nMORE\nWIDE', explanation: "Thicc notes are so funny, hahaha... *sarcasm* How wide notes should be? The higher the wider. Add 0.01 to the score multiplier. Can be changed numerically."},
            {name: 'Jacktastic', value: false, conflicts: [], multi: 1.5, realmulti: 0, equation: 'times', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 500, curValue: 0, offAt: 0, addChange: 1, string: '\nMORE\nJACK(S)', explanation: "Old Whitty Ballistic chart be like. For notes, how many copies of themselves do you want over a short amount of time? The higher, the more bs the chart becomes. Multiplies the multiplier by 1.5 times an amount. Can be changed numerically. WARNING: IT'S ABSOLUTE BS!"},
            {name: 'Seasick', value: false, conflicts: [], multi: 0.005, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 10000, curValue: 0, offAt: 0, addChange: 10, string: '%\nSHIP FEEL', explanation: "Ship feel go swoosh and barf. How much do you want the camera to swing like a ship? The higher, the more they swing. Adds 0.05 to the score rate. Can be changed numerically."},
            {name: 'Upside Down', value: false, conflicts: [], multi: 0.2, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'switch', minValue: 0, maxValue: 0, curValue: 0, offAt: 0, addChange: 0, string: '', explanation: "Flip everything upside down. Not zero-gravity. Adds 0.2 to the score rate. Can be switched on or off."},
            {name: 'Mirror', value: false, conflicts: [], multi: 0.2, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'switch', minValue: 0, maxValue: 0, curValue: 0, offAt: 0, addChange: 0, string: '', explanation: "Mirror your own screen. Fun for everyone. Adds 0.2 to the score rate. Can be switched on or off."},
            {name: 'Camera Spin', value: false, conflicts: [], multi: 0.005, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 10000, curValue: 0, offAt: 0, addChange: 10, string: '%\nSPIN', explanation: "Wooooah. My head's spinning. Choose how much you can the cameras to spin around. The higher, the more they spin. Adds 0.05 to the score rate. Can be changed numerically."},
            {name: 'Earthquake', value: false, conflicts: [], multi: 0.006, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 500, curValue: 0, offAt: 0, addChange: 5, string: '%\nQUAKING', explanation: "This is some tokyo nonsense. Set how big of an earthquake you want to play with. The higher, the bigger. Adds 0.03 to the score rate. Can be changed numerically."},
            {name: 'Supportive Love', value: false, conflicts: [0,1,2,3,4,5], multi: -0.006, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 500, curValue: 0, offAt: 0, addChange: 5, string: '%\nMORE LOVE', explanation: "Girlfriend loves you very much. How much health do you want to regenerate gradually? The higher, the more love, support and all of that. Subtracts 0.03 to the score rate. Can be changed numerically."},
            {name: 'Poison Fright', value: false, conflicts: [0,1,2,3,4,5], multi: 0.006, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 500, curValue: 0, offAt: 0, addChange: 5, string: '%\nPOISON\nDOSE', explanation: "Please don't be scared. How much health do you want to drain gradually? The higher, the more poison, fear and all of that. Adds 0.03 to the score rate. Can be changed numerically. WARNING: CAN BLUE BALL YOU IF YOU SET IT TOO HIGH."},
            {name: 'Boyfriend Must Die', value: false, conflicts: [0,1,2,3,4,5], multi: 0.006, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 500, curValue: 0, offAt: 0, addChange: 5, string: "%\nASS\nWHOOPIN'", explanation: "How much ass whoopin do you want? Change how much enemies should damage Boyfriend per note. Adds 0.03 to the score rate. Can be changed numerically. WARNING: CAN BLUE BALL YOU IF YOU SET IT TOO HIGH."},
            {name: 'Stagefright', value: false, conflicts: [1,2,3,4,5], multi: 0.05, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 30, curValue: 0, offAt: 0, addChange: 1, string: '\nLESS\nMISSES', explanation: "Intimidation makes you afraid. Set how many misses you need to have until you freeze. YOU ARE GIVEN 30 MISSES BY 1 LESS MISS. The higher, the less misses you need. Adds 0.05 to the multiplier with each amount. Can be changed numerically."},
            {name: 'Paparazzi', value: false, conflicts: [], multi: 0.004, realmulti: 0, equation: '', abs: false,  revAtLow: false, type: 'number', minValue: 0, maxValue: 100, curValue: 0, offAt: 0, addChange: 1, string: '\nCAMERAMA(E)N', explanation: "Oh how popular you are! Change how many cameramen you want on the scene taking pictures. Adds 0.004 to the score rate. Can be changed numerically."},
        ];

        updateModifiers();
    }
}