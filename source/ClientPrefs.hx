package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

class ClientPrefs {
	public static var downScroll:Bool = false;
	public static var middleScroll:Bool = false;
	public static var opponentStrums:Bool = true;
	public static var showFPS:Bool = true;
	public static var flashing:Bool = true;
	public static var globalAntialiasing:Bool = true;
	public static var noteSplashes:Bool = true;
	public static var lowQuality:Bool = false;
	public static var framerate:Int = 60;
	public static var cursing:Bool = true;
	public static var violence:Bool = true;
	public static var camZooms:Bool = true;
	public static var hideHud:Bool = false;
	public static var noteOffset:Int = 0;
	public static var arrowHSV:Array<Array<Int>> = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
	public static var imagesPersist:Bool = false;
	public static var ghostTapping:Bool = true;
	public static var timeBarType:String = 'Disabled';
	public static var scoreZoom:Bool = true;
	public static var noReset:Bool = false;
	public static var healthBarAlpha:Float = 1;
	public static var controllerMode:Bool = false;
	public static var hitsoundVolume:Float = 0;
	public static var sex:Float = 0;
	public static var juketag:Bool = true;
	public static var funnitext:Bool = true;
	public static var pauseMusic:String = 'Tea Time';
	public static var gameplaySettings:Map<String, Dynamic> = [
		'scrollspeed' => 1.0,
		'scrolltype' => 'multiplicative', 
		'songspeed' => 1.0,
		'healthgain' => 1.0,
		'healthloss' => 1.0,
		'instakill' => false,
		'practice' => false,
		'botplay' => false,
		'opponentplay' => false,
		'startinghealth' => 0.5,
		'maxhealth' => 1
	];

	public static var comboOffset:Array<Int> = [0, 0, 0, 0];
	public static var ratingOffset:Int = 0;
	public static var maxWindow:Int = 15;
	public static var sickWindow:Int = 45;
	public static var goodWindow:Int = 90;
	public static var badWindow:Int = 135;
	public static var safeFrames:Float = 10;

	// ProjectFNF
	public static var damageFromOpponentNotes:Float = 0;
	public static var opponentNotesCanKill:Bool = false;
	public static var stunsBlockInputs:Float = 0;
	public static var cameraMoveIntensity:Float = 70;
	public static var missShakeIntensity:Float = 0.5;
	public static var scoreSystem:String = 'Vanilla';
	public static var accuracySystem:String = 'Psych';
	public static var missAnimsSounds:Bool = true;
	public static var advancedScoreTxt:Bool = true;
	public static var scoreTxtUnderlayOpacity:Float = 0.3;
	public static var healthBarType:String = 'Horizontal';
	public static var hideAllSprites:Bool = false;
	public static var hideOpponent:Bool = false;
	public static var hideGf:Bool = false;
	public static var hideBf:Bool = false;
	public static var missesDecreaseMaxHealth:Bool = false;
	public static var vignetteStrength:Float = 0.7;
	public static var cameraZoom:Float = 1.0;
	public static var tempMissPenalty:Float = 0;
	public static var tempMissPenaltyDPS:Float = 0;
	public static var tempMissPenaltyCanKill:Bool = false;
	public static var permaMissPenaltyDPS:Float = 0;
	public static var permaMissPenaltyCanKill:Bool = false;
	public static var playerLaneUnderlayOpacity:Float = 0;
	public static var opponentLaneUnderlayOpacity:Float = 0;
	public static var fixedComboSprPos:Bool = false;

	//Every key has two binds, add your key bind down here and then add your control on options/ControlsSubState.hx and Controls.hx
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		//Key Bind, Name for ControlsSubState
		'note_left'		=> [A, LEFT],
		'note_down'		=> [S, DOWN],
		'note_up'		=> [W, UP],
		'note_right'	=> [D, RIGHT],
		
