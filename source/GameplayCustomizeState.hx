package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;
import flixel.FlxCamera;
import flixel.math.FlxPoint;
import flixel.FlxObject;
#if windows
import Discord.DiscordClient;
import sys.thread.Thread;
#end

import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.ui.Keyboard;
import flixel.FlxSprite;
import flixel.FlxG;
import MainVariables._variables;

class GameplayCustomizeState extends MusicBeatState
{
    var background:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
    var curt:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
    var front:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));

    var sick:FlxSprite = new FlxSprite().loadGraphic(Paths.image('sick'));

    var bf:Boyfriend;
    var dad:Character;

    var strumLine:FlxSprite;
    var strumLineNotes:FlxTypedGroup<FlxSprite>;
    var playerStrums:FlxTypedGroup<FlxSprite>;
    private var camHUD:FlxCamera;

    var zoomLerp:Float = 0.09;
    
    public override function create() {
        #if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Customizing Gameplay", null);
		#end

		Conductor.changeBPM(102);
		persistentUpdate = true;

        super.create();

		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
        FlxG.cameras.add(camHUD);

        background.scrollFactor.set(0.9,0.9);
        curt.scrollFactor.set(0.9,0.9);
        front.scrollFactor.set(0.9,0.9);

        add(background);
        add(front);
        add(curt);

		var camFollow = new FlxObject(0, 0, 1, 1);

		dad = new Character(100, 100, 'dad');
        bf = new Boyfriend(770, 450, 'bf');

		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x + 400, dad.getGraphicMidpoint().y);

		camFollow.setPosition(camPos.x, camPos.y);

        add(bf);
        add(dad);

        add(sick);

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.01);
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = 0.45;
        camHUD.zoom = 0.5;

		FlxG.camera.focusOn(camFollow.getPosition());

		strumLine = new FlxSprite(0, 25).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();
		
		if (_variables.scroll == 'down')
			strumLine.y = FlxG.height - 165;

		strumLineNotes = new FlxTypedGroup<FlxSprite>();
		add(strumLineNotes);

		playerStrums = new FlxTypedGroup<FlxSprite>();

        sick.cameras = [camHUD];
        strumLine.cameras = [camHUD];
        playerStrums.cameras = [camHUD];
        
		generateStaticArrows(0);
		generateStaticArrows(1);

        sick.setGraphicSize(Std.int(sick.width * 0.7));
		sick.antialiasing = true;

        sick.updateHitbox();

        sick.x = _variables.sickX;
        sick.y = _variables.sickY;

        FlxG.mouse.visible = true;

        FlxG.camera.alpha = camHUD.alpha = 0;

        FlxTween.tween(FlxG.camera, {zoom: 0.9, alpha: 1}, 0.3, {ease: FlxEase.quartOut});
        FlxTween.tween(camHUD, {zoom: 1, alpha: 1}, 0.3, {ease: FlxEase.quartOut});

        #if mobileC
        addVirtualPad(NONE, A_B);
        _virtualpad.cameras = cameras;
        #end
    }

    override function update(elapsed:Float) {
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

        super.update(elapsed);

        FlxG.camera.zoom = FlxMath.lerp(FlxG.camera.zoom, 0.9, zoomLerp/(_variables.fps/60));
        camHUD.zoom = FlxMath.lerp(camHUD.zoom, 1, zoomLerp/(_variables.fps/60));

        if (FlxG.mouse.overlaps(sick) && FlxG.mouse.pressed)
        {
            sick.x = FlxG.mouse.x - sick.width / 2;
            sick.y = FlxG.mouse.y - sick.height / 2;
        }

        if (FlxG.mouse.overlaps(sick) && FlxG.mouse.justReleased)
        {
            _variables.sickX = sick.x;
            _variables.sickY = sick.y;

            MainVariables.Save();
        }

        if (controls.BACK)
        {
            FlxG.mouse.visible = false;
            FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.switchState(new SettingsState());

            FlxTween.tween(FlxG.camera, {zoom: 0.45, alpha: 0}, 0.5, {ease: FlxEase.quartIn});
            FlxTween.tween(camHUD, {zoom: 0.5, alpha: 0}, 0.5, {ease: FlxEase.quartIn});
        }

    }

    override function beatHit() 
    {
        super.beatHit();

        bf.playAnim('idle');
        dad.dance();

        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.010;
    }


    // ripped from play state cuz im lazy
    
	private function generateStaticArrows(player:Int):Void
        {
            for (i in 0...4)
            {
                // FlxG.log.add(i);
                var babyArrow:FlxSprite = new FlxSprite(0, strumLine.y);
                babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets', 'shared');
                babyArrow.animation.addByPrefix('green', 'arrowUP');
                babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
                babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
                babyArrow.animation.addByPrefix('red', 'arrowRIGHT');
                babyArrow.antialiasing = true;
                babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));
                switch (Math.abs(i))
                {
                    case 0:
                        babyArrow.x += Note.swagWidth * 0;
                        babyArrow.animation.addByPrefix('static', 'arrowLEFT');
                        babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
                        babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
                    case 1:
                        babyArrow.x += Note.swagWidth * 1;
                        babyArrow.animation.addByPrefix('static', 'arrowDOWN');
                        babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
                        babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
                    case 2:
                        babyArrow.x += Note.swagWidth * 2;
                        babyArrow.animation.addByPrefix('static', 'arrowUP');
                        babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
                        babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
                    case 3:
                        babyArrow.x += Note.swagWidth * 3;
                        babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
                        babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
                        babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
                }
                babyArrow.updateHitbox();
                babyArrow.scrollFactor.set();
    
                babyArrow.ID = i;
    
                if (player == 1)
                {
                    playerStrums.add(babyArrow);
                }
    
                babyArrow.animation.play('static');
                babyArrow.x += 90;
                babyArrow.x += ((FlxG.width / 2) * player);
    
                strumLineNotes.add(babyArrow);
            }
        }
}