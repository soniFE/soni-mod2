package states.stages;

import openfl.display.BlendMode;
import objects.Character;
import flixel.util.FlxColor;

class Town extends BaseStage
{
	var bg1:BGSprite;
	var bg2:BGSprite;
	var bg3:BGSprite;
	var bg4:BGSprite;
	var bg5:BGSprite;
	var bg6:BGSprite;
	var townlight:BGSprite;

	override function create()
	{
		bg1 = new BGSprite('town/sky', -300, -190, 0, 0);
		bg1.setGraphicSize(Std.int(bg1.width * 1.1));
		add(bg1);

		bg2 = new BGSprite('town/sun', 470, 0, 0.2, 0.2);
		bg2.setGraphicSize(Std.int(bg2.width * 1));
		add(bg2);

		bg3 = new BGSprite('town/cloud1', -370, -120, 0.2, 0.2);
		bg3.setGraphicSize(Std.int(bg3.width * 1));
		add(bg3);

		bg4 = new BGSprite('town/town2', -370, -300, 0.3, 0.3);
		bg4.setGraphicSize(Std.int(bg4.width * 0.7));
		add(bg4);

		bg5 = new BGSprite('town/bridge', -300, -130, 0.4, 0.4);
		bg5.setGraphicSize(Std.int(bg5.width * 0.8));
		add(bg5);

		bg6 = new BGSprite('town/town', -800, -450, 0.4, 0.4);
		bg6.setGraphicSize(Std.int(bg6.width * 0.65));
		add(bg6);

		townlight = new BGSprite('town/townlight', bg6.x, bg6.y, bg6.scrollFactor.x, bg6.scrollFactor.y);
		townlight.setGraphicSize(Std.int(townlight.width * 0.65));
		add(townlight);
		townlight.blend = BlendMode.SCREEN;
		townlight.alpha = 0;

		var bg7:BGSprite = new BGSprite('town/floor', -420, -40, 1, 1);
		bg7.setGraphicSize(Std.int(bg7.width * 0.7));
		add(bg7);

		var bg8:BGSprite = new BGSprite('town/tree', -420, -40, 1, 1);
		bg8.setGraphicSize(Std.int(bg8.width * 0.8));
		add(bg8);
	}

	override function createPost() {
		var floorshadingreal:BGSprite = new BGSprite('town/overlay', -420, -40, 1, 1);
		floorshadingreal.setGraphicSize(Std.int(floorshadingreal.width * 0.9));
		floorshadingreal.updateHitbox();
		add(floorshadingreal);
		floorshadingreal.alpha = 0.25;

		switch(get_boyfriend().healthIcon) {
			//SONI MIX & PICO MIX THING + ENCORE
			case "soni":
				floorshadingreal.alpha = 0.35;
				bg1.loadGraphic(Paths.image("town/nightsky"));
				floorshadingreal.color = FlxColor.fromRGB(20, 54, 99);
				//I Fucked Up sorry
				for (i in [bg5, bg6]) {
					i.color = FlxColor.fromRGB(100, 100, 100);
				}
				remove(bg2);
				remove(bg3);
				townlight.alpha = 0.95;
			case "pico":
				floorshadingreal.blend = BlendMode.ADD;
				bg1.color = FlxColor.fromRGB(213, 102, 27);
				floorshadingreal.color = FlxColor.fromRGB(255, 119, 1);
				remove(bg2);
			default:
				floorshadingreal.blend = BlendMode.ADD;
				bg1.color = FlxColor.fromRGB(101, 166, 255);
				floorshadingreal.color = FlxColor.fromRGB(175, 211, 255);
		}
	}
}