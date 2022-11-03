package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.graphics.FlxGraphic;
import WeekData;

using StringTools;

class StoryMenuState extends MusicBeatState
{
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();

	public var balls:Bool = true;
	
	private static var lastDifficultyName:String = '';
	var curDifficulty:Int = 1;

	var bgSprite:FlxSprite;

	private static var curWeek:Int = 0;

	var grpWeekText:FlxTypedGroup<MenuItem>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var storySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftUpArrow:FlxSprite;
	var leftDownArrow:FlxSprite;
	var rightUpArrow:FlxSprite;
	var rightDownArrow:FlxSprite;

	var loadedWeeks:Array<WeekData> = [];

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);
		if(curWeek >= WeekData.weeksList.length) curWeek = 0;
		persistentUpdate = persistentDraw = true;

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		bgSprite = new FlxSprite(0, 0);
		bgSprite.antialiasing = ClientPrefs.globalAntialiasing;

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		add(blackBarThingie);

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		var num:Int = 0;
		for (i in 0...WeekData.weeksList.length) {
			var weekFile:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var isLocked:Bool = weekIsLocked(WeekData.weeksList[i]);
			if(!isLocked || !weekFile.hiddenUntilUnlocked) {
				loadedWeeks.push(weekFile);
				WeekData.setDirectoryFromWeek(weekFile);
				var weekThing:MenuItem = new MenuItem(0, 0, WeekData.weeksList[i]);
				weekThing.y += ((weekThing.height + 20) * num);
				weekThing.targetY = num;
				grpWeekText.add(weekThing);

				weekThing.screenCenter();
				weekThing.x -= 450;
				weekThing.antialiasing = ClientPrefs.globalAntialiasing;
				
				if (isLocked) {
					var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
					lock.frames = ui_tex;
					lock.animation.addByPrefix('lock', 'lock');
					lock.animation.play('lock');
					lock.ID = i;
					lock.antialiasing = ClientPrefs.globalAntialiasing;
					grpLocks.add(lock);
				}
				num++;
			}
		}

		WeekData.setDirectoryFromWeek(loadedWeeks[0]);

		storySelectors = new FlxGroup();
		add(storySelectors);

		leftUpArrow = new FlxSprite(150, 75);
		leftUpArrow.frames = ui_tex;
		leftUpArrow.animation.addByPrefix('idle', "arrow left");
		leftUpArrow.animation.addByPrefix('press', "arrow push left");
		leftUpArrow.animation.play('idle');
		leftUpArrow.antialiasing = ClientPrefs.globalAntialiasing;
		storySelectors.add(leftUpArrow);

		leftDownArrow = new FlxSprite(leftUpArrow.x, leftUpArrow.y + 520);
		leftDownArrow.frames = ui_tex;
		leftDownArrow.animation.addByPrefix('idle', 'arrow right');
		leftDownArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		leftDownArrow.animation.play('idle');
		leftDownArrow.antialiasing = ClientPrefs.globalAntialiasing;
		storySelectors.add(leftDownArrow);

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}		
		rightUpArrow = new FlxSprite(leftUpArrow.x + 900, 75);
		rightUpArrow.frames = ui_tex;
		rightUpArrow.animation.addByPrefix('idle', "arrow left");
		rightUpArrow.animation.addByPrefix('press', "arrow push left");
		rightUpArrow.animation.play('idle');
		rightUpArrow.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(rightUpArrow);

		rightDownArrow = new FlxSprite(rightUpArrow.x, rightUpArrow.y + 520);
		rightDownArrow.frames = ui_tex;
		rightDownArrow.animation.addByPrefix('idle', 'arrow right');
		rightDownArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightDownArrow.animation.play('idle');
		rightDownArrow.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(rightDownArrow);

		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		sprDifficulty = new FlxSprite(0, rightUpArrow.y);
		sprDifficulty.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(sprDifficulty);

		add(bgSprite);

		changeWeek();
		changeDifficulty();

		super.create();
	}

	override function closeSubState() {
		persistentUpdate = true;
		changeWeek();
		super.closeSubState();
	}

	override function update(elapsed:Float) {
		if (!movedBack && !selectedWeek) {
			if (!balls) {
				leftUpArrow.alpha = 0.5;
				leftDownArrow.alpha = 0.5;

				rightDownArrow.alpha = 1;
				rightUpArrow.alpha = 1;
			} else {
				leftUpArrow.alpha = 1;
				leftDownArrow.alpha = 1;

				rightDownArrow.alpha = 0.5;
				rightUpArrow.alpha = 0.5;
			}
			var upP = controls.UI_UP_P;
			var downP = controls.UI_DOWN_P;
			if (upP) {
				if (balls) {
					changeWeek(-1);
					FlxG.sound.play(Paths.sound('scrollMenu'));
				} else changeDifficulty(-1);
			}

			if (downP) {
				if (balls) {
					changeWeek(1);
					FlxG.sound.play(Paths.sound('scrollMenu'));
				} else changeDifficulty(1);
			}

			if (controls.UI_RIGHT_P || controls.UI_LEFT_P) {
				balls = !balls;
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if(controls.RESET) {
				persistentUpdate = false;
				openSubState(new ResetScoreSubState('', curDifficulty, '', curWeek));
			}
			
			if (controls.ACCEPT)
				selectWeek();
		}

		if (controls.BACK && !movedBack && !selectedWeek) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			MusicBeatState.switchState(new MainMenuState());
		}

		super.update(elapsed);

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
			lock.visible = (lock.y > FlxG.height / 2);
		});
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek() {
		if (!weekIsLocked(loadedWeeks[curWeek].fileName)) {
			if (stopspamming == false) {
				FlxG.sound.play(Paths.sound('confirmMenu'));

				grpWeekText.members[curWeek].startFlashing();

				stopspamming = true;
			}

			// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}

			// Nevermind that's stupid lmao
			PlayState.storyPlaylist = songArray;
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
			if(diffic == null) diffic = '';

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.campaignScore = 0;
			PlayState.campaignMisses = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
				FreeplayState.destroyFreeplayVocals();
			});
		} else
			FlxG.sound.play(Paths.sound('cancelMenu'));
	}

	var tweenDifficulty:FlxTween;
	function changeDifficulty(change:Int = 0):Void {
		curDifficulty += change;

		if (curDifficulty < 0) curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length) curDifficulty = 0;

		WeekData.setDirectoryFromWeek(loadedWeeks[curWeek]);

		var diff:String = CoolUtil.difficulties[curDifficulty];
		var newImage:FlxGraphic = Paths.image('menudifficulties/' + Paths.formatToSongPath(diff));

		if(sprDifficulty.graphic != newImage)
		{
			sprDifficulty.loadGraphic(newImage);
			sprDifficulty.x = leftUpArrow.x + 60;
			sprDifficulty.x += (308 - sprDifficulty.width) / 3;
			sprDifficulty.alpha = 0;
			sprDifficulty.y = leftUpArrow.y - 15;

			if(tweenDifficulty != null) tweenDifficulty.cancel();
			tweenDifficulty = FlxTween.tween(sprDifficulty, {y: leftUpArrow.y + 15, alpha: 1}, 0.07, {onComplete: function(twn:FlxTween)
			{
				tweenDifficulty = null;
			}});
		}
		lastDifficultyName = diff;
	}

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= loadedWeeks.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = loadedWeeks.length - 1;

		var leWeek:WeekData = loadedWeeks[curWeek];
		WeekData.setDirectoryFromWeek(leWeek);

		var bullShit:Int = 0;

		var unlocked:Bool = !weekIsLocked(leWeek.fileName);
		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && unlocked)
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		bgSprite.visible = true;
		var assetName:String = leWeek.weekBackground;
		if(assetName == null || assetName.length < 1) {
			bgSprite.visible = false;
		} else {
			bgSprite.loadGraphic(Paths.image('menubackgrounds/menu_' + assetName));
		}
		PlayState.storyWeek = curWeek;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5
		difficultySelectors.visible = unlocked;

		if(diffStr != null && diffStr.length > 0) {
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
				CoolUtil.difficulties = diffs;
		}
		
		if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		else
			curDifficulty = 0;

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
			curDifficulty = newPos;

		updateText();
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}

	function updateText() {
		var leWeek:WeekData = loadedWeeks[curWeek];
		var stringThing:Array<String> = [];
		for (i in 0...leWeek.songs.length) {
			stringThing.push(leWeek.songs[i][0]);
		}
	}
}