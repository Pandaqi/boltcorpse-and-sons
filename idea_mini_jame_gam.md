# MINI JAME GAM 33

## Future To-Do

@FEEDBACK:
* Green glasses too OP for one---too slow and unusable for another :p (PERFECTLY BALANCED, AS ALL THINGS SHOULD BE!)
* Pink glasses hard to work with, especially ghosts coming from above/below
* Use mouse to allow rotation of the flashlight up/down => good idea, I needed something about the lack of sight top/bottom anyway
  * This is just a general "use the mouse" (without clicking) to watch left/right automatically

@IDEA: Get powerups/new glasses/something more _proactively_?
* Probably just by _seeing them_ for long enough, to neatly re-use the same mechanics everywhere. => **This is actually really promising, but I don't have time to put it into the game now.**
  * THis might also help clarify/specifically explain that ghosts only respond to specific glasses.
* (Or have one-time goggles that, when selected, will instantly trigger whatever they do and then disappear from your inventory.)

POSSIBLE TWEAKS:
* When determining ghost and glasses order, don't be completely random. Leave those with a higher value ( = harder) for _later_? (Should work, but I haven't actually assigned values to glasses and ghosts currently.)
* _Slightly_ faster introduction of new elements at start?
* Keep the HEALTH BAR visible through the shadow? (So you know if your attack is doing anything against them?)

GLASSES IDEAS:
* One with super high damage that only works on a _single_ ghost at a time.
  * Or "max num" of ghosts.
  * Or "first X ghosts it sees"
* One that completely freezes/stops all ghosts that are NOT weak to it.

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