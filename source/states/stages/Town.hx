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
		bg1 = new BGSprite('town', -200, -250, 0, 0, ['sky']);
		bg1.setGraphicSize(Std.int(bg1.width * 1.1));
		add(bg1);

		bg2 = new BGSprite('town', 470, 0, 0.2, 0.2, ['sun']);
		bg2.setGraphicSize(Std.int(bg2.width * 0.2));
		add(bg2);

		bg3 = new BGSprite('town', -200, -120, 0.2, 0.2, ['cloud1']);
		bg3.setGraphicSize(Std.int(bg3.width * 0.8));
		add(bg3);

		bg4 = new BGSprite('town', -500, -300, 0.3, 0.3, ['town2']);
		bg4.setGraphicSize(Std.int(bg4.width * 0.7));
		add(bg4);

		bg5 = new BGSprite('town', -450, -200, 0.4, 0.4, ['bridge']);
		bg5.setGraphicSize(Std.int(bg5.width * 0.8));
		add(bg5);

		bg6 = new BGSprite('town', -850, -250, 0.4, 0.4, ['town']);
		bg6.setGraphicSize(Std.int(bg6.width * 0.65));
		add(bg6);

		townlight = new BGSprite('town', bg6.x, bg6.y, bg6.scrollFactor.x, bg6.scrollFactor.y, ['townlight']);
		townlight.setGraphicSize(Std.int(townlight.width * 0.6));
		add(townlight);
		townlight.blend = BlendMode.SCREEN;
		townlight.alpha = 0;

		var bg7:BGSprite = new BGSprite('town', -420, -40, 1, 1, ['floor']);
		bg7.setGraphicSize(Std.int(bg7.width * 0.7));
		add(bg7);

		var bg8:BGSprite = new BGSprite('town', -420, -40, 1, 1, ['tree']);
		bg8.setGraphicSize(Std.int(bg8.width * 0.8));
		add(bg8);

		for (i in [bg1, bg2, bg3, bg4, bg5, bg6, bg7, bg8]) {
			i.active = false;
		}
	}

	override function createPost() {
		var floorshadingreal:BGSprite = new BGSprite('town', -420, -40, 1, 1, ['overlay']);
		floorshadingreal.setGraphicSize(Std.int(floorshadingreal.width * 0.9));
		floorshadingreal.updateHitbox();
		add(floorshadingreal);
		floorshadingreal.alpha = 0.15;

		switch(get_boyfriend().healthIcon) {
			//SONI MIX & PICO MIX THING + ENCORE
			case "soni":
				floorshadingreal.alpha = 0.35;

				//Temp fix sorry nightsky
				remove(bg1);

				floorshadingreal.color = FlxColor.fromRGB(20, 54, 99);
				//I Fucked Up sorry
				for (i in [bg5, bg6]) {
					i.color = FlxColor.fromRGB(100, 100, 100);
				}
				remove(bg2);
				remove(bg3);
				townlight.alpha = 0.95;
			case "pico":
				floorshadingreal.alpha = 0.25;
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