		'ui_left'		=> [A, LEFT],
		'ui_down'		=> [S, DOWN],
		'ui_up'			=> [W, UP],
		'ui_right'		=> [D, RIGHT],
		
		'accept'		=> [SPACE, ENTER],
		'back'			=> [BACKSPACE, ESCAPE],
		'pause'			=> [ENTER, ESCAPE],
		'reset'			=> [R, NONE],
		
		'volume_mute'	=> [ZERO, NONE],
		'volume_up'		=> [NUMPADPLUS, PLUS],
		'volume_down'	=> [NUMPADMINUS, MINUS],
		
		'debug_1'		=> [SEVEN, NONE],
		'debug_2'		=> [EIGHT, NONE]
	];
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	public static function loadDefaultKeys() {
		defaultKeys = keyBinds.copy();
		//trace(defaultKeys);
	}

	public static function saveSettings() {
		FlxG.save.data.downScroll = downScroll;
		FlxG.save.data.middleScroll = middleScroll;
		FlxG.save.data.opponentStrums = opponentStrums;
		FlxG.save.data.showFPS = showFPS;
		FlxG.save.data.flashing = flashing;
		FlxG.save.data.globalAntialiasing = globalAntialiasing;
		FlxG.save.data.noteSplashes = noteSplashes;
		FlxG.save.data.lowQuality = lowQuality;
		FlxG.save.data.framerate = framerate;
		//FlxG.save.data.cursing = cursing;
		//FlxG.save.data.violence = violence;
		FlxG.save.data.camZooms = camZooms;
		FlxG.save.data.noteOffset = noteOffset;
		FlxG.save.data.hideHud = hideHud;
		FlxG.save.data.arrowHSV = arrowHSV;
		FlxG.save.data.imagesPersist = imagesPersist;
		FlxG.save.data.ghostTapping = ghostTapping;
		FlxG.save.data.timeBarType = timeBarType;
		FlxG.save.data.scoreZoom = scoreZoom;
		FlxG.save.data.noReset = noReset;
		FlxG.save.data.healthBarAlpha = healthBarAlpha;
		FlxG.save.data.comboOffset = comboOffset;
		FlxG.save.data.achievementsMap = Achievements.achievementsMap;

		FlxG.save.data.ratingOffset = ratingOffset;
		FlxG.save.data.maxWindow = maxWindow;
		FlxG.save.data.sickWindow = sickWindow;
		FlxG.save.data.goodWindow = goodWindow;
		FlxG.save.data.badWindow = badWindow;
		FlxG.save.data.safeFrames = safeFrames;
		FlxG.save.data.gameplaySettings = gameplaySettings;
		FlxG.save.data.controllerMode = controllerMode;
		FlxG.save.data.hitsoundVolume = hitsoundVolume;
		FlxG.save.data.sex = sex;
		FlxG.save.data.juketag = juketag;
		FlxG.save.data.funnitext = funnitext;
		FlxG.save.data.pauseMusic = pauseMusic;

		FlxG.save.data.damageFromOpponentNotes = damageFromOpponentNotes;
		FlxG.save.data.opponentNotesCanKill = opponentNotesCanKill;
		FlxG.save.data.stunsBlockInputs = stunsBlockInputs;
		FlxG.save.data.cameraMoveIntensity = cameraMoveIntensity;
		FlxG.save.data.missShakeIntensity = missShakeIntensity;
		FlxG.save.data.scoreSystem = scoreSystem;
		FlxG.save.data.accuracySystem = accuracySystem;
		FlxG.save.data.missAnimsSounds = missAnimsSounds;
		FlxG.save.data.advancedScoreTxt = advancedScoreTxt;
		FlxG.save.data.scoreTxtUnderlayOpacity = scoreTxtUnderlayOpacity;
		FlxG.save.data.healthBarType = healthBarType;
		FlxG.save.data.hideAllSprites = hideAllSprites;
		FlxG.save.data.hideOpponent = hideOpponent;
		FlxG.save.data.hideGf = hideGf;
		FlxG.save.data.hideBf = hideBf;
		FlxG.save.data.missesDecreaseMaxHealth = missesDecreaseMaxHealth;
		FlxG.save.data.vignetteStrength = vignetteStrength;
		FlxG.save.data.cameraZoom = cameraZoom;
		FlxG.save.data.tempMissPenalty = tempMissPenalty;
		FlxG.save.data.tempMissPenaltyDPS = tempMissPenaltyDPS;
		FlxG.save.data.tempMissPenaltyCanKill = tempMissPenaltyCanKill;
		FlxG.save.data.permaMissPenaltyDPS = permaMissPenaltyDPS;
		FlxG.save.data.permaMissPenaltyCanKill = permaMissPenaltyCanKill;
		FlxG.save.data.playerLaneUnderlayOpacity = playerLaneUnderlayOpacity;
		FlxG.save.data.opponentLaneUnderlayOpacity = opponentLaneUnderlayOpacity;
		FlxG.save.data.fixedComboSprPos = fixedComboSprPos;
	
		FlxG.save.flush();

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'ninjamuffin99'); //Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		save.data.customControls = keyBinds;
		save.flush();
		FlxG.log.add("Settings saved!");
	}

	public static function loadPrefs() {
		if(FlxG.save.data.downScroll != null) {
			downScroll = FlxG.save.data.downScroll;
		}
		if(FlxG.save.data.middleScroll != null) {
			middleScroll = FlxG.save.data.middleScroll;
		}
		if(FlxG.save.data.opponentStrums != null) {
			opponentStrums = FlxG.save.data.opponentStrums;
		}
		if(FlxG.save.data.showFPS != null) {
			showFPS = FlxG.save.data.showFPS;
			if(Main.fpsVar != null) {
				Main.fpsVar.visible = showFPS;
			}
		}
		if(FlxG.save.data.flashing != null) {
			flashing = FlxG.save.data.flashing;
		}
		if(FlxG.save.data.globalAntialiasing != null) {
			globalAntialiasing = FlxG.save.data.globalAntialiasing;
		}
		if(FlxG.save.data.noteSplashes != null) {
			noteSplashes = FlxG.save.data.noteSplashes;
		}
		if(FlxG.save.data.lowQuality != null) {
			lowQuality = FlxG.save.data.lowQuality;
		}
		if(FlxG.save.data.framerate != null) {
			framerate = FlxG.save.data.framerate;
			if(framerate > FlxG.drawFramerate) {
				FlxG.updateFramerate = framerate;
				FlxG.drawFramerate = framerate;
			} else {
				FlxG.drawFramerate = framerate;
				FlxG.updateFramerate = framerate;
			}
		}
		/*if(FlxG.save.data.cursing != null) {
			cursing = FlxG.save.data.cursing;
		}
		if(FlxG.save.data.violence != null) {
			violence = FlxG.save.data.violence;
		}*/
		if(FlxG.save.data.camZooms != null) {
			camZooms = FlxG.save.data.camZooms;
		}
		if(FlxG.save.data.hideHud != null) {
			hideHud = FlxG.save.data.hideHud;
		}
		if(FlxG.save.data.noteOffset != null) {
			noteOffset = FlxG.save.data.noteOffset;
		}
		if(FlxG.save.data.arrowHSV != null) {
			arrowHSV = FlxG.save.data.arrowHSV;
		}
		if(FlxG.save.data.ghostTapping != null) {
			ghostTapping = FlxG.save.data.ghostTapping;
		}
		if(FlxG.save.data.timeBarType != null) {
			timeBarType = FlxG.save.data.timeBarType;
		}
		if(FlxG.save.data.scoreZoom != null) {
			scoreZoom = FlxG.save.data.scoreZoom;
		}
		if(FlxG.save.data.noReset != null) {
			noReset = FlxG.save.data.noReset;
		}
		if(FlxG.save.data.healthBarAlpha != null) {
			healthBarAlpha = FlxG.save.data.healthBarAlpha;
		}
		if(FlxG.save.data.comboOffset != null) {
			comboOffset = FlxG.save.data.comboOffset;
		}
		
		if(FlxG.save.data.ratingOffset != null) {
			ratingOffset = FlxG.save.data.ratingOffset;
		}
		if(FlxG.save.data.maxWindow != null) {
			maxWindow = FlxG.save.data.maxWindow;
		}
		if(FlxG.save.data.sickWindow != null) {
			sickWindow = FlxG.save.data.sickWindow;
		}
		if(FlxG.save.data.goodWindow != null) {
			goodWindow = FlxG.save.data.goodWindow;
		}
		if(FlxG.save.data.badWindow != null) {
			badWindow = FlxG.save.data.badWindow;
		}
		if(FlxG.save.data.safeFrames != null) {
			safeFrames = FlxG.save.data.safeFrames;
		}
		if(FlxG.save.data.controllerMode != null) {
			controllerMode = FlxG.save.data.controllerMode;
		}
		if(FlxG.save.data.hitsoundVolume != null) {
			hitsoundVolume = FlxG.save.data.hitsoundVolume;
		}
		if(FlxG.save.data.sex != null) {
			sex = FlxG.save.data.sex;
		}
		if(FlxG.save.data.juketag != null) {
			juketag = FlxG.save.data.juketag;
		}
		if(FlxG.save.data.funnitext != null) {
			funnitext = FlxG.save.data.funnitext;
		}
		if(FlxG.save.data.pauseMusic != null) {
			pauseMusic = FlxG.save.data.pauseMusic;
		}
		if(FlxG.save.data.gameplaySettings != null)
		{
			var savedMap:Map<String, Dynamic> = FlxG.save.data.gameplaySettings;
			for (name => value in savedMap)
			{
				gameplaySettings.set(name, value);
			}
		}
		if(FlxG.save.data.damageFromOpponentNotes != null) {
			damageFromOpponentNotes = FlxG.save.data.damageFromOpponentNotes;
		}
		if(FlxG.save.data.opponentNotesCanKill != null) {
			opponentNotesCanKill = FlxG.save.data.opponentNotesCanKill;
		}
		if(FlxG.save.data.stunsBlockInputs != null) {
			stunsBlockInputs = FlxG.save.data.stunsBlockInputs;
		}
		if(FlxG.save.data.cameraMoveIntensity != null) {
			cameraMoveIntensity = FlxG.save.data.cameraMoveIntensity;
		}
		if(FlxG.save.data.missShakeIntensity != null) {
			missShakeIntensity = FlxG.save.data.missShakeIntensity;
		}
		if(FlxG.save.data.scoreSystem != null) {
			scoreSystem = FlxG.save.data.scoreSystem;
		}
		if(FlxG.save.data.accuracySystem != null) {
			accuracySystem = FlxG.save.data.accuracySystem;
		}
		if(FlxG.save.data.missAnimsSounds != null) {
			missAnimsSounds = FlxG.save.data.missAnimsSounds;
		}
		if(FlxG.save.data.advancedScoreTxt != null) {
			advancedScoreTxt = FlxG.save.data.advancedScoreTxt;
		}
		if(FlxG.save.data.scoreTxtUnderlayOpacity != null) {
			scoreTxtUnderlayOpacity = FlxG.save.data.scoreTxtUnderlayOpacity;
		}
		if(FlxG.save.data.healthBarType != null) {
			healthBarType = FlxG.save.data.healthBarType;
		}
		if(FlxG.save.data.hideAllSprites != null) {
			hideAllSprites = FlxG.save.data.hideAllSprites;
		}
		if(FlxG.save.data.hideOpponent != null) {
			hideOpponent = FlxG.save.data.hideOpponent;
		}
		if(FlxG.save.data.hideGf != null) {
			hideGf = FlxG.save.data.hideGf;
		}
		if(FlxG.save.data.hideBf != null) {
			hideBf = FlxG.save.data.hideBf;
		}
		if(FlxG.save.data.missesDecreaseMaxHealth != null) {
			missesDecreaseMaxHealth = FlxG.save.data.missesDecreaseMaxHealth;
		}
		if(FlxG.save.data.vignetteStrength != null) {
			vignetteStrength = FlxG.save.data.vignetteStrength;
		}
		if(FlxG.save.data.cameraZoom != null) {
			cameraZoom = FlxG.save.data.cameraZoom;
		}
		if(FlxG.save.data.tempMissPenalty != null) {
			tempMissPenalty = FlxG.save.data.tempMissPenalty;
		}
		if(FlxG.save.data.tempMissPenaltyDPS != null) {
			tempMissPenaltyDPS = FlxG.save.data.tempMissPenaltyDPS;
		}
		if(FlxG.save.data.tempMissPenaltyCanKill != null) {
			tempMissPenaltyCanKill = FlxG.save.data.tempMissPenaltyCanKill;
		}
		if(FlxG.save.data.permaMissPenaltyDPS != null) {
			permaMissPenaltyDPS = FlxG.save.data.permaMissPenaltyDPS;
		}
		if(FlxG.save.data.permaMissPenaltyCanKill != null) {
			permaMissPenaltyCanKill = FlxG.save.data.permaMissPenaltyCanKill;
		}
		if(FlxG.save.data.playerLaneUnderlayOpacity != null) {
			playerLaneUnderlayOpacity = FlxG.save.data.playerLaneUnderlayOpacity;
		}
		if(FlxG.save.data.opponentLaneUnderlayOpacity != null) {
			opponentLaneUnderlayOpacity = FlxG.save.data.opponentLaneUnderlayOpacity;
		}
		if(FlxG.save.data.fixedComboSprPos != null) {
			fixedComboSprPos = FlxG.save.data.fixedComboSprPos;
		}
		
		// flixel automatically saves your volume!
		if(FlxG.save.data.volume != null)
		{
			FlxG.sound.volume = FlxG.save.data.volume;
		}
		if (FlxG.save.data.mute != null)
		{
			FlxG.sound.muted = FlxG.save.data.mute;
		}

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'ninjamuffin99');
		if(save != null && save.data.customControls != null) {
			var loadedControls:Map<String, Array<FlxKey>> = save.data.customControls;
			for (control => keys in loadedControls) {
				keyBinds.set(control, keys);
			}
			reloadControls();
		}
	}

	inline public static function getGameplaySetting(name:String, defaultValue:Dynamic):Dynamic {
		return /*PlayState.isStoryMode ? defaultValue : */ (gameplaySettings.exists(name) ? gameplaySettings.get(name) : defaultValue);
	}

	public static function reloadControls() {
		PlayerSettings.player1.controls.setKeyboardScheme(KeyboardScheme.Solo);

		TitleState.muteKeys = copyKey(keyBinds.get('volume_mute'));
		TitleState.volumeDownKeys = copyKey(keyBinds.get('volume_down'));
		TitleState.volumeUpKeys = copyKey(keyBinds.get('volume_up'));
		FlxG.sound.muteKeys = TitleState.muteKeys;
		FlxG.sound.volumeDownKeys = TitleState.volumeDownKeys;
		FlxG.sound.volumeUpKeys = TitleState.volumeUpKeys;
	}
	public static function copyKey(arrayToCopy:Array<FlxKey>):Array<FlxKey> {
		var copiedArray:Array<FlxKey> = arrayToCopy.copy();
		var i:Int = 0;
		var len:Int = copiedArray.length;

		while (i < len) {
			if(copiedArray[i] == NONE) {
				copiedArray.remove(NONE);
				--i;
			}
			i++;
			len = copiedArray.length;
		}
		return copiedArray;
	}
}
