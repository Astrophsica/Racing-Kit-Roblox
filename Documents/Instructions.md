Most of the kit is ready out of the box. For further instructions such as configurations, click on the arrow to view how to set up a specific part of the kit.

For video tutorial, you can view it here: 
https://www.youtube.com/watch?v=HJhDu9wpGzY
*(Note: Video is intended as a rough guide. For up to date instructions, read "Instructions" below)*


# Instructions:
[details="Kart"]
[u]Video shortcut:[/u]
https://www.youtube.com/watch?t=544&v=HJhDu9wpGzY

[u]Kart Instructions:[/u]
1) The "Kart" is the vehicle you want to spawn at kart spawn locations
2) When the game is run, the kart is moved to ServerStorage.
3) Do not delete the kart. This will break some elements of the kit.
4) The kart is ready and does not need any setup.
5) If you wish to configure kart, to go Racing Kit > Components > Kart > Kart > Yar890Kart > Configuration.

[u]Configuration:[/u]
* BrakingTorque: The amount of braking force applied to kart.
* MaxTurnAngle: The maximum angle that the kart wheels can turn.
* ReverseTorque: The reverse force applied to kart.
* ReverseMaxSpeed: The maximum speed that the kart can go in reverse.
* Torque: The forward force applied to kart.
* Sound deamplification: The division applied to engine sound playback speed based on vehicle kart speed.
---
[/details]

[details="Custom Kart + A-Chassis"]
[u]Video shortcut:[/u]
https://www.youtube.com/watch?t=706&v=HJhDu9wpGzY

[u]A-Chassis vehicle instructions:[/u]
1) Ensure you have A-Chassis build version 6.52S2.
2) The vehicle model "PrimaryPart" must be set to a Part in your vehicle. This is used to spawn your vehicle.
3) Set "KartModel" in RacingKit > Configuration > Kart > KartModel.

[u]Custom vehicle Instructions:[/u]
1) You can use any vehicle, as long as your drive script checks and uses the vehicle seat max speed property when changed. 
2) The vehicle seat parent must be the vehicle model.
3) The vehicle model "PrimaryPart" must be set to a Part in your vehicle. This is used to spawn your vehicle.
4) Set "KartModel" in RacingKit > Configuration > Kart > KartModel.

[u]Configuration:[/u]
* KartModel: Object value of kart to spawn in
---
[/details]

[details="Anti-Exploit"]
[u]Video shortcut:[/u]
https://www.youtube.com/watch?t=1410&v=HJhDu9wpGzY

[u]Anti-Exploit Instructions:[/u]
1) This kit comes with kart anti-exploit. This includes 2 types of checks, which are light overspeed and hard limit overspeed.
2) Light overspeed is when a player goes past the current light max speed limit + LightLimitOffset for a specific amount of time (LightOverspeedTime). If this condition is met, the player will get kicked from the game.
3) Hard limit overspeed is when a player goes over the green light max speed limit + HardLimitOffset. If this condition is met, the player will get kicked from the game.
4) Teleporting users while they are in the kart may falsely trigger anti-cheat.
5) Harsh downwards ramps may falsely trigger anti-cheat.
6) AntiCheat is off by default.
7) To turn on and configure anti-cheat, go to Racing Kit > Configuration > Kart > AntiCheat. 

[u]Configuration:[/u]
* AntiCheatEnabled: Turns Anti-Cheat on to off
* HardLimitOffset: The hard limit offset that is added onto the green light max speed
* LightLimitOffset: The light limit offset that is added onto the current light max speed
* LightOverspeedTime: The allowed time over the current light limit + Limit limit offset max speed. Does not apply to the hard limit.
---
[/details]

[details="Safety Lights"]
[u]Video shortcut:[/u]
https://www.youtube.com/watch?t=966&v=HJhDu9wpGzY

[u]Safety Instructions:[/u]
1) Click on the Control panel or Safety lights.
2) Copy and paste (Ctrl + c, Ctrl + v), duplicate (Ctrl + D) or move selected object.
3) Move anywhere you want to move it to in the game.
3) To configure Safety light max speed, got to RacingKit > Configuration > RacingLights > LightSpeed.

[u]Configuration:[/u]
* Red: Vehicle max speed on red light.
* Yellow: Vehicle max speed on yellow light.
* Green: Vehicle max speed on green light.
---
[/details]

[details="Starting Lights"]
[u]Video shortcut:[/u]
https://www.youtube.com/watch?t=1728&v=HJhDu9wpGzY

[u]Starting Lights:[/u]
1) Click on the Control panel or Starting lights.
2) Copy and paste (Ctrl + c, Ctrl + v), duplicate (Ctrl + D) or move selected object.
3) Move anywhere you want to move it to in the game.
4) The starting light barrier will go transparent when the game starts.
---
[/details]

[details="Kart Spawn"]
[u]Video shortcut:[/u]
https://www.youtube.com/watch?t=2001&v=HJhDu9wpGzY

[u]Kart Spawn Instructions:[/u]
1) Kart will spawn at all the parts in the RacingKit > KartSpawn > SpawnLocations *(Unless "SpawnLocations" value has been changed on configuration)*
2)  You can move each kart spawn part, as long as its parent stays the same (Inside "SpawnLocations")
3) All spawn location parts will become transparent when the game starts.
4) To change the spawn location, go to RacingKit > Configuration > KartSpawn > SpawnFolder.

