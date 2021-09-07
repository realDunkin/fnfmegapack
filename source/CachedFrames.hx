import flixel.util.FlxDestroyUtil;
import lime.utils.Assets;
#if haxe4
import haxe.xml.Access;
#else
import haxe.xml.Fast as Access;
#end
import flash.geom.Rectangle;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames.TexturePackerObject;
import flixel.graphics.frames.FlxFrame.FlxFrameAngle;
import flixel.graphics.frames.FlxFramesCollection.FlxFrameCollectionType;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxAssets.FlxTexturePackerSource;
import openfl.display.BitmapData;
import flixel.graphics.FlxGraphic;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
class CachedFrames
{
    public static var cachedInstance:CachedFrames;
    static var gettedRects:Array<FlxRect> = new Array<FlxRect>();

    function new() {}

    //public static function loadEverything()
  //  {
   //     cachedInstance = new CachedFrames();
//        cachedInstance.loadFrames();
 //   }

    public static function init()
    {
        cachedInstance = new CachedFrames();
        cachedInstance.loadFrames();
    }

    // so it doesn't brick your computer lol!
    public var cachedGraphics:Map<String,FlxGraphic> = new Map<String,FlxGraphic>();

    public var loaded = false;

    public function fromSparrow(id:String, xmlName:String)
    {
        var graphic = get(id);
        // No need to parse data again
		var frames:FlxAtlasFrames = FlxAtlasFrames.findFrame(graphic);
		if (frames != null)
			return frames;

		frames = new FlxAtlasFrames(graphic);

		var Description = Assets.getText(Paths.file('images/$xmlName.xml', 'shared'));

		var data:Access = new Access(Xml.parse(Description).firstElement());

		for (texture in data.nodes.SubTexture)
		{
			var name = texture.att.name;
			var trimmed = texture.has.frameX;
			var rotated = (texture.has.rotated && texture.att.rotated == "true");
			var flipX = (texture.has.flipX && texture.att.flipX == "true");
			var flipY = (texture.has.flipY && texture.att.flipY == "true");

			var rect = FlxRect.get(Std.parseFloat(texture.att.x), Std.parseFloat(texture.att.y), Std.parseFloat(texture.att.width),
				Std.parseFloat(texture.att.height));

			var size = if (trimmed)
			{
				new Rectangle(Std.parseInt(texture.att.frameX), Std.parseInt(texture.att.frameY), Std.parseInt(texture.att.frameWidth),
					Std.parseInt(texture.att.frameHeight));
			}
			else
			{
				new Rectangle(0, 0, rect.width, rect.height);
			}

			var angle = rotated ? FlxFrameAngle.ANGLE_NEG_90 : FlxFrameAngle.ANGLE_0;

			var offset = FlxPoint.get(-size.left, -size.top);
			var sourceSize = FlxPoint.get(size.width, size.height);

			if (rotated && !trimmed)
				sourceSize.set(size.height, size.width);

			frames.addAtlasFrame(rect, sourceSize, offset, name, angle, flipX, flipY);
            gettedRects.push(rect);
            
		}

        return frames;
    }

    public function get(id:String)
    {
        return cachedGraphics.get(id);
    }

    public function load(id:String, path:String)
    {
        var graph = FlxGraphic.fromAssetKey(Paths.image(path,'shared'));
        graph.persist = true;
        graph.destroyOnNoUse = false;
        cachedGraphics.set(id,graph);
        trace('Loaded ' + id);
    }

    public function clear()
    {
        for (removeMe in cachedGraphics.keys())
        {
            cachedGraphics[removeMe].destroyOnNoUse = true;
            cachedGraphics[removeMe].persist = false;
            cachedGraphics[removeMe].bitmap.disposeImage();
            cachedGraphics[removeMe].bitmap.dispose();
            FlxDestroyUtil.destroy(cachedGraphics[removeMe]);
            cachedGraphics.remove(removeMe);
            FlxDestroyUtil.putArray(gettedRects);
            gettedRects.splice(0, gettedRects.length);  
        }
    }

    public var toBeLoaded:Map<String,String> = new Map<String,String>();


    public var progress:Float = 0;

    public function loadFrames()
    {                
        /*  toBeLoaded.set('idle','hellclwn/Tricky/Idle');
            toBeLoaded.set('left','hellclwn/Tricky/Left');
            toBeLoaded.set('right','hellclwn/Tricky/right');
            toBeLoaded.set('up','hellclwn/Tricky/Up');
            toBeLoaded.set('down','hellclwn/Tricky/Down');*/
            toBeLoaded.set('sign','fourth/mech/Sign_Post_Mechanic');
            toBeLoaded.set('grem','fourth/mech/HP GREMLIN');
            toBeLoaded.set('cln','fourth/Clone');

            // all the big sprites
            var numba = 0;
            for(i in toBeLoaded.keys())
            {
                load(i,toBeLoaded.get(i));
                numba++;
                progress = HelperFunctions.truncateFloat(numba / Lambda.count(toBeLoaded) * 100,2);
            }
            trace('loaded everythin');
            loaded = true;
    }
    
}