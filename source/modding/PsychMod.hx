package modding;

import polymod.backends.OpenFLBackend;
import polymod.backends.PolymodAssets.PolymodAssetType;
import polymod.format.ParseRules.LinesParseFormat;
import polymod.format.ParseRules.TextFileFormat;
import polymod.format.ParseRules;
import polymod.Polymod;

import sys.FileSystem;
import flixel.FlxG;
import backend.Paths;

class PsychMod
{
	private static final MOD_DIR:String = 'mods';

	static final API_VERSION = "0.1.0";

	private static final extensions:Map<String, PolymodAssetType> = [
		'mp3' => AUDIO_GENERIC,
		'ogg' => AUDIO_GENERIC,
		'png' => IMAGE,
		'xml' => TEXT,
		'txt' => TEXT,
		'hx' => TEXT,
		'json' => TEXT,
		'ttf' => FONT,
		'otf' => FONT,
		'mp4' => VIDEO
	];

	public static var curMod = "fuck"; // enabled mods

	public static function initialize():Void
	{
		if (!FileSystem.exists(MOD_DIR))
		{
			trace('Mods Folder Missing. Creating $MOD_DIR folder...');
			FileSystem.createDirectory(MOD_DIR);
			return;
		}
		trace("Initializing PsychMod...");
		initPolymod();
		trace(curMod);
		Polymod.loadOnlyMods([curMod]);
	}

	public static function initPolymod()
	{
		Polymod.init({
			// Root directory for all mods.
			modRoot: MOD_DIR,
			// The directories for one or more mods to load.
			dirs: [],
			// Framework being used to load assets. We're using a CUSTOM one which extends the OpenFL one.
			framework: Framework.CUSTOM,
			// Call this function any time an error occurs.
			errorCallback: onPolymodError,
			// Enforce semantic version patterns for each mod.
			// modVersions: null,
			// A map telling Polymod what the asset type is for unfamiliar file extensions.
			// extensionMap: [],

			frameworkParams: buildFrameworkParams(),

			// Use a custom backend so we can get a picture of what's going on,
			// or even override behavior ourselves.
			customBackend: PsychModBackend,

			// List of filenames to ignore in mods. Use the default list to ignore the metadata file, etc.
			ignoredFiles: Polymod.getDefaultIgnoreList(),

			// Parsing rules for various data formats.
			parseRules: getParseRules()
		});
	}

	public static function getParseRules():ParseRules
	{
		var output:ParseRules = ParseRules.getDefault();
		output.addType("txt", TextFileFormat.LINES);
		return output != null ? output : null;
	}

	static inline function buildFrameworkParams():polymod.FrameworkParams
	{
		return {
			assetLibraryPaths: [
				"default" => "./",
				"songs" => "./songs",
				"shared" => "./shared",
				"videos" => "./videos"
			]
		}
	}

	static function onPolymodError(error:PolymodError):Void
	{
		// Perform an action based on the error code.
		switch (error.code)
		{
			case MISSING_ICON:
			default:
				// Log the message based on its severity.
				switch (error.severity)
				{
					case NOTICE:
						trace(error.message, null);
					case WARNING:
						trace(error.message, null);
					case ERROR:
						trace(error.message, null);
				}
		}
	}
}

class PsychModBackend extends OpenFLBackend
{
	//idk but it here uh what
	public function new()
		super();

	public override function clearCache()
		super.clearCache();

	public override function exists(id:String):Bool
		return super.exists(id);

	public override function getBytes(id:String):lime.utils.Bytes
		return super.getBytes(id);

	public override function getText(id:String):String
		return super.getText(id);

	public override function list(type:PolymodAssetType = null):Array<String>
		return super.list(type);
}