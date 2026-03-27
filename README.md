<picture>
	<source media="(prefers-color-scheme: light)" srcset="https://repo.chr1s.dev/assets/Everest/everest_dark-min.png">
	<img align="left" height="120" src="https://repo.chr1s.dev/assets/Everest/everest_light-min.png" alt="Everest logo" style="float: left;"/>
</picture>
<h3 align="right">App launch animations for MacOS, <br>built for Ammonia</h3>

<p align="right" >
  <strong><a href="https://github.com/ChristopherA8/everest/graphs/contributors">Contributors</a></strong>
  •
  <strong><a href="https://discord.gg/EKZyXfM">Discord</a></strong>
  •
  <strong><a href="https://twitter.com/ChristopherA8">Twitter</a></strong>
</p>
<div class="clear"></div>

## Preview
<p align="center">
	<img src="https://github.com/user-attachments/assets/dfa57017-b862-4a68-94f3-b90f83c99ee7" />
	<img width="302" height="278" src="https://github.com/user-attachments/assets/4add66a1-0558-4953-81fd-d7a922ea85b1" />
</p>


## Installation
<ol>
	<li>Download the dylib, blacklist and Everest.app.zip files from the latest release <b><a href="https://github.com/ChristopherA8/Everest_macOS/releases/latest">here</a></b></li>
	<li>Move the dylib and blacklist files into <code>/var/ammonia/core/tweaks</code></li>
	<li>Run <code>killall Dock</code></li>
	<li>Extract Everest.app from Everest.app.zip</li>
	<li>Run <code>chmod +x '/path/to/file/Everest.app/Contents/MacOS/Everest'</code></li>
	<li>Run <code>xattr -dr com.apple.quarantine '/path/to/Everest.app'</code> <b>or</b> open <i>System Settings>Privacy & Security>Open Anyways</i> when you go to open the app</li>
	<li>Move Everest.app to the Applications folder if you wish</li>
	<li>Enjoy wiggling app icons</li>
</ol>

## Uninstalling
<ol>
	<li>Download the <code>Makefile</code> from this repo and run <code>make uninstall</code></li>
	<li>Delete Everest.app</li>
	<li>and enjoy your boring app icons >:(</li>
</ol>

## In Progress
<ul>
	<li>More Animations Coming</li>
	<li>Preferences UI</li>
	<li>.pkg for friendlier install process</li>
</ul>
<br>


This is just a recreation of my iOS Jailbreak tweak which can be found <b><a href="https://github.com/ChristopherA8/everest">here</a></b>
