This is an article based on a pretty useful lesson I learned after doing 3 game jams at the same time. In short order, I made [Druids in the Dark](https://pandaqi.itch.io/druids-in-the-dark/), [Boltcorpse & Sons](https://pandaqi.itch.io/boltcorpse-and-sons/), and [Bombgoggles](https://pandaqi.itch.io/bombgoggles/).

And all of them **didn't work at all** (at first), until I'd made **pretty much the same change** to all.

## What was the secret sauce?

I am also a writer, which means I've learned about "good conflict" (needed for a great story) and "bad conflict" (just an annoying obstacle that nobody wants to read about).

Good conflict is the following things.

* Somebody wants something.
* But there's an obstacle in the way.
* If they _don't overcome the obstacle_, they _lose something_.
* And this is _urgent_. (They must act now, instead of wait it out.)

Well, the same is true for games.

I already knew games were pretty much interactive storytelling, _even if_ the game has no explicit story at all. (In fact, it is the very first "game dev lesson" in my _Wildebyte Arcades_ books. Which are children's sci-fi novels about someone stuck in video games.) 

But thinking about my core gameplay using this specific list saved all three of those jam games.

In general,

> You want some OBSTACLE that is URGENT, and not dealing with it leads to (HARD) LOSS. And because it's a game, this obstacle should be a LOOP ( = appear over and over, perhaps in varied ways).

Let me show you why.

## Bombgoggles

This is a game where all elements of the map are hidden. The players, however, have "bombgoggles" that indicate how far away or nearby elements are. Like a compass. Using that, you can find the hidden things you want and avoid those you don't.

A pretty solid idea, I thought. In practice, however, it was a bit meh.

* There is no time limit. You can keep inching in different directions "safely" until you find the one thing you need.
* There is no reason for players to be close to each other. While the only way to hit another player, is to explode a hidden bomb while they're near.
* In fact, there is sometimes no reason to move at all. Because moving might be more dangerous than just waiting until other players kill themselves.

It was _meh_ because it didn't satisfy "good conflict"! No urgency, no loss if you didn't do something (tactical), no hard penalties to make it have stakes.

In a game, surprise surprise, you must urge players to _act now_ because it is more fun and rewarding than any alternative.

After a (very) short playtest, I added the battery mechanic. 

* Your battery would deplete, which meant "bad stuff" (your goggles start to display random data, you move very slowly)
* To recharge, you need to visit your personal beacon. Which, after visiting, teleports randomly to somewhere else.

This is a "loop"! You deplete and recharge over and over, until the end of the game. It nudges you to move around and be smarter about it.

But does it _force_ you? No! Those bad effects can be fine. It's too vague, too soft. 

We need a _hard cutoff_. A _terrible loss_ if that obstacle can't be overcome. The far-off pressure of "oh no, the opponent is collecting more treasures than you, and might win in a minute" is also too vague and distant.

Instead, I changed it to:

> When your battery runs out, you **lose a life**.

There's certain loss of something valuable if you don't recharge in time. This cycle is ~20 seconds, which means more immediate and specific goals to work towards (and rewards/penalties to get). Standing still next to your beacon (constantly recharging) also doesn't work, because it teleports around.

Now we've created "good conflict". And sure, testing this version of the game, it stopped feeling "this is very meh" and actually started to become a fun playable game.

## Druids in the Dark

_Druids in the Dark_ (which I made for the PirateJam 2024.2) felt like a "meh" idea as well. 

You run a potion shop on a grid. But the grid has holes, and the player has a _shadow_ that obscures all elements close to them. So you have to memorize where things are before you get close, and constantly check if things haven't changed in the parts you couldn't see. (By moving around more, to get your shadow out of the way.)

This was a good idea in theory---but had some downsides in practice.

* You couldn't actually walk into holes (the code prevented you). So the only downside to trying to do so was "some time lost/less efficiency". Which is too soft, too vague.
* The only reason you'd care about time lost, was because you needed to fulfill orders. But those can have quite a lot of time left for delivery, so the disadvantage for _trying_ to move into a hole is not immediate or repetitive/cyclical enough. ("Oh well, I'll just try another route. And another one.")

You guessed it. The evening before submitting, I changed it to "good conflict".

> You _can_ walk into holes ... you simply **die** if you do so.

You are constantly moving and holes are everywhere, so this is a _cyclical_ problem. Failing to overcome it has a harsh cutoff: the terrible consequences called _game over_. And it is urgent, because you need to fulfill that order in time, but _any_ route needs to be taken with caution.

This simple change took the game from "neat idea, but meh" to "this is really tense and hard to do well"

When I tested multiplayer (with my little sister), she started calling out the shapes of holes in the map to memorize them and ensure none of us walked into one. "Oh Tiamo, don't walk into the dinosaur head in the middle!"

As I stated before, when doing playtests I barely listen to what people say. I check their expressions and actions in-game. When people start doing this kind of strategizing and extra work because they're so afraid of the _stakes_ of this conflict, then you know you're doing it right.

## Boltcorpse & Sons

In this game, ghosts approach you from the left and right. (It's 2D, side-view.) But you only have one flashlight and can only look in one direction at a time.

This game was the easiest of them all to create, and turned out the best by far (I believe). Because I'd now had this realization and was able to fix the core game loop right from the start!

Initially,

* You could see all ghosts on the side you were looking at.
* You had a smaller "kill range". (If they came inside that, they'd start taking damage every second.)
* All other values (such as the _amount_ of damage) were fixed.

But I grew frustrated that I couldn't see the kill range, so I added a debug circle on the floor. And I wanted more unique glasses (you can switch between different "glasses" to change how you view the ghosts or how much damage you do), so I also added a _sight range_ that determined when you could see the ghosts.

After adding those circles, the game became much better already. 

* Before, the player could already see ghosts from far away, making it much easier to just ignore the other side (where things were far away) => Now, staying in one view (and not checking the other) had much higher stakes. You saw less, could have missed a ghost, and that would almost certainly lead to a harsh cutoff: loss of a life.
* Before, the player had no idea when the ghosts would start taking damage. => Now there's the obstacle of ghosts being _out of range_. You know they will be in range in a second or two, but do you dare switch away?

Once I saw those circles, though, I realized how I could use them better.

> The longer you stay in one view, the bigger the circles get (and the more damage you do).

This turned the core gameplay loop into a _loop of good conflict_.

* You want to see and kill all ghosts.
* But you might not be able to see them yet, or kill them yet.
* You can stay in this view longer, but risk neglecting the other side and getting a harsh penalty: loss of life.
* Or you can switch to the other side, but risk resetting your strength and hurting yourself in case you need to switch back later.
* But this choice is always _urgent_, because the ghosts will just keep creeping closer and the moment of the switch is crucial.

And this only works, of course, if there is _considerable_ advantage to staying in the same view. Nudging some values by _tiny bits_ would be imperceptible to the player and feel too soft, too vague. Instead, there are some ghosts (such as the turtle with loads of health) that you can _only_ kill by relying on the increased damage of staying in a view. If you can look the same way for 5+ seconds, that's a huge boost in sight and damage.

But neglecting the other side for that long ... yeah, big risk of terrible loss because some ghost crept up on you.

I was able to pick a core game loop that already provided decent conflict. Then I realized this "revelation" and spent time early on to change it to "good conflict", following the list that I use for stories + adding that it must be a loop/cyclical. These are easy tweaks once you brainstorm a bit and try some different rules. But they make any game _much better_---more than graphics, sound, content, or anything else could ever do.

## Conclusion

I have a few more game jams planned this summer. I will obviously keep this list in mind _right from the start_. It made the development of Boltcorpse & Sons far more effortless than the other games, and the end product much better.

A recurring theme here, of course, is "loss of life". In a game based on health/lives, this is obviously the hardest cutoff there is. The biggest risk to take if you fail to overcome the obstacle.

A game always has one or two elements that are most important to winning/losing. It seems quite obvious now, but the core gameplay loop should _risk losing that most important thing_ if you _don't play (well)_. Otherwise, it's just not good conflict. The player could sit still and do nothing. Or they could pick one strategy and stick with it always. Or the stakes feel too low, which makes players _not care_.

I guess this also comes from ... fear? The fear of hurting your players too much. Of creating a game that's too harsh and too punishing. 

In much the same way, beginning designers (including me) usually pick colors that are too soft and muddy at the start. They lack contrast and make all illustrations look "flat". Why? Because they fear picking colors that are too bright, or striking, or contrasting, and hurting the eyes of people looking at their design :p

Experience naturally takes that away. The more games I make, the more I see that the _core gameplay loop_ should be "good conflict". And yes, that means having a clear, hard penalty for not playing (well). Players don't hate this (or your game)---it actually makes them care and play actively. Any "soft penalties/rewards" should be reserved for secondary mechanics, not the _core loop_.

For example, in Boltcorpse & Sons, all ghosts take away 1 life on hit. But I might add a single ghost, for variety/a new mechanic, that does a more _soft_ or _vague_ type of damage. Maybe, once hit, it randomizes the order of your glasses, or it makes you more "vulnerable" for other (later) ghosts. That's not hard and clear enough for the core loop, but it _is_ a great idea for something sprinkled in.

Those were my thoughts about these three games and the biggest lesson(s) I learned.

Keep playing,

Pandaqi