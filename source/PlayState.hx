// welcome to friday night frostbite source code!

// also all you need to know:

// 1. thereel is not funny
// 2. sex is so cool
// 3. Montgomery Gator is awesome
// 4. 

// :TrollHD:

// have a nice day!

// - TheReel 9/28/2022

package;

import flixel.graphics.FlxGraphic;
#if desktop
import Discord.DiscordClient;
#end
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.Lib;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.BitmapFilter;
import openfl.utils.Assets as OpenFlAssets;
import editors.ChartingState;
import editors.CharacterEditorState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import Note.EventNote;
import openfl.events.KeyboardEvent;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxSave;
import animateatlas.AtlasFrameMaker;
import Achievements;
import StageData;
import FunkinLua;
import DialogueBoxPsych;
import Conductor.Rating;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

#if VIDEOS_ALLOWED
import vlc.MP4Handler;
#end

using StringTools;

class PlayState extends MusicBeatState
{
	public static var STRUM_X = 42;
	public static var STRUM_X_MIDDLESCROLL = -278;

	public var myass:Array<String> = [
		'Friday Night Frostbite Week 7 leaked on 4chan',
		'Friday Night Funkin Pibby FNF FROSTBITE vs Boyfriend (FNF Mod/Hard/Come Learn With Pibby)',
		'I love Sex!!',
		'h',
		'How many Bonus Songs are there in the mod',
		'Fuck you, you fucking dick',
		'British Informal Park - Friday Night Frostbite OST',
		'My Dad beats me',
		'Found Footage of Me doing the',
		'YIPEEE!!!!',
		'la Puta Madre',
		'I fucking HATE Frostbite from FNF >:(',
		'Sweet little bumblebee, i know what you want from me, Doo bi doo bi doo da da, Doo bi doo bi doo da da',
		'My name is Walter Hartwell White. I live at 308 Negra Arroyo Lane, Albuquerque, New Mexico, 87104. This is my confession.',
		'STOP FUCKING PINGING ME MEE6',
		'Red Underscore says hi!',
		'Hi AD3.!! How are you today??',
		'https://discord.gg/YvT4VtyHD5',
		'I wonder what happens when i deepfry icecubes',
		'Welcome to the Los Pollos Hermanos Family',
		'Dave and Bambi Fantracks be like: BRBRBRRBRRRRRRRRRRRRRRHGRHRHGRGRGRGGRRGAGAGAGSGSAGGSGAGABEEBPEPBPRPREPBPRPGGRGGRGRGAGSG',
		'We should make a Baldis Basics Mod',
		'Top 10 Anime Betrayals',
		'Beep Boop Bap',
		'I just leaked Week 4 of FNFrostbite on 4chan',
		'F____ FURRY EW, f that!'
	];
	public var textthingies:FlxText;
	public var textrandom:Int = 0;

	public var sex:Float = ClientPrefs.sex; // haha i said sex laugh

	public static var ratingStuff:Array<Dynamic> = [
		['=F=', 0.4], //From 0% to 39%
		['!E!', 0.5], //From 40% to 49%
		['@D@', 0.6], //From 50% to 59%
		['#C#', 0.7], //From 60% to 68%
		['$B$', 0.8], //From 70% to 79%
		['^A^', 0.9], //From 80% to 89%
		['&S&', 0.99], //From 90% to 99%
		['_SS_', 1]
	];
	public static var healthStuff:Array<Dynamic> = [
		['=', 0],
		['!', 0.4],
		['@', 0.8],
		['#', 1.2],
		['$', 1.6],
		['^', 2],
		['&', 2]
	];
	var redFormat:FlxTextFormat = new FlxTextFormat(FlxColor.RED);
	var orangeFormat:FlxTextFormat = new FlxTextFormat(FlxColor.ORANGE);
	var yellowFormat:FlxTextFormat = new FlxTextFormat(FlxColor.YELLOW);
	var greenFormat:FlxTextFormat = new FlxTextFormat(FlxColor.GREEN);
	var limeFormat:FlxTextFormat = new FlxTextFormat(FlxColor.LIME);
	var cyanFormat:FlxTextFormat = new FlxTextFormat(FlxColor.CYAN);
	var magentaFormat:FlxTextFormat = new FlxTextFormat(FlxColor.MAGENTA);
	var blackFormat:FlxTextFormat = new FlxTextFormat(FlxColor.BLACK);

	public var modchartTweens:Map<String, FlxTween> = new Map<String, FlxTween>();
	public var modchartSprites:Map<String, ModchartSprite> = new Map<String, ModchartSprite>();
	public var modchartTimers:Map<String, FlxTimer> = new Map<String, FlxTimer>();
	public var modchartSounds:Map<String, FlxSound> = new Map<String, FlxSound>();
	public var modchartTexts:Map<String, ModchartText> = new Map<String, ModchartText>();
	public var modchartSaves:Map<String, FlxSave> = new Map<String, FlxSave>();

	//event variables
	private var isCameraOnForcedPos:Bool = false;
	#if (haxe >= "4.0.0")
	public var boyfriendMap:Map<String, Boyfriend> = new Map();
	public var dadMap:Map<String, Character> = new Map();
	public var gfMap:Map<String, Character> = new Map();
	public var variables:Map<String, Dynamic> = new Map();
	#else
	public var boyfriendMap:Map<String, Boyfriend> = new Map<String, Boyfriend>();
	public var dadMap:Map<String, Character> = new Map<String, Character>();
	public var gfMap:Map<String, Character> = new Map<String, Character>();
	public var variables:Map<String, Dynamic> = new Map<String, Dynamic>();
	#end

	public var BF_X:Float = 770;
	public var BF_Y:Float = 100;
	public var DAD_X:Float = 100;
	public var DAD_Y:Float = 100;
	public var GF_X:Float = 400;
	public var GF_Y:Float = 130;

	public var songSpeedTween:FlxTween;
	public var songSpeed(default, set):Float = 1;
	public var songSpeedType:String = "multiplicative";
	public var songSpeedBonus:Float = 1 / 2.4;
	public var noteKillOffset:Float = 350;

	public var boyfriendGroup:FlxSpriteGroup;
	public var dadGroup:FlxSpriteGroup;
	public var gfGroup:FlxSpriteGroup;
	public static var curStage:String = '';
	public static var SONG:SwagSong = null;
	public static var isStoryMode:Bool = false;
	public static var isCodes:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;
	var creditsText:FlxTypedGroup<FlxText>;
	var creditsTxt:FlxText;
	var box:FlxSprite; 

	public var spawnTime:Float = 2000;

	public var vocals:FlxSound;

	public var dad:Character = null;
	public var gf:Character = null;
	public var boyfriend:Boyfriend = null;

	public var notes:FlxTypedGroup<Note>;
	public var unspawnNotes:Array<Note> = [];
	public var eventNotes:Array<EventNote> = [];
	public var mustHitNoteCount:Int = 0;

	private var strumLine:FlxSprite;

	public var camFollow:FlxPoint;
	public var camFollowPos:FlxObject;
	private static var prevCamFollow:FlxPoint;
	private static var prevCamFollowPos:FlxObject;

	public var strumLineNotes:FlxTypedGroup<StrumNote>;
	public var opponentStrums:FlxTypedGroup<StrumNote>;
	public var playerStrums:FlxTypedGroup<StrumNote>;
	public var grpNoteSplashes:FlxTypedGroup<NoteSplash>;

	public var camZooming:Bool = false;
	public var camZoomingMult:Float = 1;
	public var camZoomingDecay:Float = 1;
	private var curSong:String = "";

	public var gfSpeed:Int = 1;
	public var health:Float = 1;
	public var maxHealth:Float = 2;
	public var healthDrained:Float = 1;
	public var healthPercentageDisplay:Float = 50;
	public var healthPercentageBar:Float = 50;
	public var oldPercentage:Float = 50;
	public var combo:Int = 0;

	private var healthBorder:AttachedSprite;
	private var healthBarBG:AttachedSprite;
	public var healthBar:FlxBar;
	var songPercent:Float = 0;

	private var timeBarBG:AttachedSprite;
	public var timeBar:FlxBar;

	public var ratingsData:Array<Rating> = [];
	public var maxs:Int = 0;
	public var sicks:Int = 0;
	public var goods:Int = 0;
	public var bads:Int = 0;
	public var shits:Int = 0;

	private var generatedMusic:Bool = false;
	public var endingSong:Bool = false;
	public var startingSong:Bool = false;
	private var updateTime:Bool = true;
	public static var changedDifficulty:Bool = false;
	public static var chartingMode:Bool = false;

	//Gameplay settings
	public var healthGain:Float = 1;
	public var healthLoss:Float = 1;
	public var instakillOnMiss:Bool = false;
	public var cpuControlled:Bool = false;
	public var practiceMode:Bool = false;
	public var opponentPlay:Bool = false;

	public var botplaySine:Float = 0;
	public var botplayTxt:FlxText;

	public var iconP1:HealthIcon;
	public var iconP2:HealthIcon;
	public var camHUD:FlxCamera;
	public var camCREDITS:FlxCamera;
	public var camGame:FlxCamera;
	public var camOther:FlxCamera;
	public var camChars:FlxCamera; // Special camera for characters
	public var cameraSpeed:Float = 0.7;

	var dialogue:Array<String> = ['blah blah blah', 'coolswag'];
	var dialogueJson:DialogueFile = null;

	public var songScore:Float = 0;
	public var maxScore:Float = 0;
	public var thScore:Float = 0;
	public var songHits:Int = 0;
	public var songMisses:Int = 0;
	public var pressMisses:Int = 0;
	public var scoreText:FlxText;
	public var missesTxt:FlxText;
	public var ratingTxt:FlxText;
	public var accuracyTxt:FlxText;
	var timeTxt:FlxText;

	public static var campaignScore:Int = 0;
	public static var campaignMisses:Int = 0;
	public static var seenCutscene:Bool = false;
	public static var deathCounter:Int = 0;

	public var defaultCamZoom:Float = 1.05;

