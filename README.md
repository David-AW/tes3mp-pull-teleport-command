# tes3mp-pull-teleport-command

## Using the Command

In-game, use ```/pull``` to become "pullable" to nearby players.

Nearby players can use ```/pull 0``` with 0 being whatever the pullable player's pid is,
	to teleport the player to them.


## Installing the Script
	
	
To install the script you first drop **pull.lua** into your **\mp-stuff\scripts** folder.

While inside of **\mp-stuff\scripts** open up **server.lua** in a text editor.

Near the top of the script you will see ```myMod = require("myMod")```

Copy and paste this snippet on the empty line right below that line.
```pull = require("pull")```

CTRL+F and search for ```elseif cmd[1] == "difficulty"```

Copy and paste this snippet on the empty line right above the line you searched for.
```
	elseif cmd[1] == "pull" then
		pull.ProcessPullCommand(pid, cmd[2])
```
