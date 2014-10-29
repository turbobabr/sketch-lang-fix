Sketch Lang-Fix
===============
Sketch Lang-Fix is a small [Sketch App](http://bohemiancoding.com/sketch/) plugin that uses some hackery to solve the long standing problem with non working single letter shortcuts like `R`,`O`,`T`,`etc` when non latin keyboard input sources like `Russian`,`Ukrainian`,`Belarusian`,`Turkish`,`Greek`,`Hebrew` are used.

This plugins substitutes the drawing area keyboard `keyUp:` and `keyDown:` event handlers to mutate them using key codes instead of characters. Thus, it works correctly for any keyboard input source and doesn't doesn't break Sketch functionality.

> WARNING: This plugin uses undocumented APIs of Sketch App and might stop working at any moment.

## About the PROBLEM (aka open letter to BC team)

I reported this issue to BC support back in June 2014 with all the gruesome details about `how severe this is`, and got a respond that it's going to be fixed. I also saw several other users were whining about the same thing, but unfortunately nothing changed.

I believe that the problem is that all the BC developers speak English, Dutch, Spanish... The keyboard input sources for these languages have latin characters and they work great with the single letter shortcuts. So I guess that this problem appears to the dev team as a inconvenience or a pet-peeve, but in reality it looks like this:

<img src="https://raw.githubusercontent.com/turbobabr/sketch-lang-fix/master/docs/the_pain_is_here.png">

I don't want to dive into details again, here is the axiom:
> Every time you switch your keyboard input source to non latin language - Sketch becomes the most awful tool you've ever used. PERIOD!

I speak Russian, and I thought that no other person on the planet hates Sketch for this particular problem as I do.. but I was wrong :). For Russian shortcuts just don't work. During the testing process of this plugin I decided to try it with `Turkish` and found out that their default keyboard input actually has some latin characters but they are located differently than on the standard QWERTY keyboard, thus the workflow for Turkish designer look like this:

<img src="https://raw.githubusercontent.com/turbobabr/sketch-lang-fix/master/docs/turkish_hell_for_designers.png">

There is actually a QWERTY keyboard version for Turkish language. I'm not sure which of them is used, but anyway I like the picture above, since it clearly demonstrates that designers might go insane with this language problem.

Meanwhile you can use this plugin to solve the problem and boost your work productivity! :)

## Installation

1. [Download Lang-Fix.zip archive file](https://github.com/turbobabr/sketch-lang-fix/blob/master/dist/Lang-Fix.zip?raw=true).
2. Reveal plugins folder in finder ('Sketch App Menu' -> 'Plugins' -> 'Reveal Plugins Folder...').
3. Copy downloaded zip file to the revealed folder and un-zip it.
4. Install [Sketch DevTools Assistant](https://github.com/turbobabr/sketch-devtools-assistant) application.
5. You are ready to go! :)

## Usage

### Step #1: Testing applicator

First, you have to test if plugin works correctly and handles the shorctuts:

1. Execute `Sketch App Menu -> Plugins -> Lang-Fix -> Apply Lang-Fix` plugin.
2. If it worked correctly you should see the following message at the bottom of your document: <img src="https://raw.githubusercontent.com/turbobabr/sketch-lang-fix/master/docs/applicator_notification.png">
3. Now switch to non latin keyboard inut source and try to use shortcuts to create some shapes.
4. If it worked out - proceed to the Step #2, otherwise [open an issue](https://github.com/turbobabr/sketch-lang-fix/issues).

### Step #2: Registering auto-running script

Running the applicator manually, like we did in the first step, is a really boring task. You have to do it every time you launch Sketch App, but the biggest problem is that it's hard to remember to do it. :)

With the help of [Sketch DevTools Assistant](https://github.com/turbobabr/sketch-devtools-assistant) we can register an action that runs the applicator on Sketch launch automatically.

Here are the steps to register the action:

1. Be sure that [Sketch DevTools Assistant](https://github.com/turbobabr/sketch-devtools-assistant) is installed and running.
2. Execute `Sketch App Menu -> Plugins -> Lang-Fix -> Register Lang-Fix Autorun` plugin.
3. Restart Sketch App.
4. If everything worked out, you should see the message in automatically opened document: <img src="https://raw.githubusercontent.com/turbobabr/sketch-lang-fix/master/docs/applicator_notification.png">
5. Check if the shortcuts are working as expected.

### Troubleshooting

If shortcuts work but you're experiencing some Sketch behaviour change you think was triggered by this plugin:

1. Execute `Sketch App Menu -> Plugins -> Lang-Fix -> Unregister Lang-Fix Autorun` plugin ro remove this plugin from auto-launch list.
2. [Open an issue](https://github.com/turbobabr/sketch-lang-fix/issues).

## Change Log

#### v1.0.0: October 29, 2014
- First version (hope it's going to be the last one) :)

## Feedback

If you discover any issue or have any suggestions, please [open an issue](https://github.com/turbobabr/sketch-lang-fix/issues) or find me on twitter [@turbobabr](http://twitter.com/turbobabr).

## License

The MIT License (MIT)

Copyright (c) 2014 Andrey Shakhmin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.





