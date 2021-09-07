package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class StudioCrashBG extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas("crash/crash_back");
		animation.addByPrefix('code', 'code', 24, true);
		animation.play('code');
		antialiasing = true;
	}
}
