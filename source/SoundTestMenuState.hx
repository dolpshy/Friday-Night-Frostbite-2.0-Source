package;

import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

#if windows
import Discord.DiscordClient;
#end

class SoundTestMenuState extends MusicBeatState
{
	var whiteshit:FlxSprite;

	var firstValue:Int = 0;
	var secondValue:Int = 0;

	var soundCooldown:Bool = true;

	var thej:Bool = true;

	var firstnum = new FlxText(FlxG.width / 6, FlxG.height / 2, 0, 'Num. 1', 23);
	var secondnum = new FlxText(FlxG.width * .6, FlxG.height / 2, 0, 'Num. 2', 23);

	var first_NUMBER = new FlxText(FlxG.width / 6, FlxG.height / 2, 0, '0', 23);
	var second_NUMBER = new FlxText(FlxG.width / 6, FlxG.height / 2, 0, '0', 23);

    override function create()
        {
			DiscordClient.changePresence('Writing codes', null);
		
			whiteshit = new FlxSprite().makeGraphic(1280, 720, FlxColor.WHITE);
			whiteshit.alpha = 0;

			var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('menuBGMagenta'));
			bg.scrollFactor.x = 0;
			bg.scrollFactor.y = 0;
			bg.setGraphicSize(Std.int(bg.width * 1));
			bg.updateHitbox();
			bg.screenCenter();
			bg.antialiasing = true;
			add(bg);

			var codestext = new FlxText(0, 0, 0, 'The Codes', 25);
			codestext.screenCenter();
			codestext.y -= 180;
			codestext.x -= 33;
			codestext.setFormat(Paths.font("pixel.otf"), 25, FlxColor.fromRGB(102, 157, 196));
			codestext.setBorderStyle(SHADOW, FlxColor.BLACK, 4, 1);
			add(codestext);
		
			firstnum.setFormat(Paths.font("pixel.otf"), 23, FlxColor.fromRGB(102, 157, 196));
			firstnum.setBorderStyle(SHADOW, FlxColor.BLACK, 4, 1);
			firstnum.y -= 70;
			firstnum.x += 120;

			secondnum.setFormat(Paths.font("pixel.otf"), 23, FlxColor.fromRGB(102, 157, 196));
			secondnum.setBorderStyle(SHADOW, FlxColor.BLACK, 4, 1);
			secondnum.y -= 70;
			
			add(firstnum);
			add(secondnum);

			first_NUMBER.y -= 70;
			first_NUMBER.x += 290;
			first_NUMBER.setFormat(Paths.font("pixel.otf"), 23, FlxColor.fromRGB(102, 157, 196));
			first_NUMBER.setBorderStyle(SHADOW, FlxColor.BLACK, 4, 1);
			add(first_NUMBER);

			second_NUMBER.y -= 70;
			second_NUMBER.x += secondnum.x - 70;
			second_NUMBER.setFormat(Paths.font("pixel.otf"), 23, FlxColor.fromRGB(102, 157, 196));
			second_NUMBER.setBorderStyle(SHADOW, FlxColor.BLACK, 4, 1);
			add(second_NUMBER);

			add(whiteshit);
        }

	function changeNumber(selection:Int) {
		if (thej) {
			firstValue += selection;
			if (firstValue < 0) firstValue = 91;
			if (firstValue > 91) firstValue = 0;
		} else {
			secondValue += selection;
			if (secondValue < 0) secondValue = 91;
			if (secondValue > 91) secondValue = 0;
		}
	}

	function flashshit(good:Bool) {
		if (good == true) {
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
		} else {
			FlxTween.color(whiteshit, 0.1, FlxColor.WHITE, FlxColor.BLUE);
			FlxTween.tween(whiteshit, {alpha: 0}, 0.3);
		}
	}

	function doTheThing(first:Int, second:Int) 
	{
		if (first == 38 && second == 29) {
			PlayState.SONG = Song.loadFromJson('edible-delicious', 'Edible');
			PlayState.isCodes = true;
			PlayState.storyDifficulty = 5;
			flashshit(true);
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			});
        } else if (first == 88 && second == 91) {
			PlayState.SONG = Song.loadFromJson('avalanche-corrupted', 'Avalanche');
			PlayState.isCodes = true;
			PlayState.storyDifficulty = 6;
			flashshit(true);
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			});
        } else if (first == 43 && second == 72) {
			PlayState.SONG = Song.loadFromJson('warfare-violence', 'Warfare');
			PlayState.isCodes = true;
			PlayState.storyDifficulty = 7;
			flashshit(true);
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			});
        } else if (first == 69 && second == 69) {
			PlayState.SONG = Song.loadFromJson('top-10-moments-hard', 'Top-10-Moments');
			PlayState.isCodes = true;
			PlayState.storyDifficulty = 2;
			flashshit(true);
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			});
        } else if (first == 18 && second == 27) {
			PlayState.SONG = Song.loadFromJson('can_t-break-free-chained', "Can't-Break-Free");
			PlayState.isCodes = true;
			PlayState.storyDifficulty = 8;
			flashshit(true);
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			});
        } else if (first == 52 && second == 73) {
			PlayState.SONG = Song.loadFromJson('aiden-rematch', 'Aiden');
			PlayState.isCodes = true;
			PlayState.storyDifficulty = 9;
			flashshit(true);
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			});
        } else if (first == 12 && second == 12) {
			PlayState.SONG = Song.loadFromJson('frozen-system-hard', 'Frozen-System');
			PlayState.isCodes = true;
			PlayState.storyDifficulty = 2;
			flashshit(true);
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			});
        } else {
			if (soundCooldown) {
				soundCooldown = false;
				FlxG.sound.play(Paths.sound('denied'));
				new FlxTimer().start(0.8, function(tmr:FlxTimer) {
					soundCooldown = true;
				});
			}
        }
	}
		
	override public function update(elapsed:Float)
		{
			if (controls.UI_LEFT_P || controls.UI_RIGHT_P) thej = !thej;

			if (controls.UI_DOWN_P) changeNumber(1);

			if (controls.UI_UP_P) changeNumber(-1);

			if (controls.ACCEPT) doTheThing(firstValue, secondValue);

			if (controls.BACK) MusicBeatState.switchState(new MainMenuState());

			if (thej) {
				firstnum.setFormat(Paths.font("pixel.otf"), 23, FlxColor.fromRGB(52, 134, 235));
				firstnum.setBorderStyle(SHADOW, FlxColor.fromRGB(16, 37, 71), 4, 1);
				secondnum.setFormat(Paths.font("pixel.otf"), 23, FlxColor.fromRGB(102, 157, 196));
				secondnum.setBorderStyle(SHADOW, FlxColor.BLACK, 4, 1);
			} else {
				firstnum.setFormat(Paths.font("pixel.otf"), 23, FlxColor.fromRGB(102, 157, 196));
				firstnum.setBorderStyle(SHADOW, FlxColor.BLACK, 4, 1);
				secondnum.setFormat(Paths.font("pixel.otf"), 23, FlxColor.fromRGB(52, 134, 235));
				secondnum.setBorderStyle(SHADOW, FlxColor.fromRGB(16, 37, 71), 4, 1);
			}

			if (firstValue < 10) first_NUMBER.text = '0' + Std.string(firstValue);
			else first_NUMBER.text = Std.string(firstValue);
			if (secondValue < 10) second_NUMBER.text = '0' + Std.string(secondValue);
			else second_NUMBER.text = Std.string(secondValue);

			super.update(elapsed);
		}
}