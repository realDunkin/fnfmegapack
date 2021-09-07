package ui;

import flixel.graphics.FlxGraphic;
import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.graphics.frames.FlxTileFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets;
import flixel.util.FlxDestroyUtil;
import flixel.ui.FlxButton;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.ui.FlxVirtualPad;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import MainVariables._variables;

// copyed from flxvirtualpad
class Hitbox extends FlxSpriteGroup
{
    public var hitbox:FlxSpriteGroup;

    var sizex:Int = 320;

    var screensizey:Int = 720;

    var frameshb:FlxAtlasFrames;

    public var buttonLeft:FlxButton;
    public var buttonDown:FlxButton;
    public var buttonUp:FlxButton;
    public var buttonRight:FlxButton;

    public var buttonLeft2:FlxButton;
    public var buttonDown2:FlxButton;


    public var buttonUp2:FlxButton;
    public var buttonRight2:FlxButton;

    public var buttonLeft3:FlxButton;
    
    public function new(type:HitboxType = DEFAULT)
    {
        super();

        trace(type);

        //add graphic
        hitbox = new FlxSpriteGroup();
        hitbox.scrollFactor.set();
        
        var hitbox_hint:FlxSprite = new FlxSprite(0, 0);
        hitbox_hint.alpha = 0.3;
        add(hitbox_hint);

        // stupid way to fix crash
        buttonLeft = new FlxButton(0, 0);
        buttonDown = new FlxButton(0, 0);
        buttonUp = new FlxButton(0, 0);
        buttonRight = new FlxButton(0, 0);

        buttonUp2 = new FlxButton(0, 0);
        buttonRight2 = new FlxButton(0, 0);
        buttonLeft2 = new FlxButton(0, 0);
        buttonDown2 = new FlxButton(0, 0);

        buttonLeft3 = new FlxButton(0, 0);

        var arrowextra2:String = '';

        arrowextra2 = PlayState.arrowextra;

        switch (type){
            case NINE:
            {
                hitbox_hint.loadGraphic('assets/shared/images/hitbox/hitboxgod_hint' + arrowextra2 + '.png');

                frameshb = FlxAtlasFrames.fromSparrow('assets/shared/images/hitbox/hitboxgod' + arrowextra2 + '.png', 'assets/shared/images/hitbox/hitboxgod' + arrowextra2 + '.xml');
                sizex = 142;
                
                hitbox.add(add(buttonLeft = createhitbox(0, "left"))); //
                hitbox.add(add(buttonDown = createhitbox(sizex, "down")));
                hitbox.add(add(buttonUp = createhitbox(sizex * 2, "up"))); //
                hitbox.add(add(buttonRight = createhitbox(sizex * 3, "right")));    
                
                hitbox.add(add(buttonUp2 = createhitbox(sizex * 4, "up2")));
                hitbox.add(add(buttonRight2 = createhitbox(sizex * 5, "right2"))); 
                hitbox.add(add(buttonLeft2 = createhitbox(sizex * 6, "left2")));
                hitbox.add(add(buttonDown2 = createhitbox(sizex * 7, "down2"))); 

                hitbox.add(add(buttonLeft3 = createhitbox(sizex * 8, "left3")));
            }
            case SIX:
            {
                hitbox_hint.loadGraphic('assets/shared/images/hitbox/hitboxsix_hint' + arrowextra2 + '.png');

                frameshb = FlxAtlasFrames.fromSparrow('assets/shared/images/hitbox/hitboxsix' + arrowextra2 + '.png', 'assets/shared/images/hitbox/hitboxsix' + arrowextra2 + '.xml');
                sizex = 213;
                
                hitbox.add(add(buttonLeft = createhitbox(0, "left"))); //
                hitbox.add(add(buttonDown = createhitbox(sizex, "down")));
                hitbox.add(add(buttonUp = createhitbox(sizex * 2, "up"))); //
                hitbox.add(add(buttonRight = createhitbox(sizex * 3, "right")));    
                hitbox.add(add(buttonUp2 = createhitbox(sizex * 4, "up2")));
                hitbox.add(add(buttonRight2 = createhitbox(sizex * 5, "right2"))); 
            } 
            default:
            {
                hitbox_hint.loadGraphic('assets/shared/images/hitbox/hitbox_hint' + arrowextra2 + '.png');

                frameshb = FlxAtlasFrames.fromSparrow('assets/shared/images/hitbox/hitbox' + arrowextra2 + '.png', 'assets/shared/images/hitbox/hitbox' + arrowextra2 + '.xml');
                sizex = 320;

                hitbox.add(add(buttonLeft = createhitbox(0, "left")));
                hitbox.add(add(buttonDown = createhitbox(sizex, "down")));
                hitbox.add(add(buttonUp = createhitbox(sizex * 2, "up")));
                hitbox.add(add(buttonRight = createhitbox(sizex * 3, "right")));    
            }
        }
    }

    public function createhitbox(X:Float, framestring:String) {
        var button = new FlxButton(X, 0);
        
        var graphic:FlxGraphic = FlxGraphic.fromFrame(frameshb.getByName(framestring));

        button.loadGraphic(graphic);

        button.alpha = 0;

    
        button.onDown.callback = function (){
            FlxTween.num(0, 0.75, .075, {ease: FlxEase.circInOut}, function (a:Float) { button.alpha = a; });
        };

        button.onUp.callback = function (){
            FlxTween.num(0.75, 0, .1, {ease: FlxEase.circInOut}, function (a:Float) { button.alpha = a; });
        }
        
        button.onOut.callback = function (){
            FlxTween.num(button.alpha, 0, .2, {ease: FlxEase.circInOut}, function (a:Float) { button.alpha = a; });
        }

        return button;
    }

    override public function destroy():Void
        {
            super.destroy();
    
            buttonLeft = null;
            buttonDown = null;
            buttonUp = null;
            buttonRight = null;
        }
}

enum HitboxType {
    DEFAULT;
    SIX;
    NINE;
}

/*if (widghtScreen == null)
widghtScreen = FlxG.width;*/