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


## STRETCH GOALS

@IDEA: Get powerups/new glasses/something more _proactively_?
* Probably just by _seeing them_ for long enough, to neatly re-use the same mechanics everywhere. => **This is actually really promising, but I don't have time to put it into the game now.**
* (Or have one-time goggles that, when selected, will instantly trigger whatever they do and then disappear from your inventory.)


POSSIBLE TWEAKS:
* The starting glasses are pretty powerful now. Slightly reduce their range of kill (and maybe sight)?
* When determining ghost and glasses order, don't be completely random. Leave those with a higher value ( = harder) for _later_? (Should work, but I haven't actually assigned values to glasses and ghosts currently.)

MORE SPIRIT HELP OPTIONS:
* Get an extra life
* Get more points?
* Range grows faster (when you stay in view)
* Bigger likelihood of ghosts being weak to more glasses
* Something to do with glasses? (Get an extra glasses now? Get an extra ghost now?)


Juice:
* Give the player some idle animation or something?
* Actually animate the ghosts (as they move/crawl/whatever)

Core Gameplay:
* Those special effects/curses of ghosts?

Devlog => 
* Mention that I wanted to continue my challenge of using custom resources in Godot, now by making them _behavior defining_ such as giving ghosts completely different movement by just slotting them in.
* Mention using a scaling factor in config for all resources, so I can easily play around with values even after defining all ghosts/glasses/whatever




## Ghosts

### [x] Regular (0)

* Movement: Floaty
* Health/Attack/Shield/Speed: Regular

### [x] Speedy (1)

* Movement: Floaty
* Speed++
* Health--

### [x] Turtle (2)

* Movement: Floaty
* Speed--
* Health++
* Shield+
* SelfLight: false

### [x] Jumper (3)

* Movement: Jump (sits still, suddenly jumps a gap, sits still again)

### [x] Dancer (4)

* Movement: back-and-forth
* Speed+
* Shield+

### [x] Weeping Angel (5)

* Movement: Only moves when you're not looking. (Regardless of glasses you're wearing.)
* Speed+
* Health-
* SelfLight: false

### [x] Monster (6)

* Movement: Floaty
* Speed-
* Shield+
* Special: Takes away 2 lives on impact

### [x] Racer (7)

* Movement: Changes over time (speed-up)

### [x] Sleepwalker (8)

* Movement: Changes over time (slow-down)
* SelfLight: false

### [x] Einzelganger (9)

* Movement: only moves if no other ghosts are close
* Speed++



## Glasses

### Circle

Starter, everything default/middle road

### Triangle

* Damage++
* Sight Range--

### Square

* Damage--
* Kill Range++

### Wavy

* Speeds up (all) ghosts
* Damage+
* Kill Range+
* Sight Range+

### Holes

* Ignores Ghost Shields
* Damage-
* Kill Range-
* Sight Range+

### Inverted

* Slows down (all) ghosts
* Ghosts only take 1 life at most
* Kill Range--