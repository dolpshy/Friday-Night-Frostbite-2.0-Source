package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import lime.utils.Assets;

using StringTools;

class CreditsFrostState extends MusicBeatState {
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var descBox:AttachedSprite;

	var offsetThing:Float = -75;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		add(bg);
		bg.screenCenter();
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		//REAL
		var FrostCreditsReal:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['Xarbros', 'spetrorecter', 'Director, Artist', 'https://www.youtube.com/channel/UCepuPlRZnRp7eExtkozDDgA', '082173'],
			['Floffelo', 'floffelo', 'Charter, Chromatic for Frostbite (FS), Programmer', 'https://www.youtube.com/channel/UCMZy4stSxj3OjWlT0efDSWA', 'C16BFF'],
			['Liric54', 'liric', 'Musician, Charter', 'https://twitter.com/liric54', 'FFE28C'],
			['AD3.', 'ad3', 'Musician, Charter, Chromatics for many Characters from the Mod', 'https://twitter.com/alejandrougames', 'C16BFF'],
			['Spamtune', 'spammy', 'Musician, Artist', 'https://www.youtube.com/channel/UC2LQpSD96z0naJH-JoBSaxA', 'FFFFFF'],
			['CharaWhy', 'chara', 'Musician', 'https://www.youtube.com/channel/UCiEUXX_YWxVevGxSRYCM5Cw', '930FFF'],
			['Nesquik', 'nesquik', 'Musician', 'https://www.youtube.com/channel/UCrURywBu-fDA5KQaDPc3GOg', 'FF0A2A'],
			['ShredBoi', 'shred', "Musician", 'https://www.youtube.com/channel/UCcPW37b_Gb_j0CG3U1B89YQ', '808080'],
			['Ray', 'ray', 'Musician, Artist, Professional Furry', 'https://www.youtube.com/channel/UCsoHljPC3gBqVTmTpkS8rYg', 'C16BFF'],
			['Azaria', 'azaria', 'Musician', 'https://www.youtube.com/channel/UC5jj1CMTlCXFMlkwy_JYEyA/videos', '5751FF'],
			['Korv', 'korv', 'Musician', 'https://www.youtube.com/channel/UCtFPl-mDVoINooCR-KMySBw', 'FF0A2A'],
			['JPR', 'jpr', "Musician", 'https://www.youtube.com/channel/UCW4ISpzbmHPh97JN87Xsq_w', '7F3300'],
			['Shyllis', 'reel', 'Coder, Musician, Charter', 'https://shyllis.carrd.co/', 'FF3852'],
			['Fox', 'FOX', 'Musician, Artist, Voice Actor for Frostbite, Blaze and many more!', 'https://www.youtube.com/channel/UCHr0p_VPdEiaMmvTndXVt1Q', '3FC5FF'],
			['Osward', 'osward', 'Artist', 'https://www.youtube.com/channel/UCufHUTDGvLgK1fcjEW94EeA', '808080'],
			['Stamp', 'stamp', 'Musician, Artist', 'https://www.youtube.com/channel/UCDilkyn-MId2_HKiwqBcDHg', 'FFA042'],
			['Kayne', 'kayne', 'Artist', 'https://twitter.com/Kayne4481', 'FFFD87'],
			['TeapotMann', 'teapot', 'Artist', 'https://twitter.com/TeapotMann', 'FF3852'],
			['Volcatic', 'volcatic', 'Artist', 'https://volcatic.carrd.co/', '7F3300'],
			['Wave728', 'wave', 'Artist', 'https://mobile.twitter.com/therealwave728', '7F3300'],
			['Milo', 'milo', 'Artist', 'https://mmccrafter.carrd.co/', 'F52A2A'],
			['CherryCY', 'cherry', "Musician", 'https://cherrycy82.carrd.co/', 'FF3852']
		];
		
		// POG
		for(i in FrostCreditsReal){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			optionText.yAdd -= 70;
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
		}
		
		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float) {
		if (FlxG.sound.music.volume < 0.7)
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

		if(!quitting) {
			if(creditsStuff.length > 1) {
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_UP_P;
				var downP = controls.UI_DOWN_P;

				if (upP) {
					changeSelection(-1 * shiftMult);
					holdTime = 0;
				}
				if (downP) {
					changeSelection(1 * shiftMult);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP) {
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
				}
			}

			if(controls.ACCEPT && (creditsStuff[curSelected][3] == null || creditsStuff[curSelected][3].length > 4))
				CoolUtil.browserLoad(creditsStuff[curSelected][3]);
			if (controls.BACK) {
				if(colorTween != null)
					colorTween.cancel();
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new CreditsSelectState());
				quitting = true;
			}
		}
		
		for (item in grpOptions.members) {
			if(!item.isBold) {
				var lerpVal:Float = CoolUtil.boundTo(elapsed * 12, 0, 1);
				if(item.targetY == 0) {
					var lastX:Float = item.x;
					item.screenCenter(X);
					item.x = FlxMath.lerp(lastX, item.x - 70, lerpVal);
					item.forceX = item.x;
				} else {
					item.x = FlxMath.lerp(item.x, 200 + -40 * Math.abs(item.targetY), lerpVal);
					item.forceX = item.x;
				}
			}
		}
		super.update(elapsed);
	}

	var moveTween:FlxTween = null;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null)
				colorTween.cancel();
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}

		descText.text = creditsStuff[curSelected][2];
		descText.y = FlxG.height - descText.height + offsetThing - 60;

		if(moveTween != null) moveTween.cancel();
		moveTween = FlxTween.tween(descText, {y : descText.y + 75}, 0.25, {ease: FlxEase.sineOut});

		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();
	}

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}