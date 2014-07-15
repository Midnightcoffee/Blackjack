Blackjack
=========

A mostly* BDD driving single player blackjack game.

Mostly because I believe true BDD requires an actual client. Sense this was a 
bootcamp project at my internship in 2014 at Atomic Object my client was my
mentor.

What I learned
=============
+ tests save keep you honest and focused.
+ I don't know the pattern well enough to break it. I kept the deck as a single 
column on the game class because I thought it would lead to less hassling with
the database. A mistake because this lead to breaking single responsibility and 
didn't save any time as i just had to wrestle with string splitting instead.
+ Just read the docs. Sure blog posts are nice, but their wrong or outdated as often
as not.
+ Make sure you know the scope. I over planned because I mis-understood the scope
of the probject.
+ rails, ruby, anguarJS, html, css, etc...

What needs improvement
======================

+ Deck, Hand and Cards should all be separate models. 