[u]Configuration:[/u]
* SpawnFolder: The folder which contains all spawn locations for karts.

---
[/details]

[details="Collision"]
[u]Video shortcut:[/u]
https://www.youtube.com/watch?t=2348&v=HJhDu9wpGzY

[u]Collision Instructions:[/u]
1) Click on the Control panel
2) Copy and paste (Ctrl + c, Ctrl + v), duplicate (Ctrl + D) or move selected object.
3) Move anywhere you want to move it to in the game.
---
[/details]

[details="Initialise"]
[u]Video shortcut:[/u]
https://www.youtube.com/watch?t=2425&v=HJhDu9wpGzY

[u]Initialise Instructions:[/u]
1) This contains starting script, as well as all other main scripts. 
2) You do not need to access this script unless you wish to make modifications.
3) This script has to stay within the kit folder.
---
[/details]

[details="Pit gate / barrier"]
[u]Video shortcut:[/u]
https://www.youtube.com/watch?t=2498&v=HJhDu9wpGzY

[u]Pit gate/barrier Instructions:[/u]
1) Click on the Control panel or Barrier.
2) Copy and paste (Ctrl + c, Ctrl + v), duplicate (Ctrl + D) or move selected object.
3) Move anywhere you want to move it to in the game.
4) To change control panel sign, to go ControlPanel > Sign > SignUI > TextBox and change the "Text" property.
5) Each Barrier and Control Panel has ClassId value. When a control panel button is clicked with the same ClassId value as the Barrier, then the barrier state will change (open/close).
6) Example: ControlPanel class Id of "OpenPitEntrance" will open/close all barriers with class Id of "OpenPitEntrance".
7) To configure the control panel class Id, got to ControlPanel > Configuration.
8) To configure the barrier class Id and transparency, got to ControlPanel > Configuration.

[u]Configuration:[/u]
* ClassId: Value used to connect different barriers and control panels together.
* BarrierOffTransparency: The transparency of barrier when the barrier is off.
* BarrierOnTransparency: The transparency of barrier when the barrier is on.
---
[/details]

[details="Track Change"]
[u]Track Change Instructions:[/u]
1) Create a new folder in "Workspace".
![WorkspaceFolder|516x432](upload://ks1G0AmH008HYH1Rs7hFPZiL7fa.gif) 
</br>
2) Create a new folder in "ServerStorage".
![ServerStorage|403x500](upload://vDv56dOUOv03IYBpXS5N3I7ErqC.gif) 
</br>
3) Rename these folders. Suggested names are "CurrentTrack" for the workspace folder and "TrackStorage" for ServerStorage.
</br>
4) Set "TrackWorkspaceFolder" configuration to workspace folder in configuration
![SetObjectValue|266x500](upload://z0d62NfDqLEojsyQgwcdvxw7jCD.gif) 
</br>
5) Set "TrackStorageFolder" configuration to server storage folder in configuration
![ServerStorageFolder|323x499](upload://cR47feCHjzdyMdQaI1XatLFk6DX.gif) 
</br>
6) Make sure each track is in its own folder/model
![GroupedTrack|418x364](upload://iDCi2iaaBPhCbBnaj04qZfacnC.gif) 
</br>
7) Add the first track you want to show on the game in the Workspace folder you created.
![MoveFirstTrack|342x356](upload://6Xt2UeWFnoK9VsTbGoENEIetrUm.gif) 
</br>
8) Add all other tracks to the ServerStorage folder you created.
![MoveOtherTrack|324x500](upload://jxFj56peQmnQXKkFk7v73oVjtIB.gif) 
</br>

[u]Notes:[/u]
* If the track loads in the wrong place, you will need to move the track back into the workspace. Next, move the track to the correct position. Finally, moved the track back into the ServerStorage track folder.

[u]Configuration:[/u]
* TrackWorkspaceFolder: The object value that links to the folder in Workspace.
* TrackStorageFolder: The object value that links to the folder in ServerStorage *(Or other storage places)*.
---
[/details]

[details="Group Restriction"]
[u]Video shortcut:[/u]
https://www.youtube.com/watch?t=3327&v=HJhDu9wpGzY

[u]Group Restriction Instructions:[/u]
1) Group restrictions allow people within a specific group and rank to click the button. All other players will not be able to click it.
2) If group ID is set to 0, then all players can click on the button.
3) To configure group restrictions, go to RacingKit > Configuration > Group.

[u]Configuration:[/u]
* GroupID: The ID of your group (Typically found in the URL).
* RankID: The minimum RankID required to use the control panel.
---
[/details]

[details="API"]
[u]API Instructions:[/u]
1) The API is designed to allow advanced users to create custom scripts to trigger events or get info from events. This can include changing lights in scripts or getting info about who clicked a button.
2) View "examples" to get an idea of how you can get info from API events.
---
[/details]

# How to:
[details="Change a value object"]
[u]Instructions:[/u]
* To adjust a "value", you click on the pointing value, then go into the properties window and change the "Value". You can see an example of this below:
![image|270x500](upload://1UcdYTP7I7xwqEUEgLmoUYud5EK.png) 
You will need to know how to do this to change some of the configurations.
---
[/details]

**Last Update: 01/02/2021**