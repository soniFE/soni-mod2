package backend;

#if FEATURE_MODCORE
import polymod.backends.OpenFLBackend;
import polymod.backends.PolymodAssets.PolymodAssetType;
import polymod.format.ParseRules.LinesParseFormat;
import polymod.format.ParseRules.TextFileFormat;
import polymod.format.ParseRules;
import polymod.Polymod;
#end
import sys.FileSystem;
import flixel.FlxG;

class PsychCore
{
	private static final MOD_DIR:String = 'mods';

	static final API_VERSION = "0.1.0";

	private static final extensions:Map<String, PolymodAssetType> = [
		'mp3' => AUDIO_GENERIC,
		'ogg' => AUDIO_GENERIC,
		'png' => IMAGE,
		'xml' => TEXT,
		'txt' => TEXT,
		'ttf' => FONT,
		'otf' => FONT,
		'mp4' => VIDEO
	];

	public static var modsToLoad:Array<String> = [];
	public static var enabledMods = []; // enabled mods
	public static var modTitles = [];
	public static var modDescriptions = []; // descriptions

	public static function initialize():Void
	{
		Debug.logInfo("Initializing PsychMod...");
		initPolymod();
		Debug.logTrace(enabledMods);
		Polymod.loadOnlyMods(enabledMods);
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
			customBackend: ModCoreBackend,

			// List of filenames to ignore in mods. Use the default list to ignore the metadata file, etc.
			ignoredFiles: Polymod.getDefaultIgnoreList(),

			// Parsing rules for various data formats.
			parseRules: getParseRules(),
			customFilesystem: polymod.fs.ZipFileSystem
		});
		ModCore.modsToLoad = getAllMods();
		enabledMods = FlxG.save.data.enabledMods;
	}

	public static function getAllMods():Array<String>
	{
		var daList:Array<String> = [];

		if (!FileSystem.exists('mods'))
		{
			Debug.logTrace("Mods Folder Missing. Skipping.");
			return [];
		}

		for (i in Polymod.scan({modRoot: MOD_DIR, errorCallback: onPolymodError}))
		{
			if (i != null)
			{
				daList.push(i.id);
				modTitles.push(i.title);
				modDescriptions.push(i.description);
			}
		}
		return daList != null && daList.length > 0 ? daList : [];
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
				"default" => "./shared", // ./preload
				"songs" => "./songs",
				"shared" => "./shared",
				"videos" => "./videos",
				"weeks" => "./",
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
						Debug.logInfo(error.message, null);
					case WARNING:
						Debug.logWarn(error.message, null);
					case ERROR:
						Debug.logError(error.message, null);
				}
		}
	}
}

class PsychModBackend extends OpenFLBackend
{
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