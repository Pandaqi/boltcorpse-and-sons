# MINI JAME GAM 33


Theme: Behind You
Special Object: Glasses

## General Idea

Congratulations! You've just become a new employee at **Boltcorpse & Sons**. 

As we all know, vengeful ghosts are everywhere, trying to break into the palace now that they have no physical body anymore. Now it's your job to **defend against that!**

Unfortunately, though, our resources are limited. You can only look to one side at a time (left or right), and only wear one pair of glasses to spot and destroy specific ghosts. Defend the palace! Or, well, just survive as long as you can. Those glasses were expensive.

## Inspiration

Recently, I've read a few novels from the _Lockwood & Co_ series. That's probably why this idea of fighting off ghosts with certain properties was my very first assumption when reading the theme. That's also why the game is called _Boltcorpse & Sons_ ;)

I was also inspired by the _Weeping Angels_ from Doctor Who. Those are evil spirits that only move when you're _not looking_. In other words, they're a statue when in front of you, but when behind you ...

## Objective

Survive for as long as possible. Over time, the number of ghosts and their strength/complexity increases. When hit by a ghost, you lose a life _and_ it might trigger a special curse (such as randomizing the order of your glasses).

## Controls

Singleplayer. 
* Use **Left/Right** to change the way you look.
* Use **number keys** (or **Up/Down**) to toggle the glasses you're wearing.

## Gameplay

You only see one side of the game at a time. Ghosts spawn on either side.

* If the ghost is within _range_ of the goggle ...
* And it is _weak_ against it ...
* Its health bar depletes every frame.
* If empty, the ghost evaporates.
* If it hits you before that moment, you lose a life + the ghost might have a special curse for you.

## QUESTIONS

* How do you get new goggles?
  * Probably just by _seeing them_ for long enough, to neatly re-use the same mechanics everywhere.
  * **Or, new Glasses simply appear automatically when a new ghost arrives that needs them** => you start with two glasses, the rest comes automatically
* How do you know what does what?
  * New ghosts are introduced spaced out. When that happens, the game temporarily pauses and displays its tutorial.
  * You can pause the game yourself and look back at all ghosts unlocked? Or their tutorial stays on the screen (at the top, minified)?


## Possible Ghosts





## CRUCIAL TODO

Bring back the Config in some form => probably the resource again, does feel most useful

VISUAL STYLE:
* Very cartoony, flat, simple
* But with this "grunge, starry sky" texture thrown over everything (see reference image)

Graphics
* Player
* Glasses
* Life
* Ghost types
* Some tiled background or map or something
* _Proper light sprite that shows at least most of the map_

Glasses:
* Figure out the different things they can do.
* AT ITS CORE, the glasses are a simple pairing => "This ghost is weak against glasses X and Y, so you need one of those"
* Some are simply more powerful, make ghosts slower, etcetera
* (Also modulate the lighting color/shape based on the glasses! Especially SHAPE should be awesome => the "square" glasses have a square shape, then a triangle, then a circle, then one with holes, etcetera.)

Ghosts
* Actual health bars and being able to remove them
* Display their "weak against"-glasses clearly on their body
* Create the different types + their tutorials
* Figure out the best way to create entirely different movement => just create _scripts_ that extend from GhostMovementData, which can do anything they please for movement
  * Only move if (not) watching
  * Move in _jumps_
  * Speed up/Slow down over time
  * Only move if weak glasses watching
  * Go forward-backward-forward-backward
* Scale their numbers based on Progression => When a certain threshold is reached, unlock the next ghost

UI:
* Nice tweens when lives are added/removed
* Clear button hints + what's currently focused on/highlighted in glasses
* At game start, display the keys needed in space to left and right of player
* The number keys for glasses are also displayed + you can _click_ them to switch?

SoundFX:
* Creepy soundtrack
* Losing a life
* Getting hit
* Switching side (like a flashlight switching on/off?)
* Changing glasses
* (Movement of ghosts?)


## OPTIONAL TODO

Game Loop:
* (Create main menu? Pause menu?)

Devlog => mention that I wanted to continue my challenge of using custom resources in Godot, now by making them _behavior defining_ such as giving ghosts completely different movement by just slotting them in