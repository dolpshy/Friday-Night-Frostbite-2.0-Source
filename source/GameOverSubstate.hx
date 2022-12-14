package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import Achievements;

class GameOverSubstate extends MusicBeatSubstate
{
	//funnies
	public var deathQuotes:Array<String> = [
    	"Skill Issue",
    	"Oof...",
    	"Fun Fact: You like men",
    	"You suck bruh",
    	"Please deposit 5 coins",
    	"Balls",
    	"192.86.123.23",
    	"Hi Youtube!",
    	"No way!!!",
		"Let me guess. Lag?",
		"Step it up butterfingers!",
		"Game Over!",
		"Insert game over quote here",
    	"Watch an Ad to continue!", 
    	"I have 69,001 bodies in my basement",
    	"Not Bad!"
	];
	public var quoteText:FlxText;

	public var sex:Float = ClientPrefs.sex;
	public var boyfriend:Boyfriend;
	var camFollow:FlxPoint;
	private var camAchievement:FlxCamera;
	var camFollowPos:FlxObject;
	var updateCamera:Bool = false;
	var playingDeathSound:Bool = false;

	var stageSuffix:String = "";

	public static var characterName:String = 'bf-dead';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'gameOver';
	public static var endSoundName:String = 'gameOverEnd';

	public static var instance:GameOverSubstate;

	public static function resetVariables() {
		characterName = 'bf-dead';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';
	}

	override function create()
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);

		super.create();
	}

	public function new(x:Float, y:Float, camX:Float, camY:Float)
	{
		super();
		
		FlxG.camera.bgColor = 0xFF000000;

		var curSong:String = PlayState.SONG.song;

		var huh:Int = FlxG.random.int(0, 15);
		quoteText = new FlxText(0, 0, 625, '', 40);
		quoteText.setFormat(Paths.font("SansUndertale.ttf"), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		quoteText.text = deathQuotes[huh];

		FlxTween.tween(quoteText, {alpha: 0}, 0.1);

		Conductor.songPosition = 0;

		boyfriend = new Boyfriend(x, y, characterName);
		boyfriend.x += boyfriend.positionArray[0];
		boyfriend.y += boyfriend.positionArray[1];
		if (PlayState.isStoryMode) {
			var week:String = WeekData.getCurrentWeek().weekName;
			if (week == 'The Interesting Sussy Sussy')
				boyfriend.visible = false;
		}
		if (curSong == 'Frozen System' && curSong == 'Frozen System')
			boyfriend.visible = false;
		add(boyfriend);

		camFollow = new FlxPoint(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);

		quoteText.y = camFollow.y;
		quoteText.y += 100;
		quoteText.screenCenter(X);

		FlxG.sound.play(Paths.sound(deathSoundName));
		Conductor.changeBPM(100);
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		boyfriend.playAnim('firstDeath');

		camFollowPos = new FlxObject(0, 0, 1, 1);
		camFollowPos.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxG.camera.scroll.y + (FlxG.camera.height / 2));
		add(camFollowPos);
		
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;
		FlxG.cameras.add(camAchievement);

		quoteText.cameras = [camAchievement];

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var achieveID:Int = Achievements.getAchievementIndex('skill_issue');
		if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { 
			Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
			giveAchievement();
			sex = sex + 1;
			ClientPrefs.sex = sex;
			ClientPrefs.saveSettings();
		}
		#end
	}

	var isFollowingAlready:Bool = false;

	#if ACHIEVEMENTS_ALLOWED
	//skill issue achievement
	function giveAchievement() {
		add(new AchievementObject('skill_issue', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
	}
	#end

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);
		if(updateCamera) {
			var lerpVal:Float = CoolUtil.boundTo(elapsed * 0.6, 0, 1);
			camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
		}

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;

			WeekData.loadTheFirstEnabledMod();
			if (PlayState.isStoryMode) {
				MusicBeatState.switchState(new StoryMenuState());
				PlayState.isStoryMode = false;
			} else if (PlayState.isCodes) {
				MusicBeatState.switchState(new SoundTestMenuState());
				PlayState.isCodes = false;
			} else
				MusicBeatState.switchState(new FreeplayState());

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
		}

		if (boyfriend.animation.curAnim.name == 'firstDeath')
		{
			if(boyfriend.animation.curAnim.curFrame >= 12 && !isFollowingAlready)
			{
				FlxG.camera.follow(camFollowPos, LOCKON, 1);
				updateCamera = true;
				isFollowingAlready = true;
			}

			if (boyfriend.animation.curAnim.finished && !playingDeathSound)
			{
				coolStartDeath();
				
				boyfriend.startedDeath = true;
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		PlayState.instance.callOnLuas('onUpdatePost', [elapsed]);
	}

	override function beatHit()
	{
		super.beatHit();

		//FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void
	{
		if(ClientPrefs.funnitext) add(quoteText);
		FlxTween.tween(quoteText, {alpha: 1}, 0.2, {ease: FlxEase.sineOut});
		FlxG.sound.playMusic(Paths.music(loopSoundName), volume);
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			FlxTween.tween(quoteText, {alpha: 0}, 1.5, {ease: FlxEase.sineOut});
			isEnding = true;
			boyfriend.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music(endSoundName));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					MusicBeatState.resetState();
				});
			});
			PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
		}
	}
}
