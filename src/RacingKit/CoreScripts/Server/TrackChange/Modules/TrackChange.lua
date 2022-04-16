--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Module Name: TrackChange
	Last Updated: 27/02/2021
	Purpose: Changes Track
--]]

----------------------------------------- Variables -----------------------------------------
-- Modules
local TrackChange = {}

-- OOP Set up
TrackChange.__index = TrackChange;

-- Inbound
local mTrackChangeInbound = script.Parent.Parent.Parent.TrackChange;

-- APIs
local mAPIFolder = game.ServerScriptService:WaitForChild("Yar890Studio"):WaitForChild("Racing"):WaitForChild("API");
local mBarrierAPI = require(mAPIFolder:WaitForChild("BarrierAPI"));
local mKartAPI= require(mAPIFolder:WaitForChild("KartAPI"));
local mSafetyLightsAPI = require(mAPIFolder:WaitForChild("SafetyLightsAPI"));
local mStartingLightsAPI = require(mAPIFolder:WaitForChild("StartingLightsAPI"));

-- Configurations
local mConfiguration = script.Parent.Parent.Parent:WaitForChild("Configuration");
local mTrackChangeConfiguration =  mConfiguration:WaitForChild("TrackChange");
local mTrackWorkspaceObjectValue = mTrackChangeConfiguration:WaitForChild("TrackWorkspaceFolder");

-- Misc
local mOutboundFolder = script.Parent.Parent.Outbound;

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: ControlModule.new
	Parameters: Model
	Return: Array (ControlModule Object)
	
	Purpose: Create new instance of ControlModel and stores Control Module info.
--]]
function TrackChange.new()
	local newTrackChange = {};
	setmetatable(newTrackChange, TrackChange);
	
	if (mTrackWorkspaceObjectValue) then
		newTrackChange.mTrackWorkspaceFolder = mTrackWorkspaceObjectValue.Value;
	else
		error("Yar890 Studio Racing Kit: 'TrackWorkspaceFolder' config value is nil")
	end
	
	return newTrackChange;
end



--[[
	Function Name: ChangeTrack
	Parameter: Folder/Model
	Return: Nil
	
	Purpose: Deletes all tracks features
--]]
function TrackChange:ChangeTrack(pNewTrack)
	mBarrierAPI.DeleteBarrier();
	mKartAPI.DeleteKart();
	mSafetyLightsAPI.DeleteSafetyLight();
	mStartingLightsAPI.DeleteStartingLight();
	
	for _, object in pairs(self.mTrackWorkspaceFolder:GetChildren()) do
		object:Destroy();
	end
	
	local clonedNewTrack = pNewTrack:Clone();
	clonedNewTrack.Parent = self.mTrackWorkspaceFolder;
end



--[[
	Function Name: OnToggleTrackChange
	Parameter: Folder/Model
	Return: Nil
	
	Purpose: Spawn karts on button click.
--]]
function TrackChange:OnToggleTrackChange(pNewTrack)
	self:ChangeTrack(pNewTrack);
end



return TrackChange
