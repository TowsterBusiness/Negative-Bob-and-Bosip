package;

import haxe.macro.Expr.Function;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.geom.Point;

class GallerySubstate extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var border:FlxSprite;

	var fanmadeImage:FlxSprite;
	var officialImage:FlxSprite;

	var fanmadeText:FlxSprite;
	var officialText:FlxSprite;
	
	var xText:FlxSprite;

	var inCat:Int = 0;

	public var officialGallery:FlxTypedGroup<FlxSprite>;
	public var officialPictures:FlxTypedGroup<FlxSprite>;
	public var fanmadeGallery:FlxTypedGroup<FlxSprite>;
	public var fanmadePictures:FlxTypedGroup<FlxSprite>;

	var selectedGallery:FlxTypedGroup<FlxSprite>;
	var selectedPictures:FlxTypedGroup<FlxSprite>;
	var selectedText:FlxSprite;

	var leaveImageButton:FlxSprite;

	var selectedPicture:FlxSprite;

	var selectedMenu:String = 'none';
	var selectedUnlocked:Bool = true;
	var isFanmade:Bool = false;
	var hasTwitter:Bool = false;
	var twitterButton:FlxSprite;

	var fanMadeCaptions:Array<String> = [
		'__SaltySquid',
		'_Maratt',
		'9kbeaniex',
		'9kbeaniex',
		'anikaart_',
		'AshTheWolfYT6',
		'aslan_was_here7',
		'BlueOwl',
		'C0TTON_C4NXY',
		'Carolixe',
		'Coshue',
		'DeltaBuggo',
		'dinomaize',
		'DustSlavery',
		'Erhan_108',
		'Erhan_108',
		'FnfAnne',
		'FnfAnne',
		'FnfAnne',
		'foa_x_poa_o_BD20',
		'Fruit_Sauce',
		'gimdongdong_309',
		'hheu_fnf',
		'hheu_fnf',
		'HopeTatic',
		'iL0VEUKYO_',
		'Impcent',
		'iS2cj_',
		'JAK_SOUL',
		'JcHoTwelve',
		'JcHoTwelve',
		'JcHoTwelve',
		'kaiyaerish',
		'Lemmythekoopa',
		'Liya_rvsessii02',
		'lz_luaazs',
		'lz_luaazs',
		'lz_luaazs',
		'lz_luaazs',
		'lz_luaazs',
		'Lucidlyyyy',
		'Lucidlyyyy',
		'M1ntyChoco',
		'M1ntyChoco',
		'Nic01_Art',
		'NightFallenRose',
		'ReAegis',
		'BobotSimp',
		'BobotSimp',
		'relation_fnf',
		'relation_fnf',
		'RootPunch',
		'Senhar',
		'SP_blanket',
		'SP_blanket',
		'SP_blanket',
		'Sshiusta',
		'supernw095',
		'thatoneartboy',
		'TheGradenses',
		'Vink_fears_twt',
		'vinniieeyy',
		'wamu0mu'
	];

	var selectedLink:String;
	var officialCaptions:Array<String> = [
		'The whole bob gang hanging out in their folder.',
		"The full line-up of Amor's GD based characters.",
		'In The Background Desktop 1: Ash and Cerbera!',
		'In The Background Desktop 2: Bluskys and Minishoey!',
		'The Bob & Bosip Desktop.',
		'In The Background Desktop 3: JGhost and Cerberus!',
		'The Bob Takeover Desktop.',
		'Lineless doodle of Bob and Bosip.',
		'Bob and Bosip, Soft Edition!',
		'all the Bobs together.',
		'Cover Art for Split.',
		'Geometry Dash Icon concepts for the Bob gang.'
	];
	var officialCaptionColors:Array<FlxColor> = [];
	
	
	var fanMadeCaptionColors:Array<FlxColor> = [];

	var captions:Array<String> = [];
	var captionColors:Array<FlxColor> = [];

	var captionBG:FlxSprite;
	var caption:FlxText;

	var galleryText:FlxSprite;
	var sumOfficialText:FlxSprite;
	var sumFanMadeText:FlxSprite;

	var wallpaperButton:FlxSprite;
	var bb:FlxSprite;

	var previousPosition:FlxPoint;
	var closePosition:FlxPoint;

	var isExist:Bool = false;
	
	public var officialImageLocations:Array<String> = [];
	public var fanmadeImageLocations:Array<String> = [];
	var selectedImageLocations:Array<String> = [];
	var selectedLocation:String = '';

	public var updateBackground:Void->Void;

	public function new(s:FlxPoint, bb:FlxSprite)
	{
		this.bb = bb;
		bb.visible = false;
		super();
		var zoom:FlxSprite = new FlxSprite(s.x, s.y).loadGraphic(Paths.image('desktop/gallery/zooom'));
		zoom.origin.set(0, 0);
		zoom.scale.set(0.1, 0.1);
		zoom.alpha = 0;
		add(zoom);
		FlxTween.tween(zoom.scale, {x: 1, y: 1}, 0.3, {ease: FlxEase.cubeOut});
		FlxTween.tween(zoom, {x: 0, y: 0, alpha: 1}, 0.3, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween) {
			remove(zoom);
			closePosition = s;
			trace(closePosition);
			bb.visible = true;
			officialCaptionColors = [
				FlxColor.WHITE,
				FlxColor.BLACK,
				FlxColor.WHITE,
				FlxColor.BLACK,
				FlxColor.WHITE,
				FlxColor.WHITE,
				FlxColor.WHITE,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.WHITE,
				FlxColor.WHITE,
			];

			fanMadeCaptionColors = [
				FlxColor.WHITE,
				FlxColor.BLACK,
				FlxColor.WHITE,
				FlxColor.WHITE,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.WHITE,
				FlxColor.WHITE,
				FlxColor.WHITE,
				FlxColor.WHITE,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.WHITE,
				FlxColor.WHITE,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.WHITE,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.WHITE,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
				FlxColor.BLACK,
			];

			if (!FlxG.save.data.beatITB) {
				if (FlxG.save.data.beatWeek) {
					officialCaptions[2] = 'beat In The Background to unlock!';
					officialCaptions[3] = 'beat In The Background to unlock!';
					officialCaptions[5] = 'beat In The Background to unlock!';
				} else {
					officialCaptions[2] = 'beat ??? to unlock!';
					officialCaptions[3] = 'beat ??? to unlock!';
					officialCaptions[5] = 'beat ??? to unlock!';
				}
				officialCaptionColors[2] = FlxColor.WHITE;
				officialCaptionColors[3] = FlxColor.WHITE;
				officialCaptionColors[5] = FlxColor.WHITE;
			}

			if (!FlxG.save.data.beatBob) {
				if (FlxG.save.data.beatITB)
					officialCaptions[6] = 'beat Bob Takeover to unlock!';
				else
					officialCaptions[6] = 'beat ??? to unlock!';
				officialCaptionColors[6] = FlxColor.WHITE;
			}
		
			officialImage = new FlxSprite(10, 94).loadGraphic(Paths.image('desktop/gallery/officialImage'));
			add(officialImage);
			
			fanmadeImage = new FlxSprite(642, 94).loadGraphic(Paths.image('desktop/gallery/fanmadeImage'));
			add(fanmadeImage);

			officialText = new FlxSprite(165, 323).loadGraphic(Paths.image('desktop/gallery/officialText'));
			add(officialText);

			fanmadeText = new FlxSprite(786, 323).loadGraphic(Paths.image('desktop/gallery/fanmadeText'));
			add(fanmadeText);

			border = new FlxSprite().loadGraphic(Paths.image('desktop/gallery/galleryBorder'));
			add(border);

			xText = new FlxSprite(18, 17).loadGraphic(Paths.image('desktop/gallery/xText'));
			add(xText);
			
			galleryText = new FlxSprite(543, 8).loadGraphic(Paths.image('desktop/gallery/galleryText'));
			add(galleryText);

			sumOfficialText = new FlxSprite(518, 77).loadGraphic(Paths.image('desktop/gallery/sumofficialText'));
			add(sumOfficialText);
			sumOfficialText.alpha = 0;

			sumFanMadeText = new FlxSprite(518, 77).loadGraphic(Paths.image('desktop/gallery/sumfanmadeText'));
			add(sumFanMadeText);
			sumFanMadeText.alpha = 0;

			twitterButton = new FlxSprite(1136, 605).loadGraphic(Paths.image('desktop/gallery/twitterLogo'));
			//add(twitterButton);
			//twitterButton.visible = false;

			isExist = true;
		},});
	}

	function resetPositions() {
		for (i in 0...selectedGallery.length) {
			var spr:FlxSprite = selectedGallery.members[i];
			var image:FlxSprite = selectedPictures.members[i];
			var moduloed:Int = i % 2;
			switch (moduloed) {
				case 0:
					spr.x = 21;
				case 1:
					spr.x = 651;
			}
			spr.y = (Math.floor(i / 2) * 386) + 113;
			image.setPosition(spr.x + 15, spr.y + 13);
			spr.y += FlxG.height;
			image.y += FlxG.height;
		}
	}
	override function update(elapsed:Float)
	{
		super.update(elapsed);
	if (isExist) {
			FlxG.watch.addQuick("CAT: ", inCat);
			FlxG.watch.addQuick("y: ", FlxG.mouse.y);
			if (inCat == 0) {
				if (FlxG.mouse.overlaps(officialImage)) {
					officialImage.color = FlxColor.fromHSL(officialImage.color.hue, officialImage.color.saturation, 1, 1);
					officialText.color = FlxColor.fromHSL(officialText.color.hue, officialText.color.saturation, 1, 1);
				} else {
					officialImage.color = FlxColor.fromHSL(officialImage.color.hue, officialImage.color.saturation, 0.7, 1);
					officialText.color = FlxColor.fromHSL(officialText.color.hue, officialText.color.saturation, 0.7, 1);
				}

				if (FlxG.mouse.overlaps(fanmadeImage)) {
					fanmadeImage.color = FlxColor.fromHSL(fanmadeImage.color.hue, fanmadeImage.color.saturation, 1, 1);
					fanmadeText.color = FlxColor.fromHSL(fanmadeText.color.hue, fanmadeText.color.saturation, 1, 1);
				} else {
					fanmadeImage.color = FlxColor.fromHSL(officialImage.color.hue, officialImage.color.saturation, 0.7, 1);
					fanmadeText.color = FlxColor.fromHSL(fanmadeText.color.hue, fanmadeText.color.saturation, 0.7, 1);
				}

				if (FlxG.mouse.overlaps(xText)) {
					xText.color = FlxColor.fromHSL(officialImage.color.hue, officialImage.color.saturation, 1, 1);
				} else {
					xText.color = FlxColor.fromHSL(officialImage.color.hue, officialImage.color.saturation, 0.7, 1);
				}
				if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(officialImage) || FlxG.mouse.justPressed && FlxG.mouse.overlaps(fanmadeImage)) {
					if (FlxG.mouse.overlaps(officialImage))	{
						selectedGallery = officialGallery;
						selectedPictures = officialPictures;
						selectedText = sumOfficialText;
						captions = officialCaptions;
						captionColors = officialCaptionColors;
						selectedImageLocations = officialImageLocations;
						selectedMenu = 'official';
					}
					if (FlxG.mouse.overlaps(fanmadeImage)) {
						selectedGallery = fanmadeGallery;
						selectedPictures = fanmadePictures;
						selectedText = sumFanMadeText;
						captions = fanMadeCaptions;
						captionColors = fanMadeCaptionColors;
						selectedImageLocations = fanmadeImageLocations;
						selectedMenu = 'fanmade';
					}
					resetPositions();
					inCat = 99;
					isExist = false;
					FlxTween.tween(officialImage, {alpha: 0}, 0.6, {});
					FlxTween.tween(fanmadeImage, {alpha: 0}, 0.6, {});
					FlxTween.tween(officialText, {y: officialText.y + FlxG.height}, 1, {ease: FlxEase.cubeIn});
					FlxTween.tween(fanmadeText, {y: fanmadeText.y + FlxG.height}, 1, {ease: FlxEase.cubeIn, onComplete: function (twn:FlxTween) {
						for (i in 0...selectedGallery.length) {
							selectedGallery.members[i].visible = true;
							selectedPictures.members[i].visible = true;
							FlxTween.tween(selectedGallery.members[i], {y: selectedGallery.members[i].y - FlxG.height}, 1, {ease: FlxEase.cubeOut, onComplete: function (twn:FlxTween) {
								FlxTween.tween(selectedText, {alpha: 1}, 1, {ease: FlxEase.cubeOut});
								inCat = 1;
								officialImage.color = FlxColor.fromHSL(officialImage.color.hue, officialImage.color.saturation, 0.7, 1);
								fanmadeImage.color = FlxColor.fromHSL(officialImage.color.hue, officialImage.color.saturation, 0.7, 1);
								officialText.color = FlxColor.fromHSL(officialText.color.hue, officialText.color.saturation, 0.7, 1);
								fanmadeText.color = FlxColor.fromHSL(fanmadeText.color.hue, fanmadeText.color.saturation, 0.7, 1);
								isExist = true;
							},});
							FlxTween.tween(selectedPictures.members[i], {y: selectedPictures.members[i].y - FlxG.height}, 1, {ease: FlxEase.cubeOut});
						}
					},});
				}
				if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(xText) || FlxG.keys.justPressed.ESCAPE && !FlxG.mouse.justPressed) {
					isExist = false;
					fanmadeText.visible = false;
					officialText.visible = false;
					officialImage.visible = false;
					fanmadeImage.visible = false;
					border.visible = false;
					galleryText.visible = false;
					bb.visible = false;
					xText.visible = false;
					var zoom:FlxSprite = new FlxSprite().loadGraphic(Paths.image('desktop/gallery/zooom'));
					zoom.origin.set(0, 0);
					add(zoom);
					FlxTween.tween(zoom.scale, {x: 0.1, y: 0.1}, 0.3, {ease: FlxEase.cubeOut});
					FlxTween.tween(zoom, {x: closePosition.x, y: closePosition.y, alpha: 0}, 0.3, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween) {
						close();
					},});
				}
			}
			if (inCat == 1) {
				remove(xText);
				xText = new FlxSprite(18, 17).loadGraphic(Paths.image('desktop/gallery/backText'));
				add(xText);
				if (FlxG.mouse.overlaps(xText)) {
					xText.color = FlxColor.fromHSL(officialImage.color.hue, officialImage.color.saturation, 1, 1);
				} else {
					xText.color = FlxColor.fromHSL(officialImage.color.hue, officialImage.color.saturation, 0.7, 1);
				}
				if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(xText) || FlxG.keys.justPressed.ESCAPE && !FlxG.mouse.justPressed) {
					inCat = 99;
					isExist = false;
					for (i in 0...selectedGallery.length) {
						if (selectedGallery.members[i].y < 113) {
							FlxTween.tween(selectedGallery.members[i], {y: selectedGallery.members[i].y - FlxG.height}, 1, {ease: FlxEase.cubeOut});
							FlxTween.tween(selectedPictures.members[i], {y: selectedPictures.members[i].y - FlxG.height}, 1, {ease: FlxEase.cubeOut});
						} else {
							FlxTween.tween(selectedGallery.members[i], {y: selectedGallery.members[i].y + FlxG.height}, 1, {ease: FlxEase.cubeOut, onComplete: function (twn:FlxTween) {
								FlxTween.tween(selectedText, {alpha: 0}, 1, {ease: FlxEase.cubeOut});
								
								FlxTween.tween(officialImage, {alpha: 1}, 0.6, {});
								FlxTween.tween(fanmadeImage, {alpha: 1}, 0.6, {});
								FlxTween.tween(officialText, {y: officialText.y - FlxG.height}, 1, {ease: FlxEase.cubeOut});
								FlxTween.tween(fanmadeText, {y: fanmadeText.y - FlxG.height}, 1, {ease: FlxEase.cubeOut, onComplete: function (twn:FlxTween) {
									inCat = 0;
									remove(xText);
									isExist = true;
									xText = new FlxSprite(18, 17).loadGraphic(Paths.image('desktop/gallery/xText'));
									add(xText);
								},});
							},});
							FlxTween.tween(selectedPictures.members[i], {y: selectedPictures.members[i].y + FlxG.height}, 1, {ease: FlxEase.cubeOut});
						}
					}
					
				}
				if (selectedGallery.members[selectedGallery.length - 1].y >= 347 && FlxG.mouse.wheel < 0) {
					for (i in selectedGallery) {
						i.y += FlxG.mouse.wheel * 36;
					}
				}
				if (selectedGallery.members[0].y <= 113 && FlxG.mouse.wheel > 0) {
					for (i in selectedGallery) {
						i.y += FlxG.mouse.wheel * 36;
					}
				}
				if (FlxG.mouse.wheel != 0) {
					for (i in 0...selectedGallery.length) {
						selectedPictures.members[i].x = selectedGallery.members[i].x + 15;
						selectedPictures.members[i].y = selectedGallery.members[i].y + 13;
						
					}
				}
				for (i in 0...selectedGallery.length) {
					if (FlxG.mouse.overlaps(selectedGallery.members[i]) && FlxG.mouse.y > 93) {
						selectedGallery.members[i].color = FlxColor.fromHSL(selectedGallery.members[i].color.hue, selectedGallery.members[i].color.saturation, 0.5, 1);
						selectedGallery.members[i].scale.set(1.02, 1.02);
						if (FlxG.mouse.justPressed) {
							inCat = 99;
							selectedPicture = selectedPictures.members[i].clone();
							selectedPicture.origin.set(0, 0);
							selectedPicture.setPosition(selectedPictures.members[i].x, selectedPictures.members[i].y);
							selectedPicture.scale.set(0.45, 0.45);
							add(selectedPicture);
							previousPosition = new FlxPoint(selectedPictures.members[i].x, selectedPictures.members[i].y);
							selectedLocation = selectedImageLocations[i];
							
							captionBG = new FlxSprite(0, 612).makeGraphic(1280, 108, FlxColor.BLACK);
							captionBG.visible = false;
							captionBG.alpha = 0.14;
							add(captionBG);

							caption = new FlxText(240, 634, 800, '@' + captions[i], 16, true);
							caption.setFormat(Paths.font('PUSAB.otf'), 16, captionColors[i], CENTER);
							add(caption);
							caption.visible = false;

							
							FlxTween.tween(selectedPicture.scale, {x: 1, y: 1}, 0.6, {ease: FlxEase.cubeOut});
							FlxTween.tween(selectedPicture, {x: 0, y: 0}, 0.6, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween) {
								captionBG.visible = true;
								caption.visible = true;
								if (selectedMenu == 'official') {
									if (i == 2 || i == 3 || i == 5) {
										if (!FlxG.save.data.beatITB) {
											selectedUnlocked = false;
										} else selectedUnlocked = true;
									} else if (i == 6) {
										if (!FlxG.save.data.beatBob) {
											selectedUnlocked = false;
										} else selectedUnlocked = true;
									} else selectedUnlocked = true;
								} else {
									selectedUnlocked = true;
								}
								if (selectedUnlocked) {
									wallpaperButton = new FlxSprite(21, 648).loadGraphic(Paths.image('desktop/gallery/desktopwallpaperButton'));
									wallpaperButton.alpha = 0.6;
									add(wallpaperButton);
								}
								leaveImageButton = new FlxSprite(18, 17).loadGraphic(Paths.image('desktop/gallery/backText'));
								add(leaveImageButton);
								inCat = 2;
								if (selectedMenu == 'fanmade' && fanMadeCaptions[i] != '') {
									selectedLink = 'https://twitter.com/' + fanMadeCaptions[i];
									add(twitterButton);
									hasTwitter = true;
								}
								else {
									hasTwitter = false;
								}
							},});
						}
					} else {
						selectedGallery.members[i].color = FlxColor.fromHSL(selectedGallery.members[i].color.hue, selectedGallery.members[i].color.saturation, 1, 1);
						selectedGallery.members[i].scale.set(1, 1);
					}
				}
			} else if (inCat == 2) {
				//do nothing :D
				if (FlxG.mouse.overlaps(leaveImageButton)) {
					leaveImageButton.color = FlxColor.fromHSL(leaveImageButton.color.hue, leaveImageButton.color.saturation, 1, 1);
				} else {
					leaveImageButton.color = FlxColor.fromHSL(leaveImageButton.color.hue, leaveImageButton.color.saturation, 0.7, 1);
				}

				if (selectedUnlocked) {
					if (FlxG.mouse.overlaps(wallpaperButton)) {
						wallpaperButton.alpha = 1;
						if (FlxG.mouse.justPressed) {
							FlxG.save.data.wallpaper = selectedLocation;
							FlxG.save.data.wallpaperTextColor = caption.color;
							updateBackground();
						}
						if (FlxG.mouse.pressed) {
							wallpaperButton.scale.set(0.95, 0.95);
						} else {
							wallpaperButton.scale.set(1, 1);
						}
					} else {
						wallpaperButton.alpha = 0.6;
					}
				}
				if (hasTwitter) {
					if (FlxG.mouse.overlaps(twitterButton)) {
						twitterButton.color = FlxColor.fromHSL(twitterButton.color.hue, twitterButton.color.saturation, 1, 1);
						if (FlxG.mouse.justPressed) {
							#if linux
								Sys.command('/usr/bin/xdg-open', [selectedLink, "&"]);
							#else
								FlxG.openURL(selectedLink);
							#end
						}
					} else {
						twitterButton.color = FlxColor.fromHSL(twitterButton.color.hue, twitterButton.color.saturation, 0.7, 1);
					}
				}
				if (FlxG.keys.justPressed.ESCAPE && !FlxG.mouse.justPressed || FlxG.mouse.overlaps(leaveImageButton) && FlxG.mouse.justPressed) {
					inCat = 99;
					remove(captionBG);
					remove(caption);
					remove(leaveImageButton);
					remove(twitterButton);
					if (selectedUnlocked)
						remove(wallpaperButton);
					FlxTween.tween(selectedPicture.scale, {x: 0.45, y: 0.45}, 0.6, {ease: FlxEase.cubeOut});
					FlxTween.tween(selectedPicture, {x: previousPosition.x, y: previousPosition.y}, 0.6, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween) {
						inCat = 1;
						remove(selectedPicture);
					},});
				}
			}
			}
	}
}