	public static var daPixelZoom:Float = 6;
	private var singAnimations:Array<String> = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];

	public var inCutscene:Bool = false;
	public var skipCountdown:Bool = false;
	var songLength:Float = 0;

	public var boyfriendCameraOffset:Array<Float> = null;
	public var opponentCameraOffset:Array<Float> = null;
	public var girlfriendCameraOffset:Array<Float> = null;

	#if desktop
	// Discord RPC variables
	var storyDifficultyText:String = "";
	var detailsText:String = "";
	var detailsPausedText:String = "";
	#end

	//Achievement shit
	var keysPressed:Array<Bool> = [];
	var boyfriendIdleTime:Float = 0.0;
	var boyfriendIdled:Bool = false;

	// Lua shit
	public static var instance:PlayState;
	public var luaArray:Array<FunkinLua> = [];
	private var luaDebugGroup:FlxTypedGroup<DebugLuaText>;
	public var introSoundsSuffix:String = '';

	// Debug buttons
	private var debugKeysChart:Array<FlxKey>;
	private var debugKeysCharacter:Array<FlxKey>;

	// Less laggy controls
	private var keysArray:Array<Dynamic>;

	var precacheList:Map<String, String> = new Map<String, String>();

	private var oldLQ:Bool = ClientPrefs.lowQuality; // Avoids loading things into RAM that won't be rendered
	private var vignette:FlxSprite;
	private var tempMissPenalty:Float = 0;
	private var playerLaneUnderlay:FlxSprite;
	private var opponentLaneUnderlay:FlxSprite;

	// bg layering shit
	var tree:BGSprite;
	var floff:FlxSprite;

	// bullet
	public static var hpmechanic = false;

	override public function create()
	{
		textthingies = new FlxText(0, 1000, 625, '');
		creditsTxt = new FlxText(0, 25, 0, '', 24);

		textrandom = FlxG.random.int(1, 26);

		switch(textrandom) { // again
			case 1:
				textthingies.text = myass[0];
			case 2:
				textthingies.text = myass[1];
			case 3:
				textthingies.text = myass[2];
			case 4:
				textthingies.text = myass[3];
			case 5:
				textthingies.text = myass[4];
			case 6:
				textthingies.text = myass[5];
			case 7:
				textthingies.text = myass[6];
			case 8:
				textthingies.text = myass[7];
			case 9:
				textthingies.text = myass[8];
			case 10:
				textthingies.text = myass[9];
			case 11:
				textthingies.text = myass[10];
			case 12:
				textthingies.text = myass[11];
			case 13:
				textthingies.text = myass[12];
			case 14:
				textthingies.text = myass[13];
			case 15:
				textthingies.text = myass[14];
			case 16:
				textthingies.text = myass[15];
			case 17:
				textthingies.text = myass[16];
			case 18:
				textthingies.text = myass[17];
			case 19:
				textthingies.text = myass[18];
			case 20:
				textthingies.text = myass[19];
			case 21:
				textthingies.text = myass[20];
			case 22:
				textthingies.text = myass[21];
			case 23:
				textthingies.text = myass[22];
			case 24:
				textthingies.text = myass[23];
			case 25:
				textthingies.text = myass[24];
			case 26:
				textthingies.text = myass[25];
		} 
		// TheReel REALLY SUCKS as coder

		Paths.clearStoredMemory();
		if (ClientPrefs.hideAllSprites) ClientPrefs.lowQuality = true;

		// for lua
		instance = this;

		debugKeysChart = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));
		debugKeysCharacter = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_2'));
		PauseSubState.songName = null; //Reset to default

		keysArray = [
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_left')),
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_down')),
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_up')),
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_right'))
		];

		//Ratings
		if(ClientPrefs.scoreSystem == 'osu!mania' || ClientPrefs.accuracySystem.startsWith('osu!mania')) ratingsData.push(new Rating('max')); //default rating

		var rating:Rating = new Rating('sick');
		rating.hitValue = 300;
		rating.hitBonus = 1;
		ratingsData.push(rating);

		var rating:Rating = new Rating('good');
		rating.ratingMod = 0.7;
		rating.score = 200;
		rating.noteSplash = false;
		rating.hitValue = 200;
		rating.hitBonus = 0;
		rating.hitBonusValue = 16;
		rating.hitPunishment = 8;
		ratingsData.push(rating);

		var rating:Rating = new Rating('bad');
		rating.ratingMod = 0.4;
		rating.score = 100;
		rating.noteSplash = false;
		rating.hitValue = 100;
		rating.hitBonus = 0;
		rating.hitBonusValue = 8;
		rating.hitPunishment = 24;
		ratingsData.push(rating);

		var rating:Rating = new Rating('shit');
		rating.ratingMod = 0;
		rating.score = 50;
		rating.noteSplash = false;
		rating.hitValue = 50;
		rating.hitBonus = 0;
		rating.hitBonusValue = 4;
		rating.hitPunishment = 44;
		ratingsData.push(rating);

		// For the "Just the Two of Us" achievement
		for (i in 0...keysArray.length)
		{
			keysPressed.push(false);
		}

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		// Gameplay settings
		healthGain = ClientPrefs.getGameplaySetting('healthgain', 1);
		healthLoss = ClientPrefs.getGameplaySetting('healthloss', 1);
		instakillOnMiss = ClientPrefs.getGameplaySetting('instakill', false);
		practiceMode = ClientPrefs.getGameplaySetting('practice', false);
		cpuControlled = ClientPrefs.getGameplaySetting('botplay', false);
		opponentPlay = ClientPrefs.getGameplaySetting('opponentplay', false);
		maxHealth = ClientPrefs.getGameplaySetting('maxhealth', 1) * 2.0;
		if (curSong == "Let Us In") //lol
			health = ClientPrefs.getGameplaySetting('startinghealth', 69) * 2.0;
		else
			health = ClientPrefs.getGameplaySetting('startinghealth', 0.5) * 2.0;

		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camCREDITS = new FlxCamera();
		camOther = new FlxCamera();
		camChars = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camCREDITS.bgColor.alpha = 0;
		camOther.bgColor.alpha = 0;
		camChars.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		if (ClientPrefs.hideAllSprites) {
			FlxG.cameras.add(camChars);
			FlxG.camera = camChars;
			camChars.visible = false;
		}
		FlxG.cameras.add(camHUD);
		FlxG.cameras.add(camOther);
		FlxG.cameras.add(camCREDITS);
		grpNoteSplashes = new FlxTypedGroup<NoteSplash>();

		FlxCamera.defaultCameras = [camGame];
		CustomFadeTransition.nextCamera = camOther;

		persistentUpdate = true;
		persistentDraw = true;

		if (SONG == null)
			SONG = Song.loadFromJson('tutorial');

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);

		#if desktop
		storyDifficultyText = CoolUtil.difficulties[storyDifficulty];

		// String that contains the mode defined here so it isn't necessary to call changePresence for each mode
		if (isStoryMode)
		{
			detailsText = "Story Mode: " + WeekData.getCurrentWeek().weekName;
		}
		else if (isCodes)
		{
			detailsText = "Funny Codes Song";
		}
		else
		{
			detailsText = "Freeplay";
		}

		// String for when the game is paused
		detailsPausedText = "Paused - " + detailsText;
		#end

		GameOverSubstate.resetVariables();
		var songName:String = Paths.formatToSongPath(SONG.song);


		if(SONG.stage == null || SONG.stage.length < 1) { 
			curStage = 'stage';
			SONG.stage = curStage;
		}
		else
			curStage = SONG.stage;

		var stageData:StageFile = StageData.getStageFile(curStage);
		if(stageData == null) { //Stage couldn't be found, create a dummy stage for preventing a crash
			stageData = {
				directory: "",
				defaultZoom: 0.9,

				boyfriend: [770, 100],
				girlfriend: [400, 130],
				opponent: [100, 100],
				hide_girlfriend: false,

				camera_boyfriend: [0, 0],
				camera_opponent: [0, 0],
				camera_girlfriend: [0, 0],
				camera_speed: 1
			};
		}

		defaultCamZoom = ClientPrefs.cameraZoom != 1.0 ? ClientPrefs.cameraZoom : stageData.defaultZoom;
		BF_X = stageData.boyfriend[0];
		BF_Y = stageData.boyfriend[1];
		GF_X = stageData.girlfriend[0];
		GF_Y = stageData.girlfriend[1];
		DAD_X = stageData.opponent[0];
		DAD_Y = stageData.opponent[1];

		if(stageData.camera_speed != null)
			cameraSpeed = stageData.camera_speed;

		boyfriendCameraOffset = stageData.camera_boyfriend;
		if(boyfriendCameraOffset == null)
			boyfriendCameraOffset = [0, 0];

		opponentCameraOffset = stageData.camera_opponent;
		if(opponentCameraOffset == null)
			opponentCameraOffset = [0, 0];

		girlfriendCameraOffset = stageData.camera_girlfriend;
		if(girlfriendCameraOffset == null)
			girlfriendCameraOffset = [0, 0];

		boyfriendGroup = new FlxSpriteGroup(BF_X, BF_Y);
		dadGroup = new FlxSpriteGroup(DAD_X, DAD_Y);
		gfGroup = new FlxSpriteGroup(GF_X, GF_Y);

		switch (curStage)
		{
			case 'stage':
				var bg:BGSprite = new BGSprite('stageback', -600, -200, 0.9, 0.9);
				add(bg);

				var stageFront:BGSprite = new BGSprite('stagefront', -650, 600, 0.9, 0.9);
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
				stageFront.updateHitbox();
				add(stageFront);
				if(!ClientPrefs.lowQuality) {
					var stageLight:BGSprite = new BGSprite('stage_light', -125, -100, 0.9, 0.9);
					stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
					stageLight.updateHitbox();
					add(stageLight);
					var stageLight:BGSprite = new BGSprite('stage_light', 1225, -100, 0.9, 0.9);
					stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
					stageLight.updateHitbox();
					stageLight.flipX = true;
					add(stageLight);

					var stageCurtains:BGSprite = new BGSprite('stagecurtains', -500, -300, 1.3, 1.3);
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					add(stageCurtains);
				}
			case 'alleyway':
				var alleyway:BGSprite = new BGSprite('alleyway', -600, -350, 0.9, 0.9);
				add(alleyway);
			case 'alleyway2': // Frozen System BG fix
				var alleyway:BGSprite = new BGSprite('alleyway', -700, -350, 0.9, 0.9);
				add(alleyway);
			case 'Avenida':
				var avenida:BGSprite = new BGSprite('Avenida', -600, -300, 0.9, 0.9);
				add(avenida);
			case 'Basement':
				var basement:BGSprite = new BGSprite('basement', -600, -300, 0.9, 0.9);
				add(basement);
			case 'dark_alleyway':
				var darkalleyway:BGSprite = new BGSprite('dark_alleyway', -350, -300, 0.9, 0.9);
				add(darkalleyway);
			case 'dark_winter':
				var darkwinter:BGSprite = new BGSprite('dark_winter', -750, -280, 0.9, 0.9);
				add(darkwinter);
			case 'erect_somethingfunni':
				var erectfunni:BGSprite = new BGSprite('erect_somethingfunni', -600, -300, 0.9, 0.9);
				add(erectfunni);
			case 'erect_winter':
				var erectwinter:BGSprite = new BGSprite('erect_winter', -650, -280, 0.9, 0.9);
				add(erectwinter);
			case 'frototdate':
				var stageblack:BGSprite = new BGSprite('black', -520, -130, 1, 1);
				add(stageblack);
				var nightsky:BGSprite = new BGSprite('nightsky', -3000, -2000, 0.05, 0.05);
				add(nightsky);
				var buildings:BGSprite = new BGSprite('buildings', -3000, 0, 0.3, 0.3);
				add(buildings);
				var mansion:BGSprite = new BGSprite('mansion', 300, 0, 0.5, 0.5);
				add(mansion);
				var lights:BGSprite = new BGSprite('lights', -1100, -1000, 0.45, 0.45);
				add(lights);
				var sign:BGSprite = new BGSprite('thing', -300, 300, 0.6, 0.6);
				add(sign);
				var grass:BGSprite = new BGSprite('grass', -2600, 1200, 1, 1);
				add(grass);
				tree = new BGSprite('tree', -1000, 100, 1.2, 1.2);
			case 'frototmansion':
				var stageblack:BGSprite = new BGSprite('black', -520, -130, 1, 1);
				add(stageblack);
				var nightsky:BGSprite = new BGSprite('nightsky', -3000, -2000, 0.05, 0.05);
				add(nightsky);
				var buildings:BGSprite = new BGSprite('buildings', -3000, 0, 0.3, 0.3);
				add(buildings);
				var mansion:BGSprite = new BGSprite('mansion', 300, 0, 0.5, 0.5);
				add(mansion);
				var lights:BGSprite = new BGSprite('lights', -1100, -1000, 0.45, 0.45);
				add(lights);
				var sign:BGSprite = new BGSprite('thing', -300, 300, 0.6, 0.6);
				add(sign);
				var grass:BGSprite = new BGSprite('grass', -2600, 1200, 1, 1);
				add(grass);
				floff = new FlxSprite(1550, 200);
				floff.frames = Paths.getSparrowAtlas('dicktrocity_bg');
				floff.animation.addByPrefix('bench', 'bench', 24, true);
				floff.animation.play('bench', true);
				floff.scrollFactor.set(1.05, 1.05);
				tree = new BGSprite('tree', -1000, 100, 1.2, 1.2);
			case 'Office':
				var office:BGSprite = new BGSprite('Office', -600, -300, 0.9, 0.9);
				add(office);
			case 'ourple':
				var stageblack:BGSprite = new BGSprite('black', -520, -130, 1, 1);
				add(stageblack);
				var stagepurple:BGSprite = new BGSprite('ourple', -520, -130, 1, 1);
				add(stagepurple);
			case 'polus':
				var polus:BGSprite = new BGSprite('polus', -600, -300, 0.9, 0.9);
				add(polus);
			case 'raymanbg':
				var sky:BGSprite = new BGSprite('rayman_sky', -600, -300, 0.1, 0.1);
				add(sky);		
				var mountains:BGSprite = new BGSprite('rayman_mountain', -700, -600, 0.2, 0.2);
				add(mountains);	
				var grass:BGSprite = new BGSprite('rayman_grass', -550, -350, 1, 1);
				add(grass);
				tree = new BGSprite('rayman_tree', -700, -500, 1.3, 1.3);
			case 'somethingfunni':
				var somethingfunni:BGSprite = new BGSprite('somethingfunni', -600, -300, 0.9, 0.9);
				add(somethingfunni);
			case 'winter':
				var winter:BGSprite = new BGSprite('winter', -600, -280, 0.9, 0.9);
				add(winter);
			case 'scatmann':
				FlxG.camera.bgColor = 0xFFFFFFFF;
		}

		add(gfGroup);
		add(dadGroup);
		add(boyfriendGroup);
		// layering shitties
		if(curStage == "frototdate" || curStage == "raymanbg")
			add(tree);
		if (curStage == "frototmansion"){
			add(tree);
			add(floff);
		}
		
		#if LUA_ALLOWED
		luaDebugGroup = new FlxTypedGroup<DebugLuaText>();
		luaDebugGroup.cameras = [camOther];
		add(luaDebugGroup);
		#end

		// "GLOBAL" SCRIPTS
		#if LUA_ALLOWED
		var filesPushed:Array<String> = [];
		var foldersToCheck:Array<String> = [Paths.getPreloadPath('scripts/')];

		#if MODS_ALLOWED
		foldersToCheck.insert(0, Paths.mods('scripts/'));
		if(Paths.currentModDirectory != null && Paths.currentModDirectory.length > 0)
			foldersToCheck.insert(0, Paths.mods(Paths.currentModDirectory + '/scripts/'));

		for(mod in Paths.getGlobalMods())
			foldersToCheck.insert(0, Paths.mods(mod + '/scripts/'));
		#end

		for (folder in foldersToCheck)
		{
			if(FileSystem.exists(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					if(file.endsWith('.lua') && !filesPushed.contains(file))
					{
						luaArray.push(new FunkinLua(folder + file));
						filesPushed.push(file);
					}
				}
			}
		}
		#end


		// STAGE SCRIPTS
		#if (MODS_ALLOWED && LUA_ALLOWED)
		var doPush:Bool = false;
		var luaFile:String = 'stages/' + curStage + '.lua';
		if(FileSystem.exists(Paths.modFolders(luaFile))) {
			luaFile = Paths.modFolders(luaFile);
			doPush = true;
		} else {
			luaFile = Paths.getPreloadPath(luaFile);
			if(FileSystem.exists(luaFile)) {
				doPush = true;
			}
		}

		if(doPush)
			luaArray.push(new FunkinLua(luaFile));
		#end

		textthingies.setFormat(Paths.font("SansUndertale.ttf"), 36, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		textthingies.cameras = [camHUD];
		textthingies.screenCenter(X);
		textthingies.scrollFactor.set();

		//so true
		if (curSong == 'iceberg')
			skipCountdown = true;

		var gfVersion:String = SONG.gfVersion;
		if(gfVersion == null || gfVersion.length < 1)
		{
			gfVersion = 'gf';
			SONG.gfVersion = gfVersion; //Fix for the Chart Editor
		}

		if (!stageData.hide_girlfriend || curSong != "Can't Break Free") {
			gf = new Character(0, 0, gfVersion);
			startCharacterPos(gf);
			gf.scrollFactor.set(0.95, 0.95);
			gfGroup.add(gf);
			startCharacterLua(gf.curCharacter);
		}

		dad = new Character(0, 0, SONG.player2);
		startCharacterPos(dad, true);
		dadGroup.add(dad);
		startCharacterLua(dad.curCharacter);

		boyfriend = new Boyfriend(0, 0, SONG.player1);
		startCharacterPos(boyfriend);
		boyfriendGroup.add(boyfriend);
		startCharacterLua(boyfriend.curCharacter);

		var camPos:FlxPoint = new FlxPoint(girlfriendCameraOffset[0], girlfriendCameraOffset[1]);
		if(gf != null)
		{
			camPos.x += gf.getGraphicMidpoint().x + gf.cameraPosition[0];
			camPos.y += gf.getGraphicMidpoint().y + gf.cameraPosition[1];
		}

		if(dad.curCharacter.startsWith('gf')) {
			dad.setPosition(GF_X, GF_Y);
			if(gf != null)
				gf.visible = false;
		}

		var file:String = Paths.json(songName + '/dialogue'); //Checks for json/Psych Engine dialogue
		if (OpenFlAssets.exists(file)) {
			dialogueJson = DialogueBoxPsych.parseDialogue(file);
		}

		var file:String = Paths.txt(songName + '/' + songName + 'Dialogue'); //Checks for vanilla/Senpai dialogue
		if (OpenFlAssets.exists(file)) {
			dialogue = CoolUtil.coolTextFile(file);
		}
		var doof:DialogueBox = new DialogueBox(false, dialogue);
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;
		doof.nextDialogueThing = startNextDialogue;
		doof.skipDialogueThing = skipDialogue;

		Conductor.songPosition = -5000;

		strumLine = new FlxSprite(ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X, 50).makeGraphic(FlxG.width, 10);
		if(ClientPrefs.downScroll) strumLine.y = FlxG.height - 150;
		strumLine.scrollFactor.set();

		playerLaneUnderlay = new FlxSprite(0, 0).makeGraphic(110 * 4 + 50, FlxG.height, FlxColor.BLACK);
		playerLaneUnderlay.alpha = ClientPrefs.playerLaneUnderlayOpacity;
		playerLaneUnderlay.scrollFactor.set();
		add(playerLaneUnderlay);

		opponentLaneUnderlay = new FlxSprite(0, 0).makeGraphic(110 * 4 + 50, FlxG.height, FlxColor.BLACK);
		opponentLaneUnderlay.alpha = ClientPrefs.opponentLaneUnderlayOpacity;
		opponentLaneUnderlay.scrollFactor.set();
		if (!ClientPrefs.middleScroll) add(opponentLaneUnderlay);

		var showTime:Bool = (ClientPrefs.timeBarType != 'Disabled');
		timeTxt = new FlxText(STRUM_X + (FlxG.width / 2) - 248, 19, 400, "", 32);
		timeTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		timeTxt.scrollFactor.set();
		timeTxt.alpha = 0;
		timeTxt.borderSize = 2;
		timeTxt.visible = showTime;
		if(ClientPrefs.downScroll) timeTxt.y = FlxG.height - 44;

		if(ClientPrefs.timeBarType == 'Song Name')
		{
			timeTxt.text = SONG.song;
		}
		updateTime = showTime;

		timeBarBG = new AttachedSprite('timeBar');
		timeBarBG.x = timeTxt.x;
		timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
		timeBarBG.scrollFactor.set();
		timeBarBG.alpha = 0;
		timeBarBG.visible = showTime;
		timeBarBG.color = FlxColor.BLACK;
		timeBarBG.xAdd = -4;
		timeBarBG.yAdd = -4;
		add(timeBarBG);

		timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), this,
			'songPercent', 0, 1);
		timeBar.scrollFactor.set();
		timeBar.createFilledBar(0xFF000000, 0xFF5AA4E6); // re-color !!!
		timeBar.numDivisions = 200;
		timeBar.alpha = 0;
		timeBar.visible = showTime;
		add(timeBar);
		add(timeTxt);
		timeBarBG.sprTracker = timeBar;

		strumLineNotes = new FlxTypedGroup<StrumNote>();
		add(strumLineNotes);
		add(grpNoteSplashes);

		if(ClientPrefs.timeBarType == 'Song Name')
		{
			timeTxt.size = 24;
			timeTxt.y += 3;
		}

		var splash:NoteSplash = new NoteSplash(100, 100, 0);
		grpNoteSplashes.add(splash);
		splash.alpha = 0.0;

		opponentStrums = new FlxTypedGroup<StrumNote>();
		playerStrums = new FlxTypedGroup<StrumNote>();

		generateSong(SONG.song);
		#if LUA_ALLOWED
		for (notetype in noteTypeMap.keys())
		{
			#if MODS_ALLOWED
			var luaToLoad:String = Paths.modFolders('custom_notetypes/' + notetype + '.lua');
			if(FileSystem.exists(luaToLoad))
			{
				luaArray.push(new FunkinLua(luaToLoad));
			}
			else
			{
				luaToLoad = Paths.getPreloadPath('custom_notetypes/' + notetype + '.lua');
				if(FileSystem.exists(luaToLoad))
				{
					luaArray.push(new FunkinLua(luaToLoad));
				}
			}
			#elseif sys
			var luaToLoad:String = Paths.getPreloadPath('custom_notetypes/' + notetype + '.lua');
			if(OpenFlAssets.exists(luaToLoad))
			{
				luaArray.push(new FunkinLua(luaToLoad));
			}
			#end
		}
		for (event in eventPushedMap.keys())
		{
			#if MODS_ALLOWED
			var luaToLoad:String = Paths.modFolders('custom_events/' + event + '.lua');
			if(FileSystem.exists(luaToLoad))
			{
				luaArray.push(new FunkinLua(luaToLoad));
			}
			else
			{
				luaToLoad = Paths.getPreloadPath('custom_events/' + event + '.lua');
				if(FileSystem.exists(luaToLoad))
				{
					luaArray.push(new FunkinLua(luaToLoad));
				}
			}
			#elseif sys
			var luaToLoad:String = Paths.getPreloadPath('custom_events/' + event + '.lua');
			if(OpenFlAssets.exists(luaToLoad))
			{
				luaArray.push(new FunkinLua(luaToLoad));
			}
			#end
		}
		#end
		noteTypeMap.clear();
		noteTypeMap = null;
		eventPushedMap.clear();
		eventPushedMap = null;

		camFollow = new FlxPoint();
		camFollowPos = new FlxObject(0, 0, 1, 1);

		snapCamFollowToPos(camPos.x, camPos.y);
		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}
		if (prevCamFollowPos != null)
		{
			camFollowPos = prevCamFollowPos;
			prevCamFollowPos = null;
		}
		add(camFollowPos);

		FlxG.camera.follow(camFollowPos, LOCKON, 1);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow);

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;
		moveCameraSection();

		healthBorder = new AttachedSprite('healthBorder');
		healthBorder.y = FlxG.height * 0.88;
		healthBorder.screenCenter(X);
		healthBorder.scrollFactor.set();
		healthBorder.visible = !ClientPrefs.hideHud && ClientPrefs.healthBarType != 'Disabled';
		healthBorder.xAdd = 146;
		healthBorder.yAdd = -28;
		add(healthBorder);
		if(ClientPrefs.downScroll) healthBorder.y = 0.11 * FlxG.height;
		
		healthBarBG = new AttachedSprite('healthBar');
		healthBarBG.y = FlxG.height * 0.89;
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		healthBarBG.visible = !ClientPrefs.hideHud && ClientPrefs.healthBarType != 'Disabled';
		healthBarBG.xAdd = 196;
		healthBarBG.yAdd = -4;
		add(healthBarBG);
		if(ClientPrefs.downScroll) healthBarBG.y = 0.11 * FlxG.height;

		healthBar = new FlxBar(healthBarBG.x + 204, healthBarBG.y + 4, (opponentPlay ? LEFT_TO_RIGHT : RIGHT_TO_LEFT), Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'health', 0, 2);
		healthBar.scrollFactor.set();
		healthBar.visible = !ClientPrefs.hideHud && ClientPrefs.healthBarType != 'Disabled';
		healthBar.alpha = ClientPrefs.healthBarAlpha;
		add(healthBar);
		healthBorder.sprTracker = healthBar;
		healthBarBG.sprTracker = healthBar;

		iconP1 = new HealthIcon(boyfriend.healthIcon, true);
		iconP1.y = healthBar.y - 75;
		iconP1.visible = !ClientPrefs.hideHud && ClientPrefs.healthBarType != 'Disabled';
		iconP1.alpha = ClientPrefs.healthBarAlpha;
		add(iconP1);

		iconP2 = new HealthIcon(dad.healthIcon, false);
		iconP2.y = healthBar.y - 75;
		iconP2.visible = !ClientPrefs.hideHud && ClientPrefs.healthBarType != 'Disabled';
		iconP2.alpha = ClientPrefs.healthBarAlpha;
		add(iconP2);
		reloadHealthBarColors();

		// Sexy HUD
		var downScrollAccount:Int = FlxG.height - 150;
		if (ClientPrefs.downScroll)
			downScrollAccount -= 500;
		scoreText = new FlxText(20, downScrollAccount, FlxG.width, "", 25);
		scoreText.setFormat(Paths.font("SansUndertale.ttf"), 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreText.scrollFactor.set();
		scoreText.borderSize = 1.25;
		scoreText.visible = !ClientPrefs.hideHud;
		add(scoreText);
		missesTxt = new FlxText(20, downScrollAccount + 25, FlxG.width, "", 25);
		missesTxt.setFormat(Paths.font("SansUndertale.ttf"), 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		missesTxt.scrollFactor.set();
		missesTxt.borderSize = 1.25;
		missesTxt.visible = !ClientPrefs.hideHud;
		add(missesTxt);
		ratingTxt = new FlxText(20, downScrollAccount + 50, FlxG.width, "", 25);
		ratingTxt.setFormat(Paths.font("SansUndertale.ttf"), 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		ratingTxt.scrollFactor.set();
		ratingTxt.borderSize = 1.25;
		ratingTxt.visible = !ClientPrefs.hideHud;
		add(ratingTxt);
		accuracyTxt = new FlxText(20, downScrollAccount + 75, FlxG.width, "", 25);
		accuracyTxt.setFormat(Paths.font("SansUndertale.ttf"), 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		accuracyTxt.scrollFactor.set();
		accuracyTxt.borderSize = 1.25;
		accuracyTxt.visible = !ClientPrefs.hideHud;
		add(accuracyTxt);

		botplayTxt = new FlxText(400, timeBarBG.y + 55, FlxG.width - 800, "SKILL ISSUE", 32);
		botplayTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		botplayTxt.scrollFactor.set();
		botplayTxt.borderSize = 1.25;
		botplayTxt.visible = cpuControlled;
		add(botplayTxt);
		if(ClientPrefs.downScroll) {
			botplayTxt.y = timeBarBG.y - 78;
		}

		var versionTxt:FlxText = new FlxText(4, FlxG.height - 24, 0, '${SONG.song} - ${CoolUtil.difficultyString()} | ProjectFNF v${MainMenuState.projectFnfVersion}', 12);
		versionTxt.scrollFactor.set();
		versionTxt.screenCenter(X);
		versionTxt.setFormat(Paths.font("SansUndertale.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionTxt);

		if (ClientPrefs.healthBarType.startsWith('Vertical')) {
			healthBar.angle = 90;
			healthBar.x = ClientPrefs.healthBarType.endsWith('(left)') ? -245 : FlxG.width - 350;
			healthBar.screenCenter(Y);
		}
		strumLineNotes.cameras = [camHUD];
		grpNoteSplashes.cameras = [camHUD];
		notes.cameras = [camHUD];
		healthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		healthBorder.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		scoreText.cameras = [camHUD];
		missesTxt.cameras = [camHUD];
		ratingTxt.cameras = [camHUD];
		accuracyTxt.cameras = [camHUD];
		botplayTxt.cameras = [camHUD];
		timeBar.cameras = [camHUD];
		timeBarBG.cameras = [camHUD];
		timeTxt.cameras = [camHUD];
		playerLaneUnderlay.cameras = [camHUD];
		opponentLaneUnderlay.cameras = [camHUD];
		doof.cameras = [camHUD];
		versionTxt.cameras = [camHUD];

		startingSong = true;

		// SONG SPECIFIC SCRIPTS
		#if LUA_ALLOWED
		var filesPushed:Array<String> = [];
		var foldersToCheck:Array<String> = [Paths.getPreloadPath('data/' + Paths.formatToSongPath(SONG.song) + '/')];

		#if MODS_ALLOWED
		foldersToCheck.insert(0, Paths.mods('data/' + Paths.formatToSongPath(SONG.song) + '/'));
		if(Paths.currentModDirectory != null && Paths.currentModDirectory.length > 0)
			foldersToCheck.insert(0, Paths.mods(Paths.currentModDirectory + '/data/' + Paths.formatToSongPath(SONG.song) + '/'));

		for(mod in Paths.getGlobalMods())
			foldersToCheck.insert(0, Paths.mods(mod + '/data/' + Paths.formatToSongPath(SONG.song) + '/' ));// using push instead of insert because these should run after everything else
		#end

		for (folder in foldersToCheck)
		{
			if(FileSystem.exists(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					if(file.endsWith('.lua') && !filesPushed.contains(file))
					{
						luaArray.push(new FunkinLua(folder + file));
						filesPushed.push(file);
					}
				}
			}
		}
		#end

		var daSong:String = Paths.formatToSongPath(curSong);
		if (isStoryMode && !seenCutscene)
		{
			switch (daSong) {
				case 'chilly' | 'astral snowstorm' | 'blizzard' | 'cold-destiny' | 'swift' | 'iceberg':
					startDialogue(dialogueJson);
				case 'cantrocity':
					startVideo('real');
				default:
					startCountdown();
			}
			seenCutscene = true;
		}
		else
		{
			startCountdown();
		}
		RecalculateRating();

		//PRECACHING MISS SOUNDS BECAUSE I THINK THEY CAN LAG PEOPLE AND FUCK THEM UP IDK HOW HAXE WORKS
		if(ClientPrefs.hitsoundVolume > 0) precacheList.set('hitsound', 'sound');
		precacheList.set('missnote1', 'sound');
		precacheList.set('missnote2', 'sound');
		precacheList.set('missnote3', 'sound');

		if (PauseSubState.songName != null) {
			precacheList.set(PauseSubState.songName, 'music');
		} else if(ClientPrefs.pauseMusic != 'None') {
			precacheList.set(Paths.formatToSongPath(ClientPrefs.pauseMusic), 'music');
		}

		precacheList.set('vignette', 'image');

		#if desktop
		// Updating Discord Rich Presence.
		DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
		#end

		if(!ClientPrefs.controllerMode)
		{
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}

		if (ClientPrefs.scoreSystem == 'osu!mania')
			for (i in 0...101)
				bonusSqrtArray.insert(i, Math.sqrt(i)); // Square roots are expensive

		Conductor.safeZoneOffset = (ClientPrefs.safeFrames / 60) * 1000;
		callOnLuas('onCreatePost', []);

		super.create();

		Paths.clearUnusedMemory();

		for (key => type in precacheList)
		{
			switch(type)
			{
				case 'image':
					Paths.image(key);
				case 'sound':
					Paths.sound(key);
				case 'music':
					Paths.music(key);
			}
		}
		CustomFadeTransition.nextCamera = camOther;
	}

	function set_songSpeed(value:Float):Float
	{
		if(generatedMusic)
		{
			var ratio:Float = value / songSpeed; //funny word huh
			for (note in notes) note.resizeByRatio(ratio);
			for (note in unspawnNotes) note.resizeByRatio(ratio);
		}
		songSpeedBonus = (songSpeed + value) / 2;
		songSpeed = value;
		noteKillOffset = 350 / songSpeed;
		return value;
	}

	public function addTextToDebug(text:String, color:FlxColor) {
		#if LUA_ALLOWED
		luaDebugGroup.forEachAlive(function(spr:DebugLuaText) {
			spr.y += 20;
		});

		if(luaDebugGroup.members.length > 34) {
			var blah = luaDebugGroup.members[34];
			blah.destroy();
			luaDebugGroup.remove(blah);
		}
		luaDebugGroup.insert(0, new DebugLuaText(text, luaDebugGroup, color));
		#end
	}

	public function reloadHealthBarColors() {
		if (!opponentPlay)
		healthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
			FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));

		else healthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
			FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
		healthBar.updateBar();
	}

	public function addCharacterToList(newCharacter:String, type:Int) {
		switch(type) {
			case 0:
				if(!boyfriendMap.exists(newCharacter)) {
					var newBoyfriend:Boyfriend = new Boyfriend(0, 0, newCharacter);
					boyfriendMap.set(newCharacter, newBoyfriend);
					boyfriendGroup.add(newBoyfriend);
					startCharacterPos(newBoyfriend);
					newBoyfriend.alpha = 0.00001;
					startCharacterLua(newBoyfriend.curCharacter);
				}

			case 1:
				if(!dadMap.exists(newCharacter)) {
					var newDad:Character = new Character(0, 0, newCharacter);
					dadMap.set(newCharacter, newDad);
					dadGroup.add(newDad);
					startCharacterPos(newDad, true);
					newDad.alpha = 0.00001;
					startCharacterLua(newDad.curCharacter);
				}

			case 2:
				if(gf != null && !gfMap.exists(newCharacter)) {
					var newGf:Character = new Character(0, 0, newCharacter);
					newGf.scrollFactor.set(0.95, 0.95);
					gfMap.set(newCharacter, newGf);
					gfGroup.add(newGf);
					startCharacterPos(newGf);
					newGf.alpha = 0.00001;
					startCharacterLua(newGf.curCharacter);
				}
		}
	}

	function startCharacterLua(name:String)
	{
		#if LUA_ALLOWED
		var doPush:Bool = false;
		var luaFile:String = 'characters/' + name + '.lua';
		#if MODS_ALLOWED
		if(FileSystem.exists(Paths.modFolders(luaFile))) {
			luaFile = Paths.modFolders(luaFile);
			doPush = true;
		} else {
			luaFile = Paths.getPreloadPath(luaFile);
			if(FileSystem.exists(luaFile)) {
				doPush = true;
			}
		}
		#else
		luaFile = Paths.getPreloadPath(luaFile);
		if(Assets.exists(luaFile)) {
			doPush = true;
		}
		#end

		if(doPush)
		{
			for (script in luaArray)
			{
				if(script.scriptName == luaFile) return;
			}
			luaArray.push(new FunkinLua(luaFile));
		}
		#end
	}

	public function getLuaObject(tag:String, text:Bool=true):FlxSprite {
		if(modchartSprites.exists(tag)) return modchartSprites.get(tag);
		if(text && modchartTexts.exists(tag)) return modchartTexts.get(tag);
		return null;
	}

	function startCharacterPos(char:Character, ?gfCheck:Bool = false) {
		if(gfCheck && char.curCharacter.startsWith('gf')) { //IF DAD IS GIRLFRIEND, HE GOES TO HER POSITION
			char.setPosition(GF_X, GF_Y);
			char.scrollFactor.set(0.95, 0.95);
			char.danceEveryNumBeats = 2;
		}
		char.x += char.positionArray[0];
		char.y += char.positionArray[1];
	}

	public function startVideo(name:String)
	{
		#if VIDEOS_ALLOWED
		inCutscene = true;

		var filepath:String = Paths.video(name);
		#if sys
		if(!FileSystem.exists(filepath))
		#else
		if(!OpenFlAssets.exists(filepath))
		#end
		{
			FlxG.log.warn('Couldnt find video file: ' + name);
			startAndEnd();
			return;
		}

		var video:MP4Handler = new MP4Handler();
		video.playVideo(filepath);
		video.finishCallback = function()
		{
			startAndEnd();
			return;
		}
		#else
		FlxG.log.warn('Platform not supported!');
		startAndEnd();
		return;
		#end
	}

	function startAndEnd()
	{
		if(endingSong)
			endSong();
		else
			startCountdown();
	}

	var dialogueCount:Int = 0;
	public var psychDialogue:DialogueBoxPsych;
	public function startDialogue(dialogueFile:DialogueFile, ?song:String = null):Void
	{
		if(psychDialogue != null) return;

		if(dialogueFile.dialogue.length > 0) {
			inCutscene = true;
			precacheList.set('dialogue', 'sound');
			precacheList.set('dialogueClose', 'sound');
			psychDialogue = new DialogueBoxPsych(dialogueFile, song);
			psychDialogue.scrollFactor.set();
			if(endingSong) {
				psychDialogue.finishThing = function() {
					psychDialogue = null;
					endSong();
				}
			} else {
				psychDialogue.finishThing = function() {
					psychDialogue = null;
					startCountdown();
				}
			}
			psychDialogue.nextDialogueThing = startNextDialogue;
			psychDialogue.skipDialogueThing = skipDialogue;
			psychDialogue.cameras = [camHUD];
			add(psychDialogue);
		} else {
			FlxG.log.warn('Your dialogue file is badly formatted!');
			if(endingSong) {
				endSong();
			} else {
				startCountdown();
			}
		}
	}

	var startTimer:FlxTimer;
	var finishTimer:FlxTimer = null;

	// For being able to mess with the sprites on Lua
	public var countdownReady:FlxSprite;
	public var countdownSet:FlxSprite;
	public var countdownGo:FlxSprite;
	public static var startOnTime:Float = 0;

	public function startCountdown():Void
	{
		if(startedCountdown) {
			callOnLuas('onStartCountdown', []);
			return;
		}

		inCutscene = false;
		var ret:Dynamic = callOnLuas('onStartCountdown', [], false);
		if(ret != FunkinLua.Function_Stop) {
			if (skipCountdown || startOnTime > 0) skipArrowStartTween = true;

			generateStaticArrows(0);
			generateStaticArrows(1);
			playerLaneUnderlay.x = playerStrums.members[0].x - 25;
			opponentLaneUnderlay.x = opponentStrums.members[0].x - 25;
			for (i in 0...playerStrums.length) {
				setOnLuas('defaultPlayerStrumX' + i, playerStrums.members[i].x);
				setOnLuas('defaultPlayerStrumY' + i, playerStrums.members[i].y);
			}
			for (i in 0...opponentStrums.length) {
				setOnLuas('defaultOpponentStrumX' + i, opponentStrums.members[i].x);
				setOnLuas('defaultOpponentStrumY' + i, opponentStrums.members[i].y);
				//if(ClientPrefs.middleScroll) opponentStrums.members[i].visible = false;
			}

			startedCountdown = true;
			Conductor.songPosition = 0;
			Conductor.songPosition -= Conductor.crochet * 5;
			setOnLuas('startedCountdown', true);
			callOnLuas('onCountdownStarted', []);

			var swagCounter:Int = 0;


			if(startOnTime < 0) startOnTime = 0;

			if (startOnTime > 0) {
				clearNotesBefore(startOnTime);
				setSongTime(startOnTime - 350);
				return;
			}
			else if (skipCountdown)
			{
				setSongTime(0);
				return;
			}

			startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
			{
				if (gf != null && tmr.loopsLeft % Math.round(gfSpeed * gf.danceEveryNumBeats) == 0 && gf.animation.curAnim != null && !gf.animation.curAnim.name.startsWith("sing") && !gf.stunned)
				{
					gf.dance();
				}
				if (tmr.loopsLeft % boyfriend.danceEveryNumBeats == 0 && boyfriend.animation.curAnim != null && !boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.stunned)
				{
					boyfriend.dance();
				}
				if (tmr.loopsLeft % dad.danceEveryNumBeats == 0 && dad.animation.curAnim != null && !dad.animation.curAnim.name.startsWith('sing') && !dad.stunned)
				{
					dad.dance();
				}

				var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
				introAssets.set('default', ['ready', 'set', 'go']);

				var introAlts:Array<String> = introAssets.get('default');
				var antialias:Bool = ClientPrefs.globalAntialiasing;

				switch (swagCounter)
				{
					case 0:
						FlxG.sound.play(Paths.sound('intro3' + introSoundsSuffix), 0.6);
					case 1:
						countdownReady = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
						countdownReady.cameras = [camHUD];
						countdownReady.scrollFactor.set();
						countdownReady.updateHitbox();

						countdownReady.screenCenter();
						countdownReady.antialiasing = antialias;
						insert(members.indexOf(notes), countdownReady);
						FlxTween.tween(countdownReady, {alpha: 0}, Conductor.crochet / 1000, {
							ease: FlxEase.cubeInOut,
							onComplete: function(twn:FlxTween)
							{
								remove(countdownReady);
								countdownReady.destroy();
							}
						});
						if (ClientPrefs.hideAllSprites) switchObjectState(camGame, false);
						if (ClientPrefs.hideOpponent) switchObjectState(dad, false);
						if (ClientPrefs.hideGf) switchObjectState(gf, false);
						if (ClientPrefs.hideBf) switchObjectState(boyfriend, false);
						FlxG.sound.play(Paths.sound('intro2' + introSoundsSuffix), 0.6);
					case 2:
						countdownSet = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
						countdownSet.cameras = [camHUD];
						countdownSet.scrollFactor.set();

						countdownSet.screenCenter();
						countdownSet.antialiasing = antialias;
						insert(members.indexOf(notes), countdownSet);
						FlxTween.tween(countdownSet, {alpha: 0}, Conductor.crochet / 1000, {
							ease: FlxEase.cubeInOut,
							onComplete: function(twn:FlxTween)
							{
								remove(countdownSet);
								countdownSet.destroy();
							}
						});
						FlxG.sound.play(Paths.sound('intro1' + introSoundsSuffix), 0.6);
						if (ClientPrefs.hideAllSprites) {
							gf.cameras = [camChars];
							dad.cameras = [camChars];
							boyfriend.cameras = [camChars];
							switchObjectState(camChars, true);
						}
						if(!paused && ClientPrefs.funnitext) {
							add(textthingies);
							tweentext();
						}
					case 3:
						countdownGo = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
						countdownGo.cameras = [camHUD];
						countdownGo.scrollFactor.set();

						countdownGo.updateHitbox();

						countdownGo.screenCenter();
						countdownGo.antialiasing = antialias;
						insert(members.indexOf(notes), countdownGo);
						FlxTween.tween(countdownGo, {alpha: 0}, Conductor.crochet / 1000, {
							ease: FlxEase.cubeInOut,
							onComplete: function(twn:FlxTween)
							{
								remove(countdownGo);
								countdownGo.destroy();
							}
						});
						FlxG.sound.play(Paths.sound('introGo' + introSoundsSuffix), 0.6);
					case 4:
				}

				notes.forEachAlive(function(note:Note) {
					if(ClientPrefs.opponentStrums || note.mustPress)
					{
						note.copyAlpha = false;
						note.alpha = note.multAlpha;
						if(ClientPrefs.middleScroll && !note.mustPress) {
							note.alpha *= 0.35;
						}
					}
				});
				callOnLuas('onCountdownTick', [swagCounter]);

				swagCounter += 1;
				// generateSong('fresh');
			}, 5);
		}
	}

	public function addBehindGF(obj:FlxObject)
	{
		insert(members.indexOf(gfGroup), obj);
	}
	public function addBehindBF(obj:FlxObject)
	{
		insert(members.indexOf(boyfriendGroup), obj);
	}
	public function addBehindDad (obj:FlxObject)
	{
		insert(members.indexOf(dadGroup), obj);
	}

	public function clearNotesBefore(time:Float)
	{
		var i:Int = unspawnNotes.length - 1;
		while (i >= 0) {
			var daNote:Note = unspawnNotes[i];
			if(daNote.strumTime - 350 < time)
			{
				daNote.active = false;
				daNote.visible = false;
				daNote.ignoreNote = true;

				daNote.kill();
				unspawnNotes.remove(daNote);
				daNote.destroy();
			}
			--i;
		}

		i = notes.length - 1;
		while (i >= 0) {
			var daNote:Note = notes.members[i];
			if(daNote.strumTime - 350 < time)
			{
				daNote.active = false;
				daNote.visible = false;
				daNote.ignoreNote = true;

				daNote.kill();
				notes.remove(daNote, true);
				daNote.destroy();
			}
			--i;
		}
	}

	public function updateScore(miss:Bool = false)
	{
		oldPercentage = Highscore.floorDecimal(health / 0.02, 0);
		var nearestTen:Float = FlxMath.roundDecimal(ratingPercent * 10, 0) * 10; // multiply AFTER rounding
		var accuracyPercentage:Float = Highscore.floorDecimal(ratingPercent * 100, 2);
		var suffix:String = '';
		if (accuracyPercentage > 30 && nearestTen - accuracyPercentage > 0) {
			if (nearestTen - accuracyPercentage < 5) suffix = '+';
			if (accuracyPercentage > 99) suffix = '-';
			else if (nearestTen - accuracyPercentage < 1) suffix = "++";
		}
		var thScoreHealthTxt:String = '';
		var pressMissesTxt:String = '';
		var perfRatingTxt:String = '';
		var unrankedTxt:String = cpuControlled || practiceMode || chartingMode ? ' ![UNRANKED]!' : '';
		if (pressMisses > 0)
			pressMissesTxt = ' (+$pressMisses)';
		perfRatingTxt = ' (${Highscore.floorDecimal(perfRating, 2)})';
		
		scoreText.applyMarkup('Score$unrankedTxt: ${FlxMath.roundDecimal(songScore, 0)}',
			[
				new FlxTextFormatMarkerPair(redFormat, '!'),
				new FlxTextFormatMarkerPair(orangeFormat, '@'),
				new FlxTextFormatMarkerPair(yellowFormat, '#'),
				new FlxTextFormatMarkerPair(greenFormat, '$'),
				new FlxTextFormatMarkerPair(limeFormat, '^'),
				new FlxTextFormatMarkerPair(cyanFormat, '&'),
				new FlxTextFormatMarkerPair(magentaFormat, '_'),
				new FlxTextFormatMarkerPair(blackFormat, '=')
			]);
		missesTxt.applyMarkup('Misses: $songMisses$pressMissesTxt',
			[
				new FlxTextFormatMarkerPair(redFormat, '!'),
				new FlxTextFormatMarkerPair(orangeFormat, '@'),
				new FlxTextFormatMarkerPair(yellowFormat, '#'),
				new FlxTextFormatMarkerPair(greenFormat, '$'),
				new FlxTextFormatMarkerPair(limeFormat, '^'),
				new FlxTextFormatMarkerPair(cyanFormat, '&'),
				new FlxTextFormatMarkerPair(magentaFormat, '_'),
				new FlxTextFormatMarkerPair(blackFormat, '=')
			]);
		ratingTxt.applyMarkup('Rating: $ratingName$suffix$perfRatingTxt$ratingFC',
			[
				new FlxTextFormatMarkerPair(redFormat, '!'),
				new FlxTextFormatMarkerPair(orangeFormat, '@'),
				new FlxTextFormatMarkerPair(yellowFormat, '#'),
				new FlxTextFormatMarkerPair(greenFormat, '$'),
				new FlxTextFormatMarkerPair(limeFormat, '^'),
				new FlxTextFormatMarkerPair(cyanFormat, '&'),
				new FlxTextFormatMarkerPair(magentaFormat, '_'),
				new FlxTextFormatMarkerPair(blackFormat, '=')
			]);
		accuracyTxt.applyMarkup('Accuracy: $accuracyPercentage%$ratingFC',
			[
				new FlxTextFormatMarkerPair(redFormat, '!'),
				new FlxTextFormatMarkerPair(orangeFormat, '@'),
				new FlxTextFormatMarkerPair(yellowFormat, '#'),
				new FlxTextFormatMarkerPair(greenFormat, '$'),
				new FlxTextFormatMarkerPair(limeFormat, '^'),
				new FlxTextFormatMarkerPair(cyanFormat, '&'),
				new FlxTextFormatMarkerPair(magentaFormat, '_'),
				new FlxTextFormatMarkerPair(blackFormat, '=')
			]);

	}

	public function setSongTime(time:Float)
	{
		if(time < 0) time = 0;

		FlxG.sound.music.pause();
		vocals.pause();

		FlxG.sound.music.time = time;
		FlxG.sound.music.play();

		if (Conductor.songPosition <= vocals.length)
		{
			vocals.time = time;
		}
		vocals.play();
		Conductor.songPosition = time;
		songTime = time;
	}

	function startNextDialogue() {
		dialogueCount++;
		callOnLuas('onNextDialogue', [dialogueCount]);
	}

	function skipDialogue() {
		callOnLuas('onSkipDialogue', [dialogueCount]);
	}

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;

	function startSong():Void
	{
		creditsText = new FlxTypedGroup<FlxText>();
		if(!paused && ClientPrefs.juketag) {
			box = new FlxSprite(0, 47.5).loadGraphic(Paths.image("box"));
			box.cameras = [camCREDITS];
			box.setGraphicSize(Std.int(box.height * 0.7));
			box.screenCenter(X);
			box.x -= 1000;
			add(box);

			var texti:String;
			var size:String;
			var upY:String;
			switch (curSong) {
				case 'Astral Snowstorm':
					if (CoolUtil.difficultyString() != 'ERECT') {
						texti = File.getContent((Paths.json("astral-snowstorm/credits"))).split("TIME")[0];
						size = File.getContent((Paths.json("astral-snowstorm/credits"))).split("SIZE")[1];
						upY = File.getContent((Paths.json("astral-snowstorm/credits"))).split("UPY")[2];
					} else {
						texti = File.getContent((Paths.json("astral-snowstorm/creditserect"))).split("TIME")[0];
						size = File.getContent((Paths.json("astral-snowstorm/creditserect"))).split("SIZE")[1];
						upY = File.getContent((Paths.json("astral-snowstorm/crediterect"))).split("UPY")[2];
					}
				case 'Big Shot':
					texti = File.getContent((Paths.json("big-shot/credits"))).split("TIME")[0];
					size = File.getContent((Paths.json("big-shot/credits"))).split("SIZE")[1];
					upY = File.getContent((Paths.json("big-shot/credits"))).split("UPY")[2];
				case 'Breath Catcher':
					texti = File.getContent((Paths.json("breath-catcher/credits"))).split("TIME")[0];
					size = File.getContent((Paths.json("breath-catcher/credits"))).split("SIZE")[1];
					upY = File.getContent((Paths.json("breath-catcher/credits"))).split("UPY")[2];
				case "Can't Break Free":
					texti = File.getContent((Paths.json("can't-break-free/credits"))).split("TIME")[0];
					size = File.getContent((Paths.json("can't-break-free/credits"))).split("SIZE")[1];
					upY = File.getContent((Paths.json("can't-break-free/credits"))).split("UPY")[2];
				case 'Cold Destiny':
					texti = File.getContent((Paths.json("cold-destiny/credits"))).split("TIME")[0];
					size = File.getContent((Paths.json("cold-destiny/credits"))).split("SIZE")[1];
					upY = File.getContent((Paths.json("cold-destiny/credits"))).split("UPY")[2];
				case 'Frozen System':
					texti = File.getContent((Paths.json("frozen-system/credits"))).split("TIME")[0];
					size = File.getContent((Paths.json("frozen-system/credits"))).split("SIZE")[1];
					upY = File.getContent((Paths.json("frozen-system/credits"))).split("UPY")[2];
				case 'Frozen System Alt':
					texti = File.getContent((Paths.json("frozen-system-alt/credits"))).split("TIME")[0];
					size = File.getContent((Paths.json("frozen-system-alt/credits"))).split("SIZE")[1];
					upY = File.getContent((Paths.json("frozen-system-alt/credits"))).split("UPY")[2];
				case 'Ice Cold Killer':
					texti = File.getContent((Paths.json("ice-cold-killer/credits"))).split("TIME")[0];
					size = File.getContent((Paths.json("ice-cold-killer/credits"))).split("SIZE")[1];
					upY = File.getContent((Paths.json("ice-cold-killer/credits"))).split("UPY")[2];
				case 'Let Us In':
					texti = File.getContent((Paths.json("let-us-in/credits"))).split("TIME")[0];
					size = File.getContent((Paths.json("let-us-in/credits"))).split("SIZE")[1];
					upY = File.getContent((Paths.json("let-us-in/credits"))).split("UPY")[2];
				case 'Scatmann 2':
					texti = File.getContent((Paths.json("scatmann-2/credits"))).split("TIME")[0];
					size = File.getContent((Paths.json("scatmann-2/credits"))).split("SIZE")[1];
					upY = File.getContent((Paths.json("scatmann-2/credits"))).split("UPY")[2];
				case 'Sussy Balls':
					texti = File.getContent((Paths.json("sussy-balls/credits"))).split("TIME")[0];
					size = File.getContent((Paths.json("sussy-balls/credits"))).split("SIZE")[1];
					upY = File.getContent((Paths.json("sussy-balls/credits"))).split("UPY")[2];
				case 'Rayed Out':
					//texti = File.getContent((Paths.json("rayed-out/credits"))).split("TIME")[0];
					//size = File.getContent((Paths.json("rayed-out/credits"))).split("SIZE")[1];
					//upY = File.getContent((Paths.json("rayed-out/credits"))).split("UPY")[2];
					texti = "unfinished";
					size = '24';
					upY = '0';
				case 'Top 10 Moments':
					//texti = File.getContent((Paths.json("top-10-moments/credits"))).split("TIME")[0];
					//size = File.getContent((Paths.json("top-10-moments/credits"))).split("SIZE")[1];
					//upY = File.getContent((Paths.json("top-10-moments/credits"))).split("UPY")[2];
					texti = "unfinished";
					size = '24';
					upY = '0';
				default:
					if (FileSystem.exists(Paths.json(curSong.toLowerCase() + "/credits"))) {
						if (CoolUtil.difficultyString() != 'ERECT') {
							texti = File.getContent((Paths.json(curSong.toLowerCase() + "/credits"))).split("TIME")[0];
							size = File.getContent((Paths.json(curSong.toLowerCase() + "/credits"))).split("SIZE")[1];
							upY = File.getContent((Paths.json(curSong.toLowerCase() + "/credits"))).split("UPY")[2];
						} else {
							texti = File.getContent((Paths.json(curSong.toLowerCase() + "/creditserect"))).split("TIME")[0];
							size = File.getContent((Paths.json(curSong.toLowerCase() + "/creditserect"))).split("SIZE")[1];
							upY = File.getContent((Paths.json(curSong.toLowerCase() + "/creditserect"))).split("UPY")[2];
						}
					} else {
						texti = "unfinished";
						size = '24';
						upY = '0';
					}
			}

			creditsTxt = new FlxText(0, 75, 0, texti, 28);
			creditsTxt.cameras = [camCREDITS];
			creditsTxt.setFormat(Paths.font("pixel.otf"), Std.parseInt(size), FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			creditsTxt.setGraphicSize(Std.int(creditsTxt.width * 0.8));
			creditsTxt.updateHitbox();
			creditsTxt.screenCenter(X);
			creditsTxt.x -= 1000;
			creditsTxt.y -= Std.parseInt(upY);
			creditsText.add(creditsTxt);
			add(creditsText);

			var timei:String;

			if (FileSystem.exists(Paths.json(curSong.toLowerCase() + "/credits")))
				timei = File.getContent((Paths.json(curSong.toLowerCase() + "/credits"))).split("TIME")[1];
			else
				timei = "0";

			if (timei != "0")
				new FlxTimer().start(Std.parseFloat(timei), function(tmr:FlxTimer) { tweencredits(); });

		}
		startingSong = false;

		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;
		if (!SONG.isErect)
			FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		else
			FlxG.sound.playMusic(Paths.insterect(PlayState.SONG.song), 1, false);
			
		FlxG.sound.music.onComplete = onSongComplete;
		vocals.play();

		if(startOnTime > 0)
		{
			setSongTime(startOnTime - 500);
		}
		startOnTime = 0;

		if(paused) {
			FlxG.sound.music.pause();
			vocals.pause();
		}

		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;
		FlxTween.tween(timeBar, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
		FlxTween.tween(timeTxt, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

		#if desktop
		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter(), true, songLength);
		#end
		maxScore = 1000000;
		setOnLuas('songLength', songLength);
		callOnLuas('onSongStart', []);
	}

	var debugNum:Int = 0;
	private var noteTypeMap:Map<String, Bool> = new Map<String, Bool>();
	private var eventPushedMap:Map<String, Bool> = new Map<String, Bool>();
	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());
		songSpeedType = ClientPrefs.getGameplaySetting('scrolltype','multiplicative');

		switch(songSpeedType)
		{
			case "multiplicative":
				songSpeed = SONG.speed * ClientPrefs.getGameplaySetting('scrollspeed', 1);
			case "constant":
				songSpeed = ClientPrefs.getGameplaySetting('scrollspeed', 1);
		}
		songSpeedBonus = songSpeed / 2.4;

		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		if (SONG.needsVoices)
			if (!SONG.isErect)
				vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
			else
				vocals = new FlxSound().loadEmbedded(Paths.voiceserect(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		FlxG.sound.list.add(vocals);
		FlxG.sound.list.add(new FlxSound().loadEmbedded(Paths.inst(PlayState.SONG.song)));

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped

		var songName:String = Paths.formatToSongPath(SONG.song);
		var file:String = Paths.json(songName + '/events');
		#if MODS_ALLOWED
		if (FileSystem.exists(Paths.modsJson(songName + '/events')) || FileSystem.exists(file)) {
		#else
		if (OpenFlAssets.exists(file)) {
		#end
			var eventsData:Array<Dynamic> = Song.loadFromJson('events', songName).events;
			for (event in eventsData) //Event Notes
			{
				for (i in 0...event[1].length)
				{
					var newEventNote:Array<Dynamic> = [event[0], event[1][i][0], event[1][i][1], event[1][i][2]];
					var subEvent:EventNote = {
						strumTime: newEventNote[0] + ClientPrefs.noteOffset,
						event: newEventNote[1],
						value1: newEventNote[2],
						value2: newEventNote[3]
					};
					subEvent.strumTime -= eventNoteEarlyTrigger(subEvent);
					eventNotes.push(subEvent);
					eventPushed(subEvent);
				}
			}
		}

		for (section in noteData)
		{
			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0];
				var daNoteData:Int = Std.int(songNotes[1] % 4);

				var gottaHitNote:Bool = section.mustHitSection;

				if (songNotes[1] > 3)
				{
					gottaHitNote = !section.mustHitSection;
				}
				if (opponentPlay) gottaHitNote = !gottaHitNote;

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote);
				swagNote.mustPress = gottaHitNote;
				swagNote.sustainLength = songNotes[2];
				swagNote.gfNote = (section.gfSection && (songNotes[1]<4));
				swagNote.noteType = songNotes[3];
				if(!Std.isOfType(songNotes[3], String)) swagNote.noteType = editors.ChartingState.noteTypeList[songNotes[3]]; //Backward compatibility + compatibility with Week 7 charts

				swagNote.scrollFactor.set();

				var susLength:Float = swagNote.sustainLength;

				susLength = susLength / Conductor.stepCrochet;
				unspawnNotes.push(swagNote);

				var floorSus:Int = Math.floor(susLength);
				if(floorSus > 0) {
					for (susNote in 0...floorSus+1)
					{
						oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

						var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + (Conductor.stepCrochet / FlxMath.roundDecimal(songSpeed, 2)), daNoteData, oldNote, true);
						sustainNote.mustPress = gottaHitNote;
						sustainNote.gfNote = (section.gfSection && (songNotes[1]<4));
						sustainNote.noteType = swagNote.noteType;
						sustainNote.scrollFactor.set();
						swagNote.tail.push(sustainNote);
						sustainNote.parent = swagNote;
						unspawnNotes.push(sustainNote);

						if (sustainNote.mustPress)
						{
							sustainNote.x += FlxG.width / 2; // general offset
						}
						else if(ClientPrefs.middleScroll)
						{
							sustainNote.x += 310;
							if(daNoteData > 1) //Up and Right
							{
								sustainNote.x += FlxG.width / 2 + 25;
							}
						}
					}
				}

				if (swagNote.mustPress)
				{
					if (!swagNote.ignoreNote && !swagNote.isSustainNote) mustHitNoteCount++;
					swagNote.x += FlxG.width / 2; // general offset
				}
				else if(ClientPrefs.middleScroll)
				{
					swagNote.x += 310;
					if(daNoteData > 1) //Up and Right
					{
						swagNote.x += FlxG.width / 2 + 25;
					}
				}

				if(!noteTypeMap.exists(swagNote.noteType)) {
					noteTypeMap.set(swagNote.noteType, true);
				}
			}
			daBeats += 1;
		}
		for (event in songData.events) //Event Notes
		{
			for (i in 0...event[1].length)
			{
				var newEventNote:Array<Dynamic> = [event[0], event[1][i][0], event[1][i][1], event[1][i][2]];
				var subEvent:EventNote = {
					strumTime: newEventNote[0] + ClientPrefs.noteOffset,
					event: newEventNote[1],
					value1: newEventNote[2],
					value2: newEventNote[3]
				};
				subEvent.strumTime -= eventNoteEarlyTrigger(subEvent);
				eventNotes.push(subEvent);
				eventPushed(subEvent);
			}
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);
		if(eventNotes.length > 1) { //No need to sort if there's a single one or none at all
			eventNotes.sort(sortByTime);
		}
		checkEventNote();
		generatedMusic = true;
	}

	function eventPushed(event:EventNote) {
		switch(event.event) {
			case 'Change Character':
				var charType:Int = 0;
				switch(event.value1.toLowerCase()) {
					case 'gf' | 'girlfriend' | '1':
						charType = 2;
					case 'dad' | 'opponent' | '0':
						charType = 1;
					default:
						charType = Std.parseInt(event.value1);
						if(Math.isNaN(charType)) charType = 0;
				}

				var newCharacter:String = event.value2;
				addCharacterToList(newCharacter, charType);
		}

		if(!eventPushedMap.exists(event.event)) {
			eventPushedMap.set(event.event, true);
		}
	}

	function eventNoteEarlyTrigger(event:EventNote):Float {
		var returnedValue:Float = callOnLuas('eventEarlyTrigger', [event.event]);
		if(returnedValue != 0) {
			return returnedValue;
		}
		return 0;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	function sortByTime(Obj1:EventNote, Obj2:EventNote):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	public var skipArrowStartTween:Bool = false; //for lua
	private function generateStaticArrows(player:Int):Void
	{
		for (i in 0...4)
		{
			// FlxG.log.add(i);
			var targetAlpha:Float = 1;
			if (player < 1)
			{
				if(!ClientPrefs.opponentStrums) targetAlpha = 0;
				else if(ClientPrefs.middleScroll) targetAlpha = 0.35;
			}

			var babyArrow:StrumNote = new StrumNote(ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X, strumLine.y, i, player);
			babyArrow.downScroll = ClientPrefs.downScroll;
			if (!isStoryMode && !skipArrowStartTween)
			{
				//babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {/*y: babyArrow.y + 10,*/ alpha: targetAlpha}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}
			else
			{
				babyArrow.alpha = targetAlpha;
			}

			var shouldSwap:Bool = opponentPlay && !ClientPrefs.middleScroll;
			if ((player == 1) != shouldSwap)
			{
				playerStrums.add(babyArrow);
			}
			else
			{
				if(ClientPrefs.middleScroll)
				{
					babyArrow.x += 310;
					if(i > 1) { //Up and Right
						babyArrow.x += FlxG.width / 2 + 25;
					}
				}
				opponentStrums.add(babyArrow);
			}

			strumLineNotes.add(babyArrow);
			babyArrow.postAddedToGroup();
		}
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			if (startTimer != null && !startTimer.finished)
				startTimer.active = false;
			if (finishTimer != null && !finishTimer.finished)
				finishTimer.active = false;
			if (songSpeedTween != null)
				songSpeedTween.active = false;

			var chars:Array<Character> = [boyfriend, gf, dad];
			for (char in chars) {
				if(char != null && char.colorTween != null) {
					char.colorTween.active = false;
				}
			}

			for (tween in modchartTweens) {
				tween.active = false;
			}
			for (timer in modchartTimers) {
				timer.active = false;
			}
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (startTimer != null && !startTimer.finished)
				startTimer.active = true;
			if (finishTimer != null && !finishTimer.finished)
				finishTimer.active = true;
			if (songSpeedTween != null)
				songSpeedTween.active = true;

			var chars:Array<Character> = [boyfriend, gf, dad];
			for (char in chars) {
				if(char != null && char.colorTween != null) {
					char.colorTween.active = true;
				}
			}

			for (tween in modchartTweens) {
				tween.active = true;
			}
			for (timer in modchartTimers) {
				timer.active = true;
			}
			paused = false;
			callOnLuas('onResume', []);

			#if desktop
			if (startTimer != null && startTimer.finished)
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter(), true, songLength - Conductor.songPosition - ClientPrefs.noteOffset);
			}
			else
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
			}
			#end
		}

		super.closeSubState();
	}

	override public function onFocus():Void
	{
		#if desktop
		if (health > 0 && !paused)
		{
			if (Conductor.songPosition > 0.0)
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter(), true, songLength - Conductor.songPosition - ClientPrefs.noteOffset);
			}
			else
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
			}
		}
		#end

		super.onFocus();
	}

	override public function onFocusLost():Void
	{
		#if desktop
		if (health > 0 && !paused)
		{
			DiscordClient.changePresence(detailsPausedText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
		}
		#end

		super.onFocusLost();
	}

	function resyncVocals():Void
	{
		if(finishTimer != null) return;

		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		if (Conductor.songPosition <= vocals.length)
		{
			vocals.time = Conductor.songPosition;
		}
		vocals.play();
	}

	public var paused:Bool = false;
	public var canReset:Bool = true;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;
	var limoSpeed:Float = 0;

	override public function update(elapsed:Float)
	{
		if (CoolUtil.difficultyString() == "ERECT")
			SONG.isErect = true;

		callOnLuas('onUpdate', [elapsed]);

		if(!inCutscene) {
			var lerpVal:Float = CoolUtil.boundTo(elapsed * 2.4 * cameraSpeed, 0, 1);
			camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
			if(!startingSong && !endingSong && boyfriend.animation.curAnim.name.startsWith('idle')) {
				boyfriendIdleTime += elapsed;
				if(boyfriendIdleTime >= 0.15) { // Kind of a mercy thing for making the achievement easier to get as it's apparently frustrating to some playerss
					boyfriendIdled = true;
				}
			} else {
				boyfriendIdleTime = 0;
			}
		}

		super.update(elapsed);

		setOnLuas('curDecStep', curDecStep);
		setOnLuas('curDecBeat', curDecBeat);

		if(botplayTxt.visible) {
			botplaySine += 180 * elapsed;
			botplayTxt.alpha = 1 - Math.sin((Math.PI * botplaySine) / 180);
		}

		if (controls.PAUSE && startedCountdown && canPause)
		{
			var ret:Dynamic = callOnLuas('onPause', [], false);
			if(ret != FunkinLua.Function_Stop) {
				openPauseMenu();
			}
		}

		if (FlxG.keys.anyJustPressed(debugKeysChart) && !endingSong && !inCutscene)
		{
			openChartEditor();
		}

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);
		var toRemove:Float = Math.min(tempMissPenalty, ClientPrefs.tempMissPenaltyDPS * 0.02 * elapsed);
		if (health - toRemove > 0 || ClientPrefs.tempMissPenaltyCanKill) {
			health -= toRemove;
			tempMissPenalty -= toRemove;
		}

		var damage:Float = ClientPrefs.permaMissPenaltyDPS * 0.02 * elapsed * songMisses;
		if ((notes.length > 0 || unspawnNotes.length > 0 || eventNotes.length > 0) && (health - damage > 0 || ClientPrefs.permaMissPenaltyCanKill))
			health -= damage;

		if (health > maxHealth) health = maxHealth;
		healthPercentageDisplay = health / 0.02; // Don't round this for smooth health bar movement
		healthPercentageBar = opponentPlay ? Math.max(0, Math.min(100, 100 - healthPercentageDisplay)) : healthPercentageDisplay;
		updateScore(true);

		if (vignette == null) {
			vignette = new FlxSprite().loadGraphic(Paths.image('vignette'));
			vignette.cameras = [camHUD];
			add(vignette);
		}
		if (hpmechanic || curSong == 'Let Us In')
			vignette.alpha = 0.9 - (health / maxHealth);
		else
			vignette.alpha = ClientPrefs.vignetteStrength - (health / maxHealth);

		iconP1.setGraphicSize(Std.int(150 + 0.85 * (iconP1.width - 150)));
        iconP2.setGraphicSize(Std.int(150 + 0.85 * (iconP2.width - 150)));
		
        if(iconP1.angle < 0)
        	iconP1.angle = CoolUtil.coolLerp(iconP1.angle, 0, Conductor.crochet / 1000 / 4);
        if(iconP2.angle > 0)
        	iconP2.angle = CoolUtil.coolLerp(iconP2.angle, 0, Conductor.crochet / 1000 / 4);

        if(iconP1.angle > 0)
        	iconP1.angle = 0;
        if(iconP2.angle < 0)
            iconP2.angle = 0;

		iconP1.updateHitbox();
		iconP2.updateHitbox();


		var iconOffset:Int = 26;

		var axis:Float = ClientPrefs.healthBarType == 'Horizontal' ? healthBar.x : FlxG.height * 0.11;
		var newP1:Float = axis + ((healthBar.width * (FlxMath.remapToRange(healthPercentageBar, 0, 100, 100, 0) * 0.01)) + (150 * iconP1.scale.x - 150) / 2 - iconOffset);
		var oldP2:Float = axis + ((healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (150 * iconP2.scale.x) / 2 - iconOffset * 2);
		var newP2:Float = axis + ((healthBar.width * (FlxMath.remapToRange(healthPercentageBar, 0, 100, 100, 0) * 0.01)) - (150 * iconP2.scale.x) / 2 - iconOffset * 2);

		if (ClientPrefs.healthBarType == 'Horizontal') {
			iconP1.x = newP1;
			iconP2.x = newP2;
			if (healthPercentageBar > 100 || healthPercentageBar < 0 && !opponentPlay) {
				healthBar.offset.x = oldP2 - newP2;
				healthBarBG.offset.x = oldP2 - newP2;
				healthBorder.offset.x = oldP2 - newP2;
			} else {
				healthBar.offset.x = 0;
				healthBarBG.offset.x = 0;
				healthBorder.offset.x = 0;
			}
		} else {
			iconP1.x = healthBar.x + 210;
			iconP1.y = newP1;
			iconP2.x = healthBar.x + 210;
			iconP2.y = newP2;
			if (healthPercentageBar > 100 || healthPercentageBar < 0 && !opponentPlay) {
				healthBar.offset.y = oldP2 - newP2;
				healthBarBG.offset.y = oldP2 - newP2;
				healthBorder.offset.y = oldP2 - newP2;
			} else {
				healthBar.offset.y = 0;
				healthBarBG.offset.y = 0;
				healthBorder.offset.y = 0;
			}
		}
		/*if (health > 2)
			health = 2;*/

		if (healthPercentageBar < 20)
			iconP1.animation.curAnim.curFrame = 1;
		else
			iconP1.animation.curAnim.curFrame = 0;

		if (healthPercentageBar > 80)
			iconP2.animation.curAnim.curFrame = 1;
		else
			iconP2.animation.curAnim.curFrame = 0;

		if (FlxG.keys.anyJustPressed(debugKeysCharacter) && !endingSong && !inCutscene) {
			persistentUpdate = false;
			paused = true;
			cancelMusicFadeTween();
			MusicBeatState.switchState(new CharacterEditorState(SONG.player2));
		}

		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}
		else
		{
			Conductor.songPosition += FlxG.elapsed * 1000;

			if (!paused)
			{
				songTime += FlxG.game.ticks - previousFrameTime;
				previousFrameTime = FlxG.game.ticks;

				// Interpolation type beat
				if (Conductor.lastSongPos != Conductor.songPosition)
				{
					songTime = (songTime + Conductor.songPosition) / 2;
					Conductor.lastSongPos = Conductor.songPosition;
					// Conductor.songPosition += FlxG.elapsed * 1000;
					// trace('MISSED FRAME');
				}

				if(updateTime) {
					var curTime:Float = Conductor.songPosition - ClientPrefs.noteOffset;
					if(curTime < 0) curTime = 0;
					songPercent = (curTime / songLength);

					var songCalc:Float = (songLength - curTime);
					if(ClientPrefs.timeBarType == 'Time Elapsed') songCalc = curTime;

					var secondsTotal:Int = Math.floor(songCalc / 1000);
					if(secondsTotal < 0) secondsTotal = 0;

					if(ClientPrefs.timeBarType != 'Song Name')
						timeTxt.text = FlxStringUtil.formatTime(secondsTotal, false);
				}
			}

			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125 * camZoomingDecay), 0, 1));
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125 * camZoomingDecay), 0, 1));
		}

		FlxG.watch.addQuick("secShit", curSection);
		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

		// RESET = Quick Game Over Screen
		if (!ClientPrefs.noReset && controls.RESET && canReset && !inCutscene && startedCountdown && !endingSong)
		{
			health = 0;
			trace("RESET = True");
		}
		doDeathCheck();

		if (unspawnNotes[0] != null)
		{
			var time:Float = spawnTime;
			if(songSpeed < 1) time /= songSpeed;
			if(unspawnNotes[0].multSpeed < 1) time /= unspawnNotes[0].multSpeed;

			while (unspawnNotes.length > 0 && unspawnNotes[0].strumTime - Conductor.songPosition < time)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.insert(0, dunceNote);
				dunceNote.spawned=true;
				callOnLuas('onSpawnNote', [notes.members.indexOf(dunceNote), dunceNote.noteData, dunceNote.noteType, dunceNote.isSustainNote]);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (generatedMusic)
		{
			if (!inCutscene) {
				if(!cpuControlled) {
					keyShit();
				} else if(boyfriend.holdTimer > Conductor.stepCrochet * 0.0011 * boyfriend.singDuration && boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss')) {
					boyfriend.dance();
					//boyfriend.animation.curAnim.finish();
				}
			}

			var fakeCrochet:Float = (60 / SONG.bpm) * 1000;
			notes.forEachAlive(function(daNote:Note)
			{
				var strumGroup:FlxTypedGroup<StrumNote> = playerStrums;
				if(!daNote.mustPress) strumGroup = opponentStrums;

				var strumX:Float = strumGroup.members[daNote.noteData].x;
				var strumY:Float = strumGroup.members[daNote.noteData].y;
				var strumAngle:Float = strumGroup.members[daNote.noteData].angle;
				var strumDirection:Float = strumGroup.members[daNote.noteData].direction;
				var strumAlpha:Float = strumGroup.members[daNote.noteData].alpha;
				var strumScroll:Bool = strumGroup.members[daNote.noteData].downScroll;

				strumX += daNote.offsetX;
				strumY += daNote.offsetY;
				strumAngle += daNote.offsetAngle;
				strumAlpha *= daNote.multAlpha;

				if (strumScroll) //Downscroll
				{
					//daNote.y = (strumY + 0.45 * (Conductor.songPosition - daNote.strumTime) * songSpeed);
					daNote.distance = (0.45 * (Conductor.songPosition - daNote.strumTime) * songSpeed * daNote.multSpeed);
				}
				else //Upscroll
				{
					//daNote.y = (strumY - 0.45 * (Conductor.songPosition - daNote.strumTime) * songSpeed);
					daNote.distance = (-0.45 * (Conductor.songPosition - daNote.strumTime) * songSpeed * daNote.multSpeed);
				}

				var angleDir = strumDirection * Math.PI / 180;
				if (daNote.copyAngle)
					daNote.angle = strumDirection - 90 + strumAngle;

				if(daNote.copyAlpha)
					daNote.alpha = strumAlpha;

				if(daNote.copyX)
					daNote.x = strumX + Math.cos(angleDir) * daNote.distance;

				if(daNote.copyY)
				{
					daNote.y = strumY + Math.sin(angleDir) * daNote.distance;

					//Jesus fuck this took me so much mother fucking time AAAAAAAAAA
					if(strumScroll && daNote.isSustainNote)
					{
						if (daNote.animation.curAnim.name.endsWith('end')) {
							daNote.y += 10.5 * (fakeCrochet / 400) * 1.5 * songSpeed + (46 * (songSpeed - 1));
							daNote.y -= 46 * (1 - (fakeCrochet / 600)) * songSpeed;
							daNote.y -= 19;
						}
						daNote.y += (Note.swagWidth / 2) - (60.5 * (songSpeed - 1));
						daNote.y += 27.5 * ((SONG.bpm / 100) - 1) * (songSpeed - 1);
					}
				}

				if (!daNote.mustPress && daNote.wasGoodHit && !daNote.hitByOpponent && !daNote.ignoreNote)
				{
					opponentNoteHit(daNote);
				}

				if(daNote.mustPress && cpuControlled) {
					if(daNote.isSustainNote) {
						if(daNote.canBeHit) {
							goodNoteHit(daNote);
						}
					} else if(daNote.strumTime <= Conductor.songPosition || (daNote.isSustainNote && daNote.canBeHit && daNote.mustPress)) {
						goodNoteHit(daNote);
					}
				}

				var center:Float = strumY + Note.swagWidth / 2;
				if(strumGroup.members[daNote.noteData].sustainReduce && daNote.isSustainNote && (daNote.mustPress || !daNote.ignoreNote) &&
					(!daNote.mustPress || (daNote.wasGoodHit || (daNote.prevNote.wasGoodHit && !daNote.canBeHit))))
				{
					if (strumScroll)
					{
						if(daNote.y - daNote.offset.y * daNote.scale.y + daNote.height >= center)
						{
							var swagRect = new FlxRect(0, 0, daNote.frameWidth, daNote.frameHeight);
							swagRect.height = (center - daNote.y) / daNote.scale.y;
							swagRect.y = daNote.frameHeight - swagRect.height;

							daNote.clipRect = swagRect;
						}
					}
					else
					{
						if (daNote.y + daNote.offset.y * daNote.scale.y <= center)
						{
							var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
							swagRect.y = (center - daNote.y) / daNote.scale.y;
							swagRect.height -= swagRect.y;

							daNote.clipRect = swagRect;
						}
					}
				}

				// Kill extremely late notes and cause misses
				if (Conductor.songPosition > noteKillOffset + daNote.strumTime)
				{
					if (daNote.mustPress && !cpuControlled &&!daNote.ignoreNote && !endingSong && (daNote.tooLate || !daNote.wasGoodHit)) {
						noteMiss(daNote);
					}

					daNote.active = false;
					daNote.visible = false;

					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}
			});
		}
		checkEventNote();

		#if debug
		if(!endingSong && !startingSong) {
			if (FlxG.keys.justPressed.ONE) {
				KillNotes();
				FlxG.sound.music.onComplete();
			}
			if(FlxG.keys.justPressed.TWO) { //Go 10 seconds into the future :O
				setSongTime(Conductor.songPosition + 10000);
				clearNotesBefore(Conductor.songPosition);
			}
		}
		#end

		setOnLuas('cameraX', camFollowPos.x);
		setOnLuas('cameraY', camFollowPos.y);
		setOnLuas('botPlay', cpuControlled);
		callOnLuas('onUpdatePost', [elapsed]);
	}

	function openPauseMenu()
	{
		persistentUpdate = false;
		persistentDraw = true;
		paused = true;

		if(FlxG.sound.music != null) {
			FlxG.sound.music.pause();
			vocals.pause();
		}
		openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));

		#if desktop
		DiscordClient.changePresence(detailsPausedText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
		#end
	}

	function openChartEditor()
	{
		persistentUpdate = false;
		paused = true;
		cancelMusicFadeTween();
		MusicBeatState.switchState(new ChartingState());
		chartingMode = true;

		#if desktop
		DiscordClient.changePresence("Chart Editor", null, null, true);
		#end
	}

	public var isDead:Bool = false; //Don't mess with this on Lua!!!
	function doDeathCheck(?skipHealthCheck:Bool = false) {
		if (((skipHealthCheck && instakillOnMiss) || health <= 0) && !practiceMode && !isDead)
		{
			var ret:Dynamic = callOnLuas('onGameOver', [], false);
			if(ret != FunkinLua.Function_Stop) {
				hpmechanic = false;
				boyfriend.stunned = true;
				deathCounter++;

				paused = true;

				vocals.stop();
				FlxG.sound.music.stop();

				persistentUpdate = false;
				persistentDraw = false;
				for (tween in modchartTweens) {
					tween.active = true;
				}
				for (timer in modchartTimers) {
					timer.active = true;
				}
				openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x - boyfriend.positionArray[0], boyfriend.getScreenPosition().y - boyfriend.positionArray[1], camFollowPos.x, camFollowPos.y));

				#if desktop
				// Game Over doesn't get his own variable because it's only used here
				DiscordClient.changePresence("Game Over - " + detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
				#end
				isDead = true;
				return true;
			}
		}
		return false;
	}

	public function checkEventNote() {
		while(eventNotes.length > 0) {
			var leStrumTime:Float = eventNotes[0].strumTime;
			if(Conductor.songPosition < leStrumTime) {
				break;
			}

			var value1:String = '';
			if(eventNotes[0].value1 != null)
				value1 = eventNotes[0].value1;

			var value2:String = '';
			if(eventNotes[0].value2 != null)
				value2 = eventNotes[0].value2;

			triggerEventNote(eventNotes[0].event, value1, value2);
			eventNotes.shift();
		}
	}

	public function getControl(key:String) {
		var pressed:Bool = Reflect.getProperty(controls, key);
		//trace('Control result: ' + pressed);
		return pressed;
	}

	public function triggerEventNote(eventName:String, value1:String, value2:String) {
		switch(eventName) {
			case 'Hey!':
				var value:Int = 2;
				switch(value1.toLowerCase().trim()) {
					case 'bf' | 'boyfriend' | '0':
						value = 0;
					case 'gf' | 'girlfriend' | '1':
						value = 1;
				}

				var time:Float = Std.parseFloat(value2);
				if(Math.isNaN(time) || time <= 0) time = 0.6;

				if(value != 0) {
					if(dad.curCharacter.startsWith('gf')) { //Tutorial GF is actually Dad! The GF is an imposter!! ding ding ding ding ding ding ding, dindinding, end my suffering
						dad.playAnim('cheer', true);
						dad.specialAnim = true;
						dad.heyTimer = time;
					} else if (gf != null) {
						gf.playAnim('cheer', true);
						gf.specialAnim = true;
						gf.heyTimer = time;
					}
				}
				if(value != 1) {
					boyfriend.playAnim('hey', true);
					boyfriend.specialAnim = true;
					boyfriend.heyTimer = time;
				}

			case 'Set GF Speed':
				var value:Int = Std.parseInt(value1);
				if(Math.isNaN(value) || value < 1) value = 1;
				gfSpeed = value;

			case 'Add Camera Zoom':
				if(ClientPrefs.camZooms && FlxG.camera.zoom < 1.35) {
					var camZoom:Float = Std.parseFloat(value1);
					var hudZoom:Float = Std.parseFloat(value2);
					if(Math.isNaN(camZoom)) camZoom = 0.015;
					if(Math.isNaN(hudZoom)) hudZoom = 0.03;

					FlxG.camera.zoom += camZoom;
					camHUD.zoom += hudZoom;
				}

			case 'Play Animation':
				//trace('Anim to play: ' + value1);
				var char:Character = dad;
				switch(value2.toLowerCase().trim()) {
					case 'bf' | 'boyfriend':
						char = boyfriend;
					case 'gf' | 'girlfriend':
						char = gf;
					default:
						var val2:Int = Std.parseInt(value2);
						if(Math.isNaN(val2)) val2 = 0;

						switch(val2) {
							case 1: char = boyfriend;
							case 2: char = gf;
						}
				}

				if (char != null)
				{
					char.playAnim(value1, true);
					char.specialAnim = true;
				}

			case 'Camera Follow Pos':
				var val1:Float = Std.parseFloat(value1);
				var val2:Float = Std.parseFloat(value2);
				if(Math.isNaN(val1)) val1 = 0;
				if(Math.isNaN(val2)) val2 = 0;

				isCameraOnForcedPos = false;
				if(!Math.isNaN(Std.parseFloat(value1)) || !Math.isNaN(Std.parseFloat(value2))) {
					camFollow.x = val1;
					camFollow.y = val2;
					isCameraOnForcedPos = true;
				}

			case 'Alt Idle Animation':
				var char:Character = dad;
				switch(value1.toLowerCase()) {
					case 'gf' | 'girlfriend':
						char = gf;
					case 'boyfriend' | 'bf':
						char = boyfriend;
					default:
						var val:Int = Std.parseInt(value1);
						if(Math.isNaN(val)) val = 0;

						switch(val) {
							case 1: char = boyfriend;
							case 2: char = gf;
						}
				}

				if (char != null)
				{
					char.idleSuffix = value2;
					char.recalculateDanceIdle();
				}

			case 'Screen Shake':
				var valuesArray:Array<String> = [value1, value2];
				var targetsArray:Array<FlxCamera> = [camGame, camHUD, camChars];
				for (i in 0...targetsArray.length) {
					var split:Array<String> = valuesArray[i].split(',');
					var duration:Float = 0;
					var intensity:Float = 0;
					if(split[0] != null) duration = Std.parseFloat(split[0].trim());
					if(split[1] != null) intensity = Std.parseFloat(split[1].trim());
					if(Math.isNaN(duration)) duration = 0;
					if(Math.isNaN(intensity)) intensity = 0;

					if(duration > 0 && intensity != 0) {
						targetsArray[i].shake(intensity, duration);
					}
				}


			case 'Change Character':
				var charType:Int = 0;
				switch(value1) {
					case 'gf' | 'girlfriend':
						charType = 2;
					case 'dad' | 'opponent':
						charType = 1;
					default:
						charType = Std.parseInt(value1);
						if(Math.isNaN(charType)) charType = 0;
				}

				switch(charType) {
					case 0:
						if(boyfriend.curCharacter != value2) {
							if(!boyfriendMap.exists(value2)) {
								addCharacterToList(value2, charType);
							}

							var lastAlpha:Float = boyfriend.alpha;
							boyfriend.alpha = 0.00001;
							boyfriend = boyfriendMap.get(value2);
							boyfriend.alpha = lastAlpha;
							iconP1.changeIcon(boyfriend.healthIcon);
						}
						setOnLuas('boyfriendName', boyfriend.curCharacter);

					case 1:
						if(dad.curCharacter != value2) {
							if(!dadMap.exists(value2)) {
								addCharacterToList(value2, charType);
							}

							var wasGf:Bool = dad.curCharacter.startsWith('gf');
							var lastAlpha:Float = dad.alpha;
							dad.alpha = 0.00001;
							dad = dadMap.get(value2);
							if(!dad.curCharacter.startsWith('gf')) {
								if(wasGf && gf != null) {
									gf.visible = true;
								}
							} else if(gf != null) {
								gf.visible = false;
							}
							dad.alpha = lastAlpha;
							iconP2.changeIcon(dad.healthIcon);
						}
						setOnLuas('dadName', dad.curCharacter);

					case 2:
						if(gf != null)
						{
							if(gf.curCharacter != value2)
							{
								if(!gfMap.exists(value2))
								{
									addCharacterToList(value2, charType);
								}

								var lastAlpha:Float = gf.alpha;
								gf.alpha = 0.00001;
								gf = gfMap.get(value2);
								gf.alpha = lastAlpha;
							}
							setOnLuas('gfName', gf.curCharacter);
						}
				}
				reloadHealthBarColors();

			case 'Change Scroll Speed':
				if (songSpeedType == "constant")
					return;
				var val1:Float = Std.parseFloat(value1);
				var val2:Float = Std.parseFloat(value2);
				if(Math.isNaN(val1)) val1 = 1;
				if(Math.isNaN(val2)) val2 = 0;

				var newValue:Float = SONG.speed * ClientPrefs.getGameplaySetting('scrollspeed', 1) * val1;

				songSpeedBonus = (songSpeed + newValue) / 2;
				if(val2 <= 0)
				{
					songSpeed = newValue;
				}
				else
				{
					songSpeedTween = FlxTween.tween(this, {songSpeed: newValue}, val2, {ease: FlxEase.linear, onComplete:
						function (twn:FlxTween)
						{
							songSpeedTween = null;
						}
					});
				}

			case 'Set Property':
				var killMe:Array<String> = value1.split('.');
				if(killMe.length > 1) {
					FunkinLua.setVarInArray(FunkinLua.getPropertyLoopThingWhatever(killMe, true, true), killMe[killMe.length-1], value2);
				} else {
					FunkinLua.setVarInArray(this, value1, value2);
				}
			case 'Lyrics':
				var split = value1.split("--");
				var text = value1;
				var color = FlxColor.WHITE;
				if(split.length > 1){
					text = split[0];
					color = FlxColor.fromString(split[1]);
				}
				var duration:Float = Std.parseFloat(value2);
				if (Math.isNaN(duration) || duration <= 0)
					duration = text.length * 0.5;

				writeLyrics(text, duration, color);
		}
		callOnLuas('onEvent', [eventName, value1, value2]);
	}

	function moveCameraSection():Void {
		if(SONG.notes[curSection] == null) return;

		if (gf != null && SONG.notes[curSection].gfSection)
		{
			camFollow.set(gf.getMidpoint().x, gf.getMidpoint().y);
			camFollow.x += gf.cameraPosition[0] + girlfriendCameraOffset[0];
			camFollow.y += gf.cameraPosition[1] + girlfriendCameraOffset[1];
			tweenCamIn();
			callOnLuas('onMoveCamera', ['gf']);
			return;
		}

		if (!SONG.notes[curSection].mustHitSection)
		{
			moveCamera(true);
			callOnLuas('onMoveCamera', ['dad']);
		}
		else
		{
			moveCamera(false);
			callOnLuas('onMoveCamera', ['boyfriend']);
		}
	}

	var cameraTwn:FlxTween;
	public function moveCamera(isDad:Bool, ?direction:String = "")
	{
		var addX:Float = 0;
		var addY:Float = 0;
		if (direction.endsWith("UP")) addY -= ClientPrefs.cameraMoveIntensity;
		if (direction.endsWith("DOWN")) addY += ClientPrefs.cameraMoveIntensity;
		if (direction.endsWith("LEFT")) addX -= ClientPrefs.cameraMoveIntensity;
		if (direction.endsWith("RIGHT")) addX += ClientPrefs.cameraMoveIntensity;
		if(isDad)
		{
			if (ClientPrefs.hideOpponent) return;
			camFollow.set(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
			camFollow.x += dad.cameraPosition[0] + opponentCameraOffset[0] + addX;
			camFollow.y += dad.cameraPosition[1] + opponentCameraOffset[1] + addY;
			tweenCamIn();
		}
		else
		{
			if (ClientPrefs.hideBf) return;
			camFollow.set(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);
			camFollow.x -= boyfriend.cameraPosition[0] - boyfriendCameraOffset[0] - addX;
			camFollow.y += boyfriend.cameraPosition[1] + boyfriendCameraOffset[1] + addY;

			if (Paths.formatToSongPath(SONG.song) == 'tutorial' && cameraTwn == null && FlxG.camera.zoom != 1)
			{
				cameraTwn = FlxTween.tween(FlxG.camera, {zoom: 1}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut, onComplete:
					function (twn:FlxTween)
					{
						cameraTwn = null;
					}
				});
			}
		}
	}

	var lyricText:FlxText;
	var lyricTween:FlxTween;
	function writeLyrics(text:String, duration:Float, color:FlxColor) {
		if(lyricText!=null) {
			var old:FlxText = cast lyricText;
			FlxTween.tween(old, {alpha: 0}, 0.2, {onComplete: function(twn:FlxTween)
			{
				remove(old);
				old.destroy();
			}});
			lyricText=null;
		}

		if(lyricTween!=null) {
			lyricTween.cancel();
			lyricTween = null;
		}

		if(text.trim()!='' && duration > 0 && color.alphaFloat > 0){
			lyricText = new FlxText(0, 0, FlxG.width, text);
			lyricText.setFormat(Paths.font("PressStart2P.ttf"), 24, color, CENTER, OUTLINE, FlxColor.BLACK);
			lyricText.alpha = 0;
			lyricText.screenCenter(XY);
			lyricText.y += 250;
			lyricText.cameras = [camOther];
			add(lyricText);

			lyricTween = FlxTween.tween(lyricText, {alpha: color.alphaFloat}, 0.2, {onComplete: function(twn:FlxTween) {
				lyricTween = FlxTween.tween(lyricText, {alpha: 0}, 0.2, {startDelay: duration, onComplete: function(twn:FlxTween) {
					remove(lyricText);
					lyricText.destroy();
					lyricText = null;
					if(lyricTween == twn) lyricTween = null;
				}});
			}});
		}
	}

	function tweentext() {
		FlxTween.tween(textthingies, {y: 400}, 0.5, {ease: FlxEase.elasticOut});
		//tween away
		new FlxTimer().start(3, function(tmr:FlxTimer)
		{
			FlxTween.tween(textthingies, {y: 1000}, 1, {ease: FlxEase.circIn});
			//removal
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				remove(textthingies);
			});
		});
	}

	function tweencredits() {
		FlxTween.tween(creditsTxt, {x: 25}, 0.5, {ease: FlxEase.circOut});
		FlxTween.tween(box, {x: 0}, 0.5, {ease: FlxEase.circOut});
		//tween away
		new FlxTimer().start(3, function(tmr:FlxTimer)
			{
				FlxTween.tween(creditsTxt, {x: -1000}, 0.5, {ease: FlxEase.circOut});
				FlxTween.tween(box, {x: -1000}, 0.5, {ease: FlxEase.circOut});
				//removal
				new FlxTimer().start(0.5, function(tmr:FlxTimer)
					{
						remove(creditsText);
						remove(box);
					});
			});
	}

	function tweenCamIn() {
		if (Paths.formatToSongPath(SONG.song) == 'tutorial' && cameraTwn == null && FlxG.camera.zoom != 1.3) {
			cameraTwn = FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut, onComplete:
				function (twn:FlxTween) {
					cameraTwn = null;
				}
			});
		}
	}

	function snapCamFollowToPos(x:Float, y:Float) {
		camFollow.set(x, y);
		camFollowPos.setPosition(x, y);
	}

	//Any way to do this without using a different function? kinda dumb
	private function onSongComplete()
	{
		finishSong(false);
	}
	public function finishSong(?ignoreNoteOffset:Bool = false):Void
	{
		var finishCallback:Void->Void = endSong; //In case you want to change it in a specific song.

		updateTime = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		vocals.pause();
		if(ClientPrefs.noteOffset <= 0 || ignoreNoteOffset) {
			finishCallback();
		} else {
			finishTimer = new FlxTimer().start(ClientPrefs.noteOffset / 1000, function(tmr:FlxTimer) {
				finishCallback();
			});
		}
	}


	public var transitioning = false;
	public function endSong():Void
	{
		//Should kill you if you tried to cheat
		if(!startingSong) {
			notes.forEach(function(daNote:Note) {
				if(daNote.strumTime < songLength - Conductor.safeZoneOffset) {
					health -= 0.05 * healthLoss;
				}
			});
			for (daNote in unspawnNotes) {
				if(daNote.strumTime < songLength - Conductor.safeZoneOffset) {
					health -= 0.05 * healthLoss;
				}
			}

			if(doDeathCheck()) {
				return;
			}
		}

		timeBarBG.visible = false;
		timeBar.visible = false;
		timeTxt.visible = false;
		canPause = false;
		endingSong = true;
		camZooming = false;
		inCutscene = false;
		updateTime = false;

		deathCounter = 0;
		seenCutscene = false;

		#if ACHIEVEMENTS_ALLOWED
		if(achievementObj != null) {
			return;
		} else {
			var achieve:String = checkForAchievement(['getting_started', 'dehydrated', 'fell_off', 'the_one_singing', 'astral_snowstorm_nomiss', 'icy_encounter', 'alleyway', 'familiar_hero', 'sussy', 'bad_aim', 'skill_issue', 'rising_star']);

			if(achieve != null) {
				startAchievement(achieve);
				return;
			}
		}
		#end

		var ret:Dynamic = callOnLuas('onEndSong', [], false);
		if(ret != FunkinLua.Function_Stop && !transitioning) {
			var songScore:Int = 0;
			var percent:Float = 0;
			for (rating in ratingsData) {
				var counter:Int = Reflect.field(this, rating.counter);
				songScore += rating.score * counter;
				percent += rating.ratingMod * counter;
			}
			if (SONG.validScore && !ClientPrefs.getGameplaySetting('practice', false) && !ClientPrefs.getGameplaySetting('botplay', false))
			{
				#if !switch
				percent /= totalPlayed;
				if(Math.isNaN(percent)) percent = 0;
				Highscore.saveScore(SONG.song, songScore, storyDifficulty, percent);
				#end
			}

			FlxG.camera.bgColor = 0xFF000000;

			if (chartingMode)
			{
				openChartEditor();
				return;
			}

			if (isStoryMode)
			{
				campaignScore += songScore;
				campaignMisses += songMisses;

				storyPlaylist.remove(storyPlaylist[0]);

				if (storyPlaylist.length <= 0)
				{
					WeekData.loadTheFirstEnabledMod();
					FlxG.sound.playMusic(Paths.music('freakyMenu'));

					cancelMusicFadeTween();
					if(FlxTransitionableState.skipNextTransIn) {
						CustomFadeTransition.nextCamera = null;
					}
					MusicBeatState.switchState(new StoryMenuState());

					// if ()
					if(!ClientPrefs.getGameplaySetting('practice', false) && !ClientPrefs.getGameplaySetting('botplay', false)) {
						StoryMenuState.weekCompleted.set(WeekData.weeksList[storyWeek], true);

						if (SONG.validScore)
						{
							Highscore.saveWeekScore(WeekData.getWeekFileName(), campaignScore, storyDifficulty);
						}

						FlxG.save.data.weekCompleted = StoryMenuState.weekCompleted;
						FlxG.save.flush();
					}
					changedDifficulty = false;
				}
				else
				{
					var difficulty:String = CoolUtil.getDifficultyFilePath();

					trace('LOADING NEXT SONG');
					trace(Paths.formatToSongPath(PlayState.storyPlaylist[0]) + difficulty);

					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;

					prevCamFollow = camFollow;
					prevCamFollowPos = camFollowPos;

					PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0] + difficulty, PlayState.storyPlaylist[0]);
					FlxG.sound.music.stop();

					cancelMusicFadeTween();
					LoadingState.loadAndSwitchState(new PlayState());
				}
			}
			else if (isCodes)
			{
				WeekData.loadTheFirstEnabledMod();
				cancelMusicFadeTween();
				if(FlxTransitionableState.skipNextTransIn) {
					CustomFadeTransition.nextCamera = null;
				}
				MusicBeatState.switchState(new SoundTestMenuState());
				changedDifficulty = false;
			}
			else
			{
				trace('WENT BACK TO FREEPLAY??');
				WeekData.loadTheFirstEnabledMod();
				cancelMusicFadeTween();
				if(FlxTransitionableState.skipNextTransIn) {
					CustomFadeTransition.nextCamera = null;
				}
				MusicBeatState.switchState(new FreeplayState());
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
				changedDifficulty = false;
			}
			transitioning = true;
		}
	}

	#if ACHIEVEMENTS_ALLOWED
	var achievementObj:AchievementObject = null;
	function startAchievement(achieve:String) {
		achievementObj = new AchievementObject(achieve, camOther);
		achievementObj.onFinish = achievementEnd;
		add(achievementObj);
		trace('Giving achievement ' + achieve);
	}
	function achievementEnd():Void
	{
		achievementObj = null;
		if(endingSong && !inCutscene) {
			endSong();
		}
	}
	#end

	public function KillNotes() {
		while(notes.length > 0) {
			var daNote:Note = notes.members[0];
			daNote.active = false;
			daNote.visible = false;

			daNote.kill();
			notes.remove(daNote, true);
			daNote.destroy();
		}
		unspawnNotes = [];
		eventNotes = [];
	}

	public var totalPlayed:Int = 0;
	public var totalNotesHit:Float = 0.0;
	public var bonus:Int = 100;
	private var bonusSqrtArray:Array<Float> = [];

	public var showCombo:Bool = false;
	public var showComboNum:Bool = true;
	public var showRating:Bool = true;

	private function popUpScore(note:Note = null):Void
	{
		var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition + ClientPrefs.ratingOffset);

		vocals.volume = 1;

		var placement:String = Std.string(combo);

		var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
		coolText.screenCenter();
		coolText.x = FlxG.width * 0.35;

		var rating:FlxSprite = new FlxSprite();
		var score:Float = 350;

		//tryna do MS based judgment due to popular demand
		var daRating:Rating = Conductor.judgeNote(note, noteDiff);
		var ratingNum:Int = 0;

		totalNotesHit += daRating.ratingMod;
		note.ratingMod = daRating.ratingMod;
		if(!note.ratingDisabled) daRating.increase();
		note.rating = daRating.name;
		score = daRating.score; // YOU BROKE IT AGAIN (PR #9424)
		if (ClientPrefs.scoreSystem == 'Vanilla') thScore += ratingsData[0].score;

		if(daRating.noteSplash && !note.noteSplashDisabled)
		{
			spawnNoteSplashOnNote(note);
		}

		if(/*!practiceMode && */!cpuControlled) {
			if (ClientPrefs.scoreSystem == 'osu!mania') {
				bonus += daRating.hitBonus - daRating.hitPunishment;
				if (bonus < 0) bonus = 0;
				if (bonus > 100) bonus = 100;

				var firstMultiplier = maxScore * (practiceMode ? 0.5 : 1) * 0.5 / mustHitNoteCount;
 
				var baseScore:Float = firstMultiplier * (daRating.hitValue / 320);
				var bonusScore:Float = firstMultiplier * (daRating.hitBonusValue * bonusSqrtArray[bonus] / 320);

				score = baseScore + bonusScore;
				thScore += firstMultiplier * 2;
			}
			songScore += score;
			if(!note.ratingDisabled)
			{
				songHits++;
				totalPlayed++;
				RecalculateRating(false);
			}
		}

		rating.loadGraphic(Paths.image(daRating.image));
		rating.cameras = [ClientPrefs.fixedComboSprPos ? camHUD : (ClientPrefs.hideAllSprites ? camChars : camGame)];
		rating.screenCenter();
		rating.x = coolText.x - 40;
		rating.y -= 60;
		rating.acceleration.y = 550;
		rating.velocity.y -= FlxG.random.int(140, 175);
		rating.velocity.x -= FlxG.random.int(0, 10);
		rating.visible = (!ClientPrefs.hideHud && showRating);
		if (ClientPrefs.fixedComboSprPos) {
		rating.x += ClientPrefs.comboOffset[0];
		rating.y -= ClientPrefs.comboOffset[1];
		}

		var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('combo'));
		comboSpr.cameras = [ClientPrefs.fixedComboSprPos ? camHUD : (ClientPrefs.hideAllSprites ? camChars : camGame)];
		comboSpr.screenCenter();
		comboSpr.x = coolText.x;
		comboSpr.acceleration.y = FlxG.random.int(200, 300);
		comboSpr.velocity.y -= FlxG.random.int(140, 160);
		comboSpr.visible = (!ClientPrefs.hideHud && showCombo);
		if (ClientPrefs.fixedComboSprPos) {
		comboSpr.x += ClientPrefs.comboOffset[0];
		comboSpr.y -= ClientPrefs.comboOffset[1];
		}
		comboSpr.y += 60;
		comboSpr.velocity.x += FlxG.random.int(1, 10);

		insert(members.indexOf(strumLineNotes), rating);

		rating.setGraphicSize(Std.int(rating.width * 0.7));
		rating.antialiasing = ClientPrefs.globalAntialiasing;
		comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
		comboSpr.antialiasing = ClientPrefs.globalAntialiasing;	
			comboSpr.antialiasing = ClientPrefs.globalAntialiasing;
		comboSpr.antialiasing = ClientPrefs.globalAntialiasing;	
			comboSpr.antialiasing = ClientPrefs.globalAntialiasing;
		comboSpr.antialiasing = ClientPrefs.globalAntialiasing;	
		comboSpr.updateHitbox();
		rating.updateHitbox();

		var seperatedScore:Array<Int> = [];

		if(combo >= 1000) {
			seperatedScore.push(Math.floor(combo / 1000) % 10);
		}
		seperatedScore.push(Math.floor(combo / 100) % 10);
		seperatedScore.push(Math.floor(combo / 10) % 10);
		seperatedScore.push(combo % 10);

		var daLoop:Int = 0;
		var xThing:Float = 0;
		if (showCombo)
		{
			insert(members.indexOf(strumLineNotes), comboSpr);
		}
		for (i in seperatedScore)
		{
			var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image('num' + Std.int(i)));
			numScore.cameras = [ClientPrefs.fixedComboSprPos ? camHUD : (ClientPrefs.hideAllSprites ? camChars : camGame)];
			numScore.screenCenter();
			numScore.x = coolText.x + (43 * daLoop) - 90;
			numScore.y += 80;

			if (ClientPrefs.fixedComboSprPos) {
				numScore.x += ClientPrefs.comboOffset[2];
				numScore.y -= ClientPrefs.comboOffset[3];
			}
			numScore.antialiasing = ClientPrefs.globalAntialiasing;
			numScore.setGraphicSize(Std.int(numScore.width * 0.5));
			numScore.updateHitbox();

			numScore.acceleration.y = FlxG.random.int(200, 300);
			numScore.velocity.y -= FlxG.random.int(140, 160);
			numScore.velocity.x = FlxG.random.float(-5, 5);
			numScore.visible = !ClientPrefs.hideHud;
			
			if(showComboNum)
				insert(members.indexOf(strumLineNotes), numScore);

			FlxTween.tween(numScore, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					numScore.destroy();
				},
				startDelay: Conductor.crochet * 0.002
			});

			daLoop++;
			if(numScore.x > xThing) xThing = numScore.x;
		}
		comboSpr.x = xThing + 50;

		coolText.text = Std.string(seperatedScore);

		FlxTween.tween(rating, {alpha: 0}, 0.2, {
			startDelay: Conductor.crochet * 0.001
		});

		FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
			onComplete: function(tween:FlxTween)
			{
				coolText.destroy();
				comboSpr.destroy();

				rating.destroy();
			},
			startDelay: Conductor.crochet * 0.002
		});
	}

	private function onKeyPress(event:KeyboardEvent):Void
	{
		var eventKey:FlxKey = event.keyCode;
		var key:Int = getKeyFromEvent(eventKey);
		//trace('Pressed: ' + eventKey);

		if (!cpuControlled && startedCountdown && !paused && key > -1 && (FlxG.keys.checkStatus(eventKey, JUST_PRESSED) || ClientPrefs.controllerMode))
		{
			if(!boyfriend.stunned && generatedMusic && !endingSong)
			{
				//more accurate hit time for the ratings?
				var lastTime:Float = Conductor.songPosition;
				Conductor.songPosition = FlxG.sound.music.time;

				var canMiss:Bool = !ClientPrefs.ghostTapping;

				// heavily based on my own code LOL if it aint broke dont fix it
				var pressNotes:Array<Note> = [];
				//var notesDatas:Array<Int> = [];
				var notesStopped:Bool = false;

				var sortedNotesList:Array<Note> = [];
				notes.forEachAlive(function(daNote:Note)
				{
					if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !daNote.isSustainNote)
					{
						if(daNote.noteData == key)
						{
							sortedNotesList.push(daNote);
						}
						canMiss = true;
					}
				});
				sortedNotesList.sort(sortHitNotes);

				if (sortedNotesList.length > 0) {
					for (epicNote in sortedNotesList)
					{
						for (doubleNote in pressNotes) {
							if (Math.abs(doubleNote.strumTime - epicNote.strumTime) < 1) {
								doubleNote.kill();
								notes.remove(doubleNote, true);
								doubleNote.destroy();
							} else
								notesStopped = true;
						}
						if (!notesStopped) {
							goodNoteHit(epicNote);
							pressNotes.push(epicNote);
						}
					}
				}
				else {
					callOnLuas('onGhostTap', [key]);
					noteMissPress(key);
				}

				keysPressed[key] = true;
				
				Conductor.songPosition = lastTime;
			}

			var spr:StrumNote = playerStrums.members[key];
			if(spr != null && spr.animation.curAnim.name != 'confirm')
			{
				spr.playAnim('pressed');
				spr.resetAnim = 0;
			}
			callOnLuas('onKeyPress', [key]);
		}
	}

	function sortHitNotes(a:Note, b:Note):Int
	{
		if (a.lowPriority && !b.lowPriority)
			return 1;
		else if (!a.lowPriority && b.lowPriority)
			return -1;

		return FlxSort.byValues(FlxSort.ASCENDING, a.strumTime, b.strumTime);
	}

	private function onKeyRelease(event:KeyboardEvent):Void
	{
		var eventKey:FlxKey = event.keyCode;
		var key:Int = getKeyFromEvent(eventKey);
		if(!cpuControlled && startedCountdown && !paused && key > -1)
		{
			var spr:StrumNote = playerStrums.members[key];
			if(spr != null)
			{
				spr.playAnim('static');
				spr.resetAnim = 0;
			}
			callOnLuas('onKeyRelease', [key]);
		}
	}

	private function getKeyFromEvent(key:FlxKey):Int
	{
		if(key != NONE)
		{
			for (i in 0...keysArray.length)
			{
				for (j in 0...keysArray[i].length)
				{
					if(key == keysArray[i][j])
					{
						return i;
					}
				}
			}
		}
		return -1;
	}

	// Hold notes
	private function keyShit():Void
	{
		// HOLDING
		var up = controls.NOTE_UP;
		var right = controls.NOTE_RIGHT;
		var down = controls.NOTE_DOWN;
		var left = controls.NOTE_LEFT;
		var controlHoldArray:Array<Bool> = [left, down, up, right];

		if(ClientPrefs.controllerMode)
		{
			var controlArray:Array<Bool> = [controls.NOTE_LEFT_P, controls.NOTE_DOWN_P, controls.NOTE_UP_P, controls.NOTE_RIGHT_P];
			if(controlArray.contains(true))
			{
				for (i in 0...controlArray.length)
				{
					if(controlArray[i])
						onKeyPress(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, true, -1, keysArray[i][0]));
				}
			}
		}

		if (startedCountdown && !boyfriend.stunned && generatedMusic)
		{
			// rewritten inputs???
			notes.forEachAlive(function(daNote:Note)
			{
				// hold note functions
				if (daNote.isSustainNote && controlHoldArray[daNote.noteData] && daNote.canBeHit
				&& daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit) {
					goodNoteHit(daNote);
				}
			});

			if (boyfriend.holdTimer > Conductor.stepCrochet * 0.0011 * boyfriend.singDuration && boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss'))
			{
				boyfriend.dance();
			}
		}

		if(ClientPrefs.controllerMode)
		{
			var controlArray:Array<Bool> = [controls.NOTE_LEFT_R, controls.NOTE_DOWN_R, controls.NOTE_UP_R, controls.NOTE_RIGHT_R];
			if(controlArray.contains(true))
			{
				for (i in 0...controlArray.length)
				{
					if(controlArray[i])
						onKeyRelease(new KeyboardEvent(KeyboardEvent.KEY_UP, true, true, -1, keysArray[i][0]));
				}
			}
		}
	}

	function noteMiss(daNote:Note):Void {
		//Dupe note remove
		notes.forEachAlive(function(note:Note) {
			if (daNote != note && daNote.mustPress && daNote.noteData == note.noteData && daNote.isSustainNote == note.isSustainNote && Math.abs(daNote.strumTime - note.strumTime) < 1) {
				note.kill();
				notes.remove(note, true);
				note.destroy();
			}
		});
		var prevCombo:Int = combo;
		combo = 0;
		health -= daNote.missHealth * healthLoss;
		if (ClientPrefs.missesDecreaseMaxHealth) maxHealth -= daNote.missHealth * healthLoss;
		tempMissPenalty += daNote.missHealth * healthLoss * ClientPrefs.tempMissPenalty;

		if(instakillOnMiss)
		{
			vocals.volume = 0;
			doDeathCheck(true);
		}

		//For testing purposes
		//trace(daNote.missHealth);
		songMisses++;
		vocals.volume = 0;
		if(!practiceMode && ClientPrefs.scoreSystem == 'Vanilla') songScore -= 10;
		if (ClientPrefs.scoreSystem == 'Vanilla') thScore += ratingsData[0].score;
		else thScore += (maxScore * (practiceMode ? 0.5 : 1) * 0.5 / mustHitNoteCount) * 2;
		bonus = 0;

		totalPlayed++;
		RecalculateRating(true);

		if (!boyfriend.stunned && ClientPrefs.stunsBlockInputs > 0) {
			boyfriend.stunned = true;
			for (note in notes)
				if (Conductor.songPosition + ClientPrefs.stunsBlockInputs * 1000 > note.strumTime + noteKillOffset)
					{ note.copyAlpha = false; note.alpha = 0.3; }
			for (note in unspawnNotes)
				if (Conductor.songPosition + ClientPrefs.stunsBlockInputs * 1000 > note.strumTime + noteKillOffset)
					{ note.copyAlpha = false; note.alpha = 0.3; }

			new FlxTimer().start(ClientPrefs.stunsBlockInputs, function(tmr:FlxTimer) {
				boyfriend.stunned = false;
			});
		}

		var char:Character = opponentPlay ? dad : boyfriend;
		if(daNote.gfNote) {
			char = gf;
		}

		FlxG.camera.shake(ClientPrefs.missShakeIntensity / 100, 0.5, null, true, singAnimations[Std.int(Math.abs(daNote.noteData))].endsWith('UP') || singAnimations[Std.int(Math.abs(daNote.noteData))].endsWith('DOWN') ? flixel.util.FlxAxes.Y : flixel.util.FlxAxes.X);
		if (ClientPrefs.missAnimsSounds) {
			if(char != null && !daNote.noMissAnimation && char.hasMissAnimations)
			{
				if (daNote.noteType != 'Bullet_Note') {
					var animToPlay:String = singAnimations[Std.int(Math.abs(daNote.noteData))] + 'miss' + daNote.animSuffix;
					char.playAnim(animToPlay, true);
				} else {
					if(char.animation.getByName('hurt') != null) {
						char.playAnim('hurt', true);
						char.specialAnim = true;
						hpmechanic = true;
					}
					if(dad.animOffsets.exists('LEFTshoot')) {
						dad.playAnim('LEFTshoot', true);
						dad.specialAnim = true;
					}
				}
			}
			if (daNote.noteType != 'Bullet_Note') {
				if (prevCombo >= 10 || totalPlayed == 1)
					FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
			}
		}

		callOnLuas('noteMiss', [notes.members.indexOf(daNote), daNote.noteData, daNote.noteType, daNote.isSustainNote]);
	}

	function noteMissPress(direction:Int = 1):Void //You pressed a key when there was no notes to press for this key
	{
		if (!boyfriend.stunned)
		{
			var char:Character = opponentPlay ? dad : boyfriend;
			if (ClientPrefs.missAnimsSounds) {
				if (char.hasMissAnimations) char.playAnim(singAnimations[Std.int(Math.abs(direction))] + 'miss', true);
				if (!ClientPrefs.ghostTapping) FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
			}
			if (ClientPrefs.ghostTapping) {
				if (totalPlayed > 0 && (notes.length > 0 || unspawnNotes.length > 0 || eventNotes.length > 0)) {
					pressMisses++;
					updateScore(true);
				}
				return;
			}
			health -= 0.05 * healthLoss;
			if (ClientPrefs.missesDecreaseMaxHealth) maxHealth -= 0.05 * healthLoss;
			tempMissPenalty += 0.05 * healthLoss * ClientPrefs.tempMissPenalty;
			if(instakillOnMiss)
			{
				vocals.volume = 0;
				doDeathCheck(true);
			}

			if (combo > 5 && gf != null && gf.animOffsets.exists('sad'))
			{
				gf.playAnim('sad');
			}
			combo = 0;

			if(!practiceMode && ClientPrefs.scoreSystem == 'Vanilla') songScore -= 10;
			if (ClientPrefs.scoreSystem == 'Vanilla') thScore += ratingsData[0].score;
			else thScore += (maxScore * (practiceMode ? 0.5 : 1) * 0.5 / mustHitNoteCount) * 2;
			bonus = 0;
			if(!endingSong) {
				songMisses++;
			}
			totalPlayed++;
			RecalculateRating(true);

			if (!boyfriend.stunned && ClientPrefs.stunsBlockInputs > 0) {
			boyfriend.stunned = true;
			for (note in notes)
				if (Conductor.songPosition + ClientPrefs.stunsBlockInputs * 1000 > note.strumTime + noteKillOffset)
					{ note.copyAlpha = false; note.alpha = 0.3; }
			for (note in unspawnNotes)
				if (Conductor.songPosition + ClientPrefs.stunsBlockInputs * 1000 > note.strumTime + noteKillOffset)
					{ note.copyAlpha = false; note.alpha = 0.3; }

			new FlxTimer().start(ClientPrefs.stunsBlockInputs, function(tmr:FlxTimer)
			{
				boyfriend.stunned = false;
			});
			}

			FlxG.camera.shake(ClientPrefs.missShakeIntensity / 100, 0.5, null, true, singAnimations[Std.int(Math.abs(direction))].endsWith('UP') || singAnimations[Std.int(Math.abs(direction))].endsWith('DOWN') ? flixel.util.FlxAxes.Y : flixel.util.FlxAxes.X);
			/*if(char.hasMissAnimations) {
				char.playAnim(singAnimations[Std.int(Math.abs(direction))] + 'miss', true);
			}*/
			vocals.volume = 0;
		}
		callOnLuas('noteMissPress', [direction]);
	}

	function opponentNoteHit(note:Note):Void
	{
		if (curSong == 'Let Us In')
			triggerEventNote('Screen Shake', '0.005, 0.001', '0.4, 0.005');

		if (Paths.formatToSongPath(SONG.song) != 'tutorial')
			camZooming = true;

		var char:Character = opponentPlay ? boyfriend : dad;
		if (note.gfNote) char = gf;
		var animToPlay:String = singAnimations[Std.int(Math.abs(note.noteData))];
		if (!SONG.notes[curSection].mustHitSection == !opponentPlay || (opponentPlay ? ClientPrefs.hideOpponent : ClientPrefs.hideBf)) moveCamera(!opponentPlay, animToPlay);
		if(note.noteType == 'Hey!' && char.animOffsets.exists('hey')) {
			char.playAnim('hey', true);
			char.specialAnim = true;
			char.heyTimer = 0.6;
		} else if(!note.noAnimation) {
			var altAnim:String = note.animSuffix;

			if (SONG.notes[curSection] != null)
			{
				if (SONG.notes[curSection].altAnim && !SONG.notes[curSection].gfSection) {
					altAnim = '-alt';
				}
			}

			/*var char:Character = dad;
			var animToPlay:String = singAnimations[Std.int(Math.abs(note.noteData))] + altAnim;
			if(note.gfNote) {
				char = gf;
			}*/

			if(char != null)
			{
				char.playAnim(animToPlay + altAnim, true);
				char.holdTimer = 0;
			}
		}

		if (SONG.needsVoices)
			vocals.volume = 1;

		var time:Float = 0.15;
		if(note.isSustainNote && !note.animation.curAnim.name.endsWith('end')) {
			time += 0.15;
		}
		StrumPlayAnim(true, Std.int(Math.abs(note.noteData)) % 4, time);
		note.hitByOpponent = true;

		var damage:Float = ClientPrefs.damageFromOpponentNotes * 0.02;
		var toRemove:Float = Math.min(damage, ClientPrefs.opponentNotesCanKill && healthDrained + damage < 1.8 ? 0.2 : Math.max(0.001, health) - 0.001);
		health -= toRemove;
		healthDrained += toRemove;
		callOnLuas('opponentNoteHit', [notes.members.indexOf(note), Math.abs(note.noteData), note.noteType, note.isSustainNote]);

		if (!note.isSustainNote)
		{
			note.kill();
			notes.remove(note, true);
			note.destroy();
		}
	}

	function goodNoteHit(note:Note):Void
	{
		if (!note.wasGoodHit)
		{
			if(cpuControlled && (note.ignoreNote || note.hitCausesMiss)) return;

			if (ClientPrefs.hitsoundVolume > 0 && !note.hitsoundDisabled)
			{
				FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.hitsoundVolume);
			}

			var char:Character = opponentPlay ? dad : boyfriend;
			if (note.gfNote && gf != null) char = gf;
			if(note.hitCausesMiss) {
				noteMiss(note);
				if(!note.noteSplashDisabled && !note.isSustainNote) {
					spawnNoteSplashOnNote(note);
				}

				if(!note.noMissAnimation)
				{
					switch(note.noteType) {
						case 'Hurt Note': //Hurt note
							if(char.animation.getByName('hurt') != null) {
								char.playAnim('hurt', true);
								char.specialAnim = true;
							}
					}
				}

				note.wasGoodHit = true;
				if (!note.isSustainNote)
				{
					note.kill();
					notes.remove(note, true);
					note.destroy();
				}
				return;
			}

			if (!note.isSustainNote)
			{
				combo += 1;
				if(combo > 9999) combo = 9999;
				popUpScore(note);
			}
			var toAdd:Float = 0;
			if (!hpmechanic) {
				toAdd = note.hitHealth * healthGain;
				toAdd -= Math.min(toAdd, tempMissPenalty);
				tempMissPenalty -= note.hitHealth * healthGain - toAdd;
			} else if (curSong == "Let Us In") {
				toAdd = (note.hitHealth - 0.022) * healthGain;
				toAdd -= Math.min(toAdd, tempMissPenalty);
				tempMissPenalty -= note.hitHealth * healthGain - toAdd - 0.003;
			} else {
				if (health <= 0.5) {
					toAdd = (note.hitHealth - 0.013) * healthGain ;
					toAdd -= Math.min(toAdd, tempMissPenalty);
					tempMissPenalty -= note.hitHealth * healthGain - toAdd - 0.01;
				}
				if (health > 0.5)
					health = 0.5;
			}
			health += toAdd;
			healthDrained -= toAdd;

			var animToPlay:String = singAnimations[Std.int(Math.abs(note.noteData))];
			if (SONG.notes[curSection].mustHitSection == !opponentPlay || (opponentPlay ? ClientPrefs.hideBf : ClientPrefs.hideOpponent)) moveCamera(opponentPlay, animToPlay);
			if(!note.noAnimation) {
				char.playAnim(animToPlay + note.animSuffix, true);
				char.holdTimer = 0;

				if(note.noteType == 'Bullet_Note') {
					if(char.animOffsets.exists('dodge')) {
						char.playAnim('dodge', true);
						char.specialAnim = true;
					}
					
					if(dad.animOffsets.exists('LEFTshoot')) {
						dad.playAnim('LEFTshoot', true);
						dad.specialAnim = true;
					}
				}

				if(note.noteType == 'Hey!') {
					if(char.animOffsets.exists('hey')) {
						char.playAnim('hey', true);
						char.specialAnim = true;
						char.heyTimer = 0.6;
					}

					if(gf != null && gf.animOffsets.exists('cheer')) {
						gf.playAnim('cheer', true);
						gf.specialAnim = true;
						gf.heyTimer = 0.6;
					}
				}
			}

			if(cpuControlled) {
				var time:Float = 0.15;
				if(note.isSustainNote && !note.animation.curAnim.name.endsWith('end')) {
					time += 0.15;
				}
				StrumPlayAnim(false, Std.int(Math.abs(note.noteData)) % 4, time);
			} else {
				playerStrums.forEach(function(spr:StrumNote)
				{
					if (Math.abs(note.noteData) == spr.ID)
					{
						spr.playAnim('confirm', true);
					}
				});
			}
			note.wasGoodHit = true;
			vocals.volume = 1;

			var isSus:Bool = note.isSustainNote;
			var leData:Int = Math.round(Math.abs(note.noteData));
			var leType:String = note.noteType;
			callOnLuas('goodNoteHit', [notes.members.indexOf(note), leData, leType, isSus]);

			if (!note.isSustainNote)
			{
				note.kill();
				notes.remove(note, true);
				note.destroy();
			}
		}
	}

	function spawnNoteSplashOnNote(note:Note) {
		if(ClientPrefs.noteSplashes && note != null) {
			var strum:StrumNote = playerStrums.members[note.noteData];
			if(strum != null) {
				spawnNoteSplash(strum.x, strum.y, note.noteData, note);
			}
		}
	}

	public function spawnNoteSplash(x:Float, y:Float, data:Int, ?note:Note = null) {
		var skin:String = 'noteSplashes';

		if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0)
			skin = PlayState.SONG.splashSkin;

		var hue:Float = ClientPrefs.arrowHSV[data % 4][0] / 360;
		var sat:Float = ClientPrefs.arrowHSV[data % 4][1] / 100;
		var brt:Float = ClientPrefs.arrowHSV[data % 4][2] / 100;
		if(note != null) {
			skin = note.noteSplashTexture;
			hue = note.noteSplashHue;
			sat = note.noteSplashSat;
			brt = note.noteSplashBrt;
		}

		var splash:NoteSplash = grpNoteSplashes.recycle(NoteSplash);
		splash.setupNoteSplash(x, y, data, skin, hue, sat, brt);
		grpNoteSplashes.add(splash);
	}

	override function destroy() {
		ClientPrefs.lowQuality = oldLQ;
		for (lua in luaArray) {
			lua.call('onDestroy', []);
			lua.stop();
		}
		luaArray = [];

		if(!ClientPrefs.controllerMode)
		{
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		#if hscript
		FunkinLua.haxeInterp = null;
		#end
		super.destroy();
	}

	public static function cancelMusicFadeTween() {
		if(FlxG.sound.music.fadeTween != null) {
			FlxG.sound.music.fadeTween.cancel();
		}
		FlxG.sound.music.fadeTween = null;
	}

	var lastStepHit:Int = -1;
	override function stepHit()
	{
		super.stepHit();
		if (Math.abs(FlxG.sound.music.time - (Conductor.songPosition - Conductor.offset)) > 20
			|| (SONG.needsVoices && Math.abs(vocals.time - (Conductor.songPosition - Conductor.offset)) > 20))
		{
			resyncVocals();
		}

		if(curStep == lastStepHit) {
			return;
		}

		lastStepHit = curStep;
		setOnLuas('curStep', curStep);
		callOnLuas('onStepHit', []);
	}

	var lastBeatHit:Int = -1;

	override function beatHit()
	{
		super.beatHit();

		if(lastBeatHit >= curBeat) {
			return;
		}

		if (generatedMusic) {
			notes.sort(FlxSort.byY, ClientPrefs.downScroll ? FlxSort.ASCENDING : FlxSort.DESCENDING);
		}

		if(curBeat % 1 == 0 && curSong == 'Let Us In')
			health -= 0.005;
		if (hpmechanic == true && curBeat % 2 == 0 && health > 0.1)
			health -= 0.005;


		if(curBeat % 2 == 0) {
			iconP1.angle = 0;
			iconP2.angle = 0;
			iconP1.angle -= 20;
			iconP2.angle += 20;
		}

		iconP1.scale.set(1.1, 1.1);
		iconP2.scale.set(1.1, 1.1);

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		if (gf != null && curBeat % Math.round(gfSpeed * gf.danceEveryNumBeats) == 0 && gf.animation.curAnim != null && !gf.animation.curAnim.name.startsWith("sing") && !gf.stunned)
		{
			gf.dance();
		}
		if (curBeat % boyfriend.danceEveryNumBeats == 0 && boyfriend.animation.curAnim != null && !boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.stunned)
		{
			boyfriend.dance();
		}
		if (curBeat % dad.danceEveryNumBeats == 0 && dad.animation.curAnim != null && !dad.animation.curAnim.name.startsWith('sing') && !dad.stunned)
		{
			dad.dance();
		}

		lastBeatHit = curBeat;

		setOnLuas('curBeat', curBeat);
		callOnLuas('onBeatHit', []);
	}

	override function sectionHit()
	{
		super.sectionHit();

		if (SONG.notes[curSection] != null)
		{
			if (generatedMusic && !endingSong && !isCameraOnForcedPos)
			{
				moveCameraSection();
			}

			if (camZooming && FlxG.camera.zoom < 1.35 && ClientPrefs.camZooms)
			{
				FlxG.camera.zoom += 0.015 * camZoomingMult;
				camHUD.zoom += 0.03 * camZoomingMult;
			}

			if (SONG.notes[curSection].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[curSection].bpm);
				setOnLuas('curBpm', Conductor.bpm);
				setOnLuas('crochet', Conductor.crochet);
				setOnLuas('stepCrochet', Conductor.stepCrochet);
			}
			setOnLuas('mustHitSection', SONG.notes[curSection].mustHitSection);
			setOnLuas('altAnim', SONG.notes[curSection].altAnim);
			setOnLuas('gfSection', SONG.notes[curSection].gfSection);
		}
		
		setOnLuas('curSection', curSection);
		callOnLuas('onSectionHit', []);
	}

	public function callOnLuas(event:String, args:Array<Dynamic>, ignoreStops = true, exclusions:Array<String> = null):Dynamic {
		var returnVal:Dynamic = FunkinLua.Function_Continue;
		#if LUA_ALLOWED
		if(exclusions == null) exclusions = [];
		for (script in luaArray) {
			if(exclusions.contains(script.scriptName))
				continue;

			var ret:Dynamic = script.call(event, args);
			if(ret == FunkinLua.Function_StopLua && !ignoreStops)
				break;
			
			if(ret != FunkinLua.Function_Continue)
				returnVal = ret;
		}
		#end
		return returnVal;
	}

	public function setOnLuas(variable:String, arg:Dynamic) {
		#if LUA_ALLOWED
		for (i in 0...luaArray.length) {
			luaArray[i].set(variable, arg);
		}
		#end
	}

	function StrumPlayAnim(isDad:Bool, id:Int, time:Float) {
		var spr:StrumNote = null;
		if(isDad) {
			spr = opponentStrums.members[id];
		} else {
			spr = playerStrums.members[id];
		}

		if(spr != null) {
			spr.playAnim('confirm', true);
			spr.resetAnim = time;
		}
	}

	public var ratingName:String = '?';
	public var ratingPercent:Float;
	public var ratingFC:String;
	public var perfRating:Float;
	public function RecalculateRating(badHit:Bool = false) {
		setOnLuas('score', songScore);
		setOnLuas('misses', songMisses);
		setOnLuas('hits', songHits);

		var ret:Dynamic = callOnLuas('onRecalculateRating', [], false);
		if(ret != FunkinLua.Function_Stop)
		{
			if(totalPlayed < 1)
				ratingPercent = 1;
			else
			{
				if (!ClientPrefs.accuracySystem.startsWith('osu!mania')) {
				ratingPercent = Math.min(1, Math.max(0, totalNotesHit / totalPlayed));

				} else {
					var isStrictAcc:Bool = ClientPrefs.accuracySystem.endsWith('(strict)');
					var maxesAndSicks:Int = isStrictAcc ? 305 * maxs + 300 * sicks : 300 * (maxs + sicks);
					ratingPercent = (maxesAndSicks + 200 * goods + 100 * bads + 50 * shits) / ((isStrictAcc ? 305 : 300) * totalPlayed);
				}
				// Rating Name
			}	
			if(ratingPercent >= 0.99)
				ratingName = ratingStuff[ratingStuff.length-1][0]; //Uses last string
			else
				{
					for (i in 0...ratingStuff.length-1)
					{
						if(ratingPercent < ratingStuff[i][1])
						{
							ratingName = ratingStuff[i][0];
							break;
						}
					}
				}

			var ratingMultiplier:Float = 1.5;
			// Rating FC
			ratingFC = "";
			if (maxs > 0) ratingFC = " (!MFC!)";
			if (sicks > 0) ratingFC = " (_SFC_)";
			if (goods > 0) { ratingFC = " (^GFC^)"; ratingMultiplier *= ((maxs + sicks) / totalPlayed); }
			if (bads > 0 || shits > 0) { ratingFC = " ($FC$)"; ratingMultiplier *= (maxs + sicks + goods + bads * 0.5) / totalPlayed; }
			if (songMisses > 0) { ratingFC = " (&SDCB&)"; ratingMultiplier *= (totalPlayed - songMisses * 2) / totalPlayed; }
			if (songMisses >= 10) ratingFC = " (#Clear#)";

			var seconds:Float = Conductor.songPosition / 1000;
			var noteDensity:Float = totalNotesHit / (seconds - seconds / 10) * songSpeedBonus;
			perfRating = ratingPercent * ratingMultiplier * noteDensity * songSpeedBonus;
		}
		updateScore(badHit);
		setOnLuas('rating', ratingPercent);
		setOnLuas('ratingName', ratingName);
		setOnLuas('ratingFC', ratingFC);
	}

	public function switchObjectState(object:FlxBasic, newState:Bool):Void {
		FlxTween.tween(object, {alpha: newState ? 1 : 0}, Conductor.crochet / 1000, { ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween) {
			object.visible = newState;
			object.active = newState;
		}});
	}

	#if ACHIEVEMENTS_ALLOWED
	private function checkForAchievement(achievesToCheck:Array<String> = null):String
	{
		if(chartingMode) return null;

		var usedPractice:Bool = (ClientPrefs.getGameplaySetting('practice', false) || ClientPrefs.getGameplaySetting('botplay', false));

		for (i in 0...achievesToCheck.length) {
			var achievementName:String = achievesToCheck[i];
			if(!Achievements.isAchievementUnlocked(achievementName) && !cpuControlled) {
				var unlock:Bool = false;
				switch(achievementName)
				{
					case 'icy_encounter' | 'alleyway':
						if(isStoryMode && CoolUtil.difficultyString() == 'HARD' && storyPlaylist.length <= 1 && !changedDifficulty && !usedPractice)
						{
							var weekName:String = WeekData.getWeekFileName();
							switch(weekName)
							{
								case 'FrostyWeek':
									if(achievementName == 'icy_encounter') unlock = true;
								case 'FrostyWeek2':
									if(achievementName == 'alleyway') unlock = true;
							}
						}
					case 'fell_off':
						if(curSong == 'Heartfall' && songMisses > 10 && !changedDifficulty && !usedPractice) unlock = true;
					case 'dehydrated' | 'the_one_singing' | 'astral_snowstorm_nomiss':
						if(songMisses < 1 && CoolUtil.difficultyString() == 'ERECT' && !changedDifficulty && !usedPractice)
							{
								switch(curSong)
								{
									case 'Tsunami':
										if(achievementName == 'dehydrated') unlock = true;
									case 'Chilly':
										if(achievementName == 'the_one_singing') unlock = true;
									case 'Astral Snowstorm':
										if(achievementName == 'astral_snowstorm_nomiss') unlock = true;
								}
							}
					case 'sussy' | 'familiar_hero' | 'getting_started' | 'bad_aim':
						if(songMisses < 1 && CoolUtil.difficultyString() != 'ERECT' && !changedDifficulty && !usedPractice)
							{
								switch(curSong)
									{
										case 'Tsunami':
											if(achievementName == 'getting_started') unlock = true;
										case 'Sussy Balls':
											if(achievementName == 'sussy') unlock = true;
										case 'Origins':
											if(achievementName == 'familiar_hero') unlock = true;
										case 'Warfare':
											if(achievementName == 'bad_aim') unlock = true;
									}
							}
					case 'rising_star':
						if (sex == 11) unlock = true;
					// so many copy paste fuck you

					// also reel is definitely a gay

					// huh
				}

				if(unlock) {
					Achievements.unlockAchievement(achievementName);
					sex = sex + 1; //SEX IS SO FUNNY
					ClientPrefs.sex = sex;
					ClientPrefs.saveSettings();
					return achievementName;
				}
			}
		}
		return null;
	}
	#end
}