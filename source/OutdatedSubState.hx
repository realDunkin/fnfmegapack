package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class OutdatedSubState extends MusicBeatState
{
	var moveddown:Bool = false;
	var once:Bool = false;

	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";
	public static var needName:String = "Pooppy Dooppy Updtae";
	public static var currChanges:String = "dk";

	var blackScreen:FlxSprite;
	var outdatedbg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('backgroundOutdated'));

	var txt:FlxText = new FlxText(0, 0, FlxG.width,
		"FNF: Megapack is Outdated!\nYou are on "
		+ MainMenuState.megapackName
		+ "\nwhile the most recent version is " + needVer + ' - ' + needName
		+ "\n\nWhat's new:\n"
		+ currChanges
		+ "\n\nPress ESCAPE to view the full changelog and update\nor ENTER to ignore this",
		24);

	override function create()
	{
		outdatedbg.screenCenter();
		add(outdatedbg);

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.alpha = 0.6;
		add(blackScreen);
		
		txt.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER);
		txt.setBorderStyle(OUTLINE, 0xFF000000, 3, 1);
		txt.screenCenter();
		add(txt);

		#if mobileC
		addVirtualPad(NONE, A_B);
		#end

		super.create();
	}

	override function update(elapsed:Float)
	{
		//compilcated way to do it but i know nothing bout tweens
		if (!moveddown){
			if (!once){
				once  = true;
				FlxTween.linearMotion(txt, 0, 0, 0, 60, 30, false);
			}		
			if (txt.y == 60){
				moveddown = true;
				once  = false;
			}
		}

		if (moveddown){
			if (!once){
				once  = true;
				FlxTween.linearMotion(txt, 0, 60, 0, 0, 30, false);
			}
			if (txt.y == 0)
			{			
				moveddown = false;
				once  = false;
			}
		}
		// end of complicated shit

		if (controls.BACK)
		{
			FlxG.openURL("https://github.com/realDunkin/fnfmegapack/blob/beta/README.md");
		}
		if (controls.ACCEPT)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
