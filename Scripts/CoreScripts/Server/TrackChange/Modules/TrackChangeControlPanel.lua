--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Module Name: TrackChangeControlPanel
	Last Updated: 27/02/2021
	Purpose: Button for change track
--]]

----------------------------------------- Variables -----------------------------------------
-- Modules
local ControlPanel = require(script.Parent.Parent.Parent.Misc.Modules.ControlPanel);
local TrackChangeControlPanel = {}

-- OOP Set up
TrackChangeControlPanel.__index = TrackChangeControlPanel;
setmetatable(TrackChangeControlPanel, ControlPanel) -- Inheritence

-- Inbound
local mInbound = script.Parent.Parent.Inbound;

-- Configurations
local mConfiguration = script.Parent.Parent.Parent:WaitForChild("Configuration");

-- Group Info
local mGroupConfiguration = mConfiguration:WaitForChild("Group");
local mGroupID = mGroupConfiguration:WaitForChild("GroupID").Value;
local mRankID = mGroupConfiguration:WaitForChild("RankID").Value;

-- Misc
local mOutboundFolder = script.Parent.Parent.Outbound;

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: ControlModule.new
	Parameters: Model
	Return: Array (ControlModule Object)
	
	Purpose: Create new instance of ControlModel and stores Control Module info.
--]]
function TrackChangeControlPanel.new(pControlPanelModel)
	local newTrackChangeControlPanel = ControlPanel.new(pControlPanelModel);
	setmetatable(newTrackChangeControlPanel, TrackChangeControlPanel);
	
	return newTrackChangeControlPanel;
end



--[[
	Function Name: OnButtonClick
	Parameter: Player
	Return: Nil
	
	Purpose: Spawn karts on button click.
--]]
function TrackChangeControlPanel:OnButtonClick(pPlayer)
	if (pPlayer:GetRankInGroup(mGroupID) >= mRankID) then
		mInbound.ToggleTrackChange:Fire();
	end
end



return TrackChangeControlPanel
