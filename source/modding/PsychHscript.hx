package modding;

import openfl.display.BlendMode;

import crowplexus.iris.Iris;

class PsychHscript extends Iris
{
	public var filePath:String;
	public var modFolder:String;

	public var origin:String;
	override public function new(?parent:Dynamic, ?file:String, ?varsToBring:Any = null)
	{
		if (file == null)
			file = '';
	
		super(null, {name: "script", autoRun: false, autoPreset: false});

		filePath = file;
		if (filePath != null && filePath.length > 0)
		{
			this.origin = filePath;
		}

		var scriptThing:String = file;
		if(parent == null && file != null)
		{
			var f:String = file.replace('\\', '/');
			if(f.contains('/') && !f.contains('\n'))
			{
				scriptThing = File.getContent(f);
			}
		}
		this.scriptCode = scriptThing;

		preset();

		execute();
	}
	
	override function preset() {
		super.preset();
		
		set('FlxColor', CustomFlxColor);
		set('BlendMode',{
			SUBTRACT: BlendMode.SUBTRACT,
			ADD: BlendMode.ADD,
			MULTIPLY: BlendMode.MULTIPLY,
			ALPHA: BlendMode.ALPHA,
			DARKEN: BlendMode.DARKEN,
			DIFFERENCE: BlendMode.DIFFERENCE,
			INVERT: BlendMode.INVERT,
			HARDLIGHT: BlendMode.HARDLIGHT,
			LIGHTEN: BlendMode.LIGHTEN,
			OVERLAY: BlendMode.OVERLAY,
			SHADER: BlendMode.SHADER,
			SCREEN: BlendMode.SCREEN
		});
		
		set('add', FlxG.state.add);
		set('insert', FlxG.state.insert);
		set('remove', FlxG.state.remove);

		if(PlayState.instance == FlxG.state)
		{
			set('game', PlayState.instance);
			set('addBehindGF', PlayState.instance.addBehindGF);
			set('addBehindDad', PlayState.instance.addBehindDad);
			set('addBehindBF', PlayState.instance.addBehindBF);
		}
	}

	public function executeCode(?funcToRun:String = null, ?funcArgs:Array<Dynamic> = null):IrisCall {
		if (funcToRun == null || !exists(funcToRun)) return null;
	
		try {
			final callValue:IrisCall = call(funcToRun, funcArgs);
			return callValue.returnValue;
		} catch(e:Dynamic) {
			trace('ERROR ${funcToRun}: $e');
		}
		return null;
	}
	

	public function executeFunction(funcToRun:String = null, funcArgs:Array<Dynamic> = null):IrisCall {
		if (funcToRun == null || !exists(funcToRun)) return null;
		return call(funcToRun, funcArgs);
	}

	override public function set(name:String, value:Dynamic, allowOverride:Bool = false):Void {
		// should always override by default
		super.set(name, value, true);
	}

	override public function destroy()
	{
		origin = null;

		super.destroy();
	}
}

class CustomFlxColor {
	public static var TRANSPARENT(default, null):Int = FlxColor.TRANSPARENT;
	public static var BLACK(default, null):Int = FlxColor.BLACK;
	public static var WHITE(default, null):Int = FlxColor.WHITE;
	public static var GRAY(default, null):Int = FlxColor.GRAY;

	public static var GREEN(default, null):Int = FlxColor.GREEN;
	public static var LIME(default, null):Int = FlxColor.LIME;
	public static var YELLOW(default, null):Int = FlxColor.YELLOW;
	public static var ORANGE(default, null):Int = FlxColor.ORANGE;
	public static var RED(default, null):Int = FlxColor.RED;
	public static var PURPLE(default, null):Int = FlxColor.PURPLE;
	public static var BLUE(default, null):Int = FlxColor.BLUE;
	public static var BROWN(default, null):Int = FlxColor.BROWN;
	public static var PINK(default, null):Int = FlxColor.PINK;
	public static var MAGENTA(default, null):Int = FlxColor.MAGENTA;
	public static var CYAN(default, null):Int = FlxColor.CYAN;

	public static inline function fromInt(Value:Int):Int 
	{
		return cast FlxColor.fromInt(Value);
	}

	public static inline function fromRGB(Red:Int, Green:Int, Blue:Int, Alpha:Int = 255):Int
	{
		return cast FlxColor.fromRGB(Red, Green, Blue, Alpha);
	}
	public static inline function fromRGBFloat(Red:Float, Green:Float, Blue:Float, Alpha:Float = 1):Int
	{	
		return cast FlxColor.fromRGBFloat(Red, Green, Blue, Alpha);
	}

	public static inline function fromCMYK(Cyan:Float, Magenta:Float, Yellow:Float, Black:Float, Alpha:Float = 1):Int
	{
		return cast FlxColor.fromCMYK(Cyan, Magenta, Yellow, Black, Alpha);
	}

	public static inline function fromHSB(Hue:Float, Sat:Float, Brt:Float, Alpha:Float = 1):Int
	{	
		return cast FlxColor.fromHSB(Hue, Sat, Brt, Alpha);
	}
	public static inline function fromHSL(Hue:Float, Sat:Float, Light:Float, Alpha:Float = 1):Int
	{	
		return cast FlxColor.fromHSL(Hue, Sat, Light, Alpha);
	}
	public static inline function fromString(str:String):Int
	{
		return cast FlxColor.fromString(str);
	}
}