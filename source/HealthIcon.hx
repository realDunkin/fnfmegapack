package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
	public var char:String;
	public var animated:Bool = false;
	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		switch (char)
		{
			//this for animated icons or sum
			case 'verb':
			frames = Paths.getSparrowAtlas('animatedicon/verb');
			animation.addByPrefix('verb', 'idle', 24, true, isPlayer);
			animated = true;
			//
			default:
			loadGraphic(Paths.image('iconGrid'), true, 150, 150);

			antialiasing = true;
			animation.add('bf', [0, 1, 70], 0, false, isPlayer);
			animation.add('bf-car', [0, 1, 70], 0, false, isPlayer);
			animation.add('bf-christmas', [0, 1, 70], 0, false, isPlayer);
			animation.add('bf-pixel', [21, 81, 80], 0, false, isPlayer);
			animation.add('spooky', [2, 3, 71], 0, false, isPlayer);
			animation.add('pico', [4, 5, 72], 0, false, isPlayer);
			animation.add('mom', [6, 7, 73], 0, false, isPlayer);
			animation.add('mom-car', [6, 7, 73], 0, false, isPlayer);
			animation.add('dad', [12, 13, 74], 0, false, isPlayer);
			animation.add('senpai', [10, 11, 77], 0, false, isPlayer);
			animation.add('senpai-angry', [14, 15, 78], 0, false, isPlayer);
			animation.add('spirit', [22, 23, 79], 0, false, isPlayer);
			animation.add('none', [100, 101], 0, false, isPlayer);
			animation.add('gf', [16], 0, false, isPlayer);
			animation.add('gf-christmas', [16], 0, false, isPlayer);
			animation.add('gf-pixel', [16], 0, false, isPlayer);
			animation.add('parents-christmas', [17, 18, 75], 0, false, isPlayer);
			animation.add('monster', [19, 20, 76], 0, false, isPlayer);
			animation.add('monster-christmas', [19, 20, 76], 0, false, isPlayer);
			animation.add('bf-holding-gf', [0, 1, 70], 0, false, isPlayer);
			animation.add('picoasgf', [4, 5, 72], 0, false, isPlayer);
			animation.add('tankman', [8, 9, 82], 0, false, isPlayer);
			animation.add('bfb', [24, 25, 83], 0, false, isPlayer);
			animation.add('bfb-christmas', [24, 25, 83], 0, false, isPlayer);
			animation.add('bfb-car', [24, 25, 83], 0, false, isPlayer);
			animation.add('bfb-pixel', [39, 40, 90], 0, false, isPlayer);
			animation.add('gfb', [34], 0, false, isPlayer);
			animation.add('gfb-christmas', [34], 0, false, isPlayer);
			animation.add('gfb-pixel', [34], 0, false, isPlayer);
			animation.add('dadb', [30, 31, 87], 0, false, isPlayer);
			animation.add('spookyb', [26, 27, 84], 0, false, isPlayer);
			animation.add('picob', [28, 29, 85], 0, false, isPlayer);
			animation.add('momb', [32, 33, 86], 0, false, isPlayer);
			animation.add('momb-car', [32, 33, 86], 0, false, isPlayer);
			animation.add('parentsb-christmas', [35, 36, 88], 0, false, isPlayer);
			animation.add('monsterb-christmas', [37, 38, 89], 0, false, isPlayer);
			animation.add('senpaib', [41, 42, 91], 0, false, isPlayer);
			animation.add('senpaib-angry', [43, 44, 92], 0, false, isPlayer);
			animation.add('spiritb', [45, 46, 93], 0, false, isPlayer);
			animation.add('bfb3', [47, 48, 94], 0, false, isPlayer);
			animation.add('bfb3-car', [47, 48, 94], 0, false, isPlayer);
			animation.add('bfb3-christmas', [47, 48, 94], 0, false, isPlayer);
			animation.add('bfb3-pixel', [62, 63, 101], 0, false, isPlayer);
			animation.add('gfb3', [49], 0, false, isPlayer);
			animation.add('gfb3-car', [49], 0, false, isPlayer);
			animation.add('gfb3-christmas', [34], 0, false, isPlayer);
			animation.add('gfb3-pixel', [49], 0, false, isPlayer);
			animation.add('dadb3', [50, 51, 98], 0, false, isPlayer);
			animation.add('spookyb3', [52, 53, 95], 0, false, isPlayer);
			animation.add('picob3', [54, 55, 96], 0, false, isPlayer);
			animation.add('momb3', [56, 57, 97], 0, false, isPlayer);
			animation.add('momb3-car', [56, 57, 97], 0, false, isPlayer);
			animation.add('parentsb3-christmas', [58, 59, 99], 0, false, isPlayer);
			animation.add('monsterb3-christmas', [60, 61, 100], 0, false, isPlayer);
			animation.add('senpaib3', [64, 65, 102], 0, false, isPlayer);
			animation.add('senpaib3-angry', [66, 67, 103], 0, false, isPlayer);
			animation.add('spiritb3', [68, 69, 104], 0, false, isPlayer);
			animation.add('bfneo', [105, 106, 116], 0, false, isPlayer);
			animation.add('bfneo-car', [105, 106, 116], 0, false, isPlayer);
			animation.add('gfneo', [115], 0, false, isPlayer);
			animation.add('gfneo-car', [115], 0, false, isPlayer);
			animation.add('dadneo', [113, 114, 120], 0, false, isPlayer);
			animation.add('spookyneo', [107, 108, 117], 0, false, isPlayer);
			animation.add('piconeo', [109, 110, 118], 0, false, isPlayer);
			animation.add('momneo', [111, 112, 119], 0, false, isPlayer);
			animation.add('momneo-car', [111, 112, 119], 0, false, isPlayer);
			animation.add('gfwhitty', [16], 0, false, isPlayer);
			animation.add('whitty', [121, 122, 123], 0, false, isPlayer);
			animation.add('whittycrazy', [124, 125, 126], 0, false, isPlayer);
			animation.add('bfmongus', [127, 128, 127], 0, false, isPlayer);
			animation.add('nomongus', [129, 130, 129], 0, false, isPlayer);
			animation.add('hex', [131, 132, 131], 0, false, isPlayer);
			animation.add('hexsunset', [131, 132, 131], 0, false, isPlayer);
			animation.add('hexnight', [131, 132, 131], 0, false, isPlayer);
			animation.add('hexVirus', [133, 134, 133], 0, false, isPlayer);
			animation.add('hexViruswire', [133, 134, 133], 0, false, isPlayer);
			animation.add('bfsunset', [0, 1, 70], 0, false, isPlayer);
			animation.add('bfnight', [0, 1, 70], 0, false, isPlayer);
			animation.add('bfglitcher', [0, 1, 70], 0, false, isPlayer);
			animation.add('bfwire', [0, 1, 70], 0, false, isPlayer);
			animation.add('gfsunset', [16], 0, false, isPlayer);
			animation.add('gfnight', [16], 0, false, isPlayer);
			animation.add('gfglitcher', [16], 0, false, isPlayer);
			animation.add('shaggy', [135, 136, 135], 0, false, isPlayer);
			animation.add('shaggypower', [139, 136, 139], 0, false, isPlayer);
			animation.add('pshaggy', [137, 138, 137], 0, false, isPlayer);
			animation.add('bfmii', [0, 1, 70], 0, false, isPlayer);
			animation.add('gf-mii', [16], 0, false, isPlayer);
			animation.add('matt', [140, 141, 140], 0, false, isPlayer);
			animation.add('mattmad', [140, 141, 140], 0, false, isPlayer);
			animation.add('mattbox', [286, 287, 286], 0, false, isPlayer);
			animation.add('mattchill', [140, 141, 140], 0, false, isPlayer);
			animation.add('matttko', [140, 141, 140], 0, false, isPlayer);
			animation.add('mart', [288, 289, 288], 0, false, isPlayer);
			animation.add('garcello', [142, 143, 142], 0, false, isPlayer);
			animation.add('garcellotired', [144, 145, 144], 0, false, isPlayer);
			animation.add('garcelloghosty', [146, 147, 146], 0, false, isPlayer);
			animation.add('garcellodead', [146, 147, 146], 0, false, isPlayer);
			animation.add('bf-tabi', [0, 1, 70], 0, false, isPlayer);
			animation.add('bf-tabi-crazy', [0, 1, 70], 0, false, isPlayer);
			animation.add('tabi', [148, 149, 148], 0, false, isPlayer);
			animation.add('tabi-crazy', [150, 151, 150], 0, false, isPlayer);
			animation.add('trickyMask', [152, 153, 152], 0, false, isPlayer);
			animation.add('tricky', [154, 155, 154], 0, false, isPlayer);
			animation.add('trickyH', [156, 157, 156], 0, false, isPlayer);
			animation.add('exTricky', [158, 159, 158], 0, false, isPlayer);
			animation.add('bf-hell', [0, 1, 70], 0, false, isPlayer);
			animation.add('bfghost', [0, 1, 70], 0, false, isPlayer);
			animation.add('bf-sus', [0, 1, 70], 0, false, isPlayer);
			animation.add('impostor', [160, 161, 160], 0, false, isPlayer);
			animation.add('impostor2', [160, 161, 160], 0, false, isPlayer);
			animation.add('cyrix', [162, 163, 162], 0, false, isPlayer);
			animation.add('cyrix-nervous', [162, 163, 162], 0, false, isPlayer);
			animation.add('cyrix-crazy', [164, 165, 164], 0, false, isPlayer);
			animation.add('mario', [166, 167, 168], 0, false, isPlayer);
			animation.add('zardy', [169, 170, 169], 0, false, isPlayer);
			animation.add('zardyb', [207, 208, 207], 0, false, isPlayer);
			animation.add('bf-kapi', [0, 1, 70], 0, false, isPlayer);
			animation.add('kapi', [171, 172, 171], 0, false, isPlayer);
			animation.add('kapimad', [173, 172, 173], 0, false, isPlayer);
			animation.add('miku', [174, 175, 174], 0, false, isPlayer);
			animation.add('miku-mad', [176, 177, 176], 0, false, isPlayer);
			animation.add('agoti', [178, 179, 180], 0, false, isPlayer);
			animation.add('agoti-micless', [181, 182, 183], 0, false, isPlayer);
			animation.add('salty', [184, 185, 184], 0, false, isPlayer);
			animation.add('itsumi', [186, 186, 186], 0, false, isPlayer);
			animation.add('dadexe', [187, 188, 187], 0, false, isPlayer);
			animation.add('ghostngirl', [189, 190, 189], 0, false, isPlayer);
			animation.add('opheebop', [191, 192, 191], 0, false, isPlayer);
			animation.add('connor', [193, 194, 193], 0, false, isPlayer);
			animation.add('salty-car', [184, 185, 184], 0, false, isPlayer);
			animation.add('itsumi-car', [186, 186, 186], 0, false, isPlayer);
			animation.add('momexe', [195, 196, 195], 0, false, isPlayer);
			animation.add('momexe-car', [195, 196, 195], 0, false, isPlayer);
			animation.add('salty-christmas', [184, 185, 184], 0, false, isPlayer);
			animation.add('itsumi-christmas', [186, 186, 186], 0, false, isPlayer);
			animation.add('the-manager', [197, 198, 197], 0, false, isPlayer);
			animation.add('opheebop-christmas', [191, 192, 191], 0, false, isPlayer);
			animation.add('salty-pixel', [199, 199, 199], 0, false, isPlayer);
			animation.add('glitch', [200, 200, 200], 0, false, isPlayer);
			animation.add('glitchy', [200, 200, 200], 0, false, isPlayer);
			animation.add('glitchhead', [201, 201, 201], 0, false, isPlayer);
			animation.add('sky', [202, 203, 202], 0, false, isPlayer);
			animation.add('sky-annoyed', [202, 203, 202], 0, false, isPlayer);
			animation.add('sky-mad', [204, 204, 204], 0, false, isPlayer);
			animation.add('mattblue', [140, 141, 140], 0, false, isPlayer);
			animation.add('shaggyred', [135, 136, 135], 0, false, isPlayer);
			animation.add('shaggymatt', [205, 206, 205], 0, false, isPlayer);
			animation.add('gameandwatch', [209, 210, 209], 0, false, isPlayer);
			animation.add('bf-night', [0, 1, 70], 0, false, isPlayer);
			animation.add('bob', [211, 212, 213], 0, false, isPlayer);
			animation.add('bosip', [214, 215, 216], 0, false, isPlayer);
			animation.add('amor', [217, 218, 219], 0, false, isPlayer);
			animation.add('pc', [0, 1, 70], 0, false, isPlayer);
			animation.add('bf-ex', [220, 221, 222], 0, false, isPlayer);
			animation.add('bf-night-ex', [220, 221, 222], 0, false, isPlayer);
			animation.add('bobex', [223, 224, 225], 0, false, isPlayer);
			animation.add('bosipex', [226, 227, 228], 0, false, isPlayer);
			animation.add('amorex', [229, 230, 231], 0, false, isPlayer);
			animation.add('gf-ex', [232, 233, 234], 0, false, isPlayer);
			animation.add('bluskys', [235, 236, 237], 0, false, isPlayer);
			animation.add('minishoey', [238, 239, 240], 0, false, isPlayer);
			animation.add('jghost', [241, 242, 243], 0, false, isPlayer);
			animation.add('cerberus', [244, 245, 246], 0, false, isPlayer);
			animation.add('ash', [247, 248, 249], 0, false, isPlayer);
			animation.add('cerbera', [250, 251, 252], 0, false, isPlayer);
			animation.add('ashandcerbera', [253, 253, 253], 0, false, isPlayer);
			animation.add('worriedbob', [211, 212, 213], 0, false, isPlayer);
			animation.add('gloopybob', [258, 259, 260], 0, false, isPlayer);
			animation.add('bfanders', [261, 262, 261], 0, false, isPlayer);
			animation.add('anders', [261, 262, 261], 0, false, isPlayer);
			animation.add('ronsip', [263, 264, 265], 0, false, isPlayer);
			animation.add('gloopy', [266, 267, 268], 0, false, isPlayer);
			animation.add('angrygloopy', [269, 270, 271], 0, false, isPlayer);
			animation.add('hellgloopy', [272, 273, 274], 0, false, isPlayer);
			animation.add('ron', [275, 276, 277], 0, false, isPlayer);
			animation.add('gloop-gloopy', [278, 279, 278], 0, false, isPlayer);
			animation.add('glitched-gloopy', [280, 281, 280], 0, false, isPlayer);
			animation.add('little-man', [282, 283, 282], 0, false, isPlayer);
			animation.add('pizza', [284, 285, 284], 0, false, isPlayer);
			animation.add('bfbob', [0, 1, 70], 0, false, isPlayer);
		}

		animation.play(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null){
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
		}
	}
}
