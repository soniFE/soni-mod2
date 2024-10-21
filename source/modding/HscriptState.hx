package modding;

import objects.MusicBeatState;
import backend.Paths;
import states.MainMenuState;

class HscriptState extends MusicBeatState
{
	public var script:PsychHscript;
	static  public var state:String = "";

	override function create()
	{
		var path:String = Paths.getSharedPath('states/$state.hx');
		if (!FileSystem.exists(path)) {
			trace('[HscriptState] No State Found! ($path)');
			return;
		}
		script = new PsychHscript(null, path);
		trace('[HscriptState] Loaded State! ($path)');
		script.executeFunction('create');

		super.create();
	}

	override function update(elapsed:Float)
	{
		script.executeFunction('update');
		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	override function stepHit()
	{
		script.executeFunction('stepHit');
		super.stepHit();
	}

	override function beatHit()
	{
		script.executeFunction('beatHit');
		super.beatHit();
	}

	override function sectionHit()
	{
		script.executeFunction('sectionHit');
		super.sectionHit();
	}
}