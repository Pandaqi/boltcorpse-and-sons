Welcome to my devlog for the video game [Boltcorpse & Sons](https://pandaqi.itch.io/boltcorpse-and-sons). 

It will be quite brief, because it was for a very short game jam (_The Jame Gam 33_) and I had no time to actually track this diary while making the game. So I'm giving all my thoughts a few days _after_ finishing the game and not touching it again.

## What's the idea?

We have 3 days (Friday, Saturday, Sunday) to make a game. It has to follow two requirements:

* **Theme: Behind You**
* **Special Object: Glasses** (this object must be somehow in the game or relevant to the game)

Now, I had just finished doing one game jam, and was actually in the midst of doing another.

This meant that I only had _2 days_, and I had to switch my mind halfway to a new project. It meant I had zero time to brainstorm, try different things, or, well, _not make the game yet_.

As such, I took the first thing that came to mind and ran with it. (And this probably sprang to mind because I was reading the _Lockwood & Co_ novels, which is about a world in which "Visitors" can appear, but only children can usually sense them and defeat them with very specific tools.)

* You are in the center of the screen. The place is dark, you have a flashlight which is your only light.
* You're fighting ghosts/spirits. While looking at them, they slowly lose health, until they die.
* _You can only see one side of the screen._ (In other words, ghosts are constantly coming up behind you, but you don't know because you're looking the other way.)
* The _glasses_ you're wearing while doing so, determine how this works. (Different glasses have different range, color, damage, weaknesses, etcetera.)

Before I start work on any project, I must always have that feeling that there's "something there". And I usually try to make that explicit, so I know what parts of the idea I need to keep to execute the vision and get "something (good)".

So, why did this feel like a viable idea? 

* You have the constant tension of not knowing what's behind you.
* You have the constant tug-of-war between wanting to stay on one side (already damaging what you know is there or coming) and having to look the other way just in case.
* I know that simple lighting effects can easily make a game look way more professional than it is :p So this theme is basically an excuse to do that.
* Extremely simple controls and explanation, yet different glasses and ghosts provide endless progression/variation/content.

## What's my personal challenge?

I usually try to challenge myself in one or two new ways. To help me grow, try something else, really make different games for different jams.

With the other game I was making (Bombgoggles), I'd finally learned the power of custom resources in Godot and started using them. But I'd only used them, so far, as simple data containers.

With this game, I wanted to go all-in and also make resources _behavior-defining_. In other words, I knew ghosts would need different properties such as a _movement pattern_, and I wanted to be able to accomplish this completely by simply swapping one resource for another. (One ghost might float, another might jump, but it all shouldn't require any exceptions or changes in code---just a different resource slotted into the "movement" variable.)

I didn't have time or energy for any other challenges or personal restrictions. 

Let's start making the game!

## The first night

It took 30 minutes to get the basic controls going: look left or right, switch between glasses.

It took a bit longer to find a _clean_ approach for hiding all ghosts at your back, and showing all of them at the front. Eventually, I realized I now had a shared custom resource for the PlayerData and for the GhostData. By feeding one into the other, it could calculate on which side everyone was (relative to the player), and change them accordingly.

(This is now just one line of code `ghost_pos * look_dir > player_pos * look_dir`, where look_dir is `1` for looking right, and `-1` for looking left. Yes, as development continued, this became more complicated with all sorts of effects and manipulation.)

I used a `CanvasModulate` to make everything dark. It didn't work. Then I instantly remembered that of course it has no difference, because I have no background to modulate yet. So I created a simple tilable ground and made it stretch dynamically to fill the entire viewport.

Now I could give the player a flashlight, and the ghosts some softer lights, and it all started to look like it should.

I started development around 10 PM and went to bed around 2 AM that day. In that period,

* Ghosts spawn at the screen edges, but don't move yet.
* You can switch sides and glasses, and only ghosts on the right side are visible.
* A rudimentary UI is shown and can be changed. (It listens to those inputs for switching glasses or when the player were to lose a life.)

## The next day

This was the big day. I knew the game would have to be 95% done by night, allowing me to playtest and polish the next morning.

### Graphics

I started out by making **graphics**. Why? Because late at night, my screen has this blue light filter on, which means I can't judge colors correctly to save my life. Also because I needed to see what I was doing, instead of looking at the Godot logo in 20 different places. So, graphics first.

I made only a single ghost and glasses for now, focusing on the more crucial elements, such as parts of the UI and the player character in the center.

I plugged them into the game and it started to look like something.

### Closing the Game Loop

First, I needed to **"close the game loop"**. 

That's the big point I'm always racing towards. Because as long as this loop isn't closed, you don't actually have a game, and you have no clue if it's good or not.)

* The player actually damages the ghosts in range, and they die if `health <= 0`. (Thanks to the graphics I made, they already had a health bar.)
* The player checks if ghosts touch it, and it loses a life if so. (Again, we already have this UI and the corresponding sprites, so I could see it was working correctly.)
* If all lives lost, we go to a game over screen and can restart.

With this in place, I could see the game was shaping up to be quite good. That's a nice sign, of course. But it was still a long way away from being finished.

### Different Glasses

Then I needed to implement the **different glasses**. Each unique glass is a _custom resource_ in Godot.

* I created a single script called `glasses_type_data.gd`, which extends `Resource` and has loads of variables such as "range of sight" and "damage per second"
* For each glasses, I create a new resource that _extends_ this script and sets those variables (in the inspector) to what's needed.

As usual, the glasses are all _different_, with none (hopefully) clearly stronger or weaker than another. They all have some benefit and some downside. Perhaps they do more damage ... but ghosts are sped up. Perhaps they do fewer damage, but pierce through shields.

In the game, all these are just numbers on those resource that I set to `1.5` or `0.5` or whatever.

This was the first time I'd ever done this. And I instantly knew it was far better than anything I tried before, and I will be using this approach again.

Fortunately, I also realized early on that I didn't want fixed numbers in those Resources. No, they should be _factors_, multiplying some base value defined in config.

For example, the regular glasses just has `1.0` on everything. In code, this is multiplied by the actual default value from config. If a ghost does half the damage, now their value can just be `0.5`. And it will always work, even if I completely change all numbers in the game.

### Different Ghosts

Then it was time to implement the **different ghosts**. Again, each unique ghost is a _custom resource_ in Godot. In this case, it is a Resource which has another Subresource: its _movement pattern_.

Using the same technique, I built different movement patterns from the same base. Most ghosts use `float_simple`, which just means they always move towards the player at a constant speed. But some jump, some flop back and forth, some speed up over time, etcetera. These are all different _custom resources_ with the values set to achieve that exact movement pattern. And that resource is then plugged into the larger _ghost resource_.

Its numbers are, again, all factors. The regular ghost has a speed of `1.0`, which is multiplied in game by whatever base speed the config defines.

Now, at this point, this is all guesswork. What numbers are correct? Is it too easy or too hard? Don't know! 

I had to just make all the ideas I had (at the time) by setting some initial values that hopefully were in the right ballpark.

Remember that I didn't actually have sprites for any of this yet---just one ghost and one glasses---so there was no point in testing yet. I couldn't see which was which anyway.

### Tweaking the Core Mechanics

Here's a lesson learned.

At some point, I decided glasses should have a _sight range_ (they can only spot ghosts inside it) and _kill range_ (they only damage ghosts inside that). They'd obviously be different per type and a major factor in your decision to pick one or another.

But as I tested this, I grew annoyed that I didn't know if it was working. I couldn't _see_ the range! So when a ghost did or did not appear ... was it working properly or a bug in the code?

Purely for debugging, I created two circles on the floor. Then I instantly knew they were here to stay.

Now that I could _see_ the exact radius of sight/kill (for these glasses), I could actually make informed choices. I knew if I could look away, how long I could wait before ghosts would take damage anyway, how likely it was that something was lurking just outside the bounds.

I guess we learned the following: **If you feel the incredible urge to add something to help yourself debug/develop ... the player probably wants it too.**

This also directly led to new insights about the core loop.

The core tension/challenge of the game is "how long do I want to keep looking this way?" We can make this even more interesting and strategical if we _reward_ the player for _staying in one view for longer_. In other words, the longer you look to the same side (without switching glasses too), the larger your radii grow and the more damage you do.

This is such a simple tweak, but it really made the game shine. It also allowed unique ghosts to have quite some health, or walk rather quickly, because now you _could_ kill them easily ... if you dared stay in the same view for a while.

After tweaking all the numbers related to this, the feature was here to stay.

Secondly, I'd already added code for **weaknesses**. Ghosts would have certain glasses that dealt them _more damage_, like a Pokemon weakness. 

This was a good idea. Over time, however, I realized we could do better: ghosts _only_ responded to weak glasses (and ignored all the others). I displayed these weaknesses anyway---so now the player had an overview of which glasses would damage a ghost (and which would not) at all times. 

This was even better, because now the player _had_ to switch between glasses. It wasn't just a "maybe it's more strategical to use that other one now", it was "you can't hit that ghost unless you switch". Like the other change, this bumped the game 10x in terms of enjoyment and replay value.

### How do we explain all this?

I needed some sort of tutorial system that would explain just enough to play the game and know what to do. But I hate tutorials, like everyone else, and never want to just show a wall of text or endless pointers or whatever.

I ended up with the following approach.

* At the start, it just shows key hints left and right, which fade away after 5 seconds.
* The key hint for switching glasses is _always_ visible below them. (Because we easily have the space for this, and also because this is the thing that gets annoying if you have to memorize it or misclick because of that.)
* Spaced out over time, new ghosts and glasses are "unlocked". When that happens, the game pauses and it shows a single screen with the (ghost/glasses) image and a summary of its properties.

This is just a background image with some Labels and Sprite2Ds on top. It reads the values directly from the associated resource and displays that. (It's much faster and more flexible than if I'd had to create all tutorial images manually, for all ghosts/glasses. Even if it was a bit of a pain to code and figure out.)

The only thing I couldn't prevent, of course, was being forced to show _2 tutorial images_ at the start: one for ghost and one for glasses. I decided this was fine, because there's no way around it, and these are your "regular" ones and thus the simplest.

As for progression, I decided to **alternate between glasses and ghosts**. 

* At the start of the game, it randomly decides an alternating order of unlocks.
* Every X seconds (defined in config), it unlocks the next thing.
  * This felt more robust and fun than basing it on score, or ghosts killed, or how well you were doing.
  * Then you can always get in a terrible loop of "it's going bad and now you also don't get anything new anymore", or the opposite "it's going too great and now you're overwhelmed with new information that hurts you"
* It also _lengthens_ the interval between unlocks each time. 
  * This means you get faster unlocks at the start of the game, which is exciting and you can handle it.
  * But later in the game, when you're already swarmed, new unlocks slow down to not overwhelm you.
  * For the game to function at all, we really need 2 glasses and 2 ghosts as soon as possible. Otherwise there's no switching and no variation in strategy.

### Polishing (as much as possible)

Nearing evening, I had to buckle down and improvise all the unique sprites for glasses and ghosts. This took a long time, because I'd actually chosen a new (textured, semi-detailed) style that was working really well but also simply required lots of work.

With all those done, I could actually check if everything worked as intended. There were some bugs. There were some things I just forgot to connect or listen to. Most of what I'd done actually did work on the first try, even if the exact numbers (ghost speed, health, etcetera) were a bit off.

I did have one really weird issue here: Godot suddenly pretended my config didn't exist. It scared me to death :p Suddenly, everything crashed, and there was no trace or helpful message at all---one resource that had always existed and should be there, was just _gone_ everywhere.

From experience, I instantly jumped to the conclusion that cyclical references might be the culprit. And I was right! Yay! I removed the config reference from a few other shared resources, replacing the values it needed by just _feeding those in directly_ when initialized (by the parent/owner/manager).

I haphazardly slapped together and edited loads of royalty free sound effects, whipping them into shape. (That's how I get most of my sounds. I find 3--5 other sounds, make them shorter/louder/reverby/etcetera, layer them, end up with something that's close to right.) I'm quite content with the final sounds for most of the things in the game. Luckily, a ghostly game like this doesn't really need a soundtrack or something, as the silence and sparseness works much better.

I quickly added some tweens and animations to the most important effects. They really make a game feel much more alive and professional, but it sometimes feels like repeating the same code for a simple popup/fade over and over with slight variations.

Generally, such transitions should be really quick and snappy. In this game, however, that felt off. Making ghosts linger far longer after death, slowly swirling upward, felt _much_ more fitting and appropriate. I kept making animations or effects _longer and longer_ all the time, until they were all far longer than I'd usually make them.

I would've liked to add more particles, like sparkly things, swirls coming off the ghosts, etcetera---alas, no time.

## The Final Morning

Technically, I could've worked on this game until _evening_ in my time zone. But I was doing another game jam at the same time, which had a deadline around midnight, and I still needed to do a _lot_ for that one.

I'd written down that I'd work until 12 o'clock on this one, then call it done.

### First rough playtest

I asked my little brother to playtest the game. It was bug-free, easy to understand, and already quite fun. 

But it was also _way too easy_. 

{{% remark %}}
A developer really can't judge how hard a game is, because they've made it and played it themselves over and over. That's why I always default to making things much easier than I think they should be. But that was TOO EASY this time.
{{% /remark %}}

Turtles moved so slowly that you could always kill them far before they reached you. Some glasses were overpowered; the regular glasses, in fact, were so good that you barely had reason to switch. The number of ghosts didn't ramp up fast enough and had a maximum cap that was too low.

I tweaked numbers to have more ghosts spawn, have them move a little faster, lower your damage (but it ramps up more as you _stay in view longer_), lower your kill and sight range slightly, etcetera.

Everything combined, it made the game the same as before, just much more challenging and engaging.

### Roguelite system?

This was an idea I'd always had on the todo list. It was very optional and "probably don't have time".

There was also, however, one "PROBLEM???" on my list that still remained. Namely, the _ghosts_ ramp up over time, but the _player_ does not.

Yes, you get glasses that _might_ be suited better, and you get better in skill as you play more. But you still do the same damage after 2 minutes as you did at the start---but now you're up against much more powerful opposition!

I decided that I just had to pull the trigger on some progression system for the player to solve this final problem.

* I created another custom resource called `ProgressionRulesData`. (I'm not sure about the naming of things, but at least I'm consistent.)
* It has _global_ changes to all sorts of values, such as a global speed change or damage change.
* This resource is duplicated (so it's unique and I can freely change it for this run) and saved in the `ProgressionData` that is a shared resource anyone can access if they want. This also tracks time and already escalates some things over time, such as number of ghosts spawned.
* I first created an _automatic_ scaling: over time, all those global rules move to something that makes the player more powerful. I did this mostly "in case I can't finish the other one".
  * More specifically, I created a resource based on `ProgressionRulesData` with all the _final desired values_.
  * And each update tick, it simply moves the current active rules close to those final desired values.
* Then I created tons of resources (based on that same script) with values tweaked. Speed 1.15, Damage 1.1, all slight changes that would help the player a lot. With the correct descriptions to explain this, of course.

When to show this? I could've based it on score, or getting a new ghost, or anything else. In my experience, though, by far the best moment to give the player extras ... is after they just lost something. That's when they _want it_ and _need it_. When you randomly give the player an option to pick something nice, they generally just "pick anything" and don't really care, because they feel they don't need it.

As such, **when you lose a life, "Spirit Help" pops up!** (This just reuses the tutorial system, which accepts anything as input, and will pause the game and make it pop up.)

Two random choices are pulled from my list of resources. They are buttons you can click. (But keyboard works too, of course, as everyone hates _switching_ between keyboard and mouse for certain things).

If you do, and this is the magic trick, the global `ProgressionRulesData` has all its values multiplied by that resource connected to the button you just clicked.

It was very easy to code and implement, and I was incredibly surprised when it all worked flawlessly on the first try.

Within a slice of a morning, I'd completely implemented a functioning (and needed) roguelite progression system. With lots of interesting choices for when the player loses a life.

Now the game _could_ be really hard, because picking the right bonuses would help you extend your play just a little. It also felt like a very natural addition. If I hadn't been able to finish it, I'd feel the game was "missing something" or there was a "hole" in the systems.

### But progression is always hard

@TODO: about changing order of unlocks, and dynamically assigning weak glasses

### Final Playtest

I asked my little brother to test again. And yes, this time it was much more challenging. (Keeping in mind that he _is_ a gamer and this was not his _first_ attempt now, which would make him better at the game naturally.)

It felt close to the right level of difficulty. No tweaking from me would improve anything now, as I just don't have the time to playtest or balance for any longer.

That rule of "you can only damage ghosts if you have the right glasses" was never explained anywhere. There just wasn't a good place in a specific tutorial, so I decided I'd need to use feedback to help the player grasp it quickly. 

Fortunately, my brother _did_ get it quite quickly, thanks to the sprites that flash and shake when targeted with the right glasses. (Before I'd implemented that, I'd even forget the rule _myself_. I'd think something was bugged because a ghost wasn't damaged, turns out I was just using the wrong glasses :p Which comes back to that lesson learned: If you want something for debugging or extra info, the player/game probably wants too.)

If I ever come back to the game, I want to do more with the glasses and "what you can see" anyway. (Such as glasses that only target the first X ghosts they see. Or powerups that appear in the world, but to grab them you have to _look at them_ for X seconds.) When I do that, I could always reuse those new systems to clarify this mechanic more.

My brother told me the game was quite addictive. He didn't need to do so, as after all these years, I can tell :p I've learned to mostly ignore what people are saying and just check their expressions and actions in-game. Once my brother started saying things like "begone you ghost!" (when killing one just in time) or let out a short yell when a weeping angel was suddenly upon him, I know the game is at least engaging and fun enough to produce _that_.

## Conclusion

For a change, I am very happy with the end result. 

I think the game looks great. I was able to keep a consistent style, that also ended up perfectly fitting the theme and dark/light environment. The tutorials, the UI, everything looks more professional to me than it deserves for such a time frame.

I also think it plays great. A very simple core idea that I was able to extend into many different ghosts, glasses, and other variations. A core idea that delivers constant tension and tough choices, from start to finish, with relatively little extra work on my end.

As stated, I have clear ideas that would surely make the game even better and more professional. I'd have added them if time allowed. I'll probably come back in a year or so to do this final update, as the idea just turned out so promising.

As usual, that doesn't mean I think it's _amazing_ or a _masterpiece_, or I expect to win. I just think it's good. Especially for the time frame, and this is quite rare for me to be honest.

I hope others have just as much fun with it. Or can learn from my source code, which I made public and free, as always. I actually think the code is exceptionally clean and easy to read on this one! That's what you get, I guess, by having a strong core idea that creates a fun game from start to finish. I never had to do major rewrites or completely pivot the idea, which is nice for code clarity and consistency.

Keep playing, and developing,

Pandaqi

