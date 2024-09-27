package states.stages;

import openfl.display.BlendMode;
import objects.Character;

class Town extends BaseStage
{
	override function create()
	{
		var bg1:BGSprite = new BGSprite('town/sky', -300, -190, 0, 0);
		bg1.setGraphicSize(Std.int(bg1.width * 1.1));
		add(bg1);

		var bg2:BGSprite = new BGSprite('town/sun', 470, 0, 0.2, 0.2);
		bg2.setGraphicSize(Std.int(bg2.width * 1));
		add(bg2);

		var bg3:BGSprite = new BGSprite('town/cloud1', -370, -120, 0.2, 0.2);
		bg3.setGraphicSize(Std.int(bg3.width * 1));
		add(bg3);

		var bg4:BGSprite = new BGSprite('town/town2', -370, -130, 0.3, 0.3);
		bg4.setGraphicSize(Std.int(bg4.width * 1));
		add(bg4);

		var bg5:BGSprite = new BGSprite('town/bridge', -300, -130, 0.4, 0.4);
		bg5.setGraphicSize(Std.int(bg5.width * 0.8));
		add(bg5);

		var bg6:BGSprite = new BGSprite('town/town', -300, -130, 0.4, 0.4);
		bg6.setGraphicSize(Std.int(bg6.width * 0.8));
		add(bg6);

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
		floorshadingreal.alpha = 0.2;
		floorshadingreal.blend = BlendMode.ADD;
	}
}