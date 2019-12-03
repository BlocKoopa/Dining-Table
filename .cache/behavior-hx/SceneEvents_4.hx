package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class SceneEvents_4 extends SceneScript
{
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		Engine.engine.setGameAttribute("RandomQuestionValue", randomInt(1, 3));
		createRecycledActor(getActorType(98), 400, 130, Script.BACK);
		getLastCreatedActor().growTo(40/100, 40/100, 0, Easing.linear);
		createRecycledActor(getActorType(94), 325, 150, Script.BACK);
		getLastCreatedActor().growTo(40/100, 40/100, 0, Easing.linear);
		createRecycledActor(getActorType(92), 490, 235, Script.MIDDLE);
		getLastCreatedActor().growTo(80/100, 80/100, 0, Easing.linear);
		createRecycledActor(getActorType(100), 550, 250, Script.MIDDLE);
		getLastCreatedActor().growTo(80/100, 80/100, 0, Easing.linear);
		createRecycledActor(getActorType(96), 495, 285, Script.MIDDLE);
		getLastCreatedActor().growTo(80/100, 80/100, 0, Easing.linear);
		Engine.engine.setGameAttribute("QuestionMenuLv1", true);
		runLater(1000 * 1, function(timeTask:TimedTask):Void
		{
			createRecycledActor(getActorType(9), 0, 0, Script.MIDDLE);
			getLastCreatedActor().alpha = 50 / 100;
			createRecycledActor(getActorType(86), 150, 100, Script.FRONT);
			getLastCreatedActor().growTo(80/100, 80/100, 0, Easing.linear);
		}, null);
		
		/* ============================ Click ============================= */
		addMousePressedListener(function(list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(((Engine.engine.getGameAttribute("TUTORIAL_Count") : Float) == 0))
				{
					recycleActor(getLastCreatedActor());
					createRecycledActor(getActorType(84), -65, 95, Script.FRONT);
					getLastCreatedActor().growTo(50/100, 50/100, 0, Easing.linear);
					Engine.engine.setGameAttribute("TUTORIAL_Count", 1);
				}
				else if(((Engine.engine.getGameAttribute("TUTORIAL_Count") : Float) == 1))
				{
					recycleActor(getLastCreatedActor());
					createRecycledActor(getActorType(88), 350, 176, Script.FRONT);
					getLastCreatedActor().growTo(50/100, 50/100, 0, Easing.linear);
					Engine.engine.setGameAttribute("TUTORIAL_Count", 2);
				}
				else if(((Engine.engine.getGameAttribute("TUTORIAL_Count") : Float) == 2))
				{
					recycleActor(getLastCreatedActor());
					createRecycledActor(getActorType(90), 432, 0, Script.FRONT);
					getLastCreatedActor().growTo(50/100, 50/100, 0, Easing.linear);
					Engine.engine.setGameAttribute("TUTORIAL_Count", 3);
				}
				else if(((Engine.engine.getGameAttribute("TUTORIAL_Count") : Float) == 3))
				{
					recycleActor(getLastCreatedActor());
					createRecycledActor(getActorType(102), 150, 100, Script.FRONT);
					getLastCreatedActor().growTo(80/100, 80/100, 0, Easing.linear);
					Engine.engine.setGameAttribute("TUTORIAL_Count", 4);
				}
				else if(((Engine.engine.getGameAttribute("TUTORIAL_Count") : Float) == 4))
				{
					Engine.engine.setGameAttribute("QuestionMenuLv1", false);
					recycleActor(getLastCreatedActor());
					switchScene(GameModel.get().scenes.get(3).getID(), null, createCrossfadeTransition(0));
				}
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.setFont(getFont(8));
				g.drawString("" + "Score:", 750, 20);
				g.drawString("" + (Engine.engine.getGameAttribute("Score") : Float), 800, 20);
				Script.setDrawingLayerToActorLayer(getActor(1));
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}