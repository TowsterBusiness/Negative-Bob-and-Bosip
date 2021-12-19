package;

import polymod.fs.SysFileSystem;
import lime.utils.Bytes;
import openfl.display.Shader;
import openfl.filters.ShaderFilter;
import flixel.FlxSubState;
import openfl.filters.BitmapFilter;
import openfl.display.BitmapData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxExtendedSprite;
import flixel.addons.plugin.FlxMouseControl;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import flixel.util.FlxSpriteUtil;
import lime.app.Application;
import openfl.Assets;
import flash.geom.Point;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
import Sys;
import sys.FileSystem;
#end

#if cpp
import sys.thread.Thread;
#end

using StringTools;

import polymod.Polymod;
import polymod.Polymod.PolymodError;

class BootupState extends MusicBeatState
{
	public static var loadedStuff:Bool = false;

	var mainSprite:FlxSprite;
	var screenLight:FlxSprite;
	var light:FlxSprite;
	var black:FlxSprite;
	var white:FlxSprite;

	var tween:FlxTween;

	override public function create():Void
	{
		
		#if sys
		if (!sys.FileSystem.exists(Sys.getCwd() + "/assets/replays"))
			sys.FileSystem.createDirectory(Sys.getCwd() + "/assets/replays");
		#end

		@:privateAccess
		{
			trace("Loaded " + openfl.Assets.getLibrary("default").assetsLoaded + " assets (DEFAULT)");
		}
		
		PlayerSettings.init();

		#if windows
		DiscordClient.initialize();

		Application.current.onExit.add (function (exitCode) {
			DiscordClient.shutdown();
		});
		 
		#end
		super.create();

		FlxG.save.bind('funkin');

		KadeEngineData.initSave();

		Highscore.load();

		FlxG.mouse.visible = false;

		FlxG.sound.playMusic(Paths.music('menuIntro'));
		FlxG.sound.music.stop();
		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));
		for (i in 0...initSonglist.length)
		{
			var data:Array<String> = initSonglist[i].split(':');
			var songHighscore = StringTools.replace(data[0], " ", "-");
				switch (songHighscore) {
					case 'Dad-Battle': songHighscore = 'Dadbattle';
					case 'Philly-Nice': songHighscore = 'Philly';
			}
			if (!loadedStuff) {
				FlxG.sound.cache(Paths.inst(songHighscore));
				if (Paths.instEXcheck(songHighscore) != null) {
					FlxG.sound.cache(Paths.instEX(songHighscore));
				}
			}
		}
		
		loadedStuff = true;

		/* 
		((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
		((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
		((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
		(((((((((((((((((((((#####((((((((((((((((((((((((((((((((((((((((((((((((((((((
		((((((((((((((#&@@#*,....,#@@@@@@@@&%((#%&&@@@@@@@@@@&&#((((((((((((((((((((((((
		(((((((((((&@%*....../@@&(,.,/%@@@%/**,................,*#@@@#((((((((((((((((((
		((((((((&@%,.......(@(.*%@@%/,.............................../@@#(((((((((((((((
		(((((#@&,..........%@@#,.......................................,%@%(((((((((((((
		((((%@*..........&@(......................................,,,,,,,,&@%(((((((((((
		((((@&.........&@*..................................,,,,,,,,,,,,,,,(@%((((((((((
		((#@@&##%&@@,(@(................................,,,,,,,,,,,,,,,,,,,,(@%(((((((((
		(@@..,,/#@@##@*...........................,,,,,,,,,,,,,,,,,,,,,,,,,,,%@(((((((((
		((#%%%#@*../@/.......,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,/@%((((((((
		(((((((#@(,&@...,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,&@((((((((
		((((((((#@%&&,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,#@#(((((((
		((((((((((@@@,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,(@@@@@&%%%
		(((((((((((@@/,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,/@&%%%%%%%
		((((((((((((@@,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,/@@&@@@@@@
		((((((((((((#@%,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,/@&######%
		(((((((((((((#@#,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,#@%##%%,  
		(((((((((((((#&@(,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,&@###%%(..
		((#%&@@@@@&&&%%&@(,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,*@@########
		&%%%%%%%%%%%%%%%&@%,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,#@@@@@@@&%(
		%%%%%&&&@@@@@@@&%%@@,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,(&@@&@@/,,,,,,,,,,,&&*********
		@@@@&%%###%%%&&%###&@(,,,,,,,,,,,,,,,,,,,,,,,/%@@@@@@@@&%@%,,,,,,,,,(@#/((((((//
		###%%(*..      .%%###@@*,,,,,,,,,,,,,,,*@@@@&%(/,******///&@*/#%@@@@@%\\\\\\\\\/
		/*##,      .,/(&%#####%@\,,,,,,,,,,,,,,|@*****////(((((((((###((((((//////////**
		/*##%%%%%#####%%&@@@@@@%%@%,,,,,,,,,,,/@//*((((((((((((((*/////////////////*****
		/* ###%%&@@@@@&%//***********#@%,,,/#&@@@///////////////////////////////////////
		****************.///((//////(&&&%#(((///////////////////////(((((((///(///(/(/(/
		*****///////////////////**//////////////////////((((((((((((/////////////*******
		/////(/(/////*************//////////((((((((((((((///(///////******************//

		/*
			_____        __     __     ______                            _                                               
			|_   _|       \ \   / /    |  ____|                 /\       | |                                              
			  | |  _ __    \ \_/ /__   | |__ __ _  ___ ___     /  \   ___| |__                                            
			  | | | '_ \    \   / _ \  |  __/ _` |/ __/ _ \   / /\ \ / __| '_ \                                           
			 _| |_| | | |    | | (_) | | | | (_| | (_|  __/  / ____ \\__ \ | | |                                          
			|_____|_| |_|    |_|\___/  |_|  \__,_|\___\___| /_/    \_\___/_| |_|           _                       _      
			|_   _|                     | |                 | |                           (_)                     | |     
			  | |    _ __ ___   __ _  __| | ___    ___ _   _| |_ ___  ___ ___ _ __   ___   _ _ __     ___ ___   __| | ___ 
			  | |   | '_ ` _ \ / _` |/ _` |/ _ \  / __| | | | __/ __|/ __/ _ \ '_ \ / _ \ | | '_ \   / __/ _ \ / _` |/ _ \
			 _| |_  | | | | | | (_| | (_| |  __/ | (__| |_| | |_\__ \ (_|  __/ | | |  __/ | | | | | | (_| (_) | (_| |  __/
			|_____| |_| |_| |_|\__,_|\__,_|\___|  \___|\__,_|\__|___/\___\___|_| |_|\___| |_|_| |_|  \___\___/ \__,_|\___|
				
			
			https://youtu.be/iH368K1udig
		*/

		var date:Date = Date.now();
		var dateMonth:String = "0";

		switch (date.getMonth()) {
			case 5:
				if (date.getDate() == 20)
					dateMonth = 'mask';
			case 12:
				if (date.getDate() == 24 || date.getDate() == 25)
					dateMonth = 'christmas';
			default:
				dateMonth = Std.string(date.getMonth() + 1);
		}

		

		mainSprite = new FlxSprite(-644, -361).loadGraphic(Paths.image('desktop/intro/calander/beginning_' + dateMonth , 'preload'));
		mainSprite.scale.set(0.5, 0.5);
		add(mainSprite);

		light = new FlxSprite(-644, -361).loadGraphic(Paths.image('desktop/intro/light', 'preload'));
		light.scale.set(0.5, 0.5);
		add(light);

		//dark
		black = new FlxSprite(-300, -30).loadGraphic(Paths.image('desktop/intro/black', 'preload'));
		add(black);

		//light
		white = new FlxSprite(-300, -30).loadGraphic(Paths.image('desktop/intro/white', 'preload'));
		white.alpha = 0;
		add(white);

		tween = FlxTween.tween(black, {alpha: 0.5}, 2, { type: FlxTweenType.ONESHOT, ease: FlxEase.cubeIn, onComplete: function(tween:FlxTween) {
			black.alpha = 0;
		}, startDelay: 1});
		tween = FlxTween.tween(FlxG.camera, {zoom: 1.1}, 6, { type: FlxTweenType.ONESHOT, ease: FlxEase.sineIn, startDelay: 1});
		tween = FlxTween.tween(FlxG.camera, {zoom: 3.5}, 3, { type: FlxTweenType.ONESHOT, ease: FlxEase.sineIn, startDelay: 7});
		tween = FlxTween.tween(mainSprite, {x: -660, y: -341}, 8, { type: FlxTweenType.ONESHOT, ease: FlxEase.sineIn, startDelay: 1});
		tween = FlxTween.tween(white, {alpha: 1}, 1, { type: FlxTweenType.ONESHOT, ease: FlxEase.cubeIn, onComplete: (a) -> {
			FlxG.switchState(new DesktopState());
		}, startDelay: 8});
	}

	override function update(elapsed:Float)
	{
		if (elapsed == 3000)
			light.alpha = 1;

		if (elapsed == 5000)
			light.alpha = 1;

		if (FlxG.keys.justPressed.ENTER) {
			tween.cancel();
			FlxG.switchState(new DesktopState());
		}

		super.update(elapsed);
	}
}
