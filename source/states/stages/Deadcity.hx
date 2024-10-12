package states.stages;

import openfl.display.BlendMode;
import flixel.util.FlxColor;

import openfl.filters.ShaderFilter;
import shaders.RainShader;

class Deadcity extends BaseStage
{
	var rainShader:RainShader;
	var rainShaderStartIntensity:Float = 0;
	var rainShaderEndIntensity:Float = 0;

	var bg:BGSprite;
	var bg2:BGSprite;
	var blendOverlay:BGSprite;
	override function create()
	{
		bg = new BGSprite('deadcity/sky', -1000, -1500, 0.2, 0.2);
		bg.setGraphicSize(Std.int(bg.width * 1));
		bg.updateHitbox();
		add(bg);
		bg.alpha = 0.6;

		bg2 = new BGSprite('deadcity/town1', -900, -1200, 0.4, 0.4);
		bg2.setGraphicSize(Std.int(bg2.width * 1.5));
		bg2.updateHitbox();
		add(bg2);
		
		var bg3:BGSprite = new BGSprite('deadcity/town2', 0, -450, 0.7, 0.7);
		bg3.updateHitbox();
		add(bg3);

		var bg4:BGSprite = new BGSprite('deadcity/floor', 0, 0, 1, 1);
		bg4.updateHitbox();
		add(bg4);
	}

	override function createPost() {
		blendOverlay = new BGSprite('deadcity/blendoverray', 0, 0, 1, 1);
		blendOverlay.setGraphicSize(Std.int(blendOverlay.width * 1));
		blendOverlay.updateHitbox();
		add(blendOverlay);
		blendOverlay.alpha = 0.2;
		blendOverlay.blend = BlendMode.ADD;

		//Will rewrite this soon fuck
		var bg7:BGSprite = new BGSprite('deadcity/7', 1000, 800, 1.4, 1.3);
		bg7.updateHitbox();
		add(bg7);
		bg7.setGraphicSize(Std.int(bg7.width));

		var bg5:BGSprite = new BGSprite('deadcity/5', 1000, 800, 1.4, 1.3);
		bg5.updateHitbox();
		add(bg5);
		bg5.setGraphicSize(Std.int(bg5.width));

		var bg5alt:BGSprite = new BGSprite('deadcity/6', 1000, 800, 1.4, 1.3);
		bg5alt.updateHitbox();
		add(bg5alt);
		bg5alt.setGraphicSize(Std.int(bg5alt.width));

		bg5.alpha = bg5alt.alpha = 0;

		switch(get_boyfriend().healthIcon) {
			case 'soni':
				if (songName == "imitate") {
					bg.color = FlxColor.fromRGB(255, 0, 0);
					bg2.color = FlxColor.fromRGB(84, 0, 36);
					blendOverlay.color = FlxColor.fromRGB(255, 0, 0);
				}
			case 'bf':
				if (songName != "imitate") {
					blendOverlay.color = FlxColor.fromRGB(255, 0, 0);
					bg.color = FlxColor.fromRGB(255, 0, 0);
					bg2.color = FlxColor.fromRGB(84, 0, 36);	
				}
				else
				{
					blendOverlay.blend = BlendMode.NORMAL;
					blendOverlay.color = FlxColor.fromRGB(85, 85, 85);
					blendOverlay.alpha = 0.15;
					if(ClientPrefs.data.shaders)
						doRainThing();
				}



		}
	}

	//Maybe Make uhh good?
	/*override function beatHit()
	{
		if (curBeat%2 == 0) {
			bg5.visible = true;
			bg5alt.visible = false;
		} else if (curBeat%0.5 == 0) {
			bg5.visible = false;
			bg5alt.visible = true;
		}
	}

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "Deadcity Light":
				if (value1 == "true")
					bg5.alpha = bg5alt.alpha = 1;
				else
					bg5.alpha = bg5alt.alpha = 0;
			}
		}*/

		function doRainThing()
		{
			rainShader = new RainShader();
			rainShader.scale = FlxG.height / 200;

			rainShaderStartIntensity = 0.1;
			rainShaderEndIntensity = 0.2;

			rainShader.intensity = rainShaderStartIntensity;
			FlxG.camera.setFilters([new ShaderFilter(rainShader)]);
		}

		override function update(elapsed:Float)
		{
			if(rainShader != null)
			{
				var remappedIntensityValue:Float = FlxMath.remapToRange(Conductor.songPosition, 0, (FlxG.sound.music != null ? FlxG.sound.music.length : 0), rainShaderStartIntensity, rainShaderEndIntensity);
				rainShader.intensity = remappedIntensityValue;
				rainShader.updateViewInfo(FlxG.width, FlxG.height, FlxG.camera);
				rainShader.update(elapsed);
			}
		}
